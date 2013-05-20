#include <stdio.h>
#include <math.h>
#include <inttypes.h>
#include <complex.h>
int main(void)
{
 int16_t me16;
 me16=4593;
 printf ("First, assume int16_t is short: ");
 printf ("me16 = %hd\n",me16);
 printf ("next,let's not make any assumptions.\n");
 printf ("instead, use a  \"macro\" from initypes.h:");
 printf ("me16 = %"PRId16"\n",me16);
 float toobig = 3.4E38 * 100.0f;
 float non;
 printf ("%e\n",toobig);
 non = asin(2);
 printf("%e\n",non);
 return 0;
}
