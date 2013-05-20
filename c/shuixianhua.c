#include <stdio.h>
#include <math.h>
int main ()
{
	int num,num1,num2,num3,i;
	for (num=100;num<1000;num++)
	{
		num1=num % 10;
		num2= (num/10)%10;
		num3= (num/100);
		if (num ==(pow(num1,3)+ pow (num2,3) + pow(num3,3)))
		{
			printf("%d,%d,%d \a \a \a \n",num3,num2,num1);
			printf ("%d is shuixianhuashu \n \a",num);
		}
	}
}
