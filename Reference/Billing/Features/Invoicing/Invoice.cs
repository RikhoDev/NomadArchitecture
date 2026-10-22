using Billing.Core;

namespace Billing.Features.Invoicing;

/// <summary>A request for payment, issued to one customer on one day, due on another.</summary>
public sealed record Invoice(Guid Id, string Customer, Money Total, DateOnly IssuedOn, DateOnly DueOn);
