Hello Matz,

I'm currently researching the lineage of the flip-flop operator syntax in Ruby
and was wondering if you could help me.

I have only recently come across this operator in the Ruby language, and despite
programming in Ruby for some time I had never encountered it before. This
piqued my interest, so I'm now looking up the history of this operator and
where came from for my own curiosity.

Doing some light research, I've found that the lineage of this operator was
inspired by the syntax in Perl, which in turn emulates the behaviour of range
addresses in awk and original UNIX text editing tools of sed/ed/qed.

My current question is trying to figure out at which point the flip-flop
operator was implemented in Ruby.

From searching ruby-doc.org, the oldest syntax manual I can find is for the
syntax of Ruby 1.4 which document this language feature and it's usage, however
I am not able to find any syntax documentation earlier than the 1.4 release.
https://ruby-doc.org/docs/ruby-doc-bundle/Manual/man-1.4/syntax.html#range

I have previously asked James Britt, the current maintainer of ruby-doc.org, if
there were any older versions of this document available but he doesn't know.
He also pointed me to ask you directly via email.

If possible, would you be able to tell me if the flip-flop operator was added
in version of Ruby prior to 1.4 and if so, at which point was it added?
I would try and test myself, but it appears only versions from 1.6.7 are
available to download from ruby-lang.org.

Thanks for making Ruby,

Jai