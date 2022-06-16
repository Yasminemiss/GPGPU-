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

uint64_t TailleGrid(uint64_t X){
	return ((X+BLOCKDIM-1)/BLOCKDIM);
}


void Lancer_isPrime(uint64_t N){
		uint64_t sqrtN = sqrt(N) + 1;
		uint64_t nombresDePossiblesPremiers = N-2;

		uint64_t *possibles_premiers = (uint64_t*)malloc(sizeof(uint64_t) * (nombresDePossiblesPremiers));
		for (int i = 0, j = 2.0; j < N; possibles_premiers[i] = j,i++,j++);
		unsigned int *res_operations = (unsigned int*)malloc(sizeof(unsigned int) * TailleGrid(sqrtN));
		for (int i = 0; i < TailleGrid(sqrtN); res_operations[i] = 1,i++);

		uint64_t *dev_possibles_premiers;
		cudaMalloc((void**)&dev_possibles_premiers, sizeof(uint64_t) * (nombresDePossiblesPremiers));

		unsigned int *dev_res_operations;
		cudaMalloc((void**)&dev_res_operations, sizeof(unsigned int) * TailleGrid(sqrtN));


		cudaMemcpy(dev_possibles_premiers, possibles_premiers, sizeof(uint64_t) * (nombresDePossiblesPremiers), cudaMemcpyHostToDevice);
	       	cudaMemcpy(dev_res_operations, res_operations, sizeof(unsigned int) * TailleGrid(sqrtN), cudaMemcpyHostToDevice);
		isPrimeGPU<<<TailleGrid(sqrtN),BLOCKDIM,SIZEMEM>>>(dev_possibles_premiers, dev_res_operations, N, sqrtN);
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
		int taille = premiers_packed.size();
		uint64_t *primes = (uint64_t*)malloc(sizeof(uint64_t) * taille);
		for(int i = 0; i < taille; primes[i]=premiers_packed.at(i),i++);

		fact  *facteurs=(fact*)malloc(sizeof(fact)*taille);
		for(int i =0 ; i<taille; i++) {
				facteurs[i].base=primes[i];
				facteurs[i].expo=0;
		}

		uint64_t *dev_primes;
		fact *dev_facteurs;

		cudaMalloc((void**)&dev_primes,sizeof(uint64_t)*taille);
	  cudaMalloc((void**)&dev_facteurs,sizeof(fact)*taille);

		cudaMemcpy(dev_primes,primes,sizeof(uint64_t)*taille,cudaMemcpyHostToDevice);
		cudaMemcpy(dev_facteurs,facteurs,sizeof(fact)*taille,cudaMemcpyHostToDevice);


	  factGPU<<<TailleGrid(taille),BLOCKDIM>>>(
				N,
				dev_primes,
				taille,
				dev_facteurs);

	     	cudaMemcpy(facteurs,dev_facteurs,sizeof(fact)*taille,cudaMemcpyDeviceToHost);


	     vector<fact> resulat(0);
	    for(int i=0 ; i <taille;i++)
	    {

	          if(facteurs[i].expo!=0)
	         {
	            fact c;
	           c.base=facteurs[i].base;
						 std::cout << c.base <<" voir " << '\n';
	          c.expo=facteurs[i].expo;
	          resulat.push_back(c);
	          }
	   }

		string res = "Les Facteurs premiers :  \n ";
	 for(int i = 0 ; i < resulat.size(); i++)
	 {
			 string cell = to_string(resulat.at(i).base)+"^"+to_string(resulat.at(i).expo);
			 res+= (i==resulat.size()-1) ? ""+cell : cell+"*" ;
	 }
	 std::cout << res << '\n';

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
