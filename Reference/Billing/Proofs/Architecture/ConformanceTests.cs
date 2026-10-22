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
    public void A_Feature_reaches_another_Feature_only_through_its_connectors()
    {
        // "A connector is thin. It wires a real seam." Only a Feature's
        // _Connectors may see another Feature.
        var features = SystemMap.Features();
        foreach (var assembly in SystemMap.Pillar("Features"))
        {
            foreach (var feature in features)
            {
                foreach (var other in features.Where(f => f != feature))
                {
                    var result = Types.InAssembly(assembly)
                        .That().ResideInNamespace($"{Ns("Features")}.{feature}")
                        .And().DoNotResideInNamespace($"{Ns("Features")}.{feature}._Connectors")
                        .ShouldNot().HaveDependencyOn($"{Ns("Features")}.{other}")
                        .GetResult();
                    Assert.True(result.IsSuccessful,
                        $"{feature} reaches {other} outside its _Connectors: {string.Join(", ", result.FailingTypeNames ?? [])}.");
                }
            }
        }
    }

    [Fact]
    public void No_dumping_grounds()
    {
        // "Every artifact lives with the owner whose meaning would disappear
        //  without it." (Worldview: No dumping grounds)
        string[] buckets = ["Common", "Shared", "Utils", "Utilities", "Helpers", "Misc"];
        var offenders = SystemMap.Assemblies().SelectMany(a => a.GetTypes())
            .Select(t => t.Namespace ?? "")
            .Where(ns => ns.Split('.').Intersect(buckets).Any())
            .Distinct()
            .ToList();
        Assert.True(offenders.Count == 0, $"Namespaces named for a bucket, not a meaning: {string.Join(", ", offenders)}.");
    }

    [Fact]
    public void Every_resident_of_a_pillar_answers_the_README_questions()
    {
        // Architecture: Feature README. Applied to every pillar's residents.
        string[] questions = ["**Promise.**", "**Residents.**", "**Relationships.**", "**Proof.**", "**Status.**"];
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
                var missing = questions.Where(q => !text.Contains(q)).ToList();
                Assert.True(missing.Count == 0, $"{pillar}/{resident.Name}/README.md does not answer {string.Join(", ", missing)}.");
            }
        }
    }
}
