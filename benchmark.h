#ifndef PROJETGPU_BENCHMARK_H
#define PROJETGPU_BENCHMARK_H

#include <vector> // vector<T>
#include <cstdint> // uint64_t
#include "sampling.h" // Fonctions de créations d'échantillons pour les graphes.
/*#include <boost/tuple/tuple.hpp> // tuple<T,T,...,T>*/
#include "utils/chronoCPU.hpp"
#include "primeBreakerCPU.hpp"

void generatePlots();
void wait_for_key();

#endif
