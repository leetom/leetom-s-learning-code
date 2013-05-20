#include <pthread.h>
#include <iostream>

using namespace std;

void* tprocess1(void* args){
         while(1){
                 cout << "tprocess1" << endl;
         }
         return NULL;
}

void* tprocess2(void* args){
         while(1){
                 cout << "tprocess2" << endl;
         }
         return NULL;
}

int main(){
         pthread_t t1;
         pthread_t t2;
         pthread_create(&t1,NULL,tprocess1,NULL);
         pthread_create(&t2,NULL,tprocess2,NULL);
         pthread_join(t1,NULL);
         return 0;
}
