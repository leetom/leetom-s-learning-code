#include<fcntl.h>
#include<stdio.h>

int main(int argc, char ** argv){
	int i,j;
	double k=0;
	for (i = 1; i++; i < 10000){
		for (j = 1; j++; j < 10000){
			k += j*i;
		}
	}
	printf("%f", k);
}
