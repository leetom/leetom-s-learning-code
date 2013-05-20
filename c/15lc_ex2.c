#include <stdio.h>

int countbit(unsigned int x){
	int mask = 0x1;
	int count = 0;
	int i;
	for (i = 0; i < 32; i++){
		if( (x & mask) != 0){
			count++;
		}
		mask <<= 1;
	}
	return count;
}

int main(){
	int num1 = 0xFFFFFFFF;
	int num2 = 0xcffffff3;
	printf("num1:%d\n", countbit(num1));
	printf("num2:%d\n", countbit(num2));

	return 0;
}
