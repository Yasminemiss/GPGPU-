
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



  __global__
  void factGPU(
  		uint64_t  N,
  		uint64_t *res_primes,
                 	int size,
  		fact *res_facteurs
  );

  void searchPrimeGPU(
  		uint64_t *possibles_premiers,
  		uint64_t *square_roots,
  		uint64_t borne_sup,
  		uint64_t *premiers);
#endif
