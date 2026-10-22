using System.Net;
using System.Net.Http.Json;
using Microsoft.AspNetCore.Mvc.Testing;

namespace Billing.Proofs.Hosts.Api;

public sealed class ApiTests(WebApplicationFactory<Program> factory) : IClassFixture<WebApplicationFactory<Program>>
{
    [Fact]
    public async Task Issues_an_invoice_and_finds_it_again_with_its_due_date()
    {
        var client = factory.CreateClient();

        var created = await client.PostAsJsonAsync("/invoices", new { customer = "Acme Ltd", amount = 250.5m, currency = "eur" });
        Assert.Equal(HttpStatusCode.Created, created.StatusCode);
        var invoice = await created.Content.ReadFromJsonAsync<InvoiceView>();
        Assert.NotNull(invoice);
        Assert.Equal(invoice.IssuedOn.AddDays(30), invoice.DueOn);

        var found = await client.GetFromJsonAsync<InvoiceView>($"/invoices/{invoice.Id}");
        Assert.Equal(invoice, found);
    }

    [Fact]
    public async Task Shows_a_refused_invoice_as_400_with_the_reason()
    {
        var response = await factory.CreateClient().PostAsJsonAsync("/invoices", new { customer = "", amount = 10m, currency = "EUR" });
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        Assert.Contains("needs a customer", await response.Content.ReadAsStringAsync());
    }

    [Fact]
    public async Task An_unknown_invoice_is_404()
    {
        var response = await factory.CreateClient().GetAsync($"/invoices/{Guid.NewGuid()}");
        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    }
}
