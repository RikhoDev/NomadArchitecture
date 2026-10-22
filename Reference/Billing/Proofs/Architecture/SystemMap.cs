using System.Reflection;

namespace Billing.Proofs.Architecture;

/// <summary>
/// Where the system's pillars are, as assemblies and as folders. Conformance
/// tests read the system from here, so a new pillar or Feature is checked
/// as soon as it exists.
/// </summary>
internal static class SystemMap
{
    public const string Root = "Billing";

    public static readonly string[] PillarOrder = ["Core", "Features", "Foundations", "Hosts"];

    public static IEnumerable<Assembly> Assemblies() =>
        AppDomain.CurrentDomain.GetAssemblies()
            .Concat(Directory.GetFiles(AppContext.BaseDirectory, $"{Root}.*.dll").Select(LoadOnce))
            .Where(a => a.GetName().Name is { } n && n.StartsWith($"{Root}.") && n != $"{Root}.Proofs")
            .DistinctBy(a => a.GetName().Name);

    public static IEnumerable<Assembly> Pillar(string pillar) =>
        Assemblies().Where(a => a.GetName().Name!.StartsWith($"{Root}.{pillar}", StringComparison.Ordinal));

    /// <summary>The Features that exist: Billing.Features.&lt;Name&gt; namespaces.</summary>
    public static IReadOnlyList<string> Features() =>
        [.. Pillar("Features").SelectMany(a => a.GetTypes())
            .Select(t => t.Namespace?.Split('.'))
            .Where(s => s is { Length: >= 3 })
            .Select(s => s![2])
            .Distinct()
            .Order()];

    /// <summary>The system's folder: the one holding Billing.sln.</summary>
    public static DirectoryInfo Folder()
    {
        for (var dir = new DirectoryInfo(AppContext.BaseDirectory); dir is not null; dir = dir.Parent)
        {
            if (File.Exists(Path.Combine(dir.FullName, $"{Root}.sln")))
            {
                return dir;
            }
        }

        throw new DirectoryNotFoundException($"{Root}.sln not found above {AppContext.BaseDirectory}.");
    }

    private static Assembly LoadOnce(string path)
    {
        var name = AssemblyName.GetAssemblyName(path);
        return AppDomain.CurrentDomain.GetAssemblies().FirstOrDefault(a => a.GetName().Name == name.Name)
            ?? Assembly.Load(name);
    }
}
