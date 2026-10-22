using System.Collections.Concurrent;
using Billing.Core;
using Billing.Features.Invoicing;

namespace Billing.Foundations.Storage;

/// <summary>
/// Keeps invoices in memory, safe for concurrent use. It fulfils the
/// Invoicing Feature's store contract; it knows nothing of what an invoice
/// means beyond its identity.
/// </summary>
public sealed class InMemoryInvoiceStore : IInvoiceStore
{
    private readonly ConcurrentDictionary<Guid, Invoice> _invoices = new();

    public void Add(Invoice invoice)
    {
        if (!_invoices.TryAdd(invoice.Id, invoice))
        {
            throw new InvalidOperationException($"Invoice {invoice.Id} is already stored.");
        }
    }

    public Invoice? Find(Guid id) => _invoices.TryGetValue(id, out var invoice) ? invoice : null;

    public IReadOnlyList<Invoice> All() => [.. _invoices.Values.OrderBy(i => i.IssuedOn).ThenBy(i => i.Id)];
}
