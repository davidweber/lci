#
# Copyright (C) David Weber <david@embeddedtoolbox.com>
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#

SRCS = cmd.cc cmd_table.c debug.c hw_reg.cc mem_map.cc ci.cc main.cc
VERSION = 1.0.0
VERDATE := $(VERSION) (built by $(shell whoami) on $(shell date +%c))
DATE := $(shell date +%Y%m%d_%H%M%S)
OUTNAME = lci
BINDIR_ARM = bin/arm
OUTNAME_ARM = $(BINDIR_ARM)/$(OUTNAME)
OBJS = $(SRCS:.c*=.o)
TARBALL = ../../$(OUTNAME)_$(VERSION)-$(DATE).tar.gz
PROMPT = [$(OUTNAME)] \# 
CC_ARM = $(CROSS_COMPILE)g++
CFLAGS_ARM = -I. -I./libtecla/arm -L. -L./libtecla/arm -O2 -D VERSION=\""$(VERDATE)"\" \
             -D PROMPT=\""$(PROMPT)"\"
LDFLAGS_ARM = -ltecla 

all: $(OUTNAME_ARM)

$(OUTNAME_ARM) : $(OBJS) makefile
	$(CC_ARM) $(CFLAGS_ARM) -D PROGRAM_NAME=\"${OUTNAME_ARM}\" $(OBJS) -o $(OUTNAME_ARM) $(LDFLAGS_ARM)

.PHONY : clean

clean:
	@rm -f $(OUTNAME_ARM)

help:
	@grep "cmd::" cmd_table.c | cut -d\: -f3 | cut -d\" -f2
