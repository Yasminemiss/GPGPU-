
#ifndef __PREMEBREAKER_HPP
#define __PREMEBREAKER_HPP

#include <stdint.h>
#include <iostream>
#include <cstdlib>
#include <cstdint>
#include "common.hpp"
#include <bits/stdc++.h>
#include <string>
#include <ctgmath>
#include <chrono>

using namespace std;

struct fact {
    uint64_t base;
    int expo;
};

__global__
void isPrimeGPU(
		uint64_t *Prime_PossiblE,
		unsigned int *resultat,
		uint64_t N,
		uint64_t sqrtN
  );

  __global__ void factGPU(
		uint64_t  N,
		uint64_t *dev_primes,
                int taille,
		fact *dev_facteurs
		);

  __global__ void searchPrimeGPU(
  		uint64_t *Prime_PossiblE,
  		uint64_t *carre,
  		uint64_t limit,
  		uint64_t *res_premes);
#endif
