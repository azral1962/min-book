## 0.1.0

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

### 0.1.1

- Added: automatic default cover generation
- Added: `#appendices` command
- Added: `#annexes` command
- Added: Unnumbered _part_ and _chapter_ with `#book(numbering-style: none)`
- Updated: `#book(titlepage)` defaults to `false`
- Updated: `#book(paper)` can be a `"type"` or `(x: LENGHT, y: LENGHT)` size
- Fixed: no part name was shown when `#book(toc: false)`
- Fixed: broken `@ref` to headings with `\n` in its numbering

## 0.2.0

- Added: Default _part, chapter, appendix_ and _annex_ titles in `#lang.text` language
- Added: Custom TOML translation file with `#book(lang-data)`
- Added: `#note(numbering-style)` set the numbering of all the next `#note` commands also
- Added: `#book(catalog)` generates cataloging in publication board
- Added: `#book(page-cfg)` act as `#set page(..page-cfg)`
- Updated: ~~`#book(paper)`~~ &rarr; `#book(page-cfg)`
- Updated: Reorganized internal structure
- Updated: `#outline(depth: 2)` when `#book(numbering-style: none)`
- Updated: `#book(part: "")` set an unnumbered and unnamed part (just heading title)
- Fixed: titlepage, toc, part, and content beginning moved to odd pages
- Fixed: `#book(cover: image())` works again