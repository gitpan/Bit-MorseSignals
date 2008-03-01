#!perl -T

use strict;
use warnings;

use Test::More tests => 9;

use Bit::MorseSignals::Emitter;
use Bit::MorseSignals::Receiver;

my @msgs = qw/hlagh hlaghlaghlagh HLAGH HLAGHLAGHLAGH \x{0dd0}\x{00}
              h\x{00}la\x{00}gh \x{00}\x{ff}\x{ff}\x{00}\x{00}\x{ff}/;

my $deuce = new Bit::MorseSignals::Emitter;
my $pants = new Bit::MorseSignals::Receiver
                 done => sub { ok($_[1] eq shift @msgs, "got $_[1]") };

$deuce->post($_) for @msgs;
$pants->push while defined ($_ = $deuce->pop); # ))<>((

ok(!$deuce->busy, 'emitter is no longer busy after all the messages have been sent');
ok(!$pants->busy, 'receiver is no longer busy after all the messages have been got');

ok(0, "didn\'t got $_") for @msgs;
