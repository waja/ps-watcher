#!/usr/bin/perl -w
# $Id: paction.t,v 1.2 2006/03/10 03:21:12 rockyb Exp $
# Arg paction-statement
use strict;
use Test::More;
use Config;

if ('cygwin' eq $Config{osname}) {
    plan( skip_all => "cygwin's ps is not powerful enough this test");
    exit 0;
}

my $test='paction';
print "1..2\n";

my $srcdir = $ENV{srcdir} ? $ENV{srcdir} : '.';
my $cmd = "../ps-watcher --log --nosyslog --nodaemon " 
        . " --sleep -1 --config ${srcdir}/$test.cnf";
my @output = `$cmd 2>&1`;

# First line is Id line. This doesn't count in testing.
shift @output;

my $count=0;
foreach (@output) {
  if (/^.+:\s+.*ok/) {
    s/.+:\s+//;
    print $_;
    $count++;
    last;
  }  
}
print "ok 2\n" if $count>0;

#;;; Local Variables: ***
#;;; mode:perl ***
#;;; End: ***
