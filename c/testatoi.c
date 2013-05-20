#include<stdio.h>
#include<string.h>
#include<inttypes.h>
#include<math.h>
#define NaN -1
int atoi(const char *str){
	int num = 0, pos = 0;
	if(strlen(str) == 0){
		return NaN;
	}else{
		while(str[pos] > '0' && str[pos] < '9' && pos < strlen(str)){
			num = num * 10 + str[pos] - '0';
			pos++;
		}
	}
	if(pos > 0){
		return num;
	}
	return NaN;
}
int main(){
	char str[] = "123and";
	int num;
	num = atoi(str);

	printf("%d\n", num);
	return(0);
}
