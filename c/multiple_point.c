#include <stdio.h>  
#include <stdlib.h>  
int main()
{
    int a = 1000;
    int *b = &a;
    int **c = &b;
    int ***d = &c;
    int ****e = &d;
    int *****f = &e;
    printf("%d\n%X\n%X\n%X\n%X\n%X\n",a,b,c,d,e,f);
    printf("%X\n%X\n%X\n%X\n%X\n%X\n",a,b,c,d,e,f);
    return 0;  
}  
