
#ifndef __PREMEBREAKER_HPP
#define __PREMEBREAKER_HPP

#include <stdint.h>
#include <iostream>
#include <cstdlib>
#include <cstdint>
#include "utils/common.hpp"
#include "utils/chronoCPU.hpp"
#include "utils/chronoGPU.hpp"
#include <bits/stdc++.h>
#include "helper.hpp"

using namespace std;

/** /brief Je suis une fonction qui évalue partiellement la primalité d'un nombre, un traitement
 * final doit être effectué par la fonction appelante afin d'évaluer la primalitée.
*/
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
		cell *dev_facteurs
		);
#endif
