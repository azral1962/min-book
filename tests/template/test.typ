#import "/src/lib.typ"

#let doc = read("/template/main.typ")
#let doc = doc.replace(regex("#import.*?min-book.*"), "")
#let doc = doc.replace(
  regex("(read|yaml)\(\"/?"),
  m => m.captures.at(0) + "(\"/template/"
)

#eval(
  "[" + doc + "]",
  scope: dictionary(lib)
)