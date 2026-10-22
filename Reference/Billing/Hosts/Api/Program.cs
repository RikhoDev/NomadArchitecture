using Billing.Features.Invoicing;
using Billing.Foundations.Storage;
using Billing.Hosts.Api;

// Composition: the only place that knows which Foundation fulfils which
// Feature contract.
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddSingleton(TimeProvider.System);
builder.Services.AddSingleton<IInvoiceStore, InMemoryInvoiceStore>();
builder.Services.AddSingleton<InvoiceIssuer>();

var app = builder.Build();

app.MapPost("/invoices", (IssueRequest request, InvoiceIssuer issuer) =>
{
    try
    {
        var invoice = issuer.Issue(request.Customer, new Money(request.Amount, request.Currency));
        return Results.Created($"/invoices/{invoice.Id}", InvoiceView.From(invoice));
    }
    catch (ArgumentException refused)
    {
        // The Host decides how a refused promise is shown: 400 with the reason.
        return Results.Problem(refused.Message, statusCode: StatusCodes.Status400BadRequest);
    }
});

app.MapGet("/invoices/{id:guid}", (Guid id, IInvoiceStore store) =>
    store.Find(id) is { } invoice ? Results.Ok(InvoiceView.From(invoice)) : Results.NotFound());

app.Run();

public sealed record IssueRequest(string Customer, decimal Amount, string Currency);

public sealed record InvoiceView(Guid Id, string Customer, decimal Amount, string Currency, DateOnly IssuedOn, DateOnly DueOn)
{
    public static InvoiceView From(Invoice invoice) => new(
        invoice.Id, invoice.Customer, invoice.Total.Amount, invoice.Total.Currency,
        invoice.IssuedOn, PaymentTerms.DueDate(invoice.IssuedOn));
}

public partial class Program;
