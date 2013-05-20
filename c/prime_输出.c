#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
int main()
{
	time_t stime, etime;
	time(&stime);
        int j,k,count=0,flag=1;
	float m;
        FILE *prime;
        if ((prime = fopen("a.txt","w+")) == NULL)
        {       printf("Cannot open file");
                exit(1);
        }

        for (j=3;j<100000000;j++)
        {
                m = sqrt(j);
		flag = 1;
		for (k = 2; k <= m; k++)
                {
                     if (j % k ==0)
                        {
                                flag = 0;
                                break;
                        }
                        
                }
         if (flag)
           {
			count++;
			fprintf(prime,"%d\t",j);
			if (count % 20 ==0)
				fprintf(prime,"\n");
           }
        }
        fprintf(prime,"\n%d\n",count);
	time(&etime);
	printf("this app cost %ld seconds\nthere are %d primers\n",etime - stime,count);
	fprintf(prime,"this app cost %ld seconds\n",etime - stime);
	fclose(prime);
        exit(0);
}

