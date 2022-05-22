#include "helper.hpp"


using namespace std;
// TODO : Commenter
void printUsage( const char *prg )
{
    cerr	<< "Usage: " << prg << "  N "
            << endl << endl;
    exit( EXIT_FAILURE );
}

// TODO : Commenter
string printPrimes(vector<uint64_t> primeNumbers)
{
    string res =  "Nombres premiers : \n " ;

    for(int i =0 ; i < primeNumbers.size() ; i++)
    {
        res += "[" + std::to_string(primeNumbers.at(i)) + "]";
    }
    return res;
}

// TODO : Commenter
string printFacteurs(vector<cell> facteurs )
{
    string res = "Les Facteurs premiers :  \n ";
    for(int i = 0 ; i < facteurs.size(); i++)
    {
        string cell = to_string(facteurs.at(i).base)+"^"+to_string(facteurs.at(i).expo);
        res+= (i==facteurs.size()-1) ? ""+cell : cell+"*" ;
    }
    return res;
}

// TODO : commenter


/**   \brief je suis la methode qui va ajouter , une celule dans le vecteurs de facteurs
*/

void addCell( cell c , vector< cell> *facteursPrimes)
{

    bool add=true;
    for(int i=0 ; i < facteursPrimes->size();i++)
    {
       if(c.base==facteursPrimes->at(i).base)
       {
         facteursPrimes->at(i).expo+=1;
         add=false;
       }
    }

    if(add==true) facteursPrimes->push_back(c);
}

/** \brief Je suis une fonction pour effectuer un meilleur affichage en cas
 *          d'échec d'une assertion.
 */
 void mAssert(char *const expr_str, bool expr, basic_string<char> msg){
    if (!expr){
        std::cout << "Echec de l'assertion: " << msg << endl
        << "Resultat Attendu : " << expr_str << endl
        << "a renvoyé : False." << endl;

        std::cout << "Echec du test, fin du programme." << endl;
        exit(1);
    }
 }
