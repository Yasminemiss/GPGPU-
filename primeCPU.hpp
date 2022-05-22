#ifndef __PRIMEBREAKERCPU_HPP
#define __PRIMEBREAKERCPU_HPP

#include "helper.hpp"
#include <bits/stdc++.h>
#include <cstdint>
#include <iostream>
#include <string>
#include <ctgmath>
#include <vector>

using namespace std;

bool isPrimeCPU(const uint64_t number);
std::vector<uint64_t> searchPrimesCPU(const uint64_t l);
void factoCPU(uint64_t N, vector<primes> *facteursPrimes);



#endif
