#import "/src/lib.typ"

#let doc = read("/template/main.typ")
#let doc = doc.replace(regex("#import.*?min-book.*"), "")

#eval(
  "[" + doc + "]",
  scope: dictionary(lib)
)