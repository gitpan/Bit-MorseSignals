#!perl -T

use strict;
use warnings;

use utf8;

use Test::More 'no_plan';

use Bit::MorseSignals qw/BM_DATA_PLAIN/;
use Bit::MorseSignals::Emitter;

my $deuce = new Bit::MorseSignals::Emitter utf8 => 'DO WANT';

my $i;
sub test_bit {
 my ($desc, $b, $e) = @_;
 ok(defined $b && $b == $e,
    "$desc: bit $i : " . (defined $b ? "got $b, expected $e" : 'undef'));
 ++$i;
}

sub test_msg {
 my ($desc, $exp) = @_;
 my $last = pop @$exp;

 $i = 0;
 for (@$exp) {
  my $b = $deuce->pop;
  ok($deuce->busy, "$desc: BME object is busy after pop $i");
  test_bit $desc, $b, $_;
 }

 my $b = $deuce->pop;
 ok(!$deuce->busy, "$desc: BME object is no longer busy when over");
 test_bit $desc, $b, $last;
}

my $msg = 'é';
my @exp = split //, '11110' . '010' . '11000011' . '10010101' . '01111';

my $ret = eval { $deuce->post($msg) };
ok(!$@, "simple post doesn't croak ($@)");
ok(defined $ret && $ret > 0, 'simple post was successful');
ok($deuce->busy, 'BME object is busy after simple post');
ok(!$deuce->queued, 'BME object has no message queued after simple post');

test_msg 'simple post', [ @exp ];
ok(!defined $deuce->pop, "simple post: message is over");

$ret = eval { $deuce->post($msg) };
ok(!$@, "first double post doesn't croak ($@)");
ok(defined $ret && $ret > 0, 'first double post was successful');
ok($deuce->busy, 'BME object is busy after first double post');
ok(!$deuce->queued, 'BME object has no message queued after first double post');

$ret = eval { $deuce->post($msg) };
ok(!$@, "second double post doesn't croak ($@)");
ok(defined $ret && $ret < 0, 'second double post was queued');
ok($deuce->busy, 'BME object is busy after second double post');
ok($deuce->queued, 'BME object has a message queued after second double post');

test_msg 'first double post', [ @exp ];
ok(!$deuce->busy && $deuce->queued, 'first double post: BME object is no longer busy but still has something in queue between the two posts');
test_msg 'second double post', [ @exp ];
ok(!defined $deuce->pop, "second double post: message is over");

# Force non-utf8
@exp = split //, '00001' . '000' . '10010111' . '10000';

$ret = eval { $deuce->post($msg, type => BM_DATA_PLAIN); };
ok(!$@, "forced non-utf8 post doesn't croak ($@)");
ok(defined $ret && $ret > 0, 'forced non-utf8 post was successful');
ok($deuce->busy, 'BME object is busy after forced non-utf8 post');
ok(!$deuce->queued, 'BME object has no message queued after forced non-utf8 post');

test_msg 'forced non-utf8 post', [ @exp ];
ok(!defined $deuce->pop, "forced non-utf8 post: message is over");

