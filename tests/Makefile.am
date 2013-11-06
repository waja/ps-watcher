##############################################################################
# $Id: Makefile.am,v 1.9 2006/03/09 17:37:31 rockyb Exp $
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
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
##############################################################################

MOSTLYCLEANFILES = *~ 

# The keeps automake from substituting PS_VARS
PS_VARS = ''

check_SCRIPTS = 01.pod.t args.t basic.t count.t full.t paction.t

check_DATA = args.cnf  basic.cnf \
	     count.cnf full.cnf paction.cnf

EXTRA_DIST = $(check_SCRIPTS) $(check_DATA) \
	01.pod.t.in args.t.in basic.cnf.in count.t.in driver

all: 

check: test

test:
	srcdir=$(srcdir); export srcdir; \
	$(PERL) $(srcdir)/driver
