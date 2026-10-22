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
public sealed record Reminder(Guid InvoiceId, string Customer, ReminderLevel Level, int DaysOverdue, Money AmountDue);

/// <summary>
/// The Reminders promise: decide, for a given day, which customers to remind
/// and how firmly. A final notice adds a late fee of 2% of the amount owed.
/// </summary>
public sealed class ReminderPolicy(IOutstandingInvoices invoices, TimeProvider clock)
{
    public const decimal LateFeeRate = 0.02m;

    public IReadOnlyList<Reminder> Due()
    {
        var today = DateOnly.FromDateTime(clock.GetUtcNow().UtcDateTime);
        return [.. invoices.Outstanding()
            .Select(i => (Invoice: i, Days: today.DayNumber - i.DueOn.DayNumber))
            .Where(x => x.Days > 0)
            .OrderByDescending(x => x.Days)
            .Select(x => ToReminder(x.Invoice, x.Days))];
    }

    private static Reminder ToReminder(OutstandingInvoice invoice, int days)
    {
        var level = days switch
        {
            <= 14 => ReminderLevel.Friendly,
            <= 30 => ReminderLevel.Firm,
            _ => ReminderLevel.Final,
        };
        var amount = level == ReminderLevel.Final ? invoice.Amount.Plus(invoice.Amount.Share(LateFeeRate)) : invoice.Amount;
        return new Reminder(invoice.InvoiceId, invoice.Customer, level, days, amount);
    }
}
