#!perl -T

use strict;
use warnings;

use Test::More tests => 3;

use Bit::MorseSignals::Receiver;

my $pants = new Bit::MorseSignals::Receiver;
ok(defined $pants, 'BMR object is defined');
ok(ref $pants eq 'Bit::MorseSignals::Receiver', 'BMR object is valid');

my $fake = { };
bless $fake, 'Bit::MorseSignal::Hlagh';
eval { Bit::MorseSignals::Receiver::reset($fake) };
ok($@ && $@ =~ /^First\s+argument/, "BMR methods only apply to BMR objects");
