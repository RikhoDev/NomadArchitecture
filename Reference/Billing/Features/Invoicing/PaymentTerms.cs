namespace Billing.Features.Invoicing;

/// <summary>
/// When an invoice falls due: "net N", the number of days after issue.
/// Promoted from the Api Host when the Worker Host became a second consumer.
/// </summary>
public static class PaymentTerms
{
    public const int DefaultNetDays = 30;

    public static DateOnly DueDate(DateOnly issuedOn, int netDays = DefaultNetDays)
    {
        if (netDays is < 0 or > 365)
        {
            throw new ArgumentOutOfRangeException(nameof(netDays), "Payment terms run from 0 to 365 days.");
        }

        return issuedOn.AddDays(netDays);
    }
}
