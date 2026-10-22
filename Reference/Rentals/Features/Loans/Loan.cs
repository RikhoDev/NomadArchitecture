using Billing.Core;

namespace Rentals.Features.Loans;

/// <summary>A tool lent to a customer, to come back by a date, and what is charged if it does not.</summary>
public sealed record Loan(Guid Id, string Customer, string Tool, DateOnly ReturnBy, Money LateCharge)
{
    public bool Returned { get; init; }
}
