using Billing.Core;
using Billing.Features.Reminders;
using Microsoft.Extensions.Time.Testing;
using Rentals.Features.Loans;
using Rentals.Features.Reminders._Connectors;

namespace Rentals.Proofs.Features.Reminders;

public sealed class OutstandingFromLoansTests
{
    [Fact]
    public void Tools_not_back_are_reminded_by_the_same_policy_as_unpaid_invoices()
    {
        var desk = new LoanDesk();
        var today = new DateOnly(2026, 10, 22);
        desk.Lend("Grace", "Ladder", today.AddDays(-45), new Money(60m, "EUR"));
        desk.Lend("Ada", "Drill", today.AddDays(-3), new Money(25m, "EUR"));
        desk.Return(desk.Lend("Ken", "Sander", today.AddDays(-10), new Money(15m, "EUR")).Id);
        var clock = new FakeTimeProvider(new DateTimeOffset(2026, 10, 22, 9, 0, 0, TimeSpan.Zero));

        var reminders = new ReminderPolicy(new OutstandingFromLoans(desk), clock).Due();

        Assert.Equal(["Grace", "Ada"], reminders.Select(r => r.Customer));
        Assert.Equal([ReminderLevel.Final, ReminderLevel.Friendly], reminders.Select(r => r.Level));
        Assert.Equal(new Money(61.20m, "EUR"), reminders[0].AmountDue);
    }
}
