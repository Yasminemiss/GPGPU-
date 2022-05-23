
#include <bits/stdc++.h>
#include <cstdint>
#include <iostream>
#include <string>
#include <ctgmath>
#include <vector>
#include <iostream>
#include <cstdlib>
#include <cstdint>
#include <chrono>

using namespace std;
using namespace std::chrono;







void updatePrimes( uint64_t* ptr , vector<uint64_t*> *facteursPrimes)
{

    bool upatePrimes=true;
    int i=0 ;
    while( i < facteursPrimes->size())
    {

       uint64_t *val =facteursPrimes->at(i);
       if(ptr[0]==val[0])
       {

         facteursPrimes->at(i)[1]+=1;
         upatePrimes=false;
         std::cout << "base "<< facteursPrimes->at(i)[0]<<"^expo "<< facteursPrimes->at(i)[1]<< '\n';
       }
       i++;
    }

   if(upatePrimes==true) {
     ptr[1]+=1;
     facteursPrimes->push_back(ptr);
       std::cout << "base "<<ptr[0]<<"^expo "<<ptr[1]<< '\n';
   }

}

bool isPrimeCPU(const uint64_t number)
{
    double i = number-1;
    while(i >= 2)
    {
        if (floor(number/i) == number/i) return false;
        i--;
    }
    return true;
}


vector<uint64_t> searchPrimesCPU(const uint64_t l){
    vector<uint64_t> res(0);
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


 void factoCPU(uint64_t N, vector<uint64_t*> *facteursPrimes)
{
     vector<uint64_t> listes_numbers = searchPrimesCPU(N);
     int pivot=0;
     while(N!=1)
     {

               if(N%listes_numbers.at(pivot) == 0)
               {
                 uint64_t p[2];
                 p[0]=listes_numbers.at(pivot);
                 p[1]=0;
                 N=N/listes_numbers.at(pivot);
                 updatePrimes(p,facteursPrimes);
                }
               else if( pivot < listes_numbers.size()) pivot++;
     }

}


int main( int argc, char **argv )
{

  uint64_t N=30;
  int i;
  cout << " fonction isPrime  N "<<N<<" est prime ? " <<isPrimeCPU(N) <<'\n';
  auto start = high_resolution_clock::now();
  vector<uint64_t> v = searchPrimesCPU(N);
  cout << " fonction search prime " << '\n';
  i =0;
  while(i < v.size()) {
      cout << " nombre premier "<< std::to_string(v.at(i))<<'\n';
    i++;
   }

  cout << " fonction facteursPrimes " << '\n';
  vector<uint64_t*> facteurs(0);
  factoCPU(N,&facteurs);
  auto stop = high_resolution_clock::now();
   auto duration = duration_cast<microseconds>(stop - start);

   cout << "Time taken by function: "
        << duration.count() << " microseconds" << endl;
 	return 0;
}
