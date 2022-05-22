#include <iostream>
#include <cstdlib>
#include <cstdint>
#include "utils/chronoGPU.hpp"
#include "utils/chronoCPU.hpp"
#include "primeBreaker.hpp"
#include "primeBreakerCPU.hpp"
#include "TestPrimeBreakerGPU.hpp"
#include "TestPrimeBreaker.hpp"
#include "utils/common.hpp"
#include "helper.hpp"
#include "benchmark.h"

using namespace std;


int main( int argc, char **argv )
{

   cout << " Mode d'utilisation " << endl;
   cout <<  argv[0] <<" 0  : Pour lancer les test unitaires" << endl;
   cout << argv[0] << " 1 N : "  << " Pour lancer les fontions isprime CPU et GPU"<< endl;
   cout << argv[0] << " 2 N : " << " pour lancer les fonctions searchPrime CPU et GPU "<< endl;
   cout << argv[0] << "  3 N  : " << " pour lancer les fonctions Fact CPU et GPU " <<endl;
   cout << argv[0] << " 4  : " << " pour lancer les tests de performances ." << endl;

 if(atol(argv[1])==0){
    cout << "=========================================================================="	<< endl;
    cout << "         			Partie CPU	                              " 	<< endl;
    cout << "=========================================================================="	<< endl << endl;
    
    	launchUnitTest();
    
    cout << "=========================================================================="	<< endl;
    cout << "         			Partie GPU	                               " 	<< endl;
    cout << "=========================================================================="	<< endl << endl;
	
     	launchUnitTestGPU();
}


if(atol(argv[1])==1)
{
    cout << "=========================================================================="	<< endl;
    cout << "         			Partie CPU Test de primalite	                               " 	<< endl;
     cout << "=========================================================================="	<< endl << endl;
         lancerIsPrimeWithInput(argc,argv);
 
      
    cout << "=========================================================================="	<< endl;
    cout << "         			Partie GPU Test  de primalite	                               " 	<< endl;
    cout << "=========================================================================="	<< endl << endl;
          lancerIsPrimeWithInputGPU(argc,argv);
}
if(atol(argv[1])==2)
{
    cout << "=========================================================================="	<< endl;
    cout << "         			Partie CPU	                               " 	<< endl;
    cout << "=========================================================================="	<< endl << endl;
            lancerSearchPrimes(argc,argv);
 
    cout << "=========================================================================="	<< endl;
    cout << "         			Partie GPU	                               " 	<< endl;
    cout << "=========================================================================="	<< endl << endl;
            lancerSearchPrimesGPU(argc,argv);
}

if(atol(argv[1])==3)
{
    
    cout << "=========================================================================="	<< endl;
    cout << "         			Partie CPU	                               " 	<< endl;
    cout << "=========================================================================="	<< endl << endl;
   lancerFactorizedWithInput(argc,argv);
    cout << "=========================================================================="	<< endl;
    cout << "         			Partie GPU	                               " 	<< endl;
    cout << "=========================================================================="	<< endl << endl;
   lancerFactorizedWithInputGPU(argc,argv);
}

if(atol(argv[1]) == 4){
    cout << "=========================================================================="	<< endl;
    cout << "         			Partie CPU	                              " 	<< endl;
    cout << "=========================================================================="	<< endl << endl; 
    
	generateDataFilesCPU();

    cout << "=========================================================================="	<< endl;
    cout << "         			Partie GPU	                               " 	<< endl;
    cout << "=========================================================================="	<< endl << endl;

	generateDataFilesGPU();    
}
 	return EXIT_SUCCESS;
}
