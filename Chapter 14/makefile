CCOBJS = creditcard.o upper.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif

all: creditcard creditcardpie uppercanary

%.o : %.S
	gcc -mno-relax $(DEBUGFLGS) -c $< -o $@

%.o : %.s
	as -mno-relax $(DEBUGFLGS) $< -o $@

creditcard: $(CCOBJS)
	ld -o creditcard $(CCOBJS)
	
creditcardpie: $(CCOBJS)
	ld -pie -o creditcardpie $(CCOBJS)
	
uppercanary: upper.c
	gcc -o uppercanary -fstack-protector-all -O3 upper.c
