using System.Text.Json;
using Billing.Core;
using Billing.Features.Invoicing;

namespace Billing.Foundations.Storage;

/// <summary>
/// Keeps invoices in a JSON file, so that several Hosts on one machine share
/// them. It fulfils the same contract as <see cref="InMemoryInvoiceStore"/>;
/// the Host chooses which one to use. The file's shape belongs to this
/// Foundation: Invoicing's types carry no serialization concerns.
/// </summary>
public sealed class JsonFileInvoiceStore(string path) : IInvoiceStore
{
    private static readonly JsonSerializerOptions Json = new() { WriteIndented = true };
    private readonly object _gate = new();

    private sealed record Row(Guid Id, string Customer, decimal Amount, string Currency, DateOnly IssuedOn, DateOnly DueOn)
    {
        public static Row From(Invoice i) => new(i.Id, i.Customer, i.Total.Amount, i.Total.Currency, i.IssuedOn, i.DueOn);
        public Invoice ToInvoice() => new(Id, Customer, new Money(Amount, Currency), IssuedOn, DueOn);
    }

    public void Add(Invoice invoice)
    {
        lock (_gate)
        {
            var rows = Read();
            if (rows.Any(r => r.Id == invoice.Id))
            {
                throw new InvalidOperationException($"Invoice {invoice.Id} is already stored.");
            }

            rows.Add(Row.From(invoice));
            Write(rows);
        }
    }

    public Invoice? Find(Guid id)
    {
        lock (_gate)
        {
            return Read().FirstOrDefault(r => r.Id == id)?.ToInvoice();
        }
    }

    public IReadOnlyList<Invoice> All()
    {
        lock (_gate)
        {
            return [.. Read().Select(r => r.ToInvoice()).OrderBy(i => i.IssuedOn).ThenBy(i => i.Id)];
        }
    }

    private List<Row> Read() =>
        File.Exists(path) ? JsonSerializer.Deserialize<List<Row>>(File.ReadAllText(path), Json) ?? [] : [];

    private void Write(List<Row> rows)
    {
        // Write beside the file, then replace it, so a reader never sees half a file.
        var temporary = $"{path}.{Environment.ProcessId}.tmp";
        File.WriteAllText(temporary, JsonSerializer.Serialize(rows, Json));
        File.Move(temporary, path, overwrite: true);
    }
}
