#include "gnuplot_i.hpp" // GnuPlot
#include "benchmark.h"

void drawPlotForPrimalityTestAlgorithms(Gnuplot gnuplot);
void drawPlotForResearchOfPrimes(Gnuplot gnuplot);
void drawPlotForPrimesFactorisation(Gnuplot gnuplot);

/*using namespace boost;*/

/** \brief  Je suis une fonction qui vient enrouler les fonctions de créations de
 *          graphes de visualisation des performances des algorithmes.
 */
void generatePlots()
{
    Gnuplot gnuplot;

    drawPlotForPrimalityTestAlgorithms(gnuplot);
    //drawPlotForResearchOfPrimes(gnuplot);
    //drawPlotForPrimesFactorisation(gnuplot);
}

/** \brief  Je suis une fonction qui fait des mesures de temps pour analyser les performances
 *          des algorithmes de calcul de la primalité d'un nombre.
 *          (temps/s)
 *          ^
 *          |
 *          |
 *          |______________> (log2(N)) N e [[4;35]]
 *
 */
void drawPlotForPrimalityTestAlgorithms(Gnuplot gnuplot)
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

    gnuplot.reset_plot();
    cout << endl << endl << "*** Graphe pour le test de Primalité ***" << endl;
    gnuplot.set_grid();
    gnuplot.set_style("lines")
    .plot_xy(
            samples,
            timeMeasurements,
             "Mesure de temps (en ms) pour un nombre binaire de N bits"
             );
    gnuplot.savetofigure("PrimalityTestCPU.pdf");
}

/** \brief  Je suis une fonction qui fait des mesures de temps pour analyser les performances
 *          des algorithmes de recherches de nombres premiers.
 *          (temps/s)
 *          ^
 *          |
 *          |
 *          |________________> log2(N) [[4;18[ ~60 pour N = 17 sur Macbook Pro A1502
 */
void drawPlotForResearchOfPrimes(Gnuplot gnuplot)
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

    gnuplot.reset_plot();
    cout << endl << endl << "*** Graphe pour la recherche de nombres premiers ***" << endl;
    gnuplot.set_grid();
    gnuplot.set_style("lines")
            .plot_xy(
                    limits,
                    timeMeasurements,
                    "Mesure de temps (en ms) pour une borne superieure N."
            );
    wait_for_key();
}

/** \brief  Je suis une fonction qui fait des mesures de temps pour analyser les performances
 *          des algorithmes de factorisation en nombres premiers.
 *          (temps/s)
 *          ^
 *          |
 *          |
 *          |___________________> N Un nombre entier
 */
void drawPlotForPrimesFactorisation(Gnuplot gnuplot)
{
    vector<uint64_t> samples = generatePrimeFactorisationSamples();
    vector<float> timeMeasurements = generatePrimeFactorisationMeasurement(samples);

    gnuplot.reset_plot();
    cout << endl << endl << "*** Graphe pour la Factorisation en Nombres Premiers ***" << endl;
    gnuplot.set_grid();
    gnuplot.set_style("lines")
            .plot_xy(
                    samples,
                    timeMeasurements,
                    "Mesure de temps (en ms) pour un entier N."
            );
    wait_for_key();
}

void wait_for_key()
{
 cout << endl << "Appuyez sur une touche pour continuer." << endl;
 std::cin.clear();
 std::cin.ignore(std::cin.rdbuf()->in_avail());
 std::cin.get();
}
