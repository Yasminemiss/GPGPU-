#include <stdint.h>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <sstream>
#include <cmath>
#include <cstring>
#include <cstdlib>
#include <chrono>

using namespace std;
using namespace std::chrono;


void isPrime(){


	uint64_t N = 32;
	uint64_t sqrtN = sqrt(N) + 1;
	uint64_t nombresDePossiblesPremiers = N-2;

	uint64_t *possibles_premiers = (uint64_t*)malloc(sizeof(uint64_t) * (nombresDePossiblesPremiers));
	for (int i = 0, j = 2.0; j < N; possibles_premiers[i] = j,i++,j++);
	unsigned int *res_operations = (unsigned int*)malloc(sizeof(unsigned int) * GRIDDIM(sqrtN));
	for (int i = 0; i < GRIDDIM(sqrtN); res_operations[i] = 1,i++);

	uint64_t *dev_possibles_premiers;
	cudaMalloc((void**)&dev_possibles_premiers, sizeof(uint64_t) * (nombresDePossiblesPremiers));
	unsigned int *dev_res_operations;
	cudaMalloc((void**)&dev_res_operations, sizeof(unsigned int) * GRIDDIM(sqrtN));


	cudaMemcpy(dev_possibles_premiers, possibles_premiers, sizeof(uint64_t) * (nombresDePossiblesPremiers), cudaMemcpyHostToDevice);
  cudaMemcpy(dev_res_operations, res_operations, sizeof(unsigned int) * GRIDDIM(sqrtN), cudaMemcpyHostToDevice);
	isPrimeGPU<<<GRIDDIM(sqrtN),BLOCKDIM,SIZEMEM>>>(dev_possibles_premiers, dev_res_operations, N, sqrtN);
	cudaMemcpy(res_operations, dev_res_operations, sizeof(unsigned int) * GRIDDIM(sqrtN), cudaMemcpyDeviceToHost);

	cudaFree(dev_possibles_premiers);
	cudaFree(dev_res_operations);
	free(possibles_premiers);
	free(res_operations);
}

vector<uint64_t> searchPrimes(uint64_t borne_sup){

	vector<uint64_t> premiers_packed(0);
	uint64_t *possibles_premiers = (uint64_t*)malloc(sizeof(uint64_t)*(borne_sup-2));
	for(int i = 0; i < (borne_sup-2); possibles_premiers[i] = i+2, i++);
	uint64_t *square_roots = (uint64_t*)malloc(sizeof(uint64_t)*(borne_sup-2));
	for(int i = 0; i < (borne_sup-2); square_roots[i] = sqrt(i+2), i++);
	uint64_t *premiers = (uint64_t*)malloc(sizeof(uint64_t)*(borne_sup-2));
	for(int i = 0; i < (borne_sup-2); premiers[i] = 0, i++);


	uint64_t *dev_possibles_premiers;
	uint64_t *dev_square_roots;
	uint64_t *dev_premiers;
	cudaMalloc((void**)&dev_possibles_premiers,sizeof(uint64_t)*(borne_sup-2));
	cudaMalloc((void**)&dev_square_roots,sizeof(uint64_t)*(borne_sup-2));
	cudaMalloc((void**)&dev_premiers,sizeof(uint64_t)*(borne_sup-2));


	cudaMemcpy(dev_possibles_premiers, possibles_premiers, sizeof(uint64_t)*(borne_sup-2), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_square_roots, square_roots, sizeof(uint64_t)*(borne_sup-2), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_premiers, premiers, sizeof(uint64_t)*(borne_sup-2), cudaMemcpyHostToDevice);
	searchPrimeGPU<<<GRIDDIM(borne_sup-2),BLOCKDIM,SIZEMEM>>>(
			dev_possibles_premiers,
			dev_square_roots,
			borne_sup,
			dev_premiers);

	cudaMemcpy(premiers, dev_premiers, sizeof(uint64_t)*(borne_sup-2), cudaMemcpyDeviceToHost);

	int nombresDePremiers = 0;
	for(int i = 0; i < (borne_sup-2); i++){
		if (premiers[i] != 0)
			nombresDePremiers++;
	}

	for (int i = 0; i < nombresDePremiers; i++){
		int j = 0;

		while (premiers[j] == 0 && j < (borne_sup-2))
			j++;
		premiers_packed.push_back(j+2);
		premiers[j] = 0;
	}

	return premiers_packed;
}

void facteurs(){


        uint64_t N = 30);
      	vector<uint64_t> premiers_packed = searchPrimes(N);
      	int taille = premiers_packed.size();
      	uint64_t *primes = (uint64_t*)malloc(sizeof(uint64_t) * taille);
      	for(int i = 0; i < taille; primes[i]=premiers_packed.at(i),i++);

      	uint64_t  *facteurs=(uint64_t*)malloc(sizeof(uint64_t)*taille);
      	for(int i =0 ; i<taille; i++) {
      			facteurs[i][0]=primes[i];
      			facteurs[i][1]=0;
      	}

      	uint64_t *dev_primes;
      	uint64_t *dev_facteurs;

      	cudaMalloc((void**)&dev_primes,sizeof(uint64_t)*taille);
        cudaMalloc((void**)&dev_facteurs,sizeof(uint64_t)*taille);
      	cudaMemcpy(dev_primes,primes,sizeof(uint64_t)*taille,cudaMemcpyHostToDevice);
      	cudaMemcpy(dev_facteurs,facteurs,sizeof(uint64_t)*taille,cudaMemcpyHostToDevice);


        factGPU<<<GRIDDIM(taille),BLOCKDIM>>>(N,dev_primes,taille,dev_facteurs);

        cudaMemcpy(facteurs,dev_facteurs,sizeof(uint64_t)*taille,cudaMemcpyDeviceToHost);

          vector<uint64_t*> resulat(0);
          for(int i=0 ; i <taille;i++)
          {
                if(facteurs[i][1]!=0)
               {
                  uint64_t c[0];
                 c[0]=facteurs[i][1];
                c[1]=facteurs[i][1];
                resulat.push_back(c);
                }
         }
}

int main( int argc, char **argv ){
  uint64_t N =30;
  auto start = high_resolution_clock::now();

  isPrime();
  vector<uint64_t> v=searchPrimes(N);
  facteurs();
  auto stop = high_resolution_clock::now();
  auto duration = duration_cast<microseconds>(stop - start);
 cout << "Time taken by function: "
        << duration.count() << " microseconds" << endl;

   	return 0;
}
