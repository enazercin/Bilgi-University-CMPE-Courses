#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

#define NUM_REINDEER 9
#define NUM_ELVES 10

sem_t reindeerSem;  // Semaphore for reindeer to wait
sem_t santaSem;     // Semaphore for Santa Claus to wait
sem_t elfTex;       // Semaphore for exclusive access to elves count
sem_t mutex;        // Mutex for protecting critical sections

int numElves = 0;   // Number of elves needing help
int reindeerCount = 0;  // Number of reindeer

void* reindeer(void* arg) {
    // Reindeer code here
    
    // Wait for all reindeer to arrive
    sem_wait(&mutex);
    reindeerCount++;
    if (reindeerCount == NUM_REINDEER) {
        sem_post(&reindeerSem);  // Wake up Santa Claus
    }
    sem_post(&mutex);
    
    // Rest until Christmas is over
    sem_wait(&santaSem);
    
    // Reindeer delivering presents
    
    pthread_exit(NULL);
}

void* elf(void* arg) {
    // Elf code here
    
    // Queue up for help
    sem_wait(&elfTex);
    sem_wait(&mutex);
    numElves++;
    if (numElves == 3) {
        sem_post(&santaSem);  // Wake up Santa Claus
    } else {
        sem_post(&elfTex);    // Release queue for other elves
    }
    sem_post(&mutex);
    
    // Receive help from Santa Claus
    
    // Queue up again if problem not solved
    
    pthread_exit(NULL);
}

void* santaClaus(void* arg) {
    // Santa Claus code here
    
    while (1) {
        sem_wait(&reindeerSem);  // Wait for reindeer to arrive
        
        // Prepare sleigh and deliver presents
        
        sem_post(&santaSem);     // Signal Christmas is over
        
        sem_wait(&elfTex);       // Wait for exclusive access to elves count
        sem_wait(&mutex);
        
        // Check if there are elves waiting for help
        if (numElves >= 3) {
            sem_post(&mutex);    // Release mutex
            
            // Help the elves
            
            sem_post(&elfTex);   // Release exclusive access to elves count
            
            // Queue up again if problem not solved
        } else {
            sem_post(&elfTex);   // Release exclusive access to elves count
            sem_post(&mutex);    // Release mutex
        }
    }
    
    pthread_exit(NULL);
}

int main() {
    // Initialize semaphores
    sem_init(&reindeerSem, 0, 0);
    sem_init(&santaSem, 0, 0);
    sem_init(&elfTex, 0, 1);
    sem_init(&mutex, 0, 1);

    // Create threads for Santa Claus, reindeer, and elves
    pthread_t santaThread, reindeerThreads[NUM_REINDEER], elfThreads[NUM_ELVES];

    pthread_create(&santaThread, NULL, santaClaus, NULL);

    for (int i = 0; i < NUM_REINDEER; i++) {
        pthread_create(&reindeerThreads[i], NULL, reindeer, NULL);
    }

    for (int i = 0; i < NUM_ELVES; i++) {
        pthread_create(&elfThreads[i], NULL, elf, NULL);
    }

    // Join threads
    pthread_join(santaThread, NULL);

    for (int i = 0; i < NUM_REINDEER; i++) {
        pthread_join(reindeerThreads[i], NULL);
    }

    for (int i = 0; i < NUM_ELVES; i++) {
        pthread_join(elfThreads[i], NULL);
    }

    // Destroy semaphores
    sem_destroy(&reindeerSem);
    sem_destroy(&santaSem);
    sem_destroy(&elfTex);
    sem_destroy(&mutex);

    return 0;
}
