// NAME: Internal utilities sub-module

#let book-notes-state = state("book-notes", (:))
#let book-note-counter = counter("book-note-count")


// UTIL: Check if given required arguments are provided
#let required-args(..args) = {
  for arg in args.named().keys() {
    if args.named().at(arg) == none {
      panic("Missing required argument: " + arg)
    }
  }
}


// UTIL: Handles special numbering in #book and #appendices
#let numbering(
  patterns: (),
  scope: (:),
) = (
  ..nums
) => context {
  import "@preview/numbly:0.1.0": numbly

  // Set #patterns final value
  let patterns = if patterns.at(0) != auto {patterns.at(0)}
    else if scope.h1 != none {patterns.at(1, default: none)}
    else {patterns.at(0, default: none)}
  
  // Transform patterns into positional arguments
  patterns = arguments(..patterns).pos()
  
  let scope = scope
  
  // When using a default numbering string:
  if patterns.len() == 1 and not patterns.at(0).contains(regex("\{.*\}")) {
    return numbering(..patterns, ..nums)
  }
  
  // when numbering-style == none
  if patterns == () {
    if scope.h1 != none {
      patterns.push("\n")
      scope.h1 = scope.h1 + ":"
    }
    if scope.h2 != none {
      patterns.push("\n")
       scope.h2 = scope.h2 + ":"
    }
  }
  
  // Numbering showed after TOC.
  if query(selector(label("outline")).before(here())).len() != 0 {
    if scope.h1 != none and patterns.len() >= 1 {
      // Heading level 1 become part
      patterns.at(0) = scope.h1 + " " + patterns.at(0)
  
      // Heading level 2 become chapter
      if scope.h2 != none and patterns.len() >= 2 {
        patterns.at(1) = scope.h2 + " " + patterns.at(1)
      }
    } else {
      let n = scope.at("n", default: 0)
      
      // Heading level 1 become chapter, if no part
      if scope.h2 != none and patterns.len() >= 1 {
        patterns.at(n) = scope.h2 + " " + patterns.at(n)
      }
    }
  }
  // Numbering showed in TOC:
  else {
    let contents = ()
    
    for pattern in patterns {
      // Remove any "\n" at the end of numbering patterns:
      contents.push(
        pattern.trim(regex("\n+$"))
      )
    }
    patterns = contents
  }

  // Get numbering using numbly
  numbly(default: none, ..patterns)(..nums)
}


// UTIL: #note implementation code
// TODO: #implement-note
#let implement-note(
  body
) = context {
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
    if book-notes-state.final() != (:) {
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
      //link(label(note-label))[#super(note-number)]
    } else {
      it
    }
  }
  
  body
}

// UTIL: Create a date using named and positional arguments
#let date(..date) = {
  if type(date) == datetime {return date}
  
  if type(date.pos().at(0)) == array {date = arguments(..date.pos().at(0))}

  let year = if date.pos().len() >= 1 {date.pos().at(0)}
    else if date.named().at("year", default: none) != none {date.named().year}
    else {datetime.today().year()}
  
  let month = if date.pos().len() >= 2 {date.pos().at(1)}
    else if date.named().at("month", default: none) != none {date.named().month}
    else {1}

  let day = if date.pos().len() == 3 {date.pos().at(2)}
    else if date.named().at("day", default: none) != none {date.named().day}
    else {1}

  datetime(
    year: year,
    month: month,
    day: day
  )
}