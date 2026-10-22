namespace Billing.Features.Invoicing;

/// <summary>A request for payment, issued to one customer on one day.</summary>
public sealed record Invoice(Guid Id, string Customer, Money Total, DateOnly IssuedOn);
