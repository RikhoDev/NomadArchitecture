using Billing.Features.Invoicing;
using Billing.Foundations.Storage;
using Billing.Hosts.Worker;

// Composition for the Worker Host. It shares the Api Host's invoices through
// the same file, which both Hosts configure as Billing:StorePath.
var builder = Host.CreateApplicationBuilder(args);
var storePath = builder.Configuration["Billing:StorePath"] ?? "billing-invoices.json";
builder.Services.AddSingleton(TimeProvider.System);
builder.Services.AddSingleton<IInvoiceStore>(new JsonFileInvoiceStore(storePath));
builder.Services.AddSingleton<DueSoonDigest>();
builder.Services.AddHostedService<DigestService>();
builder.Build().Run();

/// <summary>Writes the digest at start, then once a day; with --once, exits after the first.</summary>
internal sealed class DigestService(DueSoonDigest digest, ILogger<DigestService> log, IHostApplicationLifetime life, IConfiguration config)
    : BackgroundService
{
    protected override async Task ExecuteAsync(CancellationToken stopping)
    {
        var once = config.GetValue<bool>("once");
        do
        {
            var lines = digest.Lines();
            log.LogInformation("Due within {Days} days: {Count} invoice(s)", DueSoonDigest.DefaultWindowDays, lines.Count);
            foreach (var line in lines)
            {
                log.LogInformation("{Line}", line);
            }

            if (once)
            {
                life.StopApplication();
                return;
            }
        }
        while (await WaitADay(stopping));
    }

    private static async Task<bool> WaitADay(CancellationToken stopping)
    {
        try
        {
            await Task.Delay(TimeSpan.FromDays(1), stopping);
            return true;
        }
        catch (OperationCanceledException)
        {
            return false;
        }
    }
}
