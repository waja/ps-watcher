#!/usr/bin/perl -w -T                                          -*- Perl -*-
# $Id: 01.pod.t.in,v 1.1 2006/03/09 17:37:31 rockyb Exp $
my $top_builddir = $ENV{top_builddir} ? $ENV{top_builddir} : '..';

use Test::More;
use File::Spec::Functions;
eval "use Test::Pod 1.14";
plan skip_all => "Test::Pod 1.14 required for testing POD" if $@;
all_pod_files_ok(catfile($top_builddir, "ps-watcher"));
