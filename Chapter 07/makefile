UPPEROBJS = main.o upper.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif

all: upper

%.o : %.S
	gcc -mno-relax $(DEBUGFLGS) -c $< -o $@

%.o : %.s
	as -mno-relax $(DEBUGFLGS) $< -o $@

upper: $(UPPEROBJS)
	ld -o upper $(UPPEROBJS)
