#!/usr/bin/perl -w
# $Id: count.t.in,v 1.5 2006/03/10 13:12:36 rockyb Exp $
# Some count checks
use strict;

my $test='count';
print "1..2\n";

my $srcdir = $ENV{srcdir} ? $ENV{srcdir} : '.';
my @output = `/usr/bin/perl ../ps-watcher --log --sleep -1 --nodaemon --config ${srcdir}/$test.cnf 2>&1`;

# First line is Id line. This doesn't count in testing.
shift @output;

my $count = @output;
foreach (@output) {
  s/.+:\s+//;
  print $_;
}
print "ok 2\n" unless $count == 2;

#;;; Local Variables: ***
#;;; mode:perl ***
#;;; End: ***
