using Billing.Features.Invoicing;

namespace Billing.Features.Reminders._Connectors;

/// <summary>
/// The relationship between Invoicing and Reminders: it reads Invoicing's
/// invoices and hands them to Reminders in Reminders' own vocabulary. It is
/// the only code allowed to see both Features, and it holds no policy.
/// </summary>
public sealed class OutstandingFromInvoicing(IInvoiceStore invoices) : IAmountsOwed
{
    // The system does not record payments yet, so every issued invoice is
    // still owed. When payments arrive, this is the one place that changes.
    public IReadOnlyList<AmountOwed> Outstanding() =>
        [.. invoices.All().Select(i => new AmountOwed(i.Id, i.Customer, i.Total, i.DueOn))];
}
