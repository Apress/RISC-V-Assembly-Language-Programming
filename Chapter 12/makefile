UPPER2OBJS = main.o upper2.o
UPPER3OBJS = upper3.o
 
ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif
LSTFLGS =
 
all: upper2 upper3
 
%.o : %.S
	as $(DEBUGFLGS) -mno-relax $(LSTFLGS) $< -o $@
 
upper2: $(UPPER2OBJS)
	ld -o upper2 $(UPPER2OBJS)
 
upper3: $(UPPER3OBJS)
	ld -o upper3 $(UPPER3OBJS)
 
