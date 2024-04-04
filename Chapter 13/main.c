#include <stdio.h>

extern int strcmp1(char *, char *);
extern int strcmp_zbb(char *, char *);

char *str1 = "This is one";
char *str2 = "This is the other";
char *str3 = "This is one";
char *str4 = "This is one";
int main()
{
	printf("strcmp1: %d\n", strcmp1(str1, str2));
	printf("strcmp1: %d\n", strcmp1(str3, str4));

	printf("strcmp_zbb: %d\n", strcmp_zbb(str1, str2));
	printf("strcmp1_zbb: %d\n", strcmp_zbb(str3, str4));

	return(0);
}
