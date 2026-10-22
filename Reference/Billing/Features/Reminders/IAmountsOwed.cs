using Billing.Core;

namespace Billing.Features.Reminders;

/// <summary>An unpaid amount a customer owes, as Reminders needs to see it.</summary>
public sealed record AmountOwed(Guid OwedId, string Customer, Money Amount, DateOnly DueOn);

/// <summary>
/// What Reminders needs: the amounts still owed. Reminders does not know
/// what they are owed for, or where they come from; in each system a
/// connector supplies them, from invoices, loans or anything else.
/// </summary>
public interface IAmountsOwed
{
    IReadOnlyList<AmountOwed> Outstanding();
}
