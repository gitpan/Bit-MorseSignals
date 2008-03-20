#!perl -T

use strict;
use warnings;

use utf8;

use Test::More tests => 1;

use Bit::MorseSignals::Receiver;

my $pants = new Bit::MorseSignals::Receiver;

my $msg  = 'é';
my @bits = split //, '11110' . '100' . '11000011' . '10010101' . '01111';

$pants->push for @bits;

is($pants->msg, $msg, 'message properly stored');
