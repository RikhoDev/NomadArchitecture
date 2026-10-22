#!/usr/bin/env bash
# The cold-onboarding trial: can a fresh AI session, given only this
# repository, build in the canon's shape? See README.md beside this file.
#
#   Hosts/OnboardingTrial/trial.sh prepare <work-dir>   six copies, baselines checked
#   Hosts/OnboardingTrial/trial.sh run     <work-dir>   one headless session per copy
#   Hosts/OnboardingTrial/trial.sh grade   <work-dir>   build, tests, conformance, blinded diffs
#
# Needs git, dotnet 8 and python3; `run` also needs the claude CLI. Plugins
# named in NOMAD_TRIAL_DISABLE_PLUGINS (space-separated, e.g.
# "nomad-method@synced") are disabled in every copy, so neither arm gets help
# from outside the repository.
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
repo=$(cd "$here/../.." && pwd)
tasks=(payments reminders csv)
arms=(canon control)

ask() {
    case $1 in
        payments) echo "Finance now records payments. Add the ability to record a payment (an amount and a date) against an invoice through the API, and make sure reminders are no longer sent for invoices that are fully paid; a partial payment reduces the amount a reminder asks for." ;;
        reminders) echo "The collections team wants to see today's reminders without waiting for the morning run: add GET /reminders to the API, returning the reminders that would be sent today." ;;
        csv) echo "The accounting team needs a CSV export of all invoices (id, customer, amount, currency, issued date, due date), available from the API as GET /invoices/export.csv." ;;
    esac
}

# Where the Billing system sits inside a copy.
billing() { if [ "$1" = canon ]; then echo Reference/Billing; else echo .; fi; }

prepare() {
    local work=$1
    mkdir -p "$work"
    for arm in "${arms[@]}"; do
        for task in "${tasks[@]}"; do
            local d="$work/$arm-$task"
            rm -rf "$d" && mkdir -p "$d"
            if [ "$arm" = canon ]; then
                # The whole repository, as committed.
                git -C "$repo" archive HEAD | tar -x -C "$d"
            else
                # The same code with the method's documents and checks taken
                # out: no READMEs, no conformance tests, no build comments.
                # Code comments stay, so this arm still reads some of the
                # method from the code itself.
                git -C "$repo" archive HEAD Reference/Billing | tar -x -C "$d" --strip-components=2
                find "$d" -name README.md -delete
                rm -rf "$d/Proofs/Architecture"
                find "$d" \( -name '*.csproj' -o -name '*.props' \) -print0 |
                    xargs -0 python3 -c 'import re,sys
for p in sys.argv[1:]:
    t = open(p).read()
    open(p, "w").write(re.sub(r"[ \t]*<!--.*?-->[ \t]*\n?", "", t, flags=re.S))'
            fi
            git -C "$d" init -q && git -C "$d" add -A
            git -C "$d" -c user.name=trial -c user.email=trial@invalid commit -qm baseline
            for plugin in ${NOMAD_TRIAL_DISABLE_PLUGINS:-}; do
                (cd "$d" && claude plugin disable "$plugin" --scope local >/dev/null)
            done
            printf '%s baseline: ' "$arm-$task"
            dotnet test "$d/$(billing $arm)/Billing.sln" -c Release 2>&1 | grep -E 'Passed!|Failed!' || { echo "does not build"; exit 1; }
        done
    done
}

run() {
    local work=$1
    for arm in "${arms[@]}"; do for task in "${tasks[@]}"; do echo "$work/$arm-$task"; done; done |
        xargs -P 3 -I{} "$0" _session {}
}

session() {
    local d=$1 name arm task
    name=$(basename "$d"); arm=${name%%-*}; task=${name#*-}
    local prompt="You are a developer on this repository. Task: $(ask "$task")

Work in this repository as its developer would. Keep the build and all tests passing (dotnet is on PATH; the solution is $(billing "$arm")/Billing.sln). Add or update tests for what you build. Do not ask questions: decide and finish. Do not commit. When you are done, list each file you changed or added, and say in one line why it lives where it does."
    (cd "$d" && DOTNET_CLI_TELEMETRY_OPTOUT=1 DOTNET_NOLOGO=1 timeout 1800 \
        claude -p --allowedTools "Bash Read Edit Write Glob Grep" --output-format text "$prompt" > "$d.out" 2>&1)
    echo "$name exit=$?"
}

grade() {
    set +e  # a failing build or test is a result to record, not a reason to stop
    local work=$1
    local judge="$work/judge"
    rm -rf "$judge" && mkdir -p "$judge"
    # One fixed shuffle, so the judge cannot tell the arms apart by letter.
    local letters=(P Q R S T U)
    local order=(control-reminders canon-csv control-payments canon-reminders control-csv canon-payments)
    : > "$work/blind-map.txt"
    for i in "${!order[@]}"; do
        local name=${order[$i]} letter=${letters[$i]}
        local arm=${name%%-*} d="$work/${order[$i]}" b relative=()
        b="$d/$(billing "$arm")"
        [ "$arm" = canon ] && relative=(--relative=Reference/Billing/)
        echo "$letter $name" >> "$work/blind-map.txt"
        {
            echo "== $name"
            git -C "$d" add -A
            git -C "$d" diff --cached --stat -- . ':!**/bin/**' ':!**/obj/**' | tail -1
            echo "-- the session's own tests"
            dotnet test "$b/Billing.sln" -c Release 2>&1 | grep -E 'Passed!|Failed!|error' | head -5
            echo "-- conformance rules 1-5, applied to both arms alike"
            [ "$arm" = control ] && mkdir -p "$b/Proofs/Architecture" && cp "$repo/Reference/Billing/Proofs/Architecture/"*.cs "$b/Proofs/Architecture/"
            dotnet test "$b/Proofs/Proofs.csproj" -c Release \
                --filter 'FullyQualifiedName~ConformanceTests&FullyQualifiedName!~README' 2>&1 |
                grep -E 'Passed!|Failed!|Error Message|reaches|depend|Namespaces' | head -12
            [ "$arm" = control ] && rm -rf "$b/Proofs/Architecture"
            git -C "$d" add -A
            # README changes are left out of what the judge sees: only one arm has READMEs.
            git -C "$d" diff --cached "${relative[@]}" \
                -- ':!*README.md' ':!**/bin/**' ':!**/obj/**' > "$judge/$letter.diff"
            git -C "$d" reset -q
        } > "$d.grade" 2>&1
        echo "graded $name"
    done
    git -C "$repo" archive HEAD Reference/Billing | tar -x -C "$judge" --strip-components=1
    mv "$judge/Billing" "$judge/baseline-src" && find "$judge/baseline-src" -name README.md -delete
    cp "$repo/__Docs/Architecture.md" "$judge/rubric-architecture.md"
    # The prompt without its status header, pointed at this run's folder.
    awk 'n >= 2; /^---$/ { n++ }' "$here/judge-prompt.md" | sed "s|<judge-dir>|$judge|g" > "$judge/prompt.txt"
    echo "Give $judge/prompt.txt to a reviewer that has not seen the runs; unblind with $work/blind-map.txt."
}

case ${1:-} in
    prepare) prepare "${2:?work dir}" ;;
    run) run "${2:?work dir}" ;;
    grade) grade "${2:?work dir}" ;;
    _session) session "$2" ;;
    *) sed -n '2,12p' "$0"; exit 2 ;;
esac
