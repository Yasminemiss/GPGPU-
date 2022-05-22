#include "primeBreakerCPU.hpp"
#include <bits/stdc++.h>

using namespace std;

/**  \brief  Je suis la méthode qui renvoit si un certain nombre N
 *          est premier.
 *  @param N le nombre dont on doit tester la primalité.
 */
bool isPrimeCPU_v0(const uint64_t N)
{
    long double divider = N-1;
    for (;divider >= 2; divider-=1){
        if (floor(N/divider) == N/divider){
            return false;
        }
    }
    return true;
}

/** \brief  Cette fonction va  tester la primalité d’un nombre de
            - L’algorithme consiste à vérifier pour un nombre N, si les nombres entre 2 et sqrt(N) sont diviseurs de N
*/
bool isPrimeCPU_v1(const uint64_t N,vector<uint64_t> tab_possibles_diviseurs)
{
  if(N==2) return true;

  for(int i=2; i < sqrt(N)+1;i++)
  {    tab_possibles_diviseurs.push_back(i);} // remplir


  for(int i=0;i<tab_possibles_diviseurs.size();i++)
  {
    if(N%tab_possibles_diviseurs[i]==0){ return false;}
  }
  return true;
}

/** \brief  Je suis la méthode qui renvoit un tableau de nombre premier
 *          avec pour limite N.
 *  @param  limite La borne supérieur de l'ensemble que l'on souhaite évaluer.
 */
std::vector<uint64_t> searchPrimesCPU_v0(const uint64_t limite)
{
    std::vector<uint64_t> resultat(0);

    for (uint64_t possiblePrime = limite; possiblePrime >= 2; possiblePrime-=1)
    {
        if (isPrimeCPU_v0(possiblePrime)) {
            resultat.push_back(possiblePrime);
        }
    }
    return resultat;
}


/** \brief je suis la methode qui permet de décomposeur un nombre en facteurs premiers
 *
 * @param N
 * @param facteursPrimes
 */
 void factoCPU(uint64_t N, vector<cell> *facteursPrimes) {
     bool arreter = false;

     while (arreter == false) {
         bool keepGoin = true;
         vector<uint64_t> primesNumbers = searchPrimesCPU_v0(N);
         sort(primesNumbers.begin(), primesNumbers.end());
         for (int i = 0; i < primesNumbers.size() && keepGoin == true; i++) {
             if (sqrt(N) < primesNumbers.at(i)) arreter = true;
             if (N % primesNumbers.at(i) == 0) {
                 cell c;
                 c.base = primesNumbers.at(i);
                 c.expo = 1;
                 N = N / primesNumbers.at(i);
                 addCell(c, facteursPrimes);
                 keepGoin = false;
             }
         }
     }
 }


void factoCPU_v1(uint64_t N, vector<cell> *facteursPrimes)
{
     vector<uint64_t> primesNumbers = searchPrimesCPU_v0(N);
     int i=0;
     while(N!=1)
     {
               if(N%primesNumbers.at(i) == 0)
               {
                 cell c;
                 c.base=primesNumbers.at(i);
                 c.expo=1;
                 N=N/primesNumbers.at(i);
                 addCell(c,facteursPrimes);
                }
               else
               {
                  if( i < primesNumbers.size())
                  { i++;  }
              }
     }
}
