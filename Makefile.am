##############################################################################
# $Id: Makefile.am,v 1.12 2006/03/09 17:38:14 rockyb Exp $
#  Copyright (C) 2003, 2004, 2006 Rocky Bernstein <rocky@cpan.org>
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, 
#  Boston, MA  02110-1301  USA
##############################################################################

SUBDIRS = docs tests
noinst_SCRIPTS = post-configure.in touch.pl
EXTRA_DIST = post-configure.in ps-watcher.in.in ps-watcher \
	     touch.pl Makefile.PL \
	     samples/README samples/sample.ini samples/sample2.ini \
	     samples/port-watch.ini samples/solaris.ini
bin_SCRIPTS = ps-watcher
PERL 	= @PERL@

DISTCLEANFILES = ps-watcher ps-watcher.stamp


# The keeps automake from substituting PS_VARS
PS_VARS = ''

# Build all forms of documentation: manual-pages and HTML
test: 
	echo "Checking that things work.."; \
	(cd tests && $(PERL) ./driver) 

# A timestamp file is used to record whether or not we've created 
# $(PROGRAM) from $(PROGRAM).in. During debugging if is often more
# convenient to modify $(PROGRAM) rather than $(PROGRAM).in.
$(PACKAGE).stamp: $(PACKAGE)
	@cp -p $(PACKAGE) $(PACKAGE).in ; \
	$(srcdir)/touch.pl $@

# cvs2cl
MAINTAINERCLEANFILES = ChangeLog

if MAINTAINER_MODE

.PHONY: ChangeLog
ChangeLog:
	$(CVS2CL) -W 450 --header $(srcdir)/cvs2cl_header --utc -w -I ChangeLog --usermap $(srcdir)/cvs2cl_usermap -P 

ACLOCAL_AMFLAGS=-I .

endif




