/**
 * == Appendices Command
 * 
 * :appendices:
 * 
 * Creates an special ambient to write or include multiple appendices. An
 * appendix is any important additional data left out of the main document for
 * some reason, but directly referenced or needed by it. Inside this ambient,
 * all level 1 heading is a new appendix.
**/
#let appendices(
  type: "appendix",
  title: auto,
  /** <- array | auto
    * The name of the appendices — an array `(SINGULAR, PLURAL)` to each
    * "Appendix" and the part "Appendices" names, respectively, or
    * defaults to these same words in book language (`auto`). **/
  numbering-style: (
    "",
    "{2:A}.\n",
    "{2:A}.{3:1}. ",
    "{2:A}.{3:1}.{4:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}.{6:a}. ",
  ),
  /** numbering-style: <- array | string
    * Custom heading numbering for appendices — a standard numbering (`string`),
    * or a #univ("numbly") numbering (`array`). **/
  body
  /** <- content
    * The appendices content. **/
) = context {
  import "../utils.typ"

  // Set name for "appendix" and "appendices" titles
  let (singular-title, plural-title) = if title == auto {
      //book-tr-state.get().at(type)
      utils.cfg(get: "translation").at(type)
    } else {
      title
    }
  
  let break-to = utils.cfg(get: "break-to")
  
  set heading(
    offset: 1,
    numbering: utils.numbering(
        patterns: (numbering-style,),
        scope: (
          h1: "",
          h2: singular-title,
          n: 1
        )
      ),
    supplement: singular-title
  )
  
  show heading.where(level: 2): it => {
    pagebreak(to: break-to)
    it
  }
  
  
  pagebreak(weak: true, to: break-to)
  
  // Main title (plural)
  heading(
    plural-title,
    level: 1,
    numbering: none
  )
  
  counter(heading).update(0)
  
  body
}


/** 
 * == Annexes Command
 * 
 * :annexes:
 * 
 * Creates an special ambient to write or include multiple annexes. An annex is
 * any important third-party data directly cited or referenced in the main
 * document. Inside this ambient, all level 1 heading is a new annex.
**/
#let annexes(
  type: "annex",
  title: auto,
  /** <- auto | array
    * The name of the annexes — an array `(SINGULAR, PLURAL)` to each
    * "Annex" and the part "Annexes" names, respectively, or
    * defaults to these same words in book language (`auto`). **/
  numbering-style: (
    "",
    "{2:A}.\n",
    "{2:A}.{3:1}. ",
    "{2:A}.{3:1}.{4:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}.{6:a}. ",
  ),
  /** numbering-style: <- array | string
    * Custom heading numbering for annexes — a standard numbering (`string`), or
    * a #univ("numbly") numbering (`array`). **/
  body
  /** <- content
    * The annexes content. **/
) = appendices(
  type: type,
  title: title,
  numbering-style: numbering-style,
  body
)
