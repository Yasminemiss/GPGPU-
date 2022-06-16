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

#include "primeGPGPU.hpp"

using namespace std;
using namespace std::chrono;

#define BLOCKDIM 256
#define SIZEMEM (BLOCKDIM * sizeof(unsigned int))


void Lancer_isPrime(uint64_t N){
		uint64_t sqrtN = sqrt(N) + 1;
		uint64_t nombresDePossiblesPremiers = N-2;
					uint64_t tailleGrid = (((sqrtN)+BLOCKDIM-1)/BLOCKDIM);

		uint64_t *possibles_premiers = (uint64_t*)malloc(sizeof(uint64_t) * (nombresDePossiblesPremiers));
		for (int i = 0, j = 2.0; j < N; possibles_premiers[i] = j,i++,j++);
		unsigned int *res_operations = (unsigned int*)malloc(sizeof(unsigned int) * tailleGrid);
		for (int i = 0; i < TailleGrid(sqrtN); res_operations[i] = 1,i++);

		uint64_t *dev_possibles_premiers;
		cudaMalloc((void**)&dev_possibles_premiers, sizeof(uint64_t) * (nombresDePossiblesPremiers));

		unsigned int *dev_res_operations;



		cudaMalloc((void**)&dev_res_operations, sizeof(unsigned int) * TailleGrid(sqrtN));


		cudaMemcpy(dev_possibles_premiers, possibles_premiers, sizeof(uint64_t) * (nombresDePossiblesPremiers), cudaMemcpyHostToDevice);
	       	cudaMemcpy(dev_res_operations, res_operations, sizeof(unsigned int) * TailleGrid(sqrtN), cudaMemcpyHostToDevice);
		isPrimeGPU<<<tailleGrid,BLOCKDIM,SIZEMEM>>>(dev_possibles_premiers, dev_res_operations, N, sqrtN);
		cudaMemcpy(res_operations, dev_res_operations, sizeof(unsigned int) * TailleGrid(sqrtN), cudaMemcpyDeviceToHost);


			std::cout <<" N "<< N << " est premier ? " << res_operations[0] << '\n';
		cudaFree(dev_possibles_premiers);
		cudaFree(dev_res_operations);
		free(possibles_premiers);
		free(res_operations);
}

vector<uint64_t> Lancer_searchPrimes(uint64_t N){



	vector<uint64_t> premiers_packed(0);
		uint64_t *possibles_premiers = (uint64_t*)malloc(sizeof(uint64_t)*(N-2));
		for(int i = 0; i < (N-2); possibles_premiers[i] = i+2, i++);
		uint64_t *square_roots = (uint64_t*)malloc(sizeof(uint64_t)*(N-2));
		for(int i = 0; i < (N-2); square_roots[i] = sqrt(i+2), i++);
		uint64_t *premiers = (uint64_t*)malloc(sizeof(uint64_t)*(N-2));
		for(int i = 0; i < (N-2); premiers[i] = 0, i++);


		uint64_t *dev_possibles_premiers;
		uint64_t *dev_square_roots;
		uint64_t *dev_premiers;
		cudaMalloc((void**)&dev_possibles_premiers,sizeof(uint64_t)*(N-2));
		cudaMalloc((void**)&dev_square_roots,sizeof(uint64_t)*(N-2));
		cudaMalloc((void**)&dev_premiers,sizeof(uint64_t)*(N-2));


		cudaMemcpy(dev_possibles_premiers, possibles_premiers, sizeof(uint64_t)*(N-2), cudaMemcpyHostToDevice);
		cudaMemcpy(dev_square_roots, square_roots, sizeof(uint64_t)*(N-2), cudaMemcpyHostToDevice);
		cudaMemcpy(dev_premiers, premiers, sizeof(uint64_t)*(N-2), cudaMemcpyHostToDevice);
		uint64_t tailleGrid = (((N-2)+BLOCKDIM-1)/BLOCKDIM);
		searchPrimeGPU<<<tailleGrid,BLOCKDIM,SIZEMEM>>>(
				dev_possibles_premiers,
				dev_square_roots,
				N,
				dev_premiers);

		cudaMemcpy(premiers, dev_premiers, sizeof(uint64_t)*(N-2), cudaMemcpyDeviceToHost);



		int nombresDePremiers = 0;
		for(int i = 0; i < (N-2); i++){
			if (premiers[i] != 0)
				nombresDePremiers++;
		}

		for (int i = 0; i < nombresDePremiers; i++){
			int j = 0;

			while (premiers[j] == 0 && j < (N-2))
				j++;
			premiers_packed.push_back(j+2);
			premiers[j] = 0;
		}


		return premiers_packed;
}

void Lancer_facteurs(uint64_t N){

  	vector<uint64_t> premiers_packed = Lancer_searchPrimes(N);

		uint64_t *primes = (uint64_t*)malloc(sizeof(uint64_t) * premiers_packed.size());
		for(int i = 0; i < premiers_packed.size(); primes[i]=premiers_packed.at(i),i++);

		fact  *facteurs=(fact*)malloc(sizeof(fact)*premiers_packed.size());
		for(int i =0 ; i<premiers_packed.size(); i++) {
				facteurs[i].base=primes[i];
				facteurs[i].expo=0;
				std::cout << "/* les primes  */"<<facteurs[i].base <<"expo "<< facteurs[i].expo<< '\n';
		}

		uint64_t *dev_primes;
		fact *dev_facteurs;

		cudaMalloc((void**)&dev_primes,sizeof(uint64_t)*premiers_packed.size());
	  cudaMalloc((void**)&dev_facteurs,sizeof(fact)*premiers_packed.size());

		cudaMemcpy(dev_primes,primes,sizeof(uint64_t)*premiers_packed.size(),cudaMemcpyHostToDevice);
		cudaMemcpy(dev_facteurs,facteurs,sizeof(fact)*premiers_packed.size(),cudaMemcpyHostToDevice);

			uint64_t tailleGrid = (((premiers_packed.size())+BLOCKDIM-1)/BLOCKDIM);
	  factGPU<<<tailleGrid,BLOCKDIM>>>(
				N,
				dev_primes,
				taille,
				dev_facteurs);

	     	cudaMemcpy(facteurs,dev_facteurs,sizeof(fact)*premiers_packed.size(),cudaMemcpyDeviceToHost);


	     vector<fact> resulat(0);
	    for(int i=0 ; i <premiers_packed.size();i++)
	    {
	          if(facteurs[i].expo!=0)
	         {
	            fact c;
	           c.base=facteurs[i].base;
	          c.expo=facteurs[i].expo;
	          resulat.push_back(c);
	          }
	   }

}

int main( int argc, char **argv ){
  uint64_t N =atol(argv[1]);
  auto start = high_resolution_clock::now();

  Lancer_isPrime(N);
  vector<uint64_t> premiers_packed=Lancer_searchPrimes(N);
	string printable =  "La liste des  premiers : \n " ;

		for(int i =0 ; i < premiers_packed.size() ; i++)
		{
				printable += "-" + std::to_string(premiers_packed.at(i)) + "-";
		}

		std::cout <<printable << '\n';
  Lancer_facteurs(N);
  auto stop = high_resolution_clock::now();
  auto duration = duration_cast<microseconds>(stop - start);
 cout << "Time taken by GPU version : "
        << duration.count() << " microseconds" << endl;

   	return 0;
}
