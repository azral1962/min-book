// NAME: Minimal Books
// REQ: numbly
// TODO: Implement ePub output when available
// IDEA: Use transl fluent l10n

#import "additional/notes.typ": note
#import "additional/ambient.typ": appendices, annexes
#import "additional/horizontalrule.typ": horizontalrule, hr
#import "additional/blockquote.typ": blockquote

/**
 * = Quick Start
 *
 * ```typ
 * #import "@preview/min-book:1.1.0": book
 * #show: book.with(
 *   title: "Book Title",
 *   subtitle: "Book subtitle, not more than two lines long",
 *   authors: "Book Author",
 * )
 * ```
 * 
 * = Description
 * 
 * Generate complete and complex books, without any annoying new commands or
 * syntax, just good old pure Typst. This package manipulates the standard Typst
 * elements as much as possible, adapting them to the needs of a book structure
 * in a way that there's no need to learn a whole new semantic just because of
 * _min-book_.
 * 
 * For some fancy book features there is no existing compatible Typst element to
 * re-work and adapt; in those cases, this package do provide additional commands
 * that are completely optional, for the sake of completeness.
 * 
 * This package comes with some thoughful ready-to-use defaults but also allows
 * you to play with highly customizable options if you need them, so it's really
 * up to you: customize it your way or ride along the defaults — both ways are
 * possible and encouraged.
 * 
 * #pagebreak()
 * 
 * = Options
 * 
 * These are all the options and its defaults used by _min-book_:
 * 
 * :book: show
**/
#let book(
  title: none,
  /** <- string | content <required>
    * Main title. **/
  subtitle: none,
  /** <- string | content | none
    * Subtitle, generally two lines long or less. **/
  edition: 0,
  /** <- int
    * Publication number, used when the content is changed or updated in a new
    * release after the original publication. **/
  volume: 0,
  /** <- int
    * Series volume number, used when one extensive story is told through
    * multiple books, in order. **/
  authors: none,
  /** <- string | array <required>
    * Author (`string`) or authors (`array` of `strings`). **/
  date: datetime.today(),
  /** <- datetime | array | dictionary
    * Publication date — an array or dictionary `(year, monty, day)` or `datetime`.**/
  cover: auto,
  /** <- auto | content | image | none
    * Cover — generated automatically (`auto`) or manually (`content`), from an
    * `image`, or not generated (`none`). **/
  titlepage: auto,
  /** <- auto | content | none
    * Title page, shown after cover — generated automatically (`auto`) or
    * manually (`content`). **/
  catalog: none,
  /** <- dictionary | toml | yaml
    * Cataloging in publication board, with library data — see @catalog. **/
  errata: none,
  /** <- content | string
    * A text that corrects errors from previous book editions. **/
  dedication: none,
  /** <- content | string
    * A brief text that dedicates the book in honor or in memorian of someone
    * important — can accompany a small message directed to the person. **/
  acknowledgements: none,
  /** <- content | string
    * A brief text to recognize everyone who helped directly or indirectly in
    * the process of book creation and their importance in the project. **/
  epigraph: none,
  /** <- quote | content
    * A short citation or excerpt of other works used to introduce the main
    * theme of the book; can suggest a reflection, a mood, or idea related to
    * the text. **/
  toc: true,
  /** <- boolean
    * Generate table of contents. **/
  part: auto,
  /** <- auto | string | none
    * Name of the main divisions of the book — set manually (`string`) or
    * defaults to the word "Part" in book language (`auto`). **/
  chapter: auto,
  /** <- string | none
    * The name of the sections of the book — set manually (`string`) or
    * defaults to the word "Chapter" in book language (`auto`). **/
  cfg: auto,
  /** <- dictionary
    * Custom advanced configurations, used to fine-tune some aspects of the
    * book — see @adv-config. **/
  body
  /** <- content
    * The book content.**/
) = {
  import "@preview/numbly:0.1.0": numbly
  import "utils.typ"
  
  // Required arguments
  assert.ne(title, none)
  assert.ne(authors, none)
  
  /**
   * = Advanced Configurations <adv-config>
   * 
   * :cfg: arg `typc` "(?s)\s*let\s<name>\s=\s\((.*?\n)\s*\.\.<name>,\s*\)\s*\n?\n"
   *
   * These `#book(cfg)` configurations allows to modify certain aspects of the
   * book and manage its appearance and structure. Built with some thoughful
   * ready-to-use defaults that make its use optional, so that beginners and
   * casual writers can safely ignore it and _just write_.
   * 
  **/
  if cfg == auto {cfg = (:)}
  let cfg = (
    numbering-style: auto,
      /** <- array | string | none
        * Custom heading numbering — a standard numbering (`string`) or a
        * #univ("numbly") numbering (`array`). **/
    page: "a5",
      /** <- dictionary | string
        * Page configuration — act as `#set page(..cfg.page)` when `dictionary`
        * or as `#set page(paper: cfg.page)` when `string`. **/
    lang: "en",
      /** <- string
        * Book language. **/
    lang-data: toml("assets/lang.toml"),
      /** <- toml
        * Translation file — see the `src/assets/lang.toml` file. **/
    justify: true,
      /** <- boolean
        * Text justification. **/
    line-space: 0.5em,
      /** <- length
        * Space between each line in a paragraph. **/
    par-margin: 0.65em,
      /** <- length
        * Space after each paragraph. **/
    first-line-indent: 1em,
      /** <- length
        * indentation of the first line of each paragraph in a sequence, except
        * the first one. **/
    margin: (x: 15%, y: 14%),
      /** <- length
        * Page margin. **/
    font: ("Book Antiqua", "Times New Roman"),
      /** <- string | array
        * Text font family, and fallback options (`array`). **/
    font-math: "Asana Math",
      /** <- string | array
        * Math font family, and fallback options (`array`) — see the `README.md`
        * file to download the default font, if needed. **/
    font-mono: "Inconsolata",
      /** <- string | array
        * Monospaced font family, and fallback options (`array`) — see the
        * `README.md` file to download the default font, if needed. **/
    font-size: 11pt,
      /** <- length
        * Text font size. **/
    heading-weight: auto,
      /** <- string | auto
        * Heading font weight (thickness) — set as `"regular"` or `"bold"`,
        * defaults to regular in levels 1–5 then bold (`auto`). **/
    cover-bgcolor: rgb("#3E210B"),
      /** <- color
        * Cover background color when `#book(cover: auto)`. **/
    cover-txtcolor: luma(200),
      /** <- color
        * Cover text color when `#book(cover: auto)`. **/
    cover-fonts: ("Cinzel", "Alice"),
      /** <- array
        * Cover font families when `#book(cover: auto)` — an array `(TITLE, TEXTS)`
        * for title and text fonts, respectively. **/
    cover-back: true,
      /** <- boolean
        * Generate a back cover at the end of the document when `#book(cover: auto)` **/
    toc-indent: none,
      /** <- length | auto | none
        * Indentation of each table of contents entry — by default, all entries
        * of level 2+ are equally indented in 1.5em (`none`). **/
    toc-bold: true,
      /** <- boolean
        * Allows bold fonts in table of contents entries. **/
    chapter-numrestart: false,
      /** <- boolean
        * Make chapter numbering restart after each book part. **/
    two-sided: true,
      /** <- boolean
        * Optimizes the content to be printed on both sides of the page (front
        * and back), with important elements always starting at the next front
        * side (oddly numbered) — inserts blank pages in between, if needed.**/
    link-readable: true,
      /** <- boolean
        * Enable paper-readable links, which inserts the clickable link alongside
        * a footnote to its URL. **/
    ..cfg,
  )

  date = utils.date(date)
  
  // Translate cfg.two-sided into a #pagebreak(to) value
  let break-to = if cfg.two-sided {"odd"} else {none}
  utils.cfg(add: "break-to", break-to)
  
  if type(cfg.page) == str {cfg.page = (paper: cfg.page)}

  set document(
    title: if subtitle != none {title + " - " + subtitle} else {title},
    author: authors,
    date: date
  )
  set page(
    margin: cfg.margin,
    ..cfg.page
  )
  set par(
    justify: cfg.justify,
    leading: cfg.line-space,
    spacing: cfg.par-margin, 
    first-line-indent: cfg.first-line-indent
  )
  set text(
    font: cfg.font,
    size: cfg.font-size,
    lang: cfg.lang
  )
  set terms(
    separator: [: ],
    tight: true,
    hanging-indent: 1em,
  )
  set list(marker: ([•], [–]))
  
  // Set part and chapter translations based on text.lang
  let translation = cfg.lang-data.lang.at(cfg.lang)
  
  // Fallback system when #text.lang not in #book(cfg.lang-data) file
  if translation == none {
    let lang = cfg.lang-data.conf.at("default-lang", default: none)
    translation = cfg.lang-data.at("lang").at(lang)
    
    if translation == none {
      panic("Translation not found for " + cfg.lang + " (fallback failed)")
    }
  }
  utils.cfg(add: "translation", translation)
  
  if part == auto {part = translation.part}
  if chapter == auto {chapter = translation.chapter}
  
  /**
   * = Advanced Numbering
   * 
   * The book headings can be numbered two ways: using a
   * #url("https://typst.app/docs/reference/model/numbering/")[standard]
   * numbering string or a #univ("numbly") numbering array. Strings are more
   * simple and easy to use, while arrays are more complete and customizable.
   * 
   * By default, _min-book_ uses slightly different numbering when `#book(part)`
   * is enabled or disabled, that's why _parts_ and _chapters_ appear to have
   * independent numbering when used. The `#book(cfg.numbering-style)` option
   * allow to set a custom numbering used whether `#book(part)` is enabled or
   * disabled.
  **/
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

  /**
   * = Book Parts
   *
   * ```typ
   * #show: book.with(
   *   part: "Act",
   * )
   * = This is a part!  // Act 1
   * ```
   * 
   * Some larger books are internally divided into multiple _parts_. This
   * structure allows to better organize and understand a text with multiple
   * sequential plots, or tales, or time jumps, or anything that internally
   * differentiate parts of the story. Each book can set different names for
   * them, like parts, subjects, books, acts, units, modules, etc;
   * by default, _min-book_ tries to get the word for "Part" in `#book(cfg.lang)`
   * language as its name (fallback to English).
   * 
   * When set a value (`string`), all level 1 headings become _parts_: they
   * occupy the entire page and are aligned at its middle; some decorative frame
   * also appear when `#book(cover: auto)`.
   * 
   * 
   * = Book Chapters
   * 
   * 
   * #grid(columns: (1fr, 1fr),
   *   ```typ
   *   #show: book.with(
   *     chapter: "Scene",
   *   )
   *   == This is a chapter!  // Scene 1 
   *   ```,
   *   ```typ
   *   #show: book.with(
   *     part: none,
   *     chapter: "Scene",
   *   )
   *   = This is a chapter!  // Scene 1
   *   ```
   * )
   * 
   * In most cases, books are divided into smaller sections called chapters.
   * Generally, each chapter contains a single minor story, or event, or scene,
   * or any type of subtle plot change. Each book can set different names for
   * them, like chapters, sections, articles, scenes, etc; by default, _min-book_
   * tries to get the word for "Chapter" in `#book(cfg.lang)` language as its
   * name (fallback to English).
   * 
   * Chapters are smart: when set a value (`string`), if `#book(parts: none)`
   * all level 1 headings become chapters; otherwise, all level 2 headings become
   * chapters — since the level 1 are parts.
  **/
  set heading(
    // #utils.numbering set #book(part) and #book(chapter)
    numbering: utils.numbering(
        patterns: (
          cfg.numbering-style,
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
  
  show heading: it => {
    let weight
    if cfg.heading-weight == auto {
      weight = if it.level < 6 {"regular"} else {"bold"}
    }
    else {
      weight = cfg.heading-weight
    }
  
    set align(center)
    set par(justify: false)
    set text(
      hyphenate: false,
      weight: weight,
    )
    
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
        
      if counter(page).get().at(0) != 1 {pagebreak(to: break-to)}
      
      set page(background: part-bg)
      set par(justify: false)
      
      align(center + horizon, it)
      
      set page(background: none)
      pagebreak(to: break-to, weak: true)
      
      if cfg.chapter-numrestart == false {
        // Get the current level 2 heading count:
        let current-h2-count = book-h2-counter.get()
        // Level 2 heading numbering will not restart after level 1 headings now:
        counter(heading).update((h1, ..n) => (h1, ..current-h2-count))
      }
    }
    else {
      it
    }
  }
  show heading.where(level: 2): it => {
    book-h2-counter.step()
    it
  }
  show heading.where(level: 1): set text(size: cfg.font-size * 2)
  show heading.where(level: 2): set text(size: cfg.font-size * 1.6)
  show heading.where(level: 3): set text(size: cfg.font-size * 1.4)
  show heading.where(level: 4): set text(size: cfg.font-size * 1.3)
  show heading.where(level: 5): set text(size: cfg.font-size * 1.2)
  show heading.where(level: 6): set text(size: cfg.font-size * 1.1)
  show quote.where(block: true): set pad(x: 1em)
  show raw: set text(
    font: cfg.font-mono,
    size: cfg.font-size,
  )
  show raw.where(block: true): it => pad(left: cfg.first-line-indent, it)
  show math.equation: set text(font: cfg.font-math)
  show selector.or(
      terms, enum, list, table, figure, math.equation.where(block: true),
      quote.where(block: true), raw.where(block: true)
    ): set block(above: cfg.font-size, below: cfg.font-size)
  show ref: it => context {
    let el = it.element
    
    // When referencing headings in "normal" form
    if el != none and el.func() == heading and it.form == "normal" {
      let patterns = if cfg.numbering-style != auto {cfg.numbering-style}
        else if part != none {part-pattern}
        else {no-part-pattern}
      
      // Remove \n and trim full stops
      if patterns != none and part != "" {
        patterns = patterns.map(
          item => item.replace("\n", "").trim(regex("[.:]"))
        )
        
        let number = numbly(..patterns)(..counter(heading).at(el.location()))
        
        // New reference without \n
        link(el.location())[#el.supplement #number]
      }
      else {link(it.target, el.body)}
    }
    else {it}
  }
  show link: it => {
    if cfg.link-readable and type(it.dest) == str and it.dest != it.body.text {
      it
      footnote(it.dest)
    }
    else {it}
  }
  
  // Insert notes of a section at its end, before next heading:
  import "additional/notes.typ"
  body = notes.insert(body)
  
  if volume == 0 {volume = ""}
  if edition == 0 {edition = ""}
  if titlepage == none and catalog != none and cfg.two-sided {
    // Automatic blank titlepage when generating catalog
    titlepage = []
  }

  if cover != none {
    import "components/cover.typ": init as add-cover
    
    /**
     * = Book cover
     * 
     * By default, _min-book_ automatically generates a book cover if `#book(cover)`
     * is not set, it's also possible to set a custom cover image or create one
     * using Typst code. The default automatic cover
     * #url("https://typst.app/project/r2QBJy0CmrAmvMWT1NmUEW", "code") can be a good start
     * as a base to create your own version.
     *
    **/
    
    add-cover(cover, title, subtitle, date, authors, volume, cfg, translation)
    pagebreak(to: break-to)
  }

  if titlepage != none {
    import "components/titlepage.typ": init as add-titlepage
    
    add-titlepage(
      titlepage, title, subtitle, authors, date, volume, edition, translation
    )
    if catalog != none {pagebreak()}
    else {pagebreak(to: break-to, weak: true)}
  }

  if catalog != none {
    /**
     * = Cataloging in Publication <catalog>
     * 
     * :catalog: arg `typc` "(?s)\s*let <name> = \((.*?\n)\s*\.\.<name>.*?\)\s*\n"
     * 
     * These `#book(catalog)` options set the data used to create the
     * "cataloging in publication" board. Other needed information are
     * automatically retrieved from the book data, but at least one of these
     * options must be explicitly set to generate the board; otherwise it will
     * be just ignored.
    **/
    let catalog = (
      id: none,
      /** <- string | content
        * A #url("http://www.cutternumber.com/")[Cutter-Sanborn identification code],
        * used to identify the book author. **/
      place: none,
      /** <- string | content
        * The city or region where the book was published. **/
      publisher: none,
      /** <- string | content
        * The organization or person responsible for releasing the book. **/
      isbn: none,
        /** <- string | content
          * The _International Standard Book Number_, used to identify the book. **/
      subjects: (),
      /** <- array
        * A list of subjects related to the book; must be an array of strings. **/
      access: (),
      /** <- array
        * A list of access points used to find the book in catalogues, like by
        * `"Title"` or `"Series"`; must be an array of strings. **/
      ddc: none,
      /** <- string | content
        * A #url("https://www.oclc.org/content/dam/oclc/dewey/ddc23-summaries.pdf")[Dewey Decimal Classification]
        * number, which corresponds to the specific category of the book. **/
      udc: none,
      /** <- string | content
        * An #url("https://udcsummary.info/php/index.php")[Universal Decimal Classification]
        * number, which corresponds to the specific category if the book. **/
      before: none,
      /** <- content
        * Content showed before (above) the cataloging in public ation board;
        * generally editorial data like publisher, editors, reviewers,
        * copyrights, etc. **/
      after: none,
      /** <- content
        * Content showed after (below) the cataloging in publication board;
        * generally additional information that complements the board data. **/
      ..catalog,
    )
    
    import "components/catalog.typ": new
    
    new(catalog, title, subtitle, authors, date, volume, edition)
  }
  
  if errata != none {
    pagebreak(to: break-to, weak: true)
    heading(
      translation.errata,
      numbering: none,
      outlined: false,
    )
    errata
    pagebreak(to: break-to)
  }
  
  if dedication != none {
    set text(size: cfg.font-size - 2pt)
    
    pagebreak(to: break-to, weak: true)
    align(center + horizon, dedication)
    pagebreak(to: break-to)
  }
  
  if acknowledgements != none {
    set par(justify: true)
    
    pagebreak(to: break-to, weak: true)
    // INFO: Acknowledgements without title for now, seems cleaner
    // heading(
    //   translation.acknowledgements  ,
    //   numbering: none,
    //   outlined: false,
    // )
    acknowledgements
    pagebreak(to: break-to)
  }
  
  if epigraph != none {
    set align(right + bottom)
    set quote(block: true)
    set text(
      size: cfg.font-size - 2pt,
      style: "italic",
    )
    
    pagebreak(to: break-to, weak: true)
    pad(
      epigraph,
      left: 1cm,
    )
    pagebreak(to: break-to)
  }
  
  if toc == true {
    show outline.entry.where(level: 1): it => {
      // Special formatting to parts in TOC:
      if part != none and cfg.toc-bold == true {
        v(cfg.font-size, weak: true)
        strong(it)
      }
      else {
        it
      }
    }
    let indenting = if cfg.toc-indent == auto {auto}
      else {
        lvl => {
          if cfg.toc-indent != none {cfg.toc-indent * lvl}
          else { if lvl > 0 {1.5em} else {0em} }
        }
      }

    pagebreak(to: break-to, weak: true)
    outline(
      indent: indenting,
      depth: if cfg.numbering-style == none {2} else {none},
    )
    pagebreak(weak: true)
  }
  
  // <outline> anchor allows different numbering styles in TOC and in the actual text.
  [#metadata("Marker for situating titles after/before outline") <outline>]
  
  // Start page numbering at the next even page:
  if part != none {pagebreak(weak: true, to: break-to)}
  set page(numbering: "1")
  counter(page).update(1)

  body
  
  if cover == auto and cfg.cover-back {
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
    
    pagebreak(weak: true, to: break-to)
    page(
      footer: none,
      background: cover-bg,
      fill: cfg.cover-bgcolor,
      []
    )
  }
}


/**
 * = Additional Commands
 * 
 * These commands are provided as a wa6 to access some fancy book features that
 * cannot be implemented by re-working and adapting existing Typst elements. They
 * are completely optional and is perfectly possible to write an entire book.
**/