use strict;
use warnings;
use ExtUtils::MakeMaker;

my $BUILD_REQUIRES = {
 'utf8'                => 0,
 'ExtUtils::MakeMaker' => 0,
 'Test::More'          => 0,
};

sub build_req {
 my $tometa = ' >> $(DISTVNAME)/META.yml;';
 my $build_req = 'echo "build_requires:" ' . $tometa;
 foreach my $mod ( sort { lc $a cmp lc $b } keys %$BUILD_REQUIRES ) {
  my $ver = $BUILD_REQUIRES->{$mod};
  $build_req .= sprintf 'echo "    %-30s %s" %s', "$mod:", $ver, $tometa;
 }
 return $build_req;
}

WriteMakefile(
    NAME          => 'Bit::MorseSignals',
    AUTHOR        => 'Vincent Pit <perl@profvince.com>',
    LICENSE       => 'perl',
    VERSION_FROM  => 'lib/Bit/MorseSignals.pm',
    ABSTRACT_FROM => 'lib/Bit/MorseSignals.pm',
    PL_FILES      => {},
    PREREQ_PM     => {
        'Carp'     => 0,
        'Encode'   => 0,
        'Exporter' => 0,
        'Storable' => 0,
    },
    dist          => { 
        PREOP      => 'pod2text lib/Bit/MorseSignals.pm > $(DISTVNAME)/README; '
                      . build_req,
        COMPRESS   => 'gzip -9f', SUFFIX => 'gz'
    },
    clean         => { FILES => 'Bit-MorseSignals-* *.gcov *.gcda *.gcno cover_db' },
);
