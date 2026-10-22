using Billing.Core;
using Billing.Features.Invoicing;

namespace Billing.Hosts.Worker;

/// <summary>
/// The collections team's morning digest: invoices falling due within the
/// coming days. Host-local: it is this Host's purpose, and only this Host's.
/// </summary>
public sealed class DueSoonDigest(IInvoiceStore store, TimeProvider clock)
{
    public const int DefaultWindowDays = 7;

    public IReadOnlyList<string> Lines(int windowDays = DefaultWindowDays)
    {
        var today = DateOnly.FromDateTime(clock.GetUtcNow().UtcDateTime);
        var until = today.AddDays(windowDays);
        return [.. store.All()
            .Where(i => i.DueOn >= today && i.DueOn <= until)
            .OrderBy(i => i.DueOn)
            .Select(i => $"{i.DueOn:yyyy-MM-dd}  {i.Customer}  {i.Total}")];
    }
}
