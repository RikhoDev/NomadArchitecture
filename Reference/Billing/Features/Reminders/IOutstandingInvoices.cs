using Billing.Core;

namespace Billing.Features.Reminders;

/// <summary>An unpaid amount a customer owes, as Reminders needs to see it.</summary>
public sealed record OutstandingInvoice(Guid InvoiceId, string Customer, Money Amount, DateOnly DueOn);

/// <summary>
/// What Reminders needs: the invoices still owed. Reminders does not know
/// where they come from; a connector supplies them.
/// </summary>
public interface IOutstandingInvoices
{
    IReadOnlyList<OutstandingInvoice> Outstanding();
}
