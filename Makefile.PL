use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Bit::MorseSignals',
    AUTHOR              => 'Vincent Pit <perl@profvince.com>',
    LICENSE             => 'perl',
    VERSION_FROM        => 'lib/Bit/MorseSignals.pm',
    ABSTRACT_FROM       => 'lib/Bit/MorseSignals.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Carp'       => 0,
        'Encode'     => 0,
        'Exporter'   => 0,
        'Storable'   => 0,
        'Test::More' => 0,
    },
    dist                => { 
        PREOP => 'pod2text lib/Bit/MorseSignals.pm > $(DISTVNAME)/README',
        COMPRESS => 'gzip -9f', SUFFIX => 'gz'
    },
    clean               => { FILES => 'Bit-MorseSignals-*' },
);
