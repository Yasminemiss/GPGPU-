#ifndef HELPER_H
#define HELPER_H

#include <vector>
#include <cstdint>
#include <string>
#include <iostream>

using namespace std;

typedef uint64_t longInteger;
typedef longInteger primes[2]; // tableau où la premier valeur est la base et le deuxieme et l'exposant


string afficherPrimes(vector<uint64_t> primeNumbers);
string afficherFacteurs(vector<primes> facteurs );
void updatePrimes( primes c , vector< primes> *facteursPrimes);



#endif
