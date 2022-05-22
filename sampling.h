#ifndef PRIMEBREAKER_SAMPLING_H
#define PRIMEBREAKER_SAMPLING_H

#define LOG2MAX_ISP 29
#define LOG2MAX_ROP 20
#define GRIDDIM(X) ((X+BLOCKDIM-1)/BLOCKDIM)
#define SIZEMEM (BLOCKDIM * sizeof(unsigned int))
#define BLOCKDIM 256

#include "utils/chronoCPU.hpp"
#include <cstdint> // uint64_t
#include <vector> // vector<T>
/* #include <boost/tuple/tuple.hpp> // tuple<T,T,..,T> */
#include "primeBreakerCPU.hpp" // Fonctions de calcul CPU
#include "TestPrimeBreakerGPU.hpp" // getPrimes helper func
#include "helper.hpp" // cell
#include <cmath> // pow
#include "primeBreaker.hpp" // Fonctions de calcul GPU

//using namespace boost;
using namespace std;

/*boost::tuple<vector<float>,vector<uint64_t>>
createPrimalityTestsDatas();*/
vector<uint64_t> generatePrimalityTestsSamples();
vector<float> generatePrimalityTestsMeasurement(vector<uint64_t> samples);

/*boost::tuple<vector<float>,vector<uint64_t>>
createResearchOfPrimesDatas();*/
vector<uint64_t> generateResearchOfPrimesLimits();
vector<float> generateResearchOfPrimesMeasurement(vector<uint64_t> limits);

/*boost::tuple<vector<float>,vector<uint64_t>>
createPrimeFactorisationDatas();*/
vector<uint64_t> generatePrimeFactorisationSamples();
vector<float> generatePrimeFactorisationMeasurement(vector<uint64_t> samples);

void generateDataFilesCPU();
void generateResearchOfPrimesDataFileCPU();
void generatePrimalityTestDataFileCPU();
void generatePrimeFactorisationDataFileCPU();

void generateDataFilesGPU();
void generateResearchOfPrimesDataFileGPU();
void generatePrimalityTestDataFileGPU();
void generatePrimeFactorisationDataFileGPU();

vector<float> generateGPUPrimalityTestsMeasurement(vector<uint64_t> samples);
vector<float> generateGPUResearchOfPrimesMeasurement(vector<uint64_t> limits);
vector<float> generateGPUPrimeFactorisationMeasurement(vector<uint64_t> samples);

#endif //PRIMEBREAKER_SAMPLING_H
