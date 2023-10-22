# Lineage of the flip-flop operator
**2023-01-11**  
draft

Last week, these Tweets by Gary Bernhardt appeared on my timeline:

![A screenshot of tweet thread by @garybernhardt posted on Jan 6th 2023:
The bug that I'm working on only exists because JS code can throw any value,
not just Error instances. I like to take these opportunities to fondly remember
the uncountable confident statements that "[insert language misfeature] isn't
really a problem; just don't use it".
You can't just "not use" programming language misfeatures.
They will actively seek you out and there's nothing you can do about it.
OK, there's one exception: Ruby's flip-flop operator.
It has never been used in any code......................................... ever.
](/images/flip-flop-gary-tweets.png)
*Source: https://twitter.com/garybernhardt/status/1611159965351444480*

As a someone who uses Ruby in my day job, I was quite interested in learning
about an obscure or lesser used feature of the language.
Maybe I could find a use case for it in my work, or at least be satisfied in the
knowledge that it's there?

Well, after looking it up in the docs I can say it's definitely a very niche
feature and I'm inclined to agree with Gary.
I found this feature odd enough that I had to know the reason for this being in
the language, so this post details the small amount of research I did in looking
up the lineage of the Ruby flip-flop operator.
  
## The flip-flop operator in Ruby

At the time of writing, the most current version of Ruby is version 3.2, in
which the [flip-flop operator][ruby_flip_flop] is documented.
However, instead of diving into it right away, let me breifly explain the Ruby
range syntax to give some context to why I find this operator so unusual.

Ruby, like many other languages, has
[syntax for producing a range of values][ruby_range_literal].
This can be in either the two dot inclusive form or the three dot exlusive form.
In either case, this syntax is a literal expression which results in an instance
of the [`Range` class][ruby_range_class] which produces values from the start
value on the left, to end value on the right.

```ruby
# Two dot syntax inclusive range
(0..10).to_a # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Three dot syntax exclusive range
(0...10).to_a # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

# Can even create ranges from characters
("a".."f").to_a # => ["a", "b", "c", "d", "e", "f"]

# Ranges where the end value is lower than the start value produce and empty range
(10..1).to_a # => []
```

The flip-flop operator reuses the dot syntax, but instead expects two boolean
expressions on either side of the dots.
The Ruby documentation gives this explanation and simple example:

> "The form of the flip-flop is an expression that indicates when the flip-flop
> turns on, `..` (or `...`), then an expression that indicates when the
> flip-flop will turn off.
> While the flip-flop is on it will continue to evaluate to `true`, and `false`
> when off." - [docs.ruby-lang.org][ruby_flip_flop]

```ruby
selected = []

0.upto 10 do |value|
  selected << value if value==2..value==8
end

p selected # prints [2, 3, 4, 5, 6, 7, 8]
```

To any developers familiar with Ruby, this might appear like it's actually some
sort of syntactic sugar for the [Enumerable#include?][ruby_enumerable_include]
method. In fact if I did see this code in the wild I would be tempted to
refactor the conditional into this (contrivied example notwithstanding):
```ruby
selected = []

0.upto 10 do |value|
  selected << value if (2..8).include?(value)
end

p selected # prints [2, 3, 4, 5, 6, 7, 8]
```

However in this case, the flip-flop operator is repurposing the syntax for range
literals to evaluate to boolean value dependant on evaluation context.

* However in this case, the flip-flop operator...
* How does it work (with examples)
* Don't use it!: https://www.rubydoc.info/gems/rubocop/RuboCop/Cop/Lint/FlipFlop
* Deprecated at one point and then added back: https://bugs.ruby-lang.org/issues/5400
* What was the first reference of flip-flop operator in Ruby?
* Oldest syntax manual found: https://ruby-doc.org/docs/ruby-doc-bundle/Manual/man-1.4/syntax.html#range
* Ask maintainer of ruby-doc.org James Britt <james@jamesbritt.com> for older docs
* He didn't know, ask matz
* He did know! post email response!
* Been in since at least 0.49 but before that is pre-version control
* Consider it being in Ruby forever
* Segue to perl somehow~~~

## The range operator in Perl

* Present in current Perl: https://perldoc.perl.org/perlop#Range-Operators
* How does it work with examples
* Known as the range operator
* Has two modes `..` awk mode and `...` sed mode
* How old is this?
* Asked maintainer of perldoc Dan Book<dbook@cpan.org> for older doc
* He pointed that the perl git has all the history including the manpages
* It's in perl 1!: https://github.com/Perl/perl5/blob/perl-1.0/perl.man.1#L708-L739
* Checking git, it was added in perl 4
  * Revision history: https://github.com/Perl/perl5/blob/perl-4.0.36/perl.man#L9
  * Documentation: https://github.com/Perl/perl5/blob/perl-4.0.36/perl.man#L1427-L1462
* Ask Larry Wall <larry@wall.org> about implementation details
* Specifically mentions sed and awk as predecessors for this functionality
* Segue to awk

## The range pattern in awk

* Present in awk: https://www.gnu.org/software/gawk/manual/html_node/Ranges.html
* Known as the range pattern or record range with patterns
* How does it work with examples
* Awk is a POSIX standardised tool: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/awk.html
* Extract from POSIX documentation
* How old is this functionality?
* Older version of POSIX were called SUS (Single UNIX Specification): https://en.wikipedia.org/wiki/POSIX
* SUSv1 and SUSv2 can be found online: https://unix.stackexchange.com/questions/19816/where-can-i-find-official-posix-and-unix-documentation## Sed's range addresses
* Standardised maybe in POSIX.1 (pre-SUS)? Need to research
* Originally added to Unix 7th edition
* Man page for this in the archive: http://man.cat-v.org/unix_7th/1/awk
* Awk was preceded by sed: https://en.wikipedia.org/wiki/AWK

## Range of addresses in sed

* Present in sed: https://www.gnu.org/software/sed/manual/sed.html#Range-Addresses
* Known as range addresses
* How does it work with examples
* Sed is also a POSIX standardised tool: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html
* Functionality inherited from ed

## Range of addresses in ed

* ed is the standard text editor.
* https://en.wikipedia.org/wiki/Ed_(text_editor)
* http://man.cat-v.org/unix-1st/1/ed
* http://man.cat-v.org/plan_9_1st_ed/1/ed

## Range of addresses in qed

* https://en.wikipedia.org/wiki/QED_(text_editor)
* https://gunkies.org/wiki/QED_(text_editor)
* https://github.com/arnoldrobbins/qed-archive/
* Mentioned "Text Addressing" section on the bottom line of the sds-940
  manual
* Original article in ACM magazine: 
* https://dl.acm.org/doi/pdf/10.1145/363848.363863
* Mentions two existing "online" editors of the time on other mainframes
  outside of Berkelee
* Project MAC (https://en.wikipedia.org/wiki/MIT_Computer_Science_and_Artificial_Intelligence_Laboratory)
* AN/FSQ-32 (https://en.wikipedia.org/wiki/AN/FSQ-32)

## Pre-UNIX text editors

* Can't be assed to trace which editors QED was inspired by
* Pls let me know

## Timeline

* Try and make a timeline of the history of this operation?

[ruby_flip_flop]: https://docs.ruby-lang.org/en/3.2/syntax/control_expressions_rdoc.html#label-Flip-Flop
[ruby_range_literal]: https://docs.ruby-lang.org/en/3.2/syntax/literals_rdoc.html#label-Range+Literals
[ruby_range_class]: https://docs.ruby-lang.org/en/3.2/Range.html
[ruby_enumerable_include]: https://docs.ruby-lang.org/en/3.2/Enumerable.html#method-i-include-3F

## Emails

```
From: Yukihiro Matsumoto <matz@ruby.or.jp>
To: Jai Sharma <jai@jai.moe>
Subject: Re: History of the flip-flop operator in Ruby
Date: Sunday, 8 January 2023 1:15 AM

Hi,  

The oldest version available now is 0.49 (far before the first public
release), and flip-flop operator was already implemented. Unfortunately we
didn't use version control at the time, we couldn't track any further.
So we can consider it has been in Ruby from the beginning.  

FYI, we have tried to remove this old fashion feature for simplicity but
failed because so many people were still using it.

        matz.
```

```
From: Larry Wall <larry@wall.org>
To: Jai Sharma <jai@jai.moe>
Subject: Re: History of the Range Operator
Date: Friday, 13 January 2023 8:26 PM

1. Yes, the scalar version of the range operator was inspired by sed and
awk but sed and awk are highly specialized languages with PATTERN/ACTION
syntax, while Perl is a generalized language with matchers specified as
parts of the normal expression syntax (likewise Ruby).  For that reason,
using a comma would have been highly problematic due to ambiguity with the
various other meanings of comma within normal expression syntax (function
arguments, list construction, C-style comma operator).  We could not use
hyphen for ranges as we do in English, because that's ambiguous with
subtraction.  Some languages use colon for range, but that would be
ambiguous with C's ?: ternary operator.  So I picked .. because ... is
sometimes used to indicate something is skipped in a list in English, and
because it looks a little like a horizontal colon.

The difference between .. and ... is because sed and awk actually have
different semantics for whether you retest the current line when the
condition goes false, or wait till the next line.

Of course, in Perl .. is also overloaded with integer list generation in
list context.  Interestingly, in Raku (nee Perl 6) we chose to
differentiate the two operators, so .. only creates a Range object (which
can be used either for matching ranges or generating integer sequences),
while ... becomes a generalized series generator as it is in Haskell.
On the other hand, the bistable range-matching flipflop behavior is
separated out into the operators ff and fff (matching the scalar semantics
of .. and ... in Perl).  In general, any Perl operator that had different
semantics for scalar/list context is split out into separate operators in
Raku, because compile-time scalar/list context is incompatible with lazy
evaluation, which Raku does.  And it just reads more clearly when the
operators aren't overloaded like Perl does.

2. Where various languages hide or show their state is a fascinating topic
worthy of a dissertation or two.  OO languages like to hide their state in
objects, while functional languages tend to keep their state on the
function call stack.  Logic programming languages like Icon and Prolog
take yet another approach, where the state is associated with partial
pattern matches that can be backtracked into.  Perl's range matchers are
more like that, but are not the only example of it.  Perl also stores match
state around regex matches.  This is hardwired in Perl, but Raku takes a
more OO approach underneath (much more like Ruby), but makes it look more
like Perl's surface semantics.

Perl and Raku have explored a space where the declarative vs imperative
distinction is intentionally fuzzy.  The Raku compiler is written mostly in
Raku, and nearly all the builtin functions are defined exactly the same as
user-defined functions, but just appear to come in from an outer lexical
scope.  Basically, things that can run at compile time are declarative, and
things that have to be deferred to run-time are imperative, but BEGIN
blocks and such introduce run-time during compile time, while EVAL
introduces compile-time back into run time.

And, in fact, while users of sed and awk can think of the range matchers as
declarative, sed and awk have to maintain exactly the same state at runtime
to decide whether the current line is in or out of a given range.  The flip
side is that anything in Perl/Raku that can be evaluated at compile-time
(constant expressions, for example, or function definitions) can be thought
of as declarative.  In Raku, for instance, you can declare infinite
constants.  So if you say 1,2,4...* you are declaring an infinite but
constant sequence of powers of 2, but of course, that expression must be
evaluated lazily or you'll run out of memory.  The entire lazy evaluation
mechanism of languages like Haskell and Raku can be considered run-time
state associated with the construct, on an implementation level, but Raku,
and to an even greater extent, Haskell, try to hide this under a veneer of
immutability.

Anyway, if you like Ruby, I think you'll like Raku as well, because
"everything is an object" in Raku, so it's very OO, but methods and
operators are just functions that are picked by various dispatchers that
are also functions, so it's also very FP when you want it to be.
There is no distinction between built-in and user-defined code other than
what falls out of ordinary scoping rules (that is, lexical scoping for
functions, or inheritance for methods). One advantage of Raku over Ruby is
that it supports multiple dispatch, so that symmetric operators are treated
symmetrically by the dispatcher without artificially associating the
operator with one argument or the other.

Well, that's probably a longer answer than you were looking for.... 😅

Larry
```