cmake_minimum_required(VERSION 3.10)

project(ProjetGPU LANGUAGES CUDA CXX)

set(CMAKE_CUDA_STANDARD 14)
set(gnuplot-cpp_DIR gnuplot-cpp)
find_package(gnuplot-cpp REQUIRED)

include_directories(${gnuplot-cpp_INCLUDE_DIRS})

add_executable(PrimeBreaker
      	utils/chronoGPU.cu
	utils/chronoCPU.cpp
	helper.cpp
	primeBreakerCPU.cpp
	primeBreaker.cu
	TestPrimeBreaker.cpp
	TestPrimeBreakerGPU.cu
	sampling.cu
	benchmark.cu
	main.cu
	)

target_compile_options(PrimeBreaker PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:
                       	-g
			-G
                       	--relocatable-device-code=true
                     >)

set_property(TARGET PrimeBreaker PROPERTY CUDA_SEPARABLE_COMPILATION ON)
