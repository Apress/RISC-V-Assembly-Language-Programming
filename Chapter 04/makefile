OBJS = printdword.o
ifdef  DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS = 
endif

%.o : %.S
	as $(DEBUGFLGS) $< -o $@
	
printdword: $(OBJS)
	ld -o printdword $(OBJS)
	
CodeSnippets: CodeSnippets.o
	ld -o CodeSnippets CodeSnippets.o	

all: printdword CodeSnippets

