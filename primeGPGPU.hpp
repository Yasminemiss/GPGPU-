
#ifndef __PREMEBREAKER_HPP
#define __PREMEBREAKER_HPP

#include <stdint.h>
#include <iostream>
#include <cstdlib>
#include <cstdint>
#include "common.hpp"
#include "chronoCPU.hpp"
#include "chronoGPU.hpp"
#include <bits/stdc++.h>
#include "helper.hpp"

using namespace std;

__global__
void isPrimeGPU(uint64_t N_square,
		uint64_t  N,
			uint64_t *p,
		unsigned int *r,

		);

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
		primes *dev_facteurs
		);
#endif
