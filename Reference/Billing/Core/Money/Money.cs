namespace Billing.Core;

/// <summary>
/// An amount in one currency. Amounts in different currencies never mix.
/// Promoted from the Invoicing Feature when Reminders became its second speaker.
/// </summary>
public readonly record struct Money
{
    public decimal Amount { get; }
    public string Currency { get; }

    public Money(decimal amount, string currency)
    {
        if (string.IsNullOrWhiteSpace(currency) || currency.Trim().Length != 3)
        {
            throw new ArgumentException("A currency is a three-letter ISO 4217 code.", nameof(currency));
        }

        Amount = decimal.Round(amount, 2, MidpointRounding.AwayFromZero);
        Currency = currency.Trim().ToUpperInvariant();
    }

    public Money Plus(Money other)
    {
        if (other.Currency != Currency)
        {
            throw new InvalidOperationException($"Cannot add {other.Currency} to {Currency}.");
        }

        return new Money(Amount + other.Amount, Currency);
    }

    /// <summary>A share of this amount, such as a 2% fee: <c>total.Share(0.02m)</c>.</summary>
    public Money Share(decimal rate) => new(Amount * rate, Currency);

    public override string ToString() => $"{Amount:0.00} {Currency}";
}
