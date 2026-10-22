using Billing.Core;
using Billing.Features.Reminders;
using Microsoft.Extensions.Time.Testing;

namespace Billing.Proofs.Features.Reminders;

public sealed class ReminderPolicyTests
{
    private sealed class Fixed(params AmountOwed[] items) : IAmountsOwed
    {
        public IReadOnlyList<AmountOwed> Outstanding() => items;
    }

    private static readonly DateOnly Today = new(2026, 10, 22);
    private static readonly FakeTimeProvider Clock = new(new DateTimeOffset(2026, 10, 22, 7, 0, 0, TimeSpan.Zero));

    private static AmountOwed DueDaysAgo(string customer, int days, decimal amount = 100m) =>
        new(Guid.NewGuid(), customer, new Money(amount, "EUR"), Today.AddDays(-days));

    [Fact]
    public void Reminds_more_firmly_the_longer_an_amount_is_overdue_most_overdue_first()
    {
        var reminders = new ReminderPolicy(new Fixed(
            DueDaysAgo("Fourteen", 14), DueDaysAgo("Fifteen", 15), DueDaysAgo("Thirty-one", 31), DueDaysAgo("Not yet", 0)), Clock).Due();

        Assert.Equal(["Thirty-one", "Fifteen", "Fourteen"], reminders.Select(r => r.Customer));
        Assert.Equal([ReminderLevel.Final, ReminderLevel.Firm, ReminderLevel.Friendly], reminders.Select(r => r.Level));
    }

    [Fact]
    public void A_final_notice_adds_a_two_percent_late_fee_rounded_to_cents()
    {
        var final = Assert.Single(new ReminderPolicy(new Fixed(DueDaysAgo("Late", 40, 1250.40m)), Clock).Due());
        Assert.Equal(new Money(1275.41m, "EUR"), final.AmountDue);
    }

    [Fact]
    public void Money_never_mixes_currencies()
    {
        Assert.Throws<InvalidOperationException>(() => new Money(1m, "EUR").Plus(new Money(1m, "USD")));
    }
}
