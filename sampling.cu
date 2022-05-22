#include "sampling.h"

/** \brief  Je suis une foncton qui aggrège les mesures de
 *          nos tests de performances pour une création de
 *          graphes ultérieure avec GnuPlot.
 * @return boost::tuple<vector<float>,vector<int>> couple de (Tableau de Mesures de temps, Tableau de Logarithme en base 2 des échantillons).
 *
boost::tuple<vector<float>,vector<uint64_t>>
createPrimalityTestsDatas()
{
    vector<uint64_t> samples = generatePrimalityTestsSamples();
    vector<float> timeMeasurements = generatePrimalityTestsMeasurement(samples);

    for (uint64_t log2Samples = 4,
            i = 0;
            i < LOG2MAX_ISP-4;
            log2Samples++,
            i++){
        /// Après la mesure des échantillons, remplacer les
        /// échantillons dans le tableau d'échantillons par
        /// leur logarithme en base 2.
        samples.at(i) = log2Samples;
    }

    return boost::tuple<vector<float>, vector<uint64_t>>{timeMeasurements,samples};
}
*/

void generateDataFilesCPU(){
	cout << " Lancement des tests de performances et génération des fichiers de données " << endl;
    	generateResearchOfPrimesDataFileCPU();
    	generatePrimalityTestDataFileCPU();
    	generatePrimeFactorisationDataFileCPU(); 
    	cout << " Fin des tests de performances, les fichiers des résultats sont dans data/" << endl << endl;
}

void generateResearchOfPrimesDataFileCPU(){
	cout << " Génération des données pour la recherche de nombres premiers sur le CPU " << endl;
    vector<uint64_t> limits = generateResearchOfPrimesLimits();
    vector<float> timeMeasurements = generateResearchOfPrimesMeasurement(limits);

    for (uint64_t log2Samples = 2,
                 i = 0;
         i < LOG2MAX_ROP-4;
         log2Samples++,
                 i++){
        /// Après la mesure des échantillons, remplacer les
        /// échantillons dans le tableau d'échantillons par
        /// leur logarithme en base 2.
        limits.at(i) = log2Samples;
    }

    // Créer un fichier
    ofstream datafile;
    datafile.open("data/researchOfPrimesCPU.dat",ios::out);
    if (datafile.bad()){
	cout << "Problème à l'ouverture du fichier" << endl;
    }else {
	for (int i =0; i < limits.size(); i++){
		datafile << limits.at(i) << '\t' << timeMeasurements.at(i) << '\n';
	}
    }
    	cout << " Fin Génération " << endl;
}

void generatePrimalityTestDataFileCPU(){
	cout << " Génération des données pour le test de primalité sur le CPU " << endl;
    vector<uint64_t> samples = generatePrimalityTestsSamples();
    vector<float> timeMeasurements = generatePrimalityTestsMeasurement(samples);

    for (uint64_t log2Samples = 2,
                 i = 0;
         i < LOG2MAX_ISP-4;
         log2Samples++,
                 i++){
        /// Après la mesure des échantillons, remplacer les
        /// échantillons dans le tableau d'échantillons par
        /// leur logarithme en base 2.
        samples.at(i) = log2Samples;
    }

    // Créer un fichier
    ofstream datafile;
    datafile.open("data/primalityTestsDatasCPU.dat",ios::out);
    if (datafile.bad()){
	cout << "Problème à l'ouverture du fichier" << endl;
    }else {
	for (int i =0; i < samples.size(); i++){
		datafile << samples.at(i) << '\t' << timeMeasurements.at(i) << '\n';
	}
    }
	cout << " Fin Génération. " << endl;

}

void generatePrimeFactorisationDataFileCPU(){
	cout << " Génération des données pour la factorisation sur le CPU " << endl;
    vector<uint64_t> samples = generatePrimeFactorisationSamples();
    vector<float> timeMeasurements = generatePrimeFactorisationMeasurement(samples);

    // Créer un fichier
    ofstream datafile;
    datafile.open("data/factorisationDatasCPU.dat",ios::out);
    if (datafile.bad()){
	cout << "Problème à l'ouverture du fichier" << endl;
    }else {
	for (int i =0; i < samples.size(); i++){
		datafile << samples.at(i) << '\t' << timeMeasurements.at(i) << '\n';
	}
    }
	cout << " Fin Génération. " << endl;
}

void generateDataFilesGPU(){
	cout << " Lancement des tests de performances et génération des fichiers de données " << endl;
    generateResearchOfPrimesDataFileGPU();
    generatePrimalityTestDataFileGPU();
    generatePrimeFactorisationDataFileGPU(); 
    	cout << " Fin des tests de performances, les fichiers des résultats sont dans data/" << endl << endl;
}

void generateResearchOfPrimesDataFileGPU(){
	cout << " Génération des données pour la recherche de nombres premiers sur le GPU " << endl;
    vector<uint64_t> limits = generateResearchOfPrimesLimits();
    vector<float> timeMeasurements = generateGPUResearchOfPrimesMeasurement(limits);

    for (uint64_t log2Samples = 2,
                 i = 0;
         i < LOG2MAX_ROP-4;
         log2Samples++,
                 i++){
        /// Après la mesure des échantillons, remplacer les
        /// échantillons dans le tableau d'échantillons par
        /// leur logarithme en base 2.
        limits.at(i) = log2Samples;
    }

    // Créer un fichier
    ofstream datafile;
    datafile.open("data/researchOfPrimesGPU.dat",ios::out);
    if (datafile.bad()){
	cout << "Problème à l'ouverture du fichier" << endl;
    }else {
	for (int i =0; i < limits.size(); i++){
		datafile << limits.at(i) << '\t' << timeMeasurements.at(i) << '\n';
	}
    }
    	cout << " Fin Génération " << endl;
}

void generatePrimalityTestDataFileGPU(){
	cout << " Génération des données pour le test de primalité sur le GPU " << endl;
    vector<uint64_t> samples = generatePrimalityTestsSamples();
    vector<float> timeMeasurements = generateGPUPrimalityTestsMeasurement(samples);

    for (uint64_t log2Samples = 2,
                 i = 0;
         i < LOG2MAX_ISP-4;
         log2Samples++,
                 i++){
        /// Après la mesure des échantillons, remplacer les
        /// échantillons dans le tableau d'échantillons par
        /// leur logarithme en base 2.
        samples.at(i) = log2Samples;
    }

    // Créer un fichier
    ofstream datafile;
    datafile.open("data/primalityTestsDatasGPU.dat",ios::out);
    if (datafile.bad()){
	cout << "Problème à l'ouverture du fichier" << endl;
    }else {
	for (int i =0; i < samples.size(); i++){
		datafile << samples.at(i) << '\t' << timeMeasurements.at(i) << '\n';
	}
    }
	cout << " Fin Génération. " << endl;

}

void generatePrimeFactorisationDataFileGPU(){
	cout << " Génération des données pour la factorisation sur le GPU " << endl;
    vector<uint64_t> samples = generatePrimeFactorisationSamples();
    vector<float> timeMeasurements = generateGPUPrimeFactorisationMeasurement(samples);

    // Créer un fichier
    ofstream datafile;
    datafile.open("data/factorisationDatasGPU.dat",ios::out);
    if (datafile.bad()){
	cout << "Problème à l'ouverture du fichier" << endl;
    }else {
	for (int i =0; i < samples.size(); i++){
		datafile << samples.at(i) << '\t' << timeMeasurements.at(i) << '\n';
	}
    }
	cout << " Fin Génération. " << endl;
}

/** \brief  Je suis une fonction qui génère des nombres
 *          avec une longeur allant de 4 à 35 bits.
 *  @return vector<uint64_t> Les échantillons.
 */
vector<uint64_t> generatePrimalityTestsSamples() {
    vector<uint64_t> res(0);

    for (   uint64_t currentSample = 0b1000,
            i = 4;
            i < LOG2MAX_ISP;
            currentSample <<= 1,
            i++
    ) {
        res.push_back(currentSample);
    }

    return res;
}

/** \brief  Je suis une fonction qui crée les mesures de tests de temps pour
 *          l'algorithme de tests de primalitée pour un tableau d'échantillons donné.
 *
 *  @param  samples Les échantillons sur lesquels effectuer la mesure.
 *  @return vector<float> Les mesures de temps.
 */
 vector<float> generatePrimalityTestsMeasurement(vector<uint64_t> samples){
     vector<float> res(0);
     for (int i = 0; i < samples.size(); i++){
         ChronoCPU *currentChrono = new ChronoCPU();
         currentChrono->start();
         isPrimeCPU_v0(samples.at(i));
         currentChrono->stop();
         res.push_back(currentChrono->elapsedTime());
         delete currentChrono;
     }
     return res;
 }


/** \brief  Je suis une fonction qui crée les mesures de tests de temps pour
 *          l'algorithme de tests de primalitée pour un tableau d'échantillons donné.
 *
 *  @param  samples Les échantillons sur lesquels effectuer la mesure.
 *  @return vector<float> Les mesures de temps.
 */
 vector<float> generateGPUPrimalityTestsMeasurement(vector<uint64_t> samples){
     vector<float> res(0);
     for (int i = 0; i < samples.size(); i++){
	     //printf("%d round N = %ld\n", i, samples.at(i));
	 /* GPU Routine Alloc */
         uint64_t N = samples.at(i);
	 uint64_t sqrtN = sqrt(N) + 1;
	 uint64_t nombresDePossiblesPremiers = N-2;

	 uint64_t *possibles_premiers = (uint64_t *)malloc(sizeof(uint64_t) * nombresDePossiblesPremiers);
	 for (int i = 0, j = 2; j < N; possibles_premiers[i] =j,i++,j++);
	 unsigned int *res_operations = (unsigned int*)malloc(sizeof(unsigned int) * GRIDDIM(sqrtN));

	 uint64_t *dev_possibles_premiers;
	 cudaMalloc((void**)&dev_possibles_premiers, sizeof(uint64_t) * nombresDePossiblesPremiers);
	 unsigned int *dev_res_operations;
	 cudaMalloc((void**)&dev_res_operations, sizeof(unsigned int) * GRIDDIM(sqrtN));
	 
	cudaMemcpy(dev_possibles_premiers, possibles_premiers, sizeof(uint64_t) * (nombresDePossiblesPremiers), cudaMemcpyHostToDevice);
       	cudaMemcpy(dev_res_operations, res_operations, sizeof(unsigned int) * GRIDDIM(sqrtN), cudaMemcpyHostToDevice);
	 /* END GPU ROUTINE ALLOC*/
	 ChronoCPU *currentChrono = new ChronoCPU();
        // Start chrono
	 currentChrono->start();
	isPrime<<<GRIDDIM(sqrtN),BLOCKDIM,SIZEMEM>>>(dev_possibles_premiers, dev_res_operations, N, sqrtN); 
	currentChrono->stop(); 
	// end chrono
	
	/* GPU Routine Dealloc */
	 cudaMemcpy(res_operations, dev_res_operations, sizeof(unsigned int) * GRIDDIM(sqrtN), cudaMemcpyDeviceToHost);
	cudaFree(dev_possibles_premiers);
	cudaFree(dev_res_operations);
	free(possibles_premiers);
	free(res_operations);
	 /* GPU Routine Dealloc */
	res.push_back(currentChrono->elapsedTime()); //push time 
         delete currentChrono;
     }
     return res;
 }

/** \brief  Je suis une fonction qui aggrège les mesures de
*          nos tests de performances de la recherche de nombre premiers
*          pour une création de graphes ultérieure avec GnuPlot.
* @return boost::tuple<vector<float>,vector<int>> couple de (Tableau de Mesures de temps, Tableau de Logarithme en base 2 des échantillons).
*
boost::tuple<vector<float>,vector<uint64_t>>
createResearchOfPrimesDatas()
{
    vector<uint64_t> limits = generateResearchOfPrimesLimits();
    vector<float> timeMeasurements = generateResearchOfPrimesMeasurement(limits);

    for (uint64_t log2Samples = 2,
                 i = 0;
         i < LOG2MAX_ROP-4;
         log2Samples++,
                 i++){
        /// Après la mesure des échantillons, remplacer les
        /// échantillons dans le tableau d'échantillons par
        /// leur logarithme en base 2.
        limits.at(i) = log2Samples;
    }

    return boost::tuple<vector<float>, vector<uint64_t>>{timeMeasurements,limits};
}
*/

/** \brief  Je suis une fonction qui génère des puissances de 2.
 *  @return vector<uint64_t> Les échantillons.
 */
vector<uint64_t> generateResearchOfPrimesLimits() {
    vector<uint64_t> res(0);

    for (   uint64_t currentSample = 0b1000,
                    i = 4;
            i < LOG2MAX_ROP;
            currentSample <<= 1,
                    i++
            ) {
        res.push_back(currentSample);
    }

    return res;
}

/** \brief  Je suis une fonction qui crée les mesures de tests de temps pour
 *          l'algorithme de tests de primalitée pour un tableau d'échantillons donné.
 *
 *  @param  samples Les échantillons sur lesquels effectuer la mesure.
 *  @return vector<float> Les mesures de temps.
 */
vector<float> generateResearchOfPrimesMeasurement(vector<uint64_t> limits){
    vector<float> res(0);
    for (int i = 0; i < limits.size(); i++){
        ChronoCPU *currentChrono = new ChronoCPU();
        currentChrono->start();
        searchPrimesCPU_v0(limits.at(i));
        currentChrono->stop();
        res.push_back(currentChrono->elapsedTime());
        delete currentChrono;
    }
    return res;
}

/** \brief  Je suis une fonction qui crée les mesures de tests de temps pour
 *          l'algorithme de tests de primalitée pour un tableau d'échantillons donné.
 *
 *  @param  samples Les échantillons sur lesquels effectuer la mesure.
 *  @return vector<float> Les mesures de temps.
 */
vector<float> generateGPUResearchOfPrimesMeasurement(vector<uint64_t> limits){
    vector<float> res(0);
    for (int i = 0; i < limits.size(); i++){
	uint64_t borne_sup = limits.at(i);
	uint64_t *possibles_premiers = (uint64_t*)malloc(sizeof(uint64_t)*(borne_sup-2));
	for(int i = 0; i < (borne_sup-2); possibles_premiers[i] = i+2, i++);
	uint64_t *square_roots = (uint64_t*)malloc(sizeof(uint64_t)*(borne_sup-2));
	for(int i = 0; i < (borne_sup-2); square_roots[i] = sqrt(i+2), i++);
	uint64_t *premiers = (uint64_t*)malloc(sizeof(uint64_t)*(borne_sup-2));
	for(int i = 0; i < (borne_sup-2); premiers[i] = 0, i++);
       
	uint64_t *dev_possibles_premiers;
	uint64_t *dev_square_roots;
	uint64_t *dev_premiers;

	cudaMalloc((void**)&dev_possibles_premiers,sizeof(uint64_t)*(borne_sup-2));
	cudaMalloc((void**)&dev_square_roots,sizeof(uint64_t)*(borne_sup-2));
	cudaMalloc((void**)&dev_premiers,sizeof(uint64_t)*(borne_sup-2));
	
	cudaMemcpy(dev_possibles_premiers, possibles_premiers, sizeof(uint64_t)*(borne_sup-2), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_square_roots, square_roots, sizeof(uint64_t)*(borne_sup-2), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_premiers, premiers, sizeof(uint64_t)*(borne_sup-2), cudaMemcpyHostToDevice);
	
	ChronoCPU *currentChrono = new ChronoCPU();
        currentChrono->start();
	searchPrimeGPU<<<GRIDDIM(borne_sup-2),BLOCKDIM,SIZEMEM>>>(
			dev_possibles_premiers, 
			dev_square_roots, 
			borne_sup, 
			dev_premiers);
        currentChrono->stop();
        res.push_back(currentChrono->elapsedTime());
        delete currentChrono;
    	cudaFree(dev_possibles_premiers);
    	cudaFree(dev_square_roots);
    	cudaFree(dev_premiers);
    	free(possibles_premiers);
    	free(square_roots);
    	free(premiers);
    }
    return res;
}


/** \brief  Je suis une fonction qui aggrège les mesures de
*          nos tests de performances de la recherche de nombre premiers
*          pour une création de graphes ultérieure avec GnuPlot.
* @return boost::tuple<vector<float>,vector<int>> couple de (Tableau de Mesures de temps, Tableau de Logarithme en base 2 des échantillons).
*
boost::tuple<vector<float>,vector<uint64_t>>
createPrimeFactorisationDatas()
{
    vector<uint64_t> samples = generatePrimeFactorisationSamples();
    vector<float> timeMeasurements = generatePrimeFactorisationMeasurement(samples);

    return boost::tuple<vector<float>, vector<uint64_t>>{timeMeasurements,samples};
}
*/

/** \brief  Je suis une fonction qui génère des puissances de 2.
 *  @return vector<uint64_t> Les échantillons.
 */
vector<uint64_t> generatePrimeFactorisationSamples() {
    vector<uint64_t> res(0);
    int limit = 40000;
    double step = limit/25;

    for (
            int i = 10;
            i < limit;
            i+=step){
        res.push_back(i);
    }

    return res;
}

/** \brief  Je suis une fonction qui crée les mesures de tests de temps pour
 *          l'algorithme de tests de primalitée pour un tableau d'échantillons donné.
 *
 *  @param  samples Les échantillons sur lesquels effectuer la mesure.
 *  @return vector<float> Les mesures de temps.
 */
vector<float> generatePrimeFactorisationMeasurement(vector<uint64_t> samples){
    vector<float> res(0);
    for (int i = 0; i < samples.size(); i++){
        ChronoCPU *currentChrono = new ChronoCPU();
        vector<cell> factors(0);
        currentChrono->start();
        factoCPU(samples.at(i), &factors);
        currentChrono->stop();
        res.push_back(currentChrono->elapsedTime());
        delete currentChrono;
    }
    return res;
}

/** \brief  Je suis une fonction qui crée les mesures de tests de temps pour
 *          l'algorithme de tests de primalitée pour un tableau d'échantillons donné.
 *
 *  @param  samples Les échantillons sur lesquels effectuer la mesure.
 *  @return vector<float> Les mesures de temps.
 */
vector<float> generateGPUPrimeFactorisationMeasurement(vector<uint64_t> samples){
    vector<float> res(0);
    for (int i = 0; i < samples.size(); i++){
        uint64_t N=samples.at(i);
	ChronoCPU *currentChrono = new ChronoCPU();

	vector<uint64_t> premiers_packed = getPrimes(N);
	int taille = premiers_packed.size(); 
	uint64_t *primes = (uint64_t*)malloc(sizeof(uint64_t) * taille);
	for(int i = 0; i < taille; primes[i]=premiers_packed.at(i),i++);

	cell  *facteurs=(cell*)malloc(sizeof(cell)*taille);
	for(int i =0 ; i<taille; i++) {
			facteurs[i].base=primes[i];
			facteurs[i].expo=0;
	}

	uint64_t *dev_primes;
	cell *dev_facteurs;
	
	cudaMalloc((void**)&dev_primes,sizeof(uint64_t)*taille);
        cudaMalloc((void**)&dev_facteurs,sizeof(cell)*taille);
       
	cudaMemcpy(dev_primes,primes,sizeof(uint64_t)*taille,cudaMemcpyHostToDevice);
	cudaMemcpy(dev_facteurs,facteurs,sizeof(cell)*taille,cudaMemcpyHostToDevice);
	currentChrono->start();
        
	factGPU<<<GRIDDIM(taille),BLOCKDIM>>>(
			N,
			dev_primes,
			taille,
			dev_facteurs);
        currentChrono->stop();
        
	res.push_back(currentChrono->elapsedTime());
        delete currentChrono;
	cudaFree(dev_primes);
	cudaFree(dev_facteurs);
	free(primes);
	free(facteurs);	
    }
    return res;
}
