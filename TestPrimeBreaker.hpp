#ifndef PROJET_GPU_TESTPRIMEBREAKER_HPP
#define PROJET_GPU_TESTPRIMEBREAKER_HPP

#define LARGE_UINT64_NUMBER 214767739
#define LARGE_UINT32_NUMBER 214748357

#include "helper.hpp" // cell, booléens de niveau d'affichage du débug, mAssert
#include "primeBreakerCPU.hpp"
#include <cassert> // assert
#include <stdint.h> // uint64_t, uint32_t
#include <iostream> // cout, endl
#include <fstream> // ifstream
#include <string> // string
#include <vector> // vector<T>
#include <cstdlib> // strtoull
#include <sstream> // stringstream
#include "utils/chronoCPU.hpp"
void launchUnitTest();
void TestIfPrimeIsAssertedWithAIntegerPrimeNumber();
void TestIfNonPrimeIsNotAssertedWithAIntegerPrimeNumber();
void TestIfPrimeIsAssertedWithALargeUint64PrimeNumber();
void TestIfNonPrimeIsNotAssertedWithALargeUint64PrimeNumber();
void TestIfPrimesBetween0and100AreSuccessfullyRetrieved();
void TestIfNumberIsFactorized();
vector<uint64_t> getPrimesFrom0to100FromControlPrimeSetFile();
void putPrimesFromLineInOutput(string line, vector<uint64_t> *output);
vector<uint64_t> splitNumbersFromLine(string line);
void lancerFactorizedWithInput(int argc,char **argv);
void lancerIsPrimeWithInput(int argc,char **argv);
void lancerSearchPrimes(int argc,char **argv);

#endif //PROJET_GPU_TESTPRIMEBREAKER_HPP
