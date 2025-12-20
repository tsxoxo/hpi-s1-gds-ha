== doc
https://typst.app/docs/reference/model/enum/

== custom label

#set enum(numbering: "a)")

+ foo
+ bar

== styles

#show enum: it => block(above: 1.4em, below: 2em, it)
#set enum(indent: .5em)

