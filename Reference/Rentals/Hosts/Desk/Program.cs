using Billing.Core;
using Billing.Features.Reminders;
using Rentals.Features.Loans;
using Rentals.Features.Reminders._Connectors;

// Composition: Loans and Reminders meet only through this system's connector.
// Usage: dotnet run --project Reference/Rentals/Hosts/Desk [-- yyyy-MM-dd]
var today = args.Length > 0 ? DateOnly.Parse(args[0]) : DateOnly.FromDateTime(DateTime.UtcNow);
var desk = new LoanDesk();
desk.Lend("Ada", "Hammer drill", today.AddDays(-3), new Money(25m, "EUR"));
desk.Lend("Linus", "Tile cutter", today.AddDays(-20), new Money(40m, "EUR"));
desk.Lend("Grace", "Ladder", today.AddDays(-45), new Money(60m, "EUR"));
desk.Return(desk.Lend("Ken", "Sander", today.AddDays(-10), new Money(15m, "EUR")).Id);

var clock = new FixedClock(today);
foreach (var reminder in new ReminderPolicy(new OutstandingFromLoans(desk), clock).Due())
{
    Console.WriteLine($"{reminder.Level,-8} {reminder.Customer,-6} {reminder.DaysOverdue,3} days late  {reminder.AmountDue.Amount,8:0.00} {reminder.AmountDue.Currency}");
}

internal sealed class FixedClock(DateOnly day) : TimeProvider
{
    public override DateTimeOffset GetUtcNow() => new(day.ToDateTime(new TimeOnly(9, 0)), TimeSpan.Zero);
}
