
#ifndef __PREMEBREAKER_HPP
#define __PREMEBREAKER_HPP

#include <stdint.h>
#include <iostream>
#include <cstdlib>
#include <cstdint>
#include "common.hpp"
#include <bits/stdc++.h>

using namespace std;

struct fact {
    uint64_t base;
    int expo;
};

__global__
void isPrime(	uint64_t *possibles_premiers,
		unsigned int *res_operations,
		uint64_t  N,
		uint64_t sqrtN);

__global__
void searchPrimeGPU(
		uint64_t *possibles_premiers,
		uint64_t *square_roots,
		uint64_t borne_sup,
		uint64_t *premiers);

__global__ void factGPU(
		uint64_t  N,
		uint64_t *dev_primes,
                int taille,
		fact *dev_facteurs
		);
#endif
