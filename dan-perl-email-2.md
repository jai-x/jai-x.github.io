Hello Dan,

Thanks so much for the link to the Perl 1 manpage.

It's pleasantly surprising to see that the history of Perl language has been
preserved by backporting(?) the source code history to the current git repo.

It's clear the the two dot syntax of the range operator is present since the
beginning of the language, but the three dot syntax was added much later.

Doing some digging I've found that the three dot variant was added in
Perl 4.0.36, specifically patch 20. It seems that the individual patch changes
have been combined at some point and don't seem to have translated correctly
into git, but the history is preserved in the revision history at the top of the
manpage.
Revision history: https://github.com/Perl/perl5/blob/perl-4.0.36/perl.man#L9
Documentation: https://github.com/Perl/perl5/blob/perl-4.0.36/perl.man#L1427-L1462

Ideally, I would like to know why this specific syntax was used as the mapping
from the original awk and sed functions, but I think I would have to ask
Larry Wall about that. His website lists larry@wall.org as his email and I will
try and see if he responds. Incidentally, if you know anyone else that may know
about this history of this, please let me know.

Thanks for your help,

Jai