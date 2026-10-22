using Billing.Features.Invoicing;
using Microsoft.Extensions.Time.Testing;

namespace Billing.Proofs.Features.Invoicing;

public sealed class InvoiceIssuerTests
{
    private sealed class ListStore : IInvoiceStore
    {
        public List<Invoice> Items { get; } = [];
        public void Add(Invoice invoice) => Items.Add(invoice);
        public Invoice? Find(Guid id) => Items.Find(i => i.Id == id);
        public IReadOnlyList<Invoice> All() => Items;
    }

    private static readonly FakeTimeProvider Clock = new(new DateTimeOffset(2026, 10, 22, 9, 0, 0, TimeSpan.Zero));

    [Fact]
    public void Issues_and_keeps_an_invoice_dated_today()
    {
        var store = new ListStore();
        var invoice = new InvoiceIssuer(store, Clock).Issue("  Acme Ltd ", new Money(120m, "eur"));

        Assert.Equal("Acme Ltd", invoice.Customer);
        Assert.Equal(new Money(120m, "EUR"), invoice.Total);
        Assert.Equal(new DateOnly(2026, 10, 22), invoice.IssuedOn);
        Assert.Equal(new DateOnly(2026, 11, 21), invoice.DueOn);
        Assert.Same(invoice, Assert.Single(store.Items));
    }

    [Theory]
    [InlineData("", 10)]
    [InlineData("Acme", 0)]
    [InlineData("Acme", -5)]
    public void Refuses_an_invoice_without_customer_or_amount(string customer, decimal amount)
    {
        var issuer = new InvoiceIssuer(new ListStore(), Clock);
        Assert.Throws<ArgumentException>(() => issuer.Issue(customer, new Money(amount, "EUR")));
    }

    [Fact]
    public void Payment_terms_set_the_due_date_and_stay_within_a_year()
    {
        var invoice = new InvoiceIssuer(new ListStore(), Clock).Issue("Acme", new Money(1m, "EUR"), netDays: 14);
        Assert.Equal(new DateOnly(2026, 11, 5), invoice.DueOn);
        Assert.Throws<ArgumentOutOfRangeException>(() => PaymentTerms.DueDate(invoice.IssuedOn, 400));
    }

    [Fact]
    public void Money_needs_a_three_letter_currency_and_keeps_cents()
    {
        Assert.Throws<ArgumentException>(() => new Money(1m, "EURO"));
        Assert.Equal(10.13m, new Money(10.125m, "EUR").Amount);
    }
}
