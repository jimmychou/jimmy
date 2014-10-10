#include <stdio.h>

void core_test1(){
    int i = 0;
    scanf("%d",i);  //  should have used & to get addr other than access directly
    printf("%d\n",i);
}

void core_test2(){
    char * ptr = "myname is tenfyguo";
    * ptr = 0;
}

int main(){
    core_test1();
    return 0;
}
