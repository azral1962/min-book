// NAME: Minimal Books
// REQ: numbly
// TODO: #book(catalog: dictionary) -> Catalographic sheet (ISBN)
// TODO: Implement ePub output when available

#import "@preview/numbly:0.1.0": numbly


#let book-tr-state = state("book-tr", (:))
#let book-notes-state = state("book-notes", (:))
#let book-note-counter = counter("book-note-count")


// FEATURE: #book() used in #show rule to re-structure the document as book.
#let book(
  title: none,
  subtitle: none,
  authors: none,
  date: datetime.today(),
  cover: auto,
  titlepage: none,
  part: auto,
  chapter: auto,
  numbering-style: auto,
  toc: true,
  page-cfg: "a5",
  lang: "en",
  lang-data: toml("assets/lang.toml"),
  justify: true,
  line-space: 0.5em,
  par-margin: 0.65em,
  first-line-indent: 1em,
  margin: (x: 15%, y: 14%),
  font: ("Book Antiqua", "Times New Roman"),
  font-math: "Asana Math",
  font-size: 11pt,
  body
) = {
  import "utils.typ"

  utils.required-args(
    title: title,
    authors: authors,
    body: body
  )

  date = utils.date(date)
  page-cfg = if type(page-cfg) == str {(paper: page-cfg)} else {page-cfg}

  set document(
    title: if subtitle != none {title + " - " + subtitle} else {title},
    author: if type(authors) == array {authors.join(", ")} else {authors},
    date: date
  )
  set page(
    margin: margin,
    ..page-cfg
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
  set terms(
    separator: [: ],
    tight: true,
    hanging-indent: 1em,
  )
  
  // Context to make translations available
  context {
    // Set part and chapter translations based on text.lang
    let translation = lang-data.at("lang").at(text.lang)
    let part = if part == auto {translation.part} else {part}
    let chapter = if chapter == auto {translation.chapter} else {chapter}
    
    // Set translations state to be used outside #book()
    book-tr-state.update(translation)

    let part-pattern = (
      "{1:I}:\n",
      "{2:I}.\n",
      "{2:I}.{3:1}.\n",
      "{2:I}.{3:1}.{4:1}.\n",
      "{2:I}.{3:1}.{4:1}.{5:1}.\n",
      "{2:I}.{3:1}.{4:1}.{5:1}.{6:a}. ",
    )
    
    let no-part-pattern = (
      "{1:I}.\n",
      "{1:I}.{2:1}.\n",
      "{1:I}.{2:1}.{3:1}.\n",
      "{1:I}.{2:1}.{3:1}.{4:1}.\n",
      "{1:I}.{2:1}.{3:1}.{4:1}.{5:1}.\n",
      "{1:I}.{2:1}.{3:1}.{4:1}.{5:1}.{6:a}. ",
    )

    set heading(
      numbering: utils.numbering(
          patterns: (
            numbering-style,
            part-pattern,
            no-part-pattern,
          ),
          scope: (
            h1: part,
            h2: chapter
          )
        ),
      hanging-indent: 0pt,
      supplement: it => {
          if part != none {
            context if it.depth == 1 {part}
            else if chapter != none {chapter}
            else {auto}
          }
          else if chapter != none {chapter}
          else {auto}
        }
    )
  
    // Count every level 2 heading:
    let book-h2-counter = counter("book-h2")
    
    show heading.where(level: 2): it => {
      book-h2-counter.step()
      it
    }
    show heading.where(level: 1, outlined: true): it => {
      // Create part page, if any:
      if part != none {
      
        // Set page background
        let part-bg = if cover == auto {
            let m = page.margin
            let frame = image(
                width: 93%,
                "assets/frame-gray.svg"
              )
              
            if type(m) != dictionary {
              m = (
                top: m,
                bottom: m,
                left: m,
                right: m
              )
            }
            
            v(m.top * 0.25)
            align(center + top, frame)
            
            align(center + bottom,
              rotate(180deg, frame)
            )
            v(m.bottom * 0.25)
          } else {
            none
          }
          
        
        // Part only if numbering != none
        pagebreak(weak: true, to: "even")
        set page(background: part-bg)
        set par(justify: false)
        
        align(center + horizon, it)
        
        pagebreak(weak: true)
      }
      else {
        it
      }
  
      context if type(part) != none {
        // Get the current level 2 heading count:
        let current-h2-count = book-h2-counter.get()
        // Level 2 heading numbering will not restart after level 1 headings now:
        counter(heading).update((h1, ..n) => (h1, ..current-h2-count))
      }
    }
    show heading: set align(center)
    show heading: set par(justify: false)
    show heading: set text(hyphenate: false)
    show heading.where(level: 1): set text(size: font-size * 2)
    show heading.where(level: 2): set text(size: font-size * 1.6)
    show heading.where(level: 3): set text(size: font-size * 1.4)
    show heading.where(level: 4): set text(size: font-size * 1.3)
    show heading.where(level: 5): set text(size: font-size * 1.2)
    show heading.where(level: 6): set text(size: font-size * 1.1)
    show raw: set text(font: "Inconsolata", size: font-size)
    show quote.where(block: true): set pad(x: 1em)
    show raw.where(block: true): it => pad(left: 1em, it)
    show math.equation: set text(font: font-math)
    show selector.or(
        terms, enum, list, table, figure, math.equation.where(block: true),
        quote.where(block: true), raw.where(block: true)
      ): set block(above: font-size, below: font-size)
    show ref: it => context {
      let el = it.element
      
      // When referencing headings in "normal" form
      if el != none and el.func() == heading and it.form == "normal" {
        let patterns = if numbering-style != auto {numbering-style}
          else if part != none {part-pattern}
          else {no-part-pattern}
        // Remove \n and trim full stops
        patterns = patterns.map(
          item => item.replace("\n", "").trim(regex("[.:]"))
        )
          
        let number = numbly(..patterns)(..counter(heading).at(el.location()))
        
        // New reference without \n
        link(el.location())[#el.supplement #number]
      }
      else {
        it
      }
    }
  
    // Insert notes of a section at its end, before next heading:
    // NOFIX: This really clumsy code is the only way found to implement #note.
    
    let new-body = body.children
    let h-index = ()
    
    // #note: Get index of all headings in body.children
    for n in range(new-body.len()) {
      let item = new-body.at(n)
      
      if item.func() == heading {
        h-index.push(n)
      }
    }
  
    // #note: Insert anchor <note> before each heading obtained
    for n in range(h-index.len()) {
      new-body.insert(h-index.at(n) + n, [#metadata("Note anchor") <note>])
    }
  
    // #note:Insert a final anchor <note> at the end of the document
    new-body.push([#metadata("Note anchor") <note>])
  
    // #note: Make the edited new-body into the document body
    let body = new-body.join()
  
    // #note: Make the first note be note 1, instead of note 0.
    book-note-counter.update(1)
  
    // #note: Swap the <note> for the actual notes in the current section, if any.
    show <note>: it => {
      context if book-notes-state.final() != (:) {
        // Find the level (numbering) of current section heading:
        let selector = selector(heading).before(here())
        let level = counter(selector).display()
  
        // Show notes only if there are any in this section
        if book-notes-state.get().keys().contains(level) {
          pagebreak(weak: true)
  
          // Insert the notes:
          for note in book-notes-state.get().at(level) {
            par(
              first-line-indent: 0pt,
              spacing: 0.75em,
              hanging-indent: 1em
            )[
              // Link to the note marker in the text:
              #link(label(level + "-" + str(note.at(0)) ))[
                #text(weight: "bold", [#note.at(0):])
              ]
              // Insert <LEVEl-content> for cross-reference
              #label(level + "-" + str(note.at(0)) + "-content")
              #note.at(1)
            ]
          }
  
          pagebreak(weak: true)
        }
  
        // Make every section notes start at note 1
        book-note-counter.update(1)
      }
    }
  
    show super: it => {
      let note-regex = regex("::[0-9-.]+::")
      
      // #note: Transform note markers in links to the actual notes:
      // - Targets the `#super("NUMBER ::LABEL::")` returned by `#note`
      // - After handled, turn them into `#link(<LABEL>)[#super("NUMBER")]`
      if it.body.text.ends-with(note-regex) {
        let note-label = it.body.text.find(note-regex).trim(":") + "-content"
        let note-number = it.body.text.replace(note-regex, "").trim()
  
        // Link to the actual note content:
        link(label(note-label))[#super(note-number)]
      } else {
        it
      }
    }

    
    // Generate cover
    if cover != none {
      if cover == auto {
        let cover-bg = context {
            let m = page.margin
            let frame = image(
                width: 93%,
                "assets/frame.svg"
              )
              
            if type(m) != dictionary {
              m = (
                top: m,
                bottom: m,
                left: m,
                right: m
              )
            }
            
            v(m.top * 0.25)
            align(center + top, frame)
            
            align(center + bottom, rotate(180deg, frame))
            v(m.bottom * 0.25)
          }
        
        set text(
          fill: luma(200),
          hyphenate: false
        )
        set par(justify: false)
        
        page(
          margin: (x: 12%, y: 12%),
          fill: rgb("#3E210B"),
          background: cover-bg
        )[
          #align(center + horizon)[
            #set par(leading: 2em)
            #context text(
              size: page.width * 0.09,
              font: "Cinzel",
              title
            )
            #linebreak()
            #set par(leading: line-space)
            #if subtitle != none {
            v(1cm)
              context text(
                size: page.width * 0.04,
                font: "Alice",
                subtitle
              )
              //v(4cm)
            }
          ]
          #align(center + bottom)[
            #block(width: 52%)[
              #context text(
                size: page.width * 0.035,
                font: "Alice",
                authors + "\n" + date.display("[year]")
              )
            ]
          ]
        ]
      }
      else if type(cover) == content {
        cover
      }
      else if cover != none {
        panic("Invalid page argument value: \"" + cover + "\"")
      }
      pagebreak()
    }
  
    // Generate titlepage
    if titlepage != none and titlepage != false {
      if type(titlepage) == content {
        titlepage
      } else if titlepage == true {
        align(center + horizon)[
          #set par(leading: 2em)
          #context text(
            size: page.width * 0.09,
            title
          )
          #linebreak()
          #set par(leading: line-space)
          #if subtitle != none {
          v(1cm)
            context text(
              size: page.width * 0.04,
              subtitle
            )
            //v(4cm)
          }
        ]
        align(center + bottom)[
          #block(width: 52%)[
            #context text(
              size: page.width * 0.035,
              authors + "\n" + date.display("[year]")
            )
          ]
        ]
      }
      else {
        panic("Invalid titlepage argument value: \"" + repr(titlepage) + "\"")
      }
      pagebreak(weak: true)
    }
  
    // Generate TOC
    if toc == true {
      show outline.entry.where(level: 1): it => {
        // Special formatting to parts in TOC:
        if part != none {
          v(font-size, weak: true)
          strong(it)
        }
        else {
          it
        }
      }
  
      pagebreak(weak: true, to: "even")
      outline(
        indent: lvl => if lvl > 0 {1.5em} else {0em},
        depth: if numbering-style == none {2} else {none},
      )
      pagebreak(weak: true)
    }
    // <outline> anchor allows different numbering styles in TOC and in the actual text.
    [#metadata("Marker for situating titles after/before outline") <outline>]
    
    
    // Start page numbering at the next even page:
    pagebreak(weak:true, to: "even")
    set page(numbering: "1")
    counter(page).update(1)
  
    body
  }
  
  if cover == auto {
    let cover-bg = context {
          let m = page.margin
          let frame = image(
              width: 93%,
              "assets/frame.svg"
            )
            
          if type(m) != dictionary {
            m = (
              top: m,
              bottom: m,
              left: m,
              right: m
            )
          }
          
          v(m.top * 0.25)
          align(center + top, frame)
          
          align(center + bottom,
            rotate(180deg, frame)
          )
          v(m.bottom * 0.25)
        }
    
    pagebreak(weak: true, to: "odd")
    page(
      footer: none,
      background: cover-bg,
      fill: rgb("#3E210B"),
      []
    )
  }
}


// FEATURE: #note() insert end notes in text; the notes appear one page before next heading.
// TODO: Store #note(numbering-style) in #book-notes-state.
#let note(
  content,
  numbering-style: "1"
) = context {
  context book-note-counter.step()
  
  // Find the level (numbering) of current section heading:
  let selector = selector(heading).before(here())
  let level = counter(selector).display()
  
  let this-note = (book-note-counter.get().at(0), content)
  
  // Insert book-notes-state.at(level) = this-note:
  if book-notes-state.get().at(level, default: none) == none {
    book-notes-state.update(notes => {
      notes.insert(level, (this-note,))
      notes
    })
  }
  // Insert this-note to existing book-notes-state.at(label):
  else {
    book-notes-state.update(notes => {
      notes.at(level).push(this-note)
      notes
    })
  }
  
  let note-number = numbering(numbering-style, ..book-note-counter.get())
  let note-label = level + "-" + note-number

  // Set note as #super[NUMBER ::LABEL::] to be managed later
  [#super(note-number + " ::" + note-label + "::")#label(note-label)]
}


// FEATURE: #appendices() is an ambient to insert multiple appendices.
#let appendices(
  type: "appendix",
  title: auto,
  numbering-style: (
    "",
    "{2:A}.\n",
    "{2:A}.{3:1}. ",
    "{2:A}.{3:1}.{4:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}.{6:a}. ",
  ),
  body
) = context {
  import "utils.typ"

  // Set name for "appendix" and "appendices" titles
  let (singular-title, plural-title) = if title == auto {
      book-tr-state.get().at(type)
    } else {
      title
    }
  
  // Main title (plural)
  heading(
    plural-title,
    level: 1,
    numbering: none
  )
  counter(heading).update(0)
  
  set heading(
    offset: 1,
    numbering: utils.numbering(
        patterns: (numbering-style,),
        scope: (
          h1: none,
          h2: singular-title,
          n: 1
        )
      ),
    supplement: singular-title
  )
  
  show heading.where(level: 2): it => {
    pagebreak()
    it
  }
  
  body
}

// FEATURE: #annexes() is an ambient to insert multiple annexes.
#let annexes(
  type: "annex",
  ..args
) = appendices(
  type: type,
  title: auto,
  ..args
)


// FEATURE: #horizontalrule() adds a visual separator in the text flow
#let horizontalrule(
  symbol: [#sym.ast.op #sym.ast.op #sym.ast.op],
  spacing: 1em,
  line-size: 15%,
) = {
  v(spacing, weak: true)
  
  align(
    center,
    block(width: 100%)[
      #box(
        height: 1em,
        align(
          center + horizon,
          line(length: line-size)
        )
      )
      #box(height: 1em, symbol)
      #box(
        height: 1em,
        align(
          center + horizon,
          line(length: line-size)
        )
      )
    ]
  )
  
  v(spacing, weak: true)
}


// FEATURE: #hr() is an alias to #horizontalrule()
#let hr = horizontalrule


// FEATURE: #blockquote() is an alias for `#quote(block: true)`
#let blockquote(by: none, ..args) = quote(block: true, attribution: by, ..args)