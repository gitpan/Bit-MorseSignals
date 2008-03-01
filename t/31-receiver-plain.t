#!perl -T

use strict;
use warnings;

use Test::More 'no_plan';

use Bit::MorseSignals::Receiver;

my $hlagh;

my $pants = new Bit::MorseSignals::Receiver done => sub { $hlagh = $_[1] };

my $msg  = 'x';
my @bits = split //, '111110' . '000' . '00011110' . '011111';

$pants->push for @bits;

ok(defined $hlagh && $hlagh eq $msg, 'message properly received');
