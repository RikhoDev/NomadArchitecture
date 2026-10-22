using Billing.Core;
using Billing.Features.Invoicing;
using Billing.Foundations.Storage;
using Billing.Hosts.Worker;
using Microsoft.Extensions.Time.Testing;

namespace Billing.Proofs.Hosts.Worker;

public sealed class DueSoonDigestTests
{
    [Fact]
    public void Lists_only_invoices_falling_due_within_the_window_soonest_first()
    {
        var clock = new FakeTimeProvider(new DateTimeOffset(2026, 10, 22, 6, 0, 0, TimeSpan.Zero));
        var store = new InMemoryInvoiceStore();
        var issuer = new InvoiceIssuer(store, clock);
        issuer.Issue("Later Ltd", new Money(50m, "EUR"), netDays: 6);
        issuer.Issue("Soon plc", new Money(75m, "EUR"), netDays: 2);
        issuer.Issue("Far Away", new Money(10m, "EUR"), netDays: 30);

        var lines = new DueSoonDigest(store, clock).Lines();

        Assert.Equal(["2026-10-24  Soon plc  75.00 EUR", "2026-10-28  Later Ltd  50.00 EUR"], lines);
    }
}
