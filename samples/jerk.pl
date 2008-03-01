#!/usr/bin/env perl

use strict;
use warnings;

use lib qw{blib/lib};
use Bit::MorseSignals::Emitter;
use Bit::MorseSignals::Receiver;

my $deuce = new Bit::MorseSignals::Emitter;
my $pants = new Bit::MorseSignals::Receiver done => sub { print $_[1], "\n" };

$deuce->post('HLAGH') for 1 .. 3;
$pants->push while defined ($_ = $deuce->pop);
