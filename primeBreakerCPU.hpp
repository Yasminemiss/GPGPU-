/*
* file with all function on CPU
*/
#ifndef __PRIMEBREAKERCPU_HPP
#define __PRIMEBREAKERCPU_HPP

#include "helper.hpp"
#include <bits/stdc++.h>
#include <cstdint> // uint64_t
#include <iostream> // cout, endl
#include <string> // split, strtoull
#include <ctgmath> // sqrt()
#include <vector>   // tableaux dynamiques <vector>

using namespace std;

/** \brief  Cette fonction va  tester la primalité d’un nombre de
            - L’algorithme consiste à vérifier pour un nombre N, si tous les nombres inférieurs ne le divisent pas.
*/
bool isPrimeCPU_v0(const uint64_t N);
/** \brief  Cette fonction va  tester la primalité d’un nombre de
            - L’algorithme consiste à vérifier pour un nombre N, si les nombres entre 2 et sqrt(N) sont diviseurs de N
*/
bool isPrimeCPU_v1(const uint64_t N,vector<uint64_t> v);

/** \brief
   Cette fonction permet de rechercher des nombres premiers inférieurs à N.
  - L’algorithme consiste à tester la primalité de tous les nombres inférieurs à N à l’aide de la fonction précédente.
	 Il faut savoir que l’on ne peut connaître la taille de la liste renvoyée à l’avance.
	 donc trouver une solution (structure de données dynamique, gestion de la mémoire manuelle, taille fixée, etc.).
*/
std::vector<uint64_t> searchPrimesCPU_v0(const uint64_t limite);

/** \brief
	Cette fonction va faire la décomposition en facteurs premiers
	 - Le principe de la décomposition consiste à parcourir les nombres p de la liste des nombres premiers
	trouvés avant en testant si ce nombre p divise N. Si oui, on recommence l’algorithme avec N = N/p.
	On s’arrête quand le nombre premier à tester devient supérieur à la racine carrée de N.
*/
void factoCPU(uint64_t N, vector<cell> *facteursPrimes);

void factoCPU_v1(uint64_t N, vector<cell> *facteursPrimes);

#endif
