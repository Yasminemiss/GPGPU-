program : main.o
	g++ -o program main.o
main.o : main.cpp primeCPU.o chronoCPU.o
	g++ -c main.cpp -L/usr/local/cuda/lib64 -lcudart
primeCPU.o : primeCPU.cpp helper.o
	g++ -c primeCPU.cpp -L/usr/local/cuda/lib64 -lcudart
helper.o : helper.cpp helper.hpp
	g++ -c helper.cpp- L/usr/local/cuda/lib64 -lcudart
chronoCPU.o : chronoCPU.cpp
	g++ -c chronoCPU.cpp -L/usr/local/cuda/lib64 -lcudart


#g++ -o primeCPU primeCPU.cpp
