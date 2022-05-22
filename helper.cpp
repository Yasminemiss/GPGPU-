#include "helper.hpp"


using namespace std;



string afficherPrimes(vector<uint64_t> primeNumbers)
{
    string r = " \n " ;
    int i =0
    while(i < primeNumbers.size()) {
      r += std::to_string(primeNumbers.at(i));
      i++;
    }

    return r;
}


string afficherFacteurs(vector<primes> facteurs )
{
    string res =" \n";
    int i = 0 ;
    while( i < facteurs.size())
    {
        string val = to_string(facteurs.at(i)[0])+"^"+to_string(facteurs.at(i)[1]);
        if(i==facteurs.size()-1){
          res+=val;
        }
        else{
          res+val+"*"
        }
         i++;
    }
    return res;
}


void updatePrimes( primes c , vector< primes> *facteursPrimes)
{

    bool upatePrimes=true;
    int i=0 ;
    while( i < facteursPrimes->size())
    {
       if(c[0]==facteursPrimes->at(i)[0])
       {
         facteursPrimes->at(i)[1]+=1;
         upatePrimes=false;
       }
       i++;
    }

    if(upatePrimes==true) facteursPrimes->push_back(c);
}
