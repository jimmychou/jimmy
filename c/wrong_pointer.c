#include <stdio.h>  
#include <stdlib.h>  

typedef struct Data  
{  
    int    da;  
} Data;  

void fun(Data *p);  

int main()  
{  
    Data    *d;  
    fun(d);  
    printf("%d", d->da);  
    return    0;  
}  

void fun(Data *p)  
{  
    p = (Data*)malloc(sizeof(Data));  
    p->da = 2;  
}  
