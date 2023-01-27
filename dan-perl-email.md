Hello Dan,

I'm currently researching the lineage of the range operator syntax in Perl
and was wondering if you could help me.

I am Ruby programmer in my day job, and have recently come across the flip-flip
operator, which has the same syntax and operation as the Perl range operator and
was borrowed from Perl when Ruby was first released.
https://ruby-doc.org/3.2.0/syntax/control_expressions_rdoc.html#label-Flip-Flop
https://perldoc.perl.org/perlop#Range-Operators

In Ruby, the use of this operator is quite niche and despite programming in Ruby
for some time I had never encountered it before. This piqued my interest, so I'm
now looking up the history of this operator and where came from for my own
curiosity.

Doing some light research, I've found that the lineage of this operator was
inspired by the syntax in Perl, which in turn emulates the behaviour of range
addresses in awk and the original UNIX text editing tools of sed/ed/qed.

My current question is trying to figure out at which point the range operator
operator was implemented in Perl. I have a suspicion that this feature has been
present since Perl was first release but I would like to able to prove this
somehow, and maybe find some context for why it was implemented in the way it
was.

I believe the current documentation available at perldoc.perl.org only shows
documentation from Perl version 5.0 onwards. Is there any available online
documentation from earlier versions of Perl so I can see if this feature is
present there?

From some searching, it seems that earlier versions of Perl were entirely
documented in a single man page. Do you know if an archive of these man pages
are available anywhere?

Thanks for maintaining perldoc,

Jai