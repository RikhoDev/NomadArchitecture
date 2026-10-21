# Proof for the Markdown Foundation, on throwaway files.
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '..' 'Markdown.ps1')
. (Join-Path $PSScriptRoot '..' '..' '..' '..' '..' 'Scripts' 'Proof.ps1')

$dir = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid())
New-Item -ItemType Directory $dir | Out-Null
$doc = Join-Path $dir 'doc.md'
@'
---
status: canon
kind: doctrine   # a comment
awaiting_reading: first-part, second
---

# Title

**Promise.** Read documents honestly.

## First part

See [other](other.md#a-heading) and `[not](a-link.md)` and [web](https://example.com).

```text
[also not](fenced.md)
```

### Inside

Kept.

## Second

Done.
'@ | Set-Content -LiteralPath $doc
'# Plain' , '', 'Just a lead paragraph,', 'over two lines.' | Set-Content -LiteralPath (Join-Path $dir 'plain.md')

Assert-Promise 'reads the status header' {
    $h = Read-StatusHeader $doc
    $h.status -eq 'canon' -and $h.kind -eq 'doctrine' -and $h.awaiting_reading -eq 'first-part, second'
}
Assert-Promise 'a file without a header has none' { $null -eq (Read-StatusHeader (Join-Path $dir 'plain.md')) }
Assert-Promise 'finds relative links, not code, fences or web links' {
    $links = @(Get-MarkdownLinks $doc)
    $links.Count -eq 1 -and $links[0].Target -eq 'other.md' -and $links[0].Anchor -eq 'a-heading'
}
Assert-Promise 'derives GitHub anchors' {
    $s = Get-MarkdownSlugs $doc
    $s.Contains('first-part') -and $s.Contains('inside') -and (ConvertTo-Slug '🌌 Mirage Premise') -eq '-mirage-premise'
}
Assert-Promise 'a section runs to the next heading of its level' {
    $section = Get-MarkdownSection $doc 'First part'
    $section -match 'Kept\.' -and $section -notmatch 'Done\.'
}
Assert-Promise 'the lead is the promise when there is one' { (Get-MarkdownLead $doc) -eq 'Read documents honestly.' }
Assert-Promise 'otherwise the lead is the first paragraph' {
    (Get-MarkdownLead (Join-Path $dir 'plain.md')) -eq 'Just a lead paragraph, over two lines.'
}

Assert-Promise 'the lead keeps the words inside inline code' {
    $code = Join-Path $dir 'code.md'
    '# Code', '', '`_Mirages` is a tent inside `__Docs/`.' | Set-Content -LiteralPath $code
    (Get-MarkdownLead $code) -eq '_Mirages is a tent inside __Docs/.'
}

Remove-Item -Recurse -Force $dir
Complete-Proof
