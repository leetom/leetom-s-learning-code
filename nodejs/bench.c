#include<stdio.h>

int main(void){
	int i,j;
	for(i=0;i<100000;i++){
		for(j=0;j<100000;j++){
			//i * j;
			if(i==1000 && j==1000){
				printf("Inner loop");
			}
		}
	}
}
