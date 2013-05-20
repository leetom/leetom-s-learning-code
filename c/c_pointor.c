#include <stdio.h>
#include <string.h>
main()
{
	char *p[3];
	char str[4]="hel";
	p[1]=str;
	puts(p[1]);
	printf("\n");
	puts(str);
	printf("\n");
	int i;
	for (i=0;i<3;i++)
		printf("%c",p[1][i]);

}
