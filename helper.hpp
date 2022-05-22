/** \brief  Je suis un fichier header contenant des constantes et déclarations d'usage
 *          général utiles à plusieurs parties du logiciel.
 */
#ifndef PROJETGPU_HELPER_H
#define PROJETGPU_HELPER_H

/**
 * \brief Booléens de génération de log pour le débug.
 */
#define VERBOSE 0
#define INFO    0

/** \brief Inclusions et prototypes liés aux fonctions et structures à usage général.
 *
 */
#include <vector> // vector<T>
#include <cstdint> // uint64_t
#include <string> // string
#include <iostream> // cerr, cout, endl

using namespace std;

/**  \brief Je suis un tuple contenant le facteur premier et son exponentiation.
 */
struct cell {
    uint64_t base;
    int expo;
};

void printUsage( const char *prg );
string printPrimes(vector<uint64_t> primeNumbers);
string printFacteurs(vector<cell> facteurs);
void addCell( cell c , vector< cell> *facteursPrimes);
void mAssert(char *const expr_str, bool expr, basic_string<char> msg);


#endif //PROJETGPU_HELPER_H
