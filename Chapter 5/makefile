OBJS = upper.o
ifdef  DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS = 
endif

%.o : %.S
	as -mno-relax $(DEBUGFLGS) $< -o $@
	
upper: $(OBJS)
	ld -o upper $(OBJS)
	
CodeSnippets: CodeSnippets.o
	ld -o CodeSnippets CodeSnippets.o	

all: upper CodeSnippets

