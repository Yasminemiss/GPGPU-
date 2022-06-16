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

__global__
void factGPU(
		uint64_t  N,
		uint64_t *dev_primes,
               	int taille,
		cell *dev_facteurs
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


__global__ void searchPrimeGPU(
		uint64_t *Prime_PossiblE,
		uint64_t *carre,
		uint64_t limit,
		uint64_t *res_premes)
{
	int t_id = threadIdx.x + blockIdx.x * blockDim.x;
	while (t_id < limit-2) {
		if (t_id == 0) {
			res_premes[t_id] = 1;
		} else {
			int res_operations_size = ((carre[t_id]+blockDim.x-1)/blockDim.x)+1;
			unsigned int *res_operations = (unsigned int*)malloc(sizeof(unsigned int)*res_operations_size);


			isPrimeGPU<<<gridDim.x,blockDim.x,blockDim.x*sizeof(unsigned int)>>>
				(Prime_PossiblE,
			 	res_operations,
			 	Prime_PossiblE[t_id],
			 	carre[t_id]
			 	);
			cudaDeviceSynchronize();

			res_premes[t_id] = res_operations[0];
			free(res_operations);
		}
		t_id += gridDim.x * blockDim.x;
	}

}
