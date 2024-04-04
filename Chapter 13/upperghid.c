#include <stdio.h>

#define BUFFERSIZE 250

char *tstStr = "This is a test!";
char outStr[BUFFERSIZE];

typedef unsigned char byte;
typedef int undefined8;

#define true 1
#define FUN_001005c0 printf

undefined8 main(void)

{
  char *pcVar1;
  char cVar2;
  char *pcVar3;
  char *pcVar4;
  
  // gp = &__global_pointer$;
  pcVar4 = &outStr;
  pcVar3 = tstStr;
  while( true ) {
    cVar2 = *pcVar3;
    while ((byte)(cVar2 + 0x9fU) < 0x1a) {
      *pcVar4 = cVar2 + -0x20;
      pcVar1 = pcVar3 + 1;
      pcVar4 = pcVar4 + 1;
      pcVar3 = pcVar3 + 1;
      cVar2 = *pcVar1;
    }
    *pcVar4 = cVar2;
    pcVar4 = pcVar4 + 1;
    if (cVar2 == '\0') break;
    pcVar3 = pcVar3 + 1;
  }
  FUN_001005c0("Input: %s\nOutput: %s\n",tstStr, &outStr);
  return 0;
}
