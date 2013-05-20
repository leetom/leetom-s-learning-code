#include <stdio.h>
int main(){
	int i = 0xcffffff3;
	printf("%x\n", i);
	printf("%x\n", 0xffffff3>>2);
	printf("%x\n", i>>2);
	printf("%d\n", 0xffffff3>>2);
	printf("%d\n",i >> 2);
}
