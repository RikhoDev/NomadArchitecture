using Billing.Core;

namespace Billing.Features.Reminders;

public enum ReminderLevel
{
    /// <summary>1 to 14 days overdue.</summary>
    Friendly = 1,

    /// <summary>15 to 30 days overdue.</summary>
    Firm = 2,

    /// <summary>More than 30 days overdue; a late fee is added.</summary>
    Final = 3,
}

/// <summary>A reminder to send: to whom, how firmly, and for how much.</summary>
public sealed record Reminder(Guid OwedId, string Customer, ReminderLevel Level, int DaysOverdue, Money AmountDue);

/// <summary>
/// The Reminders promise: decide, for a given day, which customers to remind
/// and how firmly. A final notice adds a late fee of 2% of the amount owed.
/// </summary>
public sealed class ReminderPolicy(IAmountsOwed owed, TimeProvider clock)
{
    public const decimal LateFeeRate = 0.02m;

    public IReadOnlyList<Reminder> Due()
    {
        var today = DateOnly.FromDateTime(clock.GetUtcNow().UtcDateTime);
        return [.. owed.Outstanding()
            .Select(o => (Owed: o, Days: today.DayNumber - o.DueOn.DayNumber))
            .Where(x => x.Days > 0)
            .OrderByDescending(x => x.Days)
            .Select(x => ToReminder(x.Owed, x.Days))];
    }

    private static Reminder ToReminder(AmountOwed owed, int days)
    {
        var level = days switch
        {
            <= 14 => ReminderLevel.Friendly,
            <= 30 => ReminderLevel.Firm,
            _ => ReminderLevel.Final,
        };
        var amount = level == ReminderLevel.Final ? owed.Amount.Plus(owed.Amount.Share(LateFeeRate)) : owed.Amount;
        return new Reminder(owed.OwedId, owed.Customer, level, days, amount);
    }
}
