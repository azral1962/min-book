# 0.1.0

- Optional _cover_
  - Image covers
  - Typst cover creation
- Optional _title page_
  - Automatic title page generation
  - Typst title page creation
- Default values for all non-essential `#book` arguments
- Automatic book divisions (_parts_)
  - Level 1 headings used as _parts_
- Automatic book main sections (_chapters_)
  - Level 2 headings used as _chapters_ when _parts_ are used
  - Level 1 headings used as _chapters_ when _parts_ are not used
- Extended numbering
  - Typst numbering strings
  - Numbly numbering arrays
- Additional `#note` command
- Additional `#horizontalrule` and `#hr` commands
- Additional `#blockquote` command

## 0.1.1

- Added: automatic default cover generation
- Added: `#appendices` command
- Added: `#annexes` command
- Added: Unnumbered _part_ and _chapter_ with `#book(numbering-style: none)`
- Updated: `#book(titlepage)` defaults to `false`
- Updated: `#book(paper)` can be paper `"type"` or `(x: LENGHT, y: LENGHT)` page size
- Fixed: no part name was shown when `#book(toc: false)`
- Fixed: broken `@ref` to headings with `\n` in its numbering