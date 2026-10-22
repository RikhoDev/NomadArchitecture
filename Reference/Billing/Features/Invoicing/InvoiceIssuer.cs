namespace Billing.Features.Invoicing;

/// <summary>Issues invoices: the Invoicing promise.</summary>
public sealed class InvoiceIssuer(IInvoiceStore store, TimeProvider clock)
{
    public Invoice Issue(string customer, Money total, int netDays = PaymentTerms.DefaultNetDays)
    {
        if (string.IsNullOrWhiteSpace(customer))
        {
            throw new ArgumentException("An invoice needs a customer.", nameof(customer));
        }

        if (total.Amount <= 0)
        {
            throw new ArgumentException("An invoice asks for more than nothing.", nameof(total));
        }

        var issuedOn = DateOnly.FromDateTime(clock.GetUtcNow().UtcDateTime);
        var invoice = new Invoice(Guid.NewGuid(), customer.Trim(), total, issuedOn, PaymentTerms.DueDate(issuedOn, netDays));
        store.Add(invoice);
        return invoice;
    }
}
