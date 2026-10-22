using System.Text.RegularExpressions;
using NetArchTest.Rules;

namespace Billing.Proofs.Architecture;

/// <summary>
/// The canon's architecture rules, as tests that fail the build. Each test
/// names the rule it enforces; see NomadArchitecture's __Docs/Architecture.md.
/// </summary>
public sealed class ConformanceTests
{
    private static string Ns(string pillar) => $"{SystemMap.Root}.{pillar}";

    private static void AssertNoDependency(IEnumerable<System.Reflection.Assembly> from, string onNamespace, string rule)
    {
        foreach (var assembly in from)
        {
            var result = Types.InAssembly(assembly).ShouldNot().HaveDependencyOn(onNamespace).GetResult();
            Assert.True(result.IsSuccessful,
                $"{rule}: {string.Join(", ", result.FailingTypeNames ?? [])} depend on {onNamespace}.");
        }
    }

    [Fact]
    public void Features_never_depend_on_Foundations_or_Hosts()
    {
        // "Foundations implement Feature contracts; dependencies point toward
        //  the contracts being implemented." (Architecture: contracts and connectors)
        AssertNoDependency(SystemMap.Pillar("Features"), Ns("Foundations"), "A Feature depends on a Foundation");
        AssertNoDependency(SystemMap.Pillar("Features"), Ns("Hosts"), "A Feature depends on a Host");
    }

    [Fact]
    public void Foundations_never_depend_on_Hosts()
    {
        AssertNoDependency(SystemMap.Pillar("Foundations"), Ns("Hosts"), "A Foundation depends on a Host");
    }

    [Fact]
    public void Core_depends_on_no_other_pillar()
    {
        // "Core owns shared language." It may not know who speaks it.
        foreach (var pillar in new[] { "Features", "Foundations", "Hosts" })
        {
            AssertNoDependency(SystemMap.Pillar("Core"), Ns(pillar), $"Core depends on {pillar}");
        }
    }

    [Fact]
    public void A_Feature_outside_its_connectors_depends_only_on_Core()
    {
        // A Feature moves to another system by changing its namespace and its
        // connectors. That holds only if, outside _Connectors, it depends on
        // nothing in this system but Core. Only a connector may see another
        // Feature. (Architecture: Pillars; Contracts and connectors)
        var features = SystemMap.Features();
        foreach (var feature in features)
        {
            var own = $"{Ns("Features")}.{feature}";
            var others = new[] { Ns("Foundations"), Ns("Hosts") }
                .Concat(features.Where(f => f != feature).Select(f => $"{Ns("Features")}.{f}"))
                .ToArray();
            var result = Types.InAssemblies(SystemMap.Pillar("Features"))
                .That().ResideInNamespace(own)
                .And().DoNotResideInNamespace($"{own}._Connectors")
                .ShouldNot().HaveDependencyOnAny(others)
                .GetResult();
            Assert.True(result.IsSuccessful,
                $"{feature} depends on {string.Join(", ", others)} outside its _Connectors: {string.Join(", ", result.FailingTypeNames ?? [])}.");
        }
    }

    private static readonly string[] Buckets = ["Common", "Shared", "Utils", "Utilities", "Helpers", "Misc"];

    [Fact]
    public void No_dumping_grounds()
    {
        // "Every artifact lives with the owner whose meaning would disappear
        //  without it." (Worldview: No dumping grounds) A bucket can hide in a
        // namespace, a folder or a type name, so all three are checked.
        var namespaces = SystemMap.Assemblies().SelectMany(a => a.GetTypes())
            .Select(t => t.Namespace ?? "")
            .Where(ns => ns.Split('.').Intersect(Buckets).Any());
        var folders = SourceFiles().Select(f => f.Folder)
            .Where(folder => folder.Split('/').Intersect(Buckets).Any());
        var types = SystemMap.Assemblies().SelectMany(a => a.GetTypes())
            .Where(t => !t.IsDefined(typeof(System.Runtime.CompilerServices.CompilerGeneratedAttribute), false))
            .Select(t => t.Name.Split('`')[0])
            .Where(name => Buckets.Any(b => name.EndsWith(b, StringComparison.Ordinal) || name.EndsWith(b.TrimEnd('s'), StringComparison.Ordinal)));
        var offenders = namespaces.Concat(folders).Concat(types).Distinct().ToList();
        Assert.True(offenders.Count == 0, $"Named for a bucket, not a meaning: {string.Join(", ", offenders)}.");
    }

    [Fact]
    public void Code_lives_where_its_namespace_says()
    {
        // Every other rule reads namespaces, so a namespace must tell the truth
        // about where the code lives: its folder's path, or the parent path
        // when the folder is named for the one type it holds (Core/Money holds
        // Money, in Billing.Core). A Host's Program.cs, with top-level
        // statements, is the one file without a namespace.
        var wrong = new List<string>();
        foreach (var file in SourceFiles())
        {
            var expected = $"{SystemMap.Root}.{file.Folder.Replace('/', '.')}";
            var parent = expected[..expected.LastIndexOf('.')];
            var folderType = file.Folder.Split('/')[^1];
            var ok = file.Namespace switch
            {
                null => file.Name == "Program.cs" && file.Folder.StartsWith("Hosts/", StringComparison.Ordinal),
                var ns when ns == expected => true,
                var ns when ns == parent => file.Types.SequenceEqual([folderType]),
                _ => false,
            };
            if (!ok)
            {
                wrong.Add($"{file.Folder}/{file.Name} declares {file.Namespace ?? "no namespace"}");
            }
        }

        Assert.True(wrong.Count == 0, $"Namespace and folder disagree: {string.Join("; ", wrong)}.");
    }

    [Fact]
    public void Every_resident_of_a_pillar_answers_the_README_questions()
    {
        // Architecture: Feature README. Applied to every pillar's residents.
        // Each answer must say something: a question followed by fewer than
        // five words is not answered.
        string[] questions = ["Promise", "Residents", "Relationships", "Proof", "Status"];
        var root = SystemMap.Folder();
        foreach (var pillar in SystemMap.PillarOrder)
        {
            var folder = new DirectoryInfo(Path.Combine(root.FullName, pillar));
            if (!folder.Exists)
            {
                continue;
            }

            foreach (var resident in folder.GetDirectories().Where(d => !d.Name.StartsWith('_') && d.Name is not ("bin" or "obj")))
            {
                var readme = Path.Combine(resident.FullName, "README.md");
                Assert.True(File.Exists(readme), $"{pillar}/{resident.Name} has no README.md.");
                var text = File.ReadAllText(readme);
                var unanswered = questions.Where(q =>
                {
                    var answer = Regex.Match(text, $@"\*\*{q}\.\*\*(.*?)(?=\*\*(?:{string.Join("|", questions)})\.\*\*|\z)", RegexOptions.Singleline);
                    return !answer.Success || Regex.Matches(answer.Groups[1].Value, @"\p{L}+").Count < 5;
                }).ToList();
                Assert.True(unanswered.Count == 0, $"{pillar}/{resident.Name}/README.md does not answer {string.Join(", ", unanswered)}.");
            }
        }
    }

    private sealed record SourceFile(string Folder, string Name, string? Namespace, IReadOnlyList<string> Types);

    /// <summary>The system's production source: every .cs file in a pillar, outside _Tests, bin and obj.</summary>
    private static IEnumerable<SourceFile> SourceFiles()
    {
        var root = SystemMap.Folder().FullName;
        foreach (var pillar in SystemMap.PillarOrder.Where(p => Directory.Exists(Path.Combine(root, p))))
        {
            foreach (var path in Directory.EnumerateFiles(Path.Combine(root, pillar), "*.cs", SearchOption.AllDirectories))
            {
                var relative = Path.GetRelativePath(root, path).Replace('\\', '/');
                if (relative.Split('/').Any(s => s is "_Tests" or "bin" or "obj"))
                {
                    continue;
                }

                var text = File.ReadAllText(path);
                var ns = Regex.Match(text, @"^\s*namespace\s+([\w.]+)", RegexOptions.Multiline);
                var types = Regex.Matches(text, @"^\s*(?:(?:public|internal|private|protected|sealed|static|abstract|readonly|partial|file)\s+)*(?:class|record|struct|interface|enum)\s+(?:struct\s+|class\s+)?(\w+)", RegexOptions.Multiline)
                    .Select(m => m.Groups[1].Value).Distinct().ToList();
                yield return new SourceFile(Path.GetDirectoryName(relative)!.Replace('\\', '/'), Path.GetFileName(relative), ns.Success ? ns.Groups[1].Value : null, types);
            }
        }
    }
}
