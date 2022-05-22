#include "primeCPU.hpp"
#include <bits/stdc++.h>

using namespace std;


bool isPrimeCPU(const uint64_t number)
{
    double i = number-1
    while(i >= 2)
    {
        if (floor(number/i) == number/i) return false;
        i--;
    }

    return true;
}


std::vector<uint64_t> searchPrimesCPU(const uint64_t l){
    std::vector<uint64_t> res(0);
    uint64_t i = l;
    bool prime;
    while( i >=2)
    {
        prime=isPrimeCPU(i);
        if (prime==1) res.push_back(i);
        i--;
    }
    return res;
}


 void factoCPU(uint64_t N, vector<primes> *facteursPrimes)
{
     vector<uint64_t> listes_numbers = searchPrimesCPU(N);
     int pivot=0;
     while(N>1)
     {
               if(N%listes_numbers.at(pivot) == 0)
               {
                 primes p;
                 p[0]=listes_numbers.at(pivot);
                 p[1]=1;
                 N=N/listes_numbers.at(pivot);
                 addCell(c,facteursPrimes);
                }
               else if( pivot < listes_numbers.size()) pivot++;

     }
}
