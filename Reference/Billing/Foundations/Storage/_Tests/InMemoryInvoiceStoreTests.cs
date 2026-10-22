using Billing.Features.Invoicing;
using Billing.Foundations.Storage;

namespace Billing.Proofs.Foundations.Storage;

public sealed class InMemoryInvoiceStoreTests
{
    private static Invoice NewInvoice(int day) =>
        new(Guid.NewGuid(), "Acme", new Money(10m, "EUR"), new DateOnly(2026, 10, day));

    [Fact]
    public void Finds_what_it_keeps_and_lists_it_oldest_first()
    {
        var store = new InMemoryInvoiceStore();
        var later = NewInvoice(20);
        var earlier = NewInvoice(5);
        store.Add(later);
        store.Add(earlier);

        Assert.Equal(later, store.Find(later.Id));
        Assert.Null(store.Find(Guid.NewGuid()));
        Assert.Equal([earlier, later], store.All());
    }

    [Fact]
    public void Refuses_to_keep_the_same_invoice_twice()
    {
        var store = new InMemoryInvoiceStore();
        var invoice = NewInvoice(1);
        store.Add(invoice);
        Assert.Throws<InvalidOperationException>(() => store.Add(invoice));
    }
}
