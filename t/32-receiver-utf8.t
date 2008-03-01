#!perl -T

use strict;
use warnings;

use utf8;

use Test::More 'no_plan';

use Bit::MorseSignals::Receiver;

my $hlagh;

my $pants = new Bit::MorseSignals::Receiver done => sub { $hlagh = $_[1] };

my $msg  = 'é';
my @bits = split //, '11110' . '010' . '11000011' . '10010101' . '01111';

$pants->push for @bits;

ok(defined $hlagh && $hlagh eq $msg, 'message properly received');
