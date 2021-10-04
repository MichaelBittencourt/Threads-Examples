#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define QTD_THREADS 10

#ifdef MUTEX_EXAMPLE

#include <time.h>
#include <unistd.h>

#ifndef DISABLE_MUTEX
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
#endif
void *increment(void *arg);
int count = 0;

int main(void) {

    pthread_t threads[QTD_THREADS];
    int retCreation[QTD_THREADS];
    srand(time(NULL));
    for (int i = 0; i < QTD_THREADS; i++) {
        if ((retCreation[i] =
                 pthread_create(&(threads[i]), NULL, increment, NULL))) {
            fprintf(stderr, "Was not possible create thread %d", i);
        }
    }

    for (int i = 0; i < QTD_THREADS; i++) {
        pthread_join(threads[i], NULL);
    }

    return 0;
}

void *increment(void *arg) {
#ifndef DISABLE_MUTEX
    pthread_mutex_lock(&mutex);
#endif
    count = count + 1;
    sleep((rand() % 10) / 10.0);
    printf("Counter = %d\n", count);
#ifndef DISABLE_MUTEX
    pthread_mutex_unlock(&mutex);
#endif
    return arg;
}

#else

void *printThread(void *number);

int main(void) {

    pthread_t threads[QTD_THREADS];
    int retCreation[QTD_THREADS];
    int params[QTD_THREADS];
    for (int i = 0; i < QTD_THREADS; i++) {
        params[i] = i;
        retCreation[i] = pthread_create(&(threads[i]), NULL, printThread,
                                        (void *)(&(params[i])));
    }

    for (int i = 0; i < QTD_THREADS; i++) {
        pthread_join(threads[i], NULL);
    }

    for (int i = 0; i < QTD_THREADS; i++) {
        printf("Ret of thread %d creation: %d\n", i, retCreation[i]);
    }

    return 0;
}

void *printThread(void *number) {
    int *internNumber = (int *)number;
    printf("Thread %d\n", *internNumber);
    return number;
}

#endif
