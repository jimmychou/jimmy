#include <stdio.h>  
#include <stdlib.h>  

typedef struct Data  
{  
    int    da;  
} Data;  

void fun(Data **p);     //这里改动了  

int main()  
{  
    Data    *d;  
    fun(&d);     //这里改动了  
    printf("%d", d->da);  
    return    0;  
}  

void fun(Data **p)     //这里改动了  
{  
    (*p) = (Data*)malloc(sizeof(Data));     //这里改动了  
    (*p)->da = 2;     //这里改动了  
}  
