#include<stdio.h>
#include<unistd.h>

int
main(int argc, char ** argv){
	int i;
	for(i=0; i<=100; i++){
		printf("Complished: %d%%\r",i);
		fflush(stdout);
		sleep(1);
	}
}
