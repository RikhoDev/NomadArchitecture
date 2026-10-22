using Billing.Features.Reminders;
using Rentals.Features.Loans;

namespace Rentals.Features.Reminders._Connectors;

/// <summary>
/// This system's seam between Loans and Reminders: a tool still out is owed
/// its late charge from its return date. It is the only code here that sees
/// both Features, and it holds no policy: how firmly to remind, and the late
/// fee, stay with Reminders.
/// </summary>
public sealed class OutstandingFromLoans(LoanDesk desk) : IOutstandingInvoices
{
    public IReadOnlyList<OutstandingInvoice> Outstanding() =>
        [.. desk.Out().Select(l => new OutstandingInvoice(l.Id, l.Customer, l.LateCharge, l.ReturnBy))];
}
