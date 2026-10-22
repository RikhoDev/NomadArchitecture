using Billing.Core;

namespace Rentals.Features.Loans;

/// <summary>
/// The Loans promise: lend a tool until a date, take it back, and say which
/// loans are still out. The desk keeps its loans itself; nothing else in this
/// system needs them stored elsewhere yet.
/// </summary>
public sealed class LoanDesk
{
    private readonly List<Loan> _loans = [];

    public Loan Lend(string customer, string tool, DateOnly returnBy, Money lateCharge)
    {
        if (string.IsNullOrWhiteSpace(customer) || string.IsNullOrWhiteSpace(tool))
        {
            throw new ArgumentException("A loan needs a customer and a tool.");
        }

        var loan = new Loan(Guid.NewGuid(), customer, tool, returnBy, lateCharge);
        _loans.Add(loan);
        return loan;
    }

    public void Return(Guid id)
    {
        var index = _loans.FindIndex(l => l.Id == id);
        if (index < 0)
        {
            throw new InvalidOperationException($"No loan {id}.");
        }

        _loans[index] = _loans[index] with { Returned = true };
    }

    public IReadOnlyList<Loan> Out() => [.. _loans.Where(l => !l.Returned)];
}
