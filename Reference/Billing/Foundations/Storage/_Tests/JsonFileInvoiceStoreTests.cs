using Billing.Features.Invoicing;
using Billing.Foundations.Storage;

namespace Billing.Proofs.Foundations.Storage;

public sealed class JsonFileInvoiceStoreTests : IDisposable
{
    private readonly string _path = Path.Combine(Path.GetTempPath(), $"billing-{Guid.NewGuid()}.json");

    public void Dispose() => File.Delete(_path);

    [Fact]
    public void Two_stores_on_one_file_see_the_same_invoices()
    {
        var invoice = new Invoice(Guid.NewGuid(), "Acme", new Money(99.99m, "GBP"), new DateOnly(2026, 10, 1), new DateOnly(2026, 10, 31));
        new JsonFileInvoiceStore(_path).Add(invoice);

        var other = new JsonFileInvoiceStore(_path);
        Assert.Equal(invoice, other.Find(invoice.Id));
        Assert.Equal([invoice], other.All());
    }

    [Fact]
    public void An_absent_file_is_an_empty_store_and_a_duplicate_is_refused()
    {
        var store = new JsonFileInvoiceStore(_path);
        Assert.Empty(store.All());
        var invoice = new Invoice(Guid.NewGuid(), "Acme", new Money(1m, "EUR"), new DateOnly(2026, 1, 1), new DateOnly(2026, 1, 31));
        store.Add(invoice);
        Assert.Throws<InvalidOperationException>(() => store.Add(invoice));
    }
}
