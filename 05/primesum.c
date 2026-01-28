#include<stdlib.h>
#include<stdio.h>
#include<stdint.h>
#include<stdbool.h>

typedef int64_t int_t;
//typedef __int128 int_t;
const int_t MODULUS = 1000000007;
//const int_t MODULUS = 0x100000000;
#define MAX_N 16000
int_t primes[MAX_N];
int_t previous_primes[MAX_N+1];
size_t prime_index = 0;
int_t* primesums_cache = NULL;

void generate_primes(){
    previous_primes[0] = previous_primes[1] = previous_primes[2] = 1;
    primes[prime_index++] = 2;
    for (size_t i = 3; i <= MAX_N; i++){
        bool broken = false;
        for (size_t j = 0; j < prime_index; j++){
            if ((i%primes[j]) == 0){
                broken = true;
                break;
            }
        }
        previous_primes[i] = primes[prime_index-1];
        if (broken) continue;
        primes[prime_index++] = i;
    }
}

int_t pairfunction(int_t a, int_t b){
    return a + (MAX_N + 1)*b;
}

int_t primesums(int_t n, int_t max_prime){
    if (primesums_cache == NULL){
        primesums_cache = calloc(MAX_N*(MAX_N+1), sizeof(int_t));
    }
    if (n == 0) return 1;
    if (n < 0) return 0;
    if (max_prime < 2) return 0;
    const int_t cache_index = pairfunction(n, max_prime);
    if (primesums_cache[cache_index] != 0) return primesums_cache[cache_index];
    const int_t result = (primesums(n - max_prime, max_prime) + primesums(n, previous_primes[max_prime])) % MODULUS;
    primesums_cache[cache_index] = result;
    return result;
}

int main(){

    generate_primes();

    printf("%lli\n", primesums(MAX_N, previous_primes[MAX_N]));

    return 0;
}
