STRCMPOBJS = main.o strcmp1.o strcmp2.o
 
ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif
LSTFLGS =
 
all: strcmp
 
%.o : %.S
	as $(DEBUGFLGS) -mno-relax $(LSTFLGS) $< -o $@
 
strcmp: $(STRCMPOBJS)
	gcc -o strcmp $(STRCMPOBJS)
 
