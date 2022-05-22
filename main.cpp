#include "TestPrimeBreaker.hpp"
#include "benchmark.h"
#include <iostream>
#include <cstdlib>

using namespace std;

int main( int argc, char **argv )
{
    cout << "========================================================================================"	<< endl;
	cout << "                           Version séquentielle sur CPU                                 " 	<< endl;
	cout << "========================================================================================"	<< endl << endl;

    //launchUnitTest();

    cout << "========================================================================================"	<< endl;
    cout << "                           Tests de performances (CPU)                                  " 	<< endl;
    cout << "========================================================================================"	<< endl << endl;

    generatePlots();

	return EXIT_SUCCESS;
}
