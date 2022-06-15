#include "primeGPGPU.hpp"


__device__ void warpReduce(volatile unsigned int* cache, int tid)
{
	cache[tid]=umin( cache[tid], cache[tid + 32] );
	cache[tid]=umin( cache[tid], cache[tid + 16] );
	cache[tid]=umin( cache[tid], cache[tid + 8] );
	cache[tid]=umin( cache[tid], cache[tid + 4] );
	cache[tid]=umin( cache[tid], cache[tid + 2] );
	cache[tid]=umin( cache[tid], cache[tid + 1] );
}

__global__
void isPrimeGPU(
		uint64_t *Prime_PossiblE,
		unsigned int *resultat,
		uint64_t N,
		uint64_t sqrtN
		){

	int gid = threadIdx.x + blockIdx.x * blockDim.x;
	int initial_gid = gid;
	int bid = blockIdx.x;
	int tid = threadIdx.x;


	extern __shared__ unsigned int Shared_memory;

	Shared_memory[tid] = 1;
	while (gid < sqrtN){

		if(N%Prime_PossiblE[gid] !=0){
				Shared_memory[tid] = 1;
		}else{
				Shared_memory[tid] = 0;
		}

		__syncthreads();



		int i = blockDim.x/2;
		while (i >32) {

			if (tid < i) {
				Shared_memory[tid] = umin ( Shared_memory[tid], Shared_memory[tid+i] );
			}
			__syncthreads();
			i /= 2;
		}

    if(tid < 32) warpReduce(Shared_memory,tid);

		if (tid == 0) {
			resultat[bid] = Shared_memory[0];
		}

		gid += gridDim.x * blockDim.x;

	}


	if (initial_gid < ((sqrtN+blockDim.x-1)/blockDim.x))
		resultat[0] = ((resultat[0] != 0) && (resultat[initial_gid] != 0));

}


__global__ void searchPrimeGPU(
		uint64_t *Prime_PossiblE,
		uint64_t *square_roots,
		uint64_t borne_sup,
		uint64_t *premiers)
{
	/*int gid = threadIdx.x + blockIdx.x * blockDim.x;
	while (gid < borne_sup-2) {
		if (gid == 0) {
			premiers[gid] = 1;
		} else {
			int resultat_size = ((square_roots[gid]+blockDim.x-1)/blockDim.x)+1;
			unsigned int *resultat = (unsigned int*)malloc(sizeof(unsigned int)*resultat_size);

			isPrimeGPU<<<gridDim.x,blockDim.x,blockDim.x*sizeof(unsigned int)>>>
				(Prime_PossiblE,
			 	resultat,
			 	Prime_PossiblE[gid],
			 	square_roots[gid]
			 	);
			cudaDeviceSynchronize();

			premiers[gid] = resultat[0];
			free(resultat);
		}
		gid += gridDim.x * blockDim.x;
	}*/

}


__global__
void factGPU(
		uint64_t  N,
		uint64_t *dev_primes,
               	int taille,
		fact *dev_facteurs
)
{
	int gid = threadIdx.x+blockIdx.x*blockDim.x;
	int tid = threadIdx.x;
        extern __shared__ unsigned int Shared_memory[];

	while(gid < taille)
       	{
        	Shared_memory[tid] = 0;
		uint64_t temp_N = N;

		while(temp_N%dev_primes[gid]==0)
                {
			Shared_memory[tid] += 1;
			temp_N /= dev_primes[gid];
		}

		__syncthreads();

		if (tid == 0){
			for (int i = 0; i < blockDim.x; i++){
				if (Shared_memory[i]) {
					dev_facteurs[i+blockIdx.x*blockDim.x].expo += Shared_memory[i];
					N -= (dev_facteurs[i+blockIdx.x*blockDim.x].base * Shared_memory[i]);
				}
			}
		}
		__syncthreads();

            gid+=blockDim.x*gridDim.x;
        }
}
