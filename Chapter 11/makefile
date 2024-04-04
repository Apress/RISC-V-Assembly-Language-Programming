CSOBJS = codesnippets.o

all: distance fpcomp codesnippets

%.o : %.S
	as -mno-relax $(DEBUGFLGS) $(LSTFLGS) $< -o $@
	
distance: main.S distance.S
	gcc -o distance main.S distance.S
	
fpcomp: fpcomp.S maincomp.S
	gcc -g -o fpcomp fpcomp.S maincomp.S
	
codesnippets: $(CSOBJS)
	ld -o codesnippets $(CSOBJS)
