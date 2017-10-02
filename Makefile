# Makefile for dungeon

# Where to install the program
BINDIR = /usr/games

# Where to install the data file
DATADIR = /usr/games/lib

# Where to install the man page
MANDIR = /usr/share/man

# The dungeon program provides a ``more'' facility which tries to
# figure out how many rows the terminal has.  Several mechanisms are
# supported for determining this; the most common one has been left
# uncommented.  If you have trouble, especially when linking, you may
# have to select a different option.

# more option 1: use the termcap routines.  On some systems the LIBS
# variable may need to be set to -lcurses.  On some it may need to
# be /usr/lib/termcape.bc.  These options are commented out below.
# LIBS = -ltermcap
# TERMFLAG =
# LIBS = -lcurses
# LIBS = /usr/lib/termcap.bc

# more option 2: use the terminfo routines.  On some systems the LIBS
# variable needs to be -lcursesX, but probably all such systems support
# the termcap routines (option 1) anyhow.
# LIBS = -lcurses
# TERMFLAG = -DMORE_TERMINFO

# more option 3: assume all terminals have 24 rows
# LIBS =
# TERMFLAG = -DMORE_24

# more option 4: don't use the more facility at all
LIBS =
TERMFLAG = -DMORE_NONE

# End of more options

# Uncomment the following line if you want to have access to the game
# debugging tool.  This is invoked by typing "gdt".  It is not much
# use except for debugging.
GDTFLAG = -DALLOW_GDT

# Compilation flags
CFLAGS = -g -static
# On SCO Unix Development System 3.2.2a, the const type qualifier does
# not work correctly when using cc.  The following line will cause it
# to not be used and should be uncommented.
# CFLAGS= -O -Dconst=

##################################################################

# Source files
CSRC =	actors.c ballop.c clockr.c demons.c dgame.c dinit.c dmain.c\
	dso1.c dso2.c dso3.c dso4.c dso5.c dso6.c dso7.c dsub.c dverb1.c\
	dverb2.c gdt.c lightp.c local.c nobjs.c np.c np1.c np2.c np3.c\
	nrooms.c objcts.c rooms.c sobjs.c supp.c sverbs.c verbs.c villns.c

# Object files
OBJS =	actors.bc ballop.bc clockr.bc demons.bc dgame.bc dinit.bc dmain.bc\
	dso1.bc dso2.bc dso3.bc dso4.bc dso5.bc dso6.bc dso7.bc dsub.bc dverb1.bc\
	dverb2.bc gdt.bc lightp.bc local.bc nobjs.bc np.bc np1.bc np2.bc np3.bc\
	nrooms.bc objcts.bc rooms.bc sobjs.bc supp.bc sverbs.bc verbs.bc villns.bc
# -s EMTERPRETIFY=1 -s EMTERPRETIFY_ASYNC=1
# -s ASYNCIFY=1
dungeon: $(OBJS) dtextc.dat
	$(CC) $(CFLAGS) -o zork.js -s WASM=1 -s NO_EXIT_RUNTIME=1 $(OBJS) $(LIBS) \
		--preload-file dtextc.dat

install: zork dtextc.dat
	mkdir -p $(BINDIR) $(LIBDIR) $(MANDIR)/man6
	cp zork $(BINDIR)
	cp dtextc.dat $(DATADIR)
	cp dungeon.6 $(MANDIR)/man6/

clean:
	rm -f $(OBJS) zork core dsave.dat *~

dtextc.dat:
	cat dtextc.uu1 dtextc.uu2 dtextc.uu3 dtextc.uu4 | uudecode

dinit.bc: dinit.c funcs.h vars.h
	$(CC) $(CFLAGS) $(GDTFLAG) -DTEXTFILE=\"$(DATADIR)/dtextc.dat\" -c dinit.c -o $@

dgame.bc: dgame.c funcs.h vars.h
	$(CC) $(CFLAGS) $(GDTFLAG) -c dgame.c -o $@

gdt.bc: gdt.c funcs.h vars.h
	$(CC) $(CFLAGS) $(GDTFLAG) -c gdt.c -o $@

local.bc: local.c funcs.h vars.h
	$(CC) $(CFLAGS) $(GDTFLAG) -c local.c -o $@

supp.bc: supp.c funcs.h vars.h
	$(CC) $(CFLAGS) $(TERMFLAG) -c supp.c -o $@

%.bc: %.c
	$(CC) $(CFLAGS) $< -o $@

actors.bc: funcs.h vars.h
ballop.bc: funcs.h vars.h
clockr.bc: funcs.h vars.h
demons.bc: funcs.h vars.h
dmain.bc: funcs.h vars.h
dso1.bc: funcs.h vars.h
dso2.bc: funcs.h vars.h
dso3.bc: funcs.h vars.h
dso4.bc: funcs.h vars.h
dso5.bc: funcs.h vars.h
dso6.bc: funcs.h vars.h
dso7.bc: funcs.h vars.h
dsub.bc: funcs.h vars.h
dverb1.bc: funcs.h vars.h
dverb2.bc: funcs.h vars.h
lightp.bc: funcs.h vars.h
nobjs.bc: funcs.h vars.h
np.bc: funcs.h vars.h
np1.bc: funcs.h vars.h parse.h
np2.bc: funcs.h vars.h parse.h
np3.bc: funcs.h vars.h parse.h
nrooms.bc: funcs.h vars.h
objcts.bc: funcs.h vars.h
rooms.bc: funcs.h vars.h
sobjs.bc: funcs.h vars.h
sverbs.bc: funcs.h vars.h
verbs.bc: funcs.h vars.h
villns.bc: funcs.h vars.h
