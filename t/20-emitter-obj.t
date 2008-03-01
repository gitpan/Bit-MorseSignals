#!perl -T

use strict;
use warnings;

use Test::More tests => 3;

use Bit::MorseSignals::Emitter;

my $deuce = new Bit::MorseSignals::Emitter;
ok(defined $deuce, 'BME object is defined');
ok(ref $deuce eq 'Bit::MorseSignals::Emitter', 'BME object is valid');

my $fake = { };
bless $fake, 'Bit::MorseSignal::Hlagh';
eval { Bit::MorseSignals::Emitter::reset($fake) };
ok($@ && $@ =~ /^First\s+argument/, "BME methods only apply to BME objects");
