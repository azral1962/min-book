// Template for writing books

#import "@preview/numbly:0.1.0": numbly

#let book-notes-state = state("book-notes", (:))
#let book-note-counter = counter("book-note-count")

#let book(
  title: none,
  subtitle: none,
  authors: none,
  date: auto,
  cover: none,
  titlepage: true,
  part: "Part",
  chapter: "Chapter",
  numbering-style: none,
  toc: true,
  paper: "a5",
  lang: "en",
  justify: true,
  line-space: 0.5em,
  par-margin: 0.75em,
  first-line-indent: 1em,
  margin: 15%,
  font: ("Book Antiqua", "Times New Roman"),
  font-size: 11pt,
  body
) = {
  // Required arguments
  let req = (
    title: title,
    authors: authors
  )
  for arg in req.keys() {
    if req.at(arg) == none {
      panic("Missing required argument: " + arg)
    }
  }

  // Tranform authors array into string
  if type(authors) != str {
    authors = authors.join(", ", last: ".")
  }

  if type(date) == array {
    date = datetime(year: date.at(0), month: date.at(1), day: date.at(2))
  }
  else {
    date = datetime.today()
  }

  // Join title and subtitle, if any
  let full-title
  if subtitle != none {
    full-title = title + " - " + subtitle
  } else {
    full-title = title
  }

  set document(
    title: full-title,
    author: authors, 
    date: date
  )
  set page(
    paper: paper,
    margin: margin
  )
  set par(
    justify: justify,
    leading: line-space,
    spacing: par-margin, 
    first-line-indent: first-line-indent
  )
  set text(
    font: font,
    size: font-size,
    lang: lang
  )
  set terms(separator: [: ], tight: true)
  
  // Define numbering pattern:
  let numpattern = ()
  if numbering-style != none {
    numpattern = numbering-style
  } else if type(part) == str {
    numpattern = (
      "{1:I}:\n",
      "{2:I}.\n",
      "{2:I}.{3:1}.\n",
      "{2:I}.{3:1}.{4:1}.\n",
      "{2:I}.{3:1}.{4:1}.{5:1}.\n",
      "{2:I}.{3:1}.{4:1}.{5:1}.{6:a}. ",
    )
  } else {
    numpattern = (
      "{1:I}.\n",
      "{1:I}.{2:1}.\n",
      "{1:I}.{2:1}.{3:1}.\n",
      "{1:I}.{2:1}.{3:1}.{4:1}.\n",
      "{1:I}.{2:1}.{3:1}.{4:1}.{5:1}.\n",
      "{1:I}.{2:1}.{3:1}.{4:1}.{5:1}.{6:a}. ",
    )
  }
  
  // Manage numbering cases:
  let set-numbering(
    ..patterns
  ) = (..nums) => {
    context {
      let patterns = patterns.pos()
      let contents = ()
      
      // When using a default numbering string:
      if patterns.len() == 1 and not patterns.at(0).contains(regex("\{.*\}")) {
        return numbering(..patterns, ..nums)
      }

      // Numbering showed after TOC.
      if query(selector(label("outline")).before(here())).len() != 0 {
        // Heading level 1 become part:
        if part != none and patterns.len() >= 1 {
          patterns.at(0) = part + " " + patterns.at(0)

          // Heading level 2 become chapter
          if chapter != none and patterns.len() >= 2 {
            patterns.at(1) = chapter + " " + patterns.at(1)
          }
        } else {
          // Heading level 1 become chapter, if no part
          if chapter != none and patterns.len() > 1 {
            patterns.at(0) = chapter + " " + patterns.at(0)
          }
        }
        
        contents = patterns
      }
      // In TOC, use just the numbering:
      else {
        for pattern in patterns {
          contents.push( pattern.trim(regex("\n$")) )
        }
      }

      // When using numbly numbering array:
      numbly(default: "I.I.1.1.1.a", ..contents)(..nums)
    }
  }

  set heading(
    numbering: set-numbering(..numpattern),
    hanging-indent: 0pt,
  )

  let book-h2-counter = counter("book-h2")
  // Count every level 2 heading to make it independent when part is used:
  show heading.where(level: 2): it => {
    book-h2-counter.step()
    it
  }

  show heading.where(level: 1, outlined: true): it => {
    // Create part page, if any:
    if type(part) != none {
      pagebreak(weak: true, to: "even")
      
      set align(center + horizon)
      it
      
      pagebreak(weak: true)
    } else {
      it
    }

    // Set independent level 2 heading numbering when parts are used:
    context if type(part) != none {
      // Get the current level 2 heading count:
      let current-h2-count = book-h2-counter.get()

      // Do not restart level 2 heading count at each  new level 1:
      counter(heading).update((h1, ..n) => (h1, ..current-h2-count))
    }
  }

  show heading: set align(center)
  show heading.where(level: 1): set text(size: font-size * 2)
  show heading.where(level: 2): set text(size: font-size * 1.6)
  show heading.where(level: 3): set text(size: font-size * 1.4)
  show heading.where(level: 4): set text(size: font-size * 1.3)
  show heading.where(level: 5): set text(size: font-size * 1.2)
  show heading.where(level: 6): set text(size: font-size * 1.1)
  show raw: set text(font: "Inconsolata", size: font-size)
  show quote.where(block: true): set pad(x: 1em)
  show raw.where(block: true): it => pad(left: 1em)[#it]
  
  show selector.or(
    terms, enum, list, quote.where(block: true),
    table, figure, raw.where(block: true),
  ): it => {
    v(font-size, weak: true)
    it
    v(font-size, weak: true)
  }

  // Insert notes of a section at its end, before next heading.
  // TODO: Try to find a less clunsy way to do it

  // Get index of all headings from body.children
  let new-body = body.children
  let h-index = ()
  
  for n in range(new-body.len()) {
    let item = new-body.at(n)

    // Find heading based on having a `depth` field:
    if item.has("depth") {
      h-index.push(n)
    }
  }

  // Insert <note> before each heading obtained
  for n in range(h-index.len()) {
    new-body.insert(h-index.at(n) + n, [#metadata("Note anchor") <note>])
  }

  // Insert a <note> at the document ending to be used by the last heading
  new-body.push([#metadata("Note anchor") <note>])

  // Make the edited new-body into the documents body
  body = new-body.join()

  // Make the first note be note 1, instead of note 0.
  book-note-counter.update(1)

  // Swap <note> for the notes in the anterior heading, if any.
  show <note>: it => {
    context if book-notes-state.final() != (:) {
      // Get the heading of the <note> section.
      let selector = selector(heading).before(here())
      let level = counter(selector).display()

      // Show notes only if there are any
      if book-notes-state.get().keys().contains(level) {
        pagebreak(weak: true)

        // Insert note where <note> stood:
        for note in book-notes-state.get().at(level) {
          par(first-line-indent: 0pt, spacing: 0.75em, hanging-indent: 1em)[
            #link(label(level + "-" + str(note.at(0))))[
              #text(weight: "bold", [#note.at(0):])
            ]
            #label(level + "-" + str(note.at(0)) + "-content")
            #note.at(1)
          ]
        }

        pagebreak(weak: true)
      }

      // Make every heading's notes start at note 1
      book-note-counter.update(1)
    }
  }

  // Tranform the note markers in links to note content:
  show super: it => {
    // RegEx to find note label:
    let note-regex = regex("::[0-9-.]+::")

    if it.body.text.ends-with(note-regex) {
      let note-label = it.body.text.find(note-regex).trim(":") + "-content"
      let note-number = it.body.text.replace(note-regex, "").trim()

      // Create link to note content:
      link(label(note-label))[#super(note-number)]
    } else {
      it
    }
  }

  // Generate cover
  if cover != none {
    set image(
      fit: "stretch",
      width: 100%,
      height: 100%
    )
    if cover.func() == image {
      set page(background: cover)
    }
    else if type(cover) == content {
      cover
    }
    else {
      panic("Invalid page argument value: \"" + cover + "\"")
    }
    pagebreak()
  }

  // Generate titlepage
  if titlepage != none and titlepage != false {
    if type(titlepage) == content {
      titlepage
    } else if titlepage == true {
      align(center + top)[
        #text(size: 27.5pt)[#title]
        #linebreak()
        #v(5pt)
        #text(size: 15pt)[#subtitle]
      ]
      align(center + bottom)[
        #text(size: 13pt)[#authors]
        #linebreak()
        #text(size: 13pt)[#date.display("[year]")]
      ]
    }
    else {
      panic("Invalid titlepage argument value: \"" + cover + "\"")
    }
    pagebreak(weak: true)
  }

  // Generate TOC
  if toc == true {
    show outline.entry.where(level: 1): it => {
      v(font-size, weak: true)
      strong(it)
    }
    show outline.entry: it => {
      h(1.5em)
      it
    }

    pagebreak(weak: true, to: "even")
    outline()
    [#metadata("Marker for situating titles after/before outline") <outline>]
    pagebreak(weak: true)
  }
  
  
  pagebreak(weak:true, to: "even")
  
  // Start page numbering at the next even page:
  set page(numbering: "1")
  counter(page).update(1)

  body
}


// Collect notes and the level of its owner heading to book-notes-state.
// Insert note number in place.
#let note(
  content,
  numbering-style: "1"
) = context {
  // Find the level (numbering) of current heading:
  let selector = selector(heading).before(here())
  let level = counter(selector).display()
  
  book-note-counter.step()
  
  let this-note = (book-note-counter.get().at(0), content)
  let book-notes-state-old = book-notes-state.get()
  
  // If already exists other notes in the same level:
  if book-notes-state-old.keys().contains(level) {
    book-notes-state-old.at(level).push(this-note)
    
  }
  // If does not exist any note in this level yet:
  else {
    book-notes-state-old.insert(level, ())
    book-notes-state-old.at(level).push(this-note)
  }
  
  book-notes-state.update(book-notes-state-old)
  
  let note-number = numbering(numbering-style, ..book-note-counter.get())
  let note-label = level + "-" + note-number
  
  // Set note as [NUMBER ::LABEL::] to be treated later
  [#super(note-number + " ::" + note-label + "::")#label(note-label)]
}


// Adds a horizontal rule to the text
#let horizontalrule(
  symbol: [#sym.ast.op #sym.ast.op #sym.ast.op],
  spacing: 1em,
  line-size: 15%,
) = [
  #v(spacing, weak: true)
  
  #align(center)[
    #block(width: 100%)[
      #box(height: 1em, align(center + horizon)[#line(length: line-size)])
      #box(height: 1em)[#symbol]
      #box(height: 1em, align(center + horizon)[#line(length: line-size)])
    ]
  ]
  
  #v(spacing, weak: true)
]

// Alias for `#horizontalrule` command:
#let hr = horizontalrule

// Alias for `#quote(block: true)` command:
#let blockquote(by: none, ..args) = quote(block: true, attribution: by, ..args)