#!perl -T

use strict;
use warnings;

use utf8;

use Test::More tests => 10;

use Bit::MorseSignals qw/BM_DATA_STORABLE/;
use Bit::MorseSignals::Emitter;
use Bit::MorseSignals::Receiver;

my @msgs = (
 \(undef, -273, 1.4159, 'yes', '¥€$'),
 [ 5, 6, 7 ],
 { hlagh => 1, HLAGH => 2 },
 { lol => [ 'bleh', { pants => 0.9999999999, deuce => 1 }, undef, 4684324 ] },
);
$msgs[7]->{wut} = { dong => [ 0 .. 99 ], recurse => $msgs[7] };
my $i = 0;

my $deuce = new Bit::MorseSignals::Emitter;
my $pants = new Bit::MorseSignals::Receiver done => sub {
 my $cur = shift @msgs;
 is_deeply($_[1], $cur, 'got object ' . $i++);
};

$deuce->post($_) for @msgs;
$pants->push while defined ($_ = $deuce->pop); # ))<>((

ok(!$deuce->busy, 'emitter is no longer busy after all the messages have been sent');
ok(!$pants->busy, 'receiver is no longer busy after all the messages have been got');

ok(0, 'didn\'t got object ' . $i++) for @msgs;
