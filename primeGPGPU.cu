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
	extern __shared__ unsigned int Shared_memory[];
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
		uint64_t *possibles_premiers,
		uint64_t *square_roots,
		uint64_t borne_sup,
		uint64_t *premiers)
{
	int gid = threadIdx.x + blockIdx.x * blockDim.x;
	while (gid < borne_sup-2) {
		if (gid == 0) {
			premiers[gid] = 1;
		} else {
			int res_operations_size = ((square_roots[gid]+blockDim.x-1)/blockDim.x)+1;
			unsigned int *res_operations = (unsigned int*)malloc(sizeof(unsigned int)*res_operations_size);
			isPrime<<<gridDim.x,blockDim.x,blockDim.x*sizeof(unsigned int)>>>
				(possibles_premiers,
			 	res_operations,
			 	possibles_premiers[gid],
			 	square_roots[gid]
			 	);
			cudaDeviceSynchronize();

			premiers[gid] = res_operations[0];
			free(res_operations);
		}
		gid += gridDim.x * blockDim.x;
	}

}


__global__
void factGPU(
		uint64_t  N,
		uint64_t *res_primes,
               	int size,
		fact *res_facteurs
)
{
	int index_grid = threadIdx.x+blockIdx.x*blockDim.x;
	int tid = threadIdx.x;
  extern __shared__ unsigned int Shared_memory[];

	while(index_grid < size){


    Shared_memory[tid] = 0;
		uint64_t tmp = N;
		while(tmp%res_primes[index_grid]==0){
			Shared_memory[tid] += 1;
			tmp = tmp/res_primes[index_grid];
		}
		__syncthreads();

		if (tid == 0){
			int i = 0;
			while ( i < blockDim.x){
				if (Shared_memory[i]==1) {
					res_facteurs[i+blockIdx.x*blockDim.x].expo =	res_facteurs[i+blockIdx.x*blockDim.x].expo + Shared_memory[i];
					N = N- (res_facteurs[i+blockIdx.x*blockDim.x].base * Shared_memory[i]);
				}
				i++;
			}
		}
		__syncthreads();

    index_grid+=blockDim.x*gridDim.x;

    }
}
