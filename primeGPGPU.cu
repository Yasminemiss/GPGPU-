#include "primeGPGPU.hpp"

__global__
void isPrimeGPU(
		uint64_t *possibles_premiers,
		unsigned int *res_operations,
		uint64_t N,
		uint64_t sqrtN
		){

	int gid = threadIdx.x + blockIdx.x * blockDim.x;
	int initial_gid = gid;
	int bid = blockIdx.x;
	int tid = threadIdx.x;
	extern __shared__ unsigned int cache[];

	cache[tid] = 1;
	while (gid < sqrtN){
		cache[tid] = (N%possibles_premiers[gid] != 0);

		__syncthreads();

		int offset = blockDim.x/2;
		while (offset != 0) {
			if (tid < offset) {
				cache[tid] = umin ( cache[tid], cache[tid+offset] );
			}
			__syncthreads();
			offset /= 2;
		}

		if (tid == 0) {
			res_operations[bid] = cache[0];
		}

		gid += gridDim.x * blockDim.x;
	}


	if (initial_gid < ((sqrtN+blockDim.x-1)/blockDim.x))
		res_operations[0] = ((res_operations[0] != 0) && (res_operations[initial_gid] != 0));

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
		uint64_t *dev_primes,
               	int taille,
		fact *dev_facteurs
)
{
	int gid = threadIdx.x+blockIdx.x*blockDim.x;
	int tid = threadIdx.x;
        extern __shared__ unsigned int cache[];

	while(gid < taille)
       	{
        	cache[tid] = 0;
		uint64_t temp_N = N;

		while(temp_N%dev_primes[gid]==0)
                {
			cache[tid] += 1;
			temp_N /= dev_primes[gid];
		}

		__syncthreads();

		if (tid == 0){
			for (int i = 0; i < blockDim.x; i++){
				if (cache[i]) {
					dev_facteurs[i+blockIdx.x*blockDim.x].expo += cache[i];
					N -= (dev_facteurs[i+blockIdx.x*blockDim.x].base * cache[i]);
				}
			}
		}
		__syncthreads();

            gid+=blockDim.x*gridDim.x;
        }
}
