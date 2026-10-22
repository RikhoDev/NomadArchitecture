using Billing.Features.Invoicing;

namespace Billing.Features.Reminders._Connectors;

/// <summary>
/// The relationship between Invoicing and Reminders: it reads Invoicing's
/// invoices and hands them to Reminders in Reminders' own vocabulary. It is
/// the only code allowed to see both Features, and it holds no policy.
/// </summary>
public sealed class OutstandingFromInvoicing(IInvoiceStore invoices) : IOutstandingInvoices
{
    // The system does not record payments yet, so every issued invoice is
    // still owed. When payments arrive, this is the one place that changes.
    public IReadOnlyList<OutstandingInvoice> Outstanding() =>
        [.. invoices.All().Select(i => new OutstandingInvoice(i.Id, i.Customer, i.Total, i.DueOn))];
}
