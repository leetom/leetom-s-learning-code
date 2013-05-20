#include<stdio.h>

#define SIZE 5
typedef struct {
	int x,y;
	int z;	//是否可以通过
	int opt; //是否途经过，没有为0,走过为1
} pt;


struct line_stack{
	int top;
	int size;
	pt stack[50];
} mz_stack = {0,50,{{0,0,0,0}}};



int maze_option[SIZE][SIZE] = {0,1,0,1,1,
							   1,0,0,0,1,
							   0,0,1,0,1,
							   1,0,0,1,1,
							   1,1,0,0,0};

pt maze[SIZE][SIZE];

//maze initialize

int mz_init(){
	for(int i=0;i<SIZE;i++){
		for(int j=0;j<SIZE;j++){
			maze[i][j] = {i,j,maze_option[i][j],0};
		}
	}
}

int main(void){
	printf("helo");
}



