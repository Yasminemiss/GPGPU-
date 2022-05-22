#include <cstring>
#include "TestPrimeBreaker.hpp"

/** \brief  Je suis une fonction qui lance les fonctions de tests.
 */
void launchUnitTest(){
    cout << "============================================"	<< endl;
    cout << "         Lancement des tests unitaires.     " 	<< endl;
    cout << "============================================"	<< endl << endl;

    TestIfNonPrimeIsNotAssertedWithAIntegerPrimeNumber();
    TestIfPrimeIsAssertedWithAIntegerPrimeNumber();
    TestIfPrimeIsAssertedWithALargeUint64PrimeNumber();
    TestIfNonPrimeIsNotAssertedWithALargeUint64PrimeNumber();
    TestIfPrimesBetween0and100AreSuccessfullyRetrieved();
    TestIfNumberIsFactorized();

    cout << "============================================"	<< endl;
    cout << "    Tests unitaires éffectués avec succès.   " 	<< endl;
    cout << "============================================"	<< endl << endl;
}


/**
 * \brief   Tester si un nombre premier assez grand (tenant sur un UINT32_T) est reconnu comme tel par
 *          notre fonction.
 */
void TestIfPrimeIsAssertedWithAIntegerPrimeNumber(){
    std::cout << "Tester si un nombre premier assez large tenant sur un UINT32_T est reconnu comme tel." << std::endl;
    uint32_t large_uint32_prime = LARGE_UINT32_NUMBER;

    mAssert("isPrimeCPU_v0(large_uint32_prime)",
            isPrimeCPU_v0(large_uint32_prime),
            "Le nombre premier tenant sur 32 bits n'a pas été reconnu comme tel.");

    std::cout << "Le nombre premier a été reconnu : succès." << std::endl << std::endl;
}

/**
 * \brief   Tester si un nombre non premier assez grand (tenant sur un UINT32_T) n'est pas reconnu
 *          comme un nombre premier par notre fonction.
 */
void TestIfNonPrimeIsNotAssertedWithAIntegerPrimeNumber(){
    std::cout << "Tester si un nombre non premier assez large tenant sur un UINT32_T n'est pas reconnu comme tel." << std::endl;
    uint32_t large_uint32_non_prime = LARGE_UINT32_NUMBER-1;

    mAssert("!isPrimeCPU_v0(large_uint32_non_prime)",
            !isPrimeCPU_v0(large_uint32_non_prime),
            "Le nombre non premier tenant sur 32 bits a été reconnu comme un nombre premier."
            );

    std::cout << "Le nombre non premier n'a pas été reconnu : succès." << std::endl << std::endl;
}

/**
 * \brief   Tester si un nombre premier assez grand (tenant sur un UINT64_T) est reconnu comme tel par
 *          notre fonction.
 */
void TestIfPrimeIsAssertedWithALargeUint64PrimeNumber(){
    std::cout << "Tester si un nombre premier tenant sur un UINT64_T est reconnu comme tel." << std::endl;
    uint64_t large_uint64_prime = LARGE_UINT64_NUMBER;

    mAssert("isPrimeCPU_v0(large_uint64_prime)",
            isPrimeCPU_v0(large_uint64_prime),
            "Le nombre premier tenant sur 64 bits n'a pas été reconnu comme tel."
            );

    std::cout << "Le nombre premier a été reconnu : succès." << std::endl << std::endl;
}

/**
 * \brief   Tester si un nombre non premier assez grand (tenant sur un UINT64_T) n'est  pas reconnu
 *          comme un nombre premier par notre fonction.
 */
void TestIfNonPrimeIsNotAssertedWithALargeUint64PrimeNumber(){
    std::cout << "Tester si un nombre non premier tenant sur un UINT64_T n'est pas reconnu comme tel." << std::endl;
    uint64_t large_uint64_non_prime = LARGE_UINT64_NUMBER-1;

    mAssert("!isPrimeCPU_v0(large_uint64_non_prime)",
            !isPrimeCPU_v0(large_uint64_non_prime),
            "Le nombre non premier tenant sur 64 bits a été reconnu comme un nombre premier.");

    std::cout << "Le nombre non premier n'a pas été reconnu : succès " << std::endl
    << std::endl;
}

/**
 * \brief Tester la génération de nombre premiers sur un interval entre zéro et 2000;
 */
void TestIfPrimesBetween0and100AreSuccessfullyRetrieved()
{
    std::cout << "Tester la récupération des nombres premiers entre 0 et 100." << std::endl;

    vector<uint64_t> controlPrimeSet = getPrimesFrom0to100FromControlPrimeSetFile();
    vector<uint64_t> primesNumberFrom0to100 = searchPrimesCPU_v0(100);

    if (VERBOSE) {
        std::cout << "Liste de nombres premier du fichier témoin. [indice,nPremier]" << std::endl;
        for (int i = controlPrimeSet.size() - 1; i >= 0; i--) {
            std::cout << "[" << std::to_string(i) << "," << controlPrimeSet.at(i) << "]";
        }
        std::cout << endl;
        std::cout << "Liste de nombres premier obtenu par la fonction testée. [indice,nPremier]" << std::endl;
        for (int i = 0; i < primesNumberFrom0to100.size(); i++) {
            std::cout << "[" << std::to_string(i) << "," << primesNumberFrom0to100.at(i) << "]";
        }
        std::cout << endl;
    }

    mAssert("controlPrimeSet.size() == primesNumberFrom0to100.size()",
            controlPrimeSet.size() == primesNumberFrom0to100.size(),
            string("La fonction ne renvoit pas le même nombre de nombres premiers que dans le groupe de controle.\n")
            + string("controlPrimeSet.size() = ") + std::to_string(controlPrimeSet.size()) +
            string("\nprimesNumberFrom0to100.size() = ") + std::to_string(primesNumberFrom0to100.size())
            + string("\n")
    );

    int i = controlPrimeSet.size()-1;
    int j = 0;
    for (; i >= 0; i-- && j++){
        mAssert("controlPrimeSet.at(i) == primesNumberFrom0to100.at(1)",
                controlPrimeSet.at(i) == primesNumberFrom0to100.at(j),
                ("On ne retrouve pas le " + std::to_string(i) + "ème nombre premier.")
                );
    }

    std::cout << "On retrouve bien tout les nombres premiers compris dans l'interval : Succès." << std::endl << std::endl;
}

/*	\brief	Tester si la factorisation d'un nombre entier en produit de nombres premiers fonctionne.
 */
void TestIfNumberIsFactorized(){
	cout << "Tester si notre fonction de test pour l'algorithme de factorisation sur le CPU." << endl;
	
	/* Initialisation du témoin. 2133 = 3^3 * 79 */
	cell trois;
	trois.base = 3;
	trois.expo = 3;
	cell soixante_dix_neuf;
	soixante_dix_neuf.base = 79;
	soixante_dix_neuf.expo = 1;
	vector<cell> temoin(0);
	temoin.push_back(soixante_dix_neuf);
	temoin.push_back(trois);

	/* Initialisation du résulat. */
	vector<cell> resultat(0);
	factoCPU_v1(2133,&resultat);

	/* Assertions */
	mAssert(	"resultat.size() == temoin.size()",
			resultat.size() == temoin.size(),
			"La fonction ne renvoit pas le même nombres de premiers distincts.");

	for (int i = 0; i < resultat.size(); i++) {
		cell current_cell_res = resultat.at(i);
		cell current_cell_temoin = temoin.at(i);

		mAssert(	"current_cell_res.base == current_cell_temoin.base",
				current_cell_res.base == current_cell_temoin.base,
				"La base a l'indice " + std::to_string(i) + " n'est pas la même pour le resultat et le témoin");

		mAssert(	"current_cell_res.expo == current_cell_temoin.expo",
				current_cell_res.expo == current_cell_temoin.expo,
				"L'exposant de la base " + std::to_string(current_cell_res.base) + " n'est pas le même pour le résultat et le témoin.");	
	}

	cout << "La factorisation a bien fonctionnée : Succès" << endl << endl;

}

/**  \brief Je suis la méthode qui récupère à partir du fichier temoin
 *          la liste des nombres premiers compris entre zéro et cent.
 *   @return La liste des nombres premiers sous la forme d'un vector<uint64_t>
 */
vector<uint64_t> getPrimesFrom0to100FromControlPrimeSetFile(){
    if (INFO) {
        std::cout << "getPrimesFrom0to100FromControlPrimeSetFile" << endl;
    }

    vector<uint64_t> output(0);
    string filename = "primes0to100.txt";
    char line[1024];
    ifstream controlFileStream;

    controlFileStream.open(filename, std::ifstream::in);
    if (controlFileStream.is_open()){
        if (INFO) {
            std::cout << "Control File Opened" << endl;
        }
        while (controlFileStream.getline(line,1024)){
            putPrimesFromLineInOutput(line, &output);
        }
        controlFileStream.close();
    } else {
        std::cout << "Control File didn't open. Error : " << strerror(errno);
        exit(1);
    }
    return output;
}

/** \brief  Je suis une fonction qui prends une ligne de notre fichier témoin
 *          et met les nombres premiers présent dans cette ligne dans notre
 *          tableau.
 * @param line Ligne de notre fichier témoin.
 * @param output Tableau de nombre premier à remplir.
 */
void putPrimesFromLineInOutput(string line,vector<uint64_t> *output){
    if (INFO) {
        std::cout << "putPrimesFromLineInOutput" << endl;
    }
    vector<uint64_t> primes = splitNumbersFromLine(line);

    for (int i = 0; i < primes.size(); i++){
        (*output).push_back(primes.at(i));
    }
    if (VERBOSE) {
        assert(primes.size() != 0);
        for (int i = 0; i < primes.size(); i++) {
            cout << "DEBUG 0 " << endl;
            cout << primes.at(i) << endl;
        }
    }
}

/** \brief  Je suis une fonction qui sépare les nombres premiers d'une ligne
 *          extraite de notre fichier témoin et qui renvoit ces nombres dans
 *          un vector<uint64_t>
 * @param line Une ligne contenant des nombres premiers séparé par des tabulations
 * @return Un vector<uint64_t> de nos nombres premiers.
 */
vector<uint64_t> splitNumbersFromLine(string line){
    if (INFO) {
        std::cout << "splitNumbersFromLine" << endl;
    }
    vector<uint64_t> output(0);
    stringstream ss(line); // Utilisé pour lire une chaine de caractère comme un flux.
    char *numberOfCharProcessed = 0; // strtoull param.

    string buffer = "";
    while (getline(ss, buffer, '\t')) {
        output.push_back(
                strtoull(buffer.c_str(), &numberOfCharProcessed, 10)
        );
        buffer = "";
    }

    if (VERBOSE) {
        assert(output.size() != 0);
        for (int i = 0; i < output.size(); i++) {
            cout << "DEBUG 1 " << endl;
            cout << output.at(i) << endl;
        }
    }
    return output;
}



void lancerFactorizedWithInput(int argc,char **argv)
{

     

         uint64_t N = atoll(argv[2]);
         ChronoCPU chrCPU;
         vector<cell> resultat(0);
         chrCPU.start();
         factoCPU_v1(N,&resultat);
         chrCPU.stop();
         const float timeComputeCPUFact = chrCPU.elapsedTime();
         cout <<"Temps de factorisation en nombre premier : "<< timeComputeCPUFact <<" ms "<<endl;
        cout <<"Factorisation CPU " << printFacteurs(resultat)<<endl;

}


 void lancerIsPrimeWithInput(int argc,char **argv)
{

     uint64_t N= atoll(argv[2]);
     ChronoCPU chrCPU;
    chrCPU.start();
    bool isPrime=isPrimeCPU_v0(N);
    chrCPU.stop();
   const float timeComputedOnCPU = chrCPU.elapsedTime();
   cout << "Temps du test de primalite " << timeComputedOnCPU << "  ms "<<endl;
   cout << "Est Premier ? "<<isPrime<<endl;

}


void lancerSearchPrimes(int argc,char **argv)
{
        uint64_t N = atoll(argv[2]);
        ChronoCPU chrCPU;
       chrCPU.start();
      searchPrimesCPU_v0(N);
     chrCPU.stop();
     const float timeCPU = chrCPU.elapsedTime();
    cout <<" Temps de recherche : "<< timeCPU <<" ms"<<endl;

}
