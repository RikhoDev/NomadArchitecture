namespace Billing.Features.Invoicing;

/// <summary>
/// What Invoicing needs in order to keep its promise: somewhere to keep
/// invoices. Invoicing declares the need; a Foundation fulfils it.
/// </summary>
public interface IInvoiceStore
{
    void Add(Invoice invoice);

    Invoice? Find(Guid id);

    IReadOnlyList<Invoice> All();
}
