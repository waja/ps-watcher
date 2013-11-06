#!/usr/bin/perl -w
my $vcid='$Id: touch.pl,v 1.4 2006/03/08 19:22:41 rockyb Exp $ ';
#  Copyright (C) 1997-2006  R. Bernstein email: rocky@cpan.org
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
use strict;
use File::Basename;
my $program = basename($0); # Who am I today, anyway? 

if (@ARGV != 1) {
  print "
usage:
  $program *file*

  A perl implimentation of a minimal Unix touch command: creates file *file*
  if it does not exist. In either case, the file is given a creation 
  time of the current time.
";
  exit 100;
}

print "$ARGV[0]\n";
if (-e $ARGV[0]) {
  my $now = time();
  my $count = utime $now, $now, $ARGV[0];
  exit ($count != 1);
} else {
  open(FILE, ">$ARGV[0]") || die "Can't open $ARGV[0]: $!";
  close(FILE);
  exit $?;
}
