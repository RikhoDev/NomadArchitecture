using Billing.Features.Reminders;
using Rentals.Features.Loans;

namespace Rentals.Features.Reminders._Connectors;

/// <summary>
/// This system's seam between Loans and Reminders: a tool still out is owed
/// its late charge from its return date. It is the only code here that sees
/// both Features, and it holds no policy: how firmly to remind, and the late
/// fee, stay with Reminders.
/// </summary>
public sealed class OutstandingFromLoans(LoanDesk desk) : IAmountsOwed
{
    public IReadOnlyList<AmountOwed> Outstanding() =>
        [.. desk.Out().Select(l => new AmountOwed(l.Id, l.Customer, l.LateCharge, l.ReturnBy))];
}
