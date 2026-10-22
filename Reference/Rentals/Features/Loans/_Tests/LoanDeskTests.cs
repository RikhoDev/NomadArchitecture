using Billing.Core;
using Rentals.Features.Loans;

namespace Rentals.Proofs.Features.Loans;

public sealed class LoanDeskTests
{
    [Fact]
    public void A_returned_tool_is_no_longer_out()
    {
        var desk = new LoanDesk();
        var drill = desk.Lend("Ada", "Drill", new DateOnly(2026, 10, 1), new Money(25m, "EUR"));
        var ladder = desk.Lend("Grace", "Ladder", new DateOnly(2026, 10, 1), new Money(60m, "EUR"));

        desk.Return(drill.Id);

        Assert.Equal([ladder.Id], desk.Out().Select(l => l.Id));
    }

    [Fact]
    public void A_loan_needs_a_customer_and_a_tool_and_only_a_known_loan_comes_back()
    {
        var desk = new LoanDesk();
        Assert.Throws<ArgumentException>(() => desk.Lend(" ", "Drill", new DateOnly(2026, 10, 1), new Money(1m, "EUR")));
        Assert.Throws<InvalidOperationException>(() => desk.Return(Guid.NewGuid()));
    }
}
