== aligned equation block

$
a^2 + 2a + 1 - a - 1 = b^2 + 2b + 1 - b - 1 \
(a + 1)^2 -a - 1 = (b + 1)^2 - b - 1
$

=== with commentary

$
a^2 + 2a + 1 - a - 1 &= b^2 + 2b + 1 - b - 1 &&quad("foo")\
(a + 1)^2 -a - 1 &= (b + 1)^2 - b - 1 &&quad("umformun")
$

spacing: `&&quad`, `&&space`, `&&#h(length)`

== consecutive blocks with separation in between

$ // regular block
a^2 + 2a + 1 - a - 1 = b^2 + 2b + 1 - b - 1 \
(a + 1)^2 -a - 1 = (b + 1)^2 - b - 1
$
#h(1fr) (multiply equations) #h(1fr)          // comment
$ // regular block
a^2 + 2a + 1 - a - 1 = b^2 + 2b + 1 - b - 1 \
(a + 1)^2 -a - 1 = (b + 1)^2 - b - 1
$
#align(center)[#line(length: 30%)]            // centered line
$ // regular block
a^2 + 2a + 1 - a - 1 = b^2 + 2b + 1 - b - 1 \
(a + 1)^2 -a - 1 = (b + 1)^2 - b - 1
$

== numbered

#set math.equation(numbering: "(1)", number-align: bottom + right)
$ a^2 + 2a + 1 - a - 1 &= b^2 + 2b + 1 - b - 1 &&quad "foo"\ $
$ (a + 1)^2 -a - 1 &= (b + 1)^2 - b - 1 &&quad "umformun" $

or caveman style
$
(1)&&quad a^2 + 2a + 1 - a - 1 &= b^2 + 2b + 1 - b - 1 &&quad "foo" \
(2)&&quad (a + 1)^2 -a - 1 &= (b + 1)^2 - b - 1 &&quad "umformun" &&
$
