CSOBJS = codesnippets.o
UPPEROBJS = main.o upper.o
UMOBJS = mainmacro.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif
LSTFLGS =

all: upper codesnippets uppermacro

%.o : %.S
	as -mno-relax $(DEBUGFLGS) $(LSTFLGS) $< -o $@
	
codesnippets: $(CSOBJS)
	ld -o codesnippets $(CSOBJS)

uppermacro: $(UMOBJS)
	ld -o uppermacro $(UMOBJS)

upper: $(UPPEROBJS)
	ld -o upper $(UPPEROBJS)
