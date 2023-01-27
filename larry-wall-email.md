Hello Larry,

I'm currently researching the lineage of the range operator syntax in Perl
and was wondering if you could help me.

I am Ruby programmer in my day job, and have recently come across the flip-flip
operator, which has the same syntax and operation as the Perl range operator and
was borrowed from Perl when Ruby was first released.
Ruby Flip-flop: https://ruby-doc.org/3.2.0/syntax/control_expressions_rdoc.html#label-Flip-Flop
Perl Range Operator: https://perldoc.perl.org/perlop#Range-Operators

In Ruby, the use of this operator is quite niche, and despite programming in
Ruby for some time I had never encountered it before. This sparked my interest,
so I'm now looking up the history of this operator and where came from for my
own curiosity.

My current research has led me to discover that the range operator two dot
syntax  has been present since Perl 1.0 and the three dot syntax was added in
Perl 4.0.36. Thankfully, the source code history has been ported to the modern
git repo which has been a big help.

Perl 1.0 Range Operator: https://github.com/Perl/perl5/blob/perl-1.0/perl.man.1#L708-L739
Perl 4.0.36 Range Operator: https://github.com/Perl/perl5/blob/perl-4.0.36/perl.man#L1427-L1462
Perl 4.0.36 Revision history: https://github.com/Perl/perl5/blob/perl-4.0.36/perl.man#L9

Helpfully, the man pages and current documentation state that this functionality
was inspired by both awk and sed range addresses, which answered my initial
questions about the lineage of this operator.

I have a few questions to do with the specific syntax and implementation
of translating this awk/sed feature into Perl I and was hoping if you could
answer? I'm not particularly familiar with Perl myself, but I have tried to
research, so I hope you can forgive any inaccuracies in my questions:

1. I belive the range operator was inspired by the range address syntax in
awk and sed. What inspired the usage of the two/three dot syntax for this
operator? Why not simply re-use the comma syntax already present in awk and sed?

2. The range operator, in the scalar context, produces a boolean value which has
its own internal bistablity. I've previously never seen a language level
operator mantain its own state like this and I don't think many modern languages
do this. What inspired you to implement it in this way?
This question feels sort of dumb to write out since obviously the range operator
behaviour is a direct translation of the awk/sed behaviour, but awk and sed
use the range to operate directly on a given set of lines and as such it feels
more declarative whereas the perl operator evaluates to a boolean which makes it
feel more like an imperative translation?
I hope that makes sense?

Thanks for making perl,

Jai
