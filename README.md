# Modélisation Dynamique du Marché de l'Emploi

Ce projet MATLAB implémente une analyse d'un modèle dynamique non-linéaire du marché de l'emploi. Il simule les interactions entre le chômage, l'emploi, les postes vacants et l'auto-entrepreneuriat.

Le code permet de déterminer les points d'équilibre, d'analyser la stabilité et la sensibilité du système, et de comparer la dynamique continue avec une approximation discrétisée linéarisée.

## 📂 Architecture du Projet

Le projet est structuré de manière modulaire :

### 🚀 Script Principal
* **`resultats.m`** : C'est le point d'entrée unique. Il orchestre l'ensemble de l'étude :
    1.  Initialisation des paramètres.
    2.  Calcul et comparaison des équilibres (Analytique vs Numérique).
    3.  Lancement de l'analyse de sensibilité.
    4.  Discrétisation et analyse de stabilité.
    5.  Simulation temporelle et affichage des courbes (Continu vs Discret).

### ⚙️ Configuration
* **`def_model_and_params.m`** : Définit la structure des paramètres physiques (`p`) et le handle de la fonction ODE (`sys_ode`) représentant les équations différentielles du modèle.

### 🧮 Modules de Calcul de l'Équilibre
* **`eq_analytique.m`** : Résout le système de manière exacte en réduisant le problème à un polynôme de degré 3 en $U$ (Chômeurs).
* **`eq_numerique.m`** : Utilise un solveur itératif (`fsolve`) pour trouver le point d'équilibre ($f(x) = 0$) à partir d'une estimation initiale.

### 📈 Modules d'Analyse
* **`analyse_sensibilite.m`** : Calcule les indices de sensibilité (élasticité) en perturbant chaque paramètre de +10% et en observant l'impact sur le taux de chômage à l'équilibre.
* **`discretisation.m`** : Effectue la linéarisation du système autour du point d'équilibre ($x^*$) pour obtenir la matrice Jacobienne continue ($A$) et les matrices du système discret ($F_d, G_d$).
* **`analyse_stabilite.m`** : Calcule et affiche les valeurs propres des systèmes continu et discret pour statuer sur la stabilité asymptotique.

---

## 💻 Instructions d'Exécution

### Prérequis
* MATLAB (R2018b ou ultérieur recommandé).
* Optimization Toolbox (pour `fsolve`).

### Lancer la simulation
1.  Assurez-vous que tous les fichiers `.m` sont dans le même dossier ou dans le path MATLAB.
2.  Ouvrez le fichier **`resultats.m`**.
3.  Exécutez le script (F5 ou bouton **Run**).

**Sorties attendues :**
* **Command Window** : Affichage textuel des points d'équilibre, du polynôme résolu, des indices de sensibilité et des valeurs propres (stabilité).
* **Figure 1** : Graphiques superposés montrant la convergence temporelle des populations et la validation du modèle discret par rapport au modèle continu.

---

## 🔧 Paramétrage et Modification

### 1. Modifier les constantes physiques
Pour changer les paramètres du modèle par exemple pour l'adapter à un certain environnement :
* Ouvrez **`def_model_and_params.m`**.
* Modifiez les valeurs dans la structure `p`.
    * *Exemple :* `p.Lambda = 25;` (Flux d'entrée de nouveaux chômeurs).

### 2. Modifier les conditions initiales de simulation
Pour observer la convergence à partir d'un autre point de départ :
* Ouvrez **`resultats.m`**.
* Cherchez la variable `x_init` 
    * Ordre du vecteur : `[U (Chômeurs), E (Employés), V (Vacants), S (Auto-Ent)]`.

### 3. Ajuster le solveur numérique
Si l'algorithme numérique ne converge pas (pour de nouveaux paramètres extrêmes) :
* Ouvrez **`eq_numerique.m`**.
* Modifiez le point de départ `x0` pour le rapprocher de l'équilibre attendu.

---

