#include<stdio.h>
#include<stdlib.h>
#include<pthread.h>

#define QTD_THREADS 10

void *printThread(void * number);

int main(void) {

    pthread_t threads[QTD_THREADS];
    int retCreation[QTD_THREADS];
    int params[QTD_THREADS];
    for(int i = 0; i < QTD_THREADS; i++) {
        params[i] = i;
        retCreation[i] = pthread_create( &(threads[i]), NULL, printThread, (void*)(&(params[i])));
    }

    for(int i = 0; i < QTD_THREADS; i++) {
        pthread_join(threads[i], NULL);
    }

    for(int i = 0; i < QTD_THREADS; i++) {
        printf("Ret of thread %d creation: %d\n", i, retCreation[i]);
    }

    return 0;
}

void * printThread(void * number) {
    int * internNumber = (int *) number;
    printf("Thread %d\n", *internNumber);
    return number;
}
