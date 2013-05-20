#include <stdio.h>

int main(){
	int num;
	int count = 0;
	for (num=0;num<10000000;num++){
		// if(num % 2 == 0){
		 	if((num/2) * 2 == num){
			// printf("%d",num);
			count++;
		}
	}
	printf("%d", count);
	return 0;
}
