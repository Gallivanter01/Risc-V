int x=1;
int y;
int z;
int a;
volatile int b;

int main(){
    int c = 96;
    x = 20;
    y = 5;

    z = x + y;

    a=0;
    a=1;

    b=0;
    b=1;
    b=c;
    
    return 0;
}
