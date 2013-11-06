##############################################################################
# $Id: Makefile.am,v 1.8 2005/05/17 09:53:00 rockyb Exp $
#  Copyright (C) 2003, 2004 Rocky Bernstein
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

# Section 8 is system administration
EXT=8
man8_MANS = $(PACKAGE).$(EXT)

MOSTLYCLEANFILES = *~ $(man8_MANS) $(PACKAGE).html
EXTRA_DIST = $(man8_MANS) $(PACKAGE).html
DISTCLEANFILES = pod2htmi.tmp pod2htmd.tmp

# The keeps automake from substituting PS_VARS
PS_VARS = ''

# Files making up the documentation part of this package
DOCS     = $(man_MANS) $(PACKAGE).html

# THIS SHOULD BE THE FIRST TARGET!
all: $(DOCS) Makefile

$(PACKAGE).html: ../$(PACKAGE).in
	-pod2html --infile=../$(PACKAGE).in --outfile=$@

$(man8_MANS): ../$(PACKAGE).in
	-pod2man --section=$(EXT) --name=$(PACKAGE) ../$(PACKAGE).in >$@
