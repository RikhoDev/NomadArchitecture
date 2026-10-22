using Billing.Core;
using Billing.Features.Invoicing;
using Billing.Features.Reminders._Connectors;
using Billing.Foundations.Storage;
using Microsoft.Extensions.Time.Testing;

namespace Billing.Proofs.Features.Reminders;

public sealed class OutstandingFromInvoicingTests
{
    [Fact]
    public void Hands_every_issued_invoice_to_Reminders_in_its_own_vocabulary()
    {
        var store = new InMemoryInvoiceStore();
        var issued = new InvoiceIssuer(store, new FakeTimeProvider(new DateTimeOffset(2026, 9, 1, 0, 0, 0, TimeSpan.Zero)))
            .Issue("Contoso", new Money(80m, "EUR"));

        var outstanding = Assert.Single(new OutstandingFromInvoicing(store).Outstanding());

        Assert.Equal(issued.Id, outstanding.InvoiceId);
        Assert.Equal("Contoso", outstanding.Customer);
        Assert.Equal(issued.Total, outstanding.Amount);
        Assert.Equal(issued.DueOn, outstanding.DueOn);
    }
}
