------------------------------------------------------------------------

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><img src="Polytechnique_signature-RGB-gauche_FR.png" alt="Logo de Polytechnique Montréal" /><a href="http://www.polymtl.ca/"><br />
</a></td>
<td><h1 id="inf3500---conception-et-réalisation-de-systèmes-numériques">INF3500 - Conception et réalisation<br />
de systèmes numériques</h1>
<h1 id="automne-2020">Automne 2020</h1></td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

Laboratoire \#1
===============

Flot de conception de systèmes numériques : le module du vote
=============================================================

Objectifs
---------

À la fin de ce laboratoire, vous devrez être capable d'appliquer le flot de conception d'un système numérique à l'aide d'outils de conception :

* modéliser un module combinatoire en VHDL;

* vérifier le module par simulation à l'aide d'un banc d'essai;

* synthétiser et implémenter le module

* générer le fichier de configuration pour le FPGA, programmer le FPGA et vérifier le fonctionnement du module sur une carte de développement.

Partie 1 : Préparation au laboratoire
-------------------------------------

Avant le début de la période de laboratoire, suivre les étapes suivantes:

1. Obtenir [une carte Digilent Basys 3](https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/). Il y a plusieurs fournisseurs, mais le meilleur choix est probablement directement du manufacturier Digilent.

2. Obtenir un câble USB pour relier votre ordinateur à la carte. Le connecteur de la carte [est de type USB 2.0 Micro-B](https://en.wikipedia.org/wiki/USB_hardware). Vérifiez de quel type de connecteur USB votre ordinateur a besoin. Les plus fréquents sont USB A (Type-A) et [USB-C](https://en.wikipedia.org/wiki/USB-C).

3. Installer les outils suivants sur votre ordinateur - <span style="font-style: italic;">attention, il faut prévoir au moins deux heures pour le téléchargement et l'installation</span> :

    1. [Active-HDL, en version étudiante](https://www.aldec.com/en/products/fpga_simulation/active_hdl_student), de la [compagnie Aldec](https://www.aldec.com/).
    \[Note : Vous pouvez utiliser tout éditeur de texte de votre choix pour entrer votre code VHDL, et l'outil de votre choix pour en faire la simulation.
    Cependant, dans le cadre du laboratoire, seul Active-HDL sera officiellement supporté.\]
    2. [Xilinx Vivado WebPack](https://www.xilinx.com/products/design-tools/vivado/vivado-webpack.html), de la [compagnie Xilinx](https://www.xilinx.com/).

4. Préparer la matière du cours de la semaine 1 : Introduction, et en particulier :

    1. les diapositives de la série 0103FlotDeConception; et,
    2. les diapositives de la série 0104IntroVHDL.

5. Choisir un/e co-équipier/ère. Vous pouvez utiliser le forum du cours. Il peut être possible de travailler seul(e), pour cela il faut en discuter avec le chargé de laboratoire qui décidera en fonction du nombre de demandes. Il n'y aura pas d'équipe de trois personnes.

Partie 2 : Mise en oeuvre de la carte Basys 3
---------------------------------------------

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>La <a href="https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/">carte Basys 3</a> comporte tous les éléments nécessaires pour se familiariser avec la technologie des FPGA. Elle contient des interfaces simples qui permettent à l'utilisateur d'interagir avec le programme du FPGA.</p>
<p>Procédure à suivre.</p>
Vérifiez que le cavalier (<span style="font-style: italic;">jumper</span>) de sélection de l'alimentation (item 16 dans la figure) est bien en mode USB, c'est à dire la position du bas.
Reliez le port USB de la carte Basys 3 (item 13 dans la figure) à votre ordinateur à l'aide d'un câble USB. Le port USB de la carte sert à trois fonctions simultanées :
<ol>
<li>l'alimentation de la carte en énergie;</li>
<li>la programmation du FPGA par son port JTAG; et,</li>
<li>la connexion à l'ordinateur via un port série (Windows : COM port) sur les pattes A18 et B18 du FPGA.</li>
</ol>
Activez le commutateur d'alimentation (item 15 dans la figure) et confirmez que la DEL d'alimentation (item 1 dans la figure) est bien allumée.
Si un programme était déjà présent dans la mémoire Flash de la carte, il se chargera dans le FPGA et commencera à s'exécuter.
<ol>
<li>Pour cela, il faut que le cavalier de configuration du FPGA (item 10 dans la figure) soit placé dans la position &quot;SPI Flash&quot;, c'est à dire sur les deux pattes du haut.</li>
<li>En tout temps on peut forcer le chargement du programme présent dans la mémoire Flash en appuyant sur le bouton &quot;PROG&quot; (item 9 dans la figure).</li>
<li>En supposant que le programme initial du manufacturier soit chargé, vous devriez voir un compte 0-9 sur les affichages à sept segments (item 4 dans la figure) et vous devriez pouvoir allumer et éteindre les DEL (item 6 dans la figure) à l'aide des commutateurs (item 5 dans la figure). Les boutons (item 7 dans la figure) ont aussi des effets sur les affichages à sept segments.</li>
</ol>
<p>Consultez le <a href="https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual">manuel de l'utilisateur disponible en ligne</a> pour tous les détails sur la carte Basys 3.</p></td>
<td><p><img src="basys3_hardware_walkaround.png" alt="Vue d&#39;ensemble de la planchette Basys 3" class="center" /></p>
<br />
Vue d'ensemble de la carte Basys 3 [<a href="https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual">Source : Digilent</a>]</td>
</tr>
</tbody>
</table>

Partie 3 : Appliquer le flot de conception à du code existant
-------------------------------------------------------------

### a. Vue d'ensemble du flot

Le flot de conception de systèmes numériques est montré à la figure suivante. Consultez les diapositives du cours, série 0103, pour une description détaillée.

![Flot de conception de systèmes numériques](flot.png)

Flot de conception de systèmes numériques

### b. Création d'un espace de travail et d'un projet dans Active-HDL

Lancez Active-HDL, créez un espace de travail (<span style="font-style: italic;">workspace</span>) et créez un projet (<span style="font-style: italic;">design</span>).

\[Recommandation : sur votre machine, créez un répertoire "inf3500\\labo1" dans lequel vous mettrez tous les fichiers de ce laboratoire.\]

Téléchargez les fichiers [vote\_labo1\_erreurs.vhd](vote_labo1_erreurs.vhd) et [vote\_labo1\_tb.vhd](vote_labo1_tb.vhd) dans votre répertoire de travail puis ajoutez-les à votre projet.

Pour de l'aide concernant l'utilisation de Active-HDL, vous pouvez suivre [le tutoriel proposé par Aldec](https://www.aldec.com/en/support/resources/documentation/articles/1054) ou tout autre que vous trouverez en ligne en cherchant par exemple "<span style="font-style: italic;">active-hdl student edition user guide</span>" ou "<span style="font-style: italic;">active-hdl tutorial</span>".

### c. Correction des erreurs de syntaxe

Le fichier [vote\_labo1\_erreurs.vhd](vote_labo1_erreurs.vhd) comporte cinq erreurs de syntaxe. Pour vous aider à les trouver, dans Active-HDL faites `Design > Compile` ou pressez la touche F11. Notez et corrigez les cinq erreurs une à la fois.

On peut aussi effectuer la compilation directement dans la console de Active-HDL avec la commande :

    acom -2018 votre-chemin\inf3500\labo1\vote_labo1_erreurs.vhd

\[Recommandation : Consultez les diapositives du cours, série 0104, pour une brève introduction au langage VHDL.\]

### d. Vérification par simulation et correction des erreurs fonctionnelles

Dans Active-HDL, définissez la paire entité/architecture vote\_labo1\_tb(arch) comme unité principale (<span style="font-style: italic;">Top-level</span>) :

-   par `Design > Settings > General > Top-level`; ou 
-   en cliquant le bouton de droite de la souris sur vote\_labo1\_tb(arch) dans la fenêtre des fichiers.

Lancez la simulation :

-   en cliquant sur le symbole de lecture (triangle vert) dans la barre d'outils;
-   en pesant les touches alt-F5; ou,
-   en tapant "run" dans la console.

On peut aussi effectuer ces opérations directement dans la console avec les commandes suivantes :

    asim vote_labo1_tb
    run

Dans la console, on peut relancer la simulation avec la commande `restart` et arrêter la simulation avec la commande `endsim`. On peut cacher ou activer la console, ou y amener le focus, en tapant alt-0 (alt-zéro).

\[Note : vous pouvez aussi utiliser un autre simulateur de votre choix, comme Vivado ou bien [GHDL, le simulateur libre de VHDL](http://ghdl.free.fr/), mais ces outils ne sont pas supportés dans le cours.\]

En consultants les spécifications données dans les commentaires et les résultats de la simulation, corrigez les erreurs fonctionnelles dans le fichier [vote\_labo1\_erreurs.vhd](vote_labo1_erreurs.vhd). Sauvegardez la version corrigée sous le nom vote\_labo1.vhd.

### e. Synthèse

La synthèse s'effectue avec le logiciel Vivado de Xilinx. On peut utiliser l'interface graphique ou la ligne de commande. La ligne de commande est beaucoup plus fiable, plus robuste et plus rapide et c'est elle qui est décrite ici.

Ajoutez le fichier [labo-1-Basys-3.xdc](labo-1-Basys-3.xdc) dans votre répertoire "inf3500\\labo1". Ce fichier contient les contraintes de synthèse et d'implémentation pour votre projet. Il spécifie l'assignation des pattes du FPGA aux ports du module `vote_labo1` décrit en VHDL.

Sous votre répertoire "inf350\\labo1", créez un répertoire "synthese-implementation". Lancez une fenêtre d'invite de commande ("cmd" sous Windows) et [naviguez au répertoire](https://www.digitalcitizen.life/command-prompt-how-use-basic-commands) "inf350\\labo1\\synthese-implementation".

De ce répertoire, lancez Vivado en mode script avec la commande `[repertoire-d-installation-de-Vivado]\bin\vivado -mode tcl,` où `[repertoire-d-installation-de-Vivado]`est probablement `C:\Xilinx\Vivado\2020.1` si votre système d'exploitation est Windows.

Dans la fenêtre, à l'invite de commande `Vivado%`, entrez les commandes suivantes \[Remarque : attention, alors que [Windows spécifie des chemins avec le '\\',](https://www.howtogeek.com/181774/why-windows-uses-backslashes-and-everything-else-uses-forward-slashes/) dans l'invite de commande de Vivado il faut utiliser plutôt '/'\] :

    read_vhdl ../vote_labo1.vhd
    read_xdc ../labo-1-Basys-3.xdc
    synth_design -top vote_labo1 -generic W=4 -part xc7a35tcpg236-1 -assert

On remarque que :

-   `vote_labo1.vhd` est un fichier de code VHDL décrivant le module à synthétiser;
-   `labo-1-Basys-3.xdc` est un fichier de texte contenant les contraintes d'implémentation;
-   `-generic W=4` spécifie la valeur à donner au `generic W` du module `vote_labo1` trouvé dans le fichier `vote_labo1.vhd`; et,
-   `-part xc7a35tcpg236-1` est le modèle spécifique du FPGA présent sur la carte et cible de la synthèse.

Toutes ces valeurs peuvent être modifiées selon les besoins.

Inspectez la fenêtre d'invite de commandes et les fichiers du répertoire "synthese-implementation". S'il y a des erreurs, corrigez-les si nécessaire et recommencez. En particulier, vous trouverez un fichier `vivado.log` qui retrace toutes les activités et un fichier `vivado.jou` qui journalise vos commandes. Les produits de la synthèse sont dans un répertoire `.Xil`.

### f. Implémentation

L'implémentation est divisée en deux parties : le <span style="font-style: italic;">placement</span> des fonctions logiques à des ressources spécifiques du FPGA, et le <span style="font-style: italic;">routage</span> des interconnexions entre ces ressources.

Entrez les commandes suivantes :

    place_design
    route_design

Inspectez la fenêtre d'invite de commandes et les fichiers du répertoire "synthese-implementation". S'il y a des erreurs, corrigez-les si nécessaire et recommencez.

### g. Génération du fichier de configuration

Entrez la commande suivante :

    write_bitstream -force fichier-de-programmation.bit

Inspectez la fenêtre d'invite de commandes et les fichiers du répertoire "synthese-implementation". S'il y a des erreurs, corrigez-les si nécessaire et recommencez.

### h. Programmation de la puce

La carte doit être reliée à votre ordinateur et allumée, conformément à la partie 2.

Entrez les commandes suivantes :

    open_hw_manager
    connect_hw_server
    get_hw_targets
    open_hw_target
    current_hw_device [get_hw_devices xc7a35t_0]
    set_property PROGRAM.FILE {fichier-de-programmation.bit} [get_hw_devices xc7a35t_0]
    program_hw_devices [get_hw_devices xc7a35t_0]

Les commandes données ici établissent entre autres la communication avec le FPGA sur la carte. Il arrive que la synchronisation ne se fasse pas correctement du premier coup. Si c'est le cas, relancez-les commandes une à une jusqu'à ce que ça fonctionne et que le FPGA soit programmé.

### i. Vérification de la puce

Vous pouvez maintenant vérifier le comportement correct du module en activant les quatre commutateurs de droite et en observant la DEL de droite.

Si le comportement n'est pas conforme aux spécifications ... il faut alors retourner au code VHDL pour le corriger, puis recommencer.

### j. Toutes les commandes en un seul script

On peut effectuer toutes les opérations de la synthèse à la programmation du FPGA à l'aide du fichier de commande [labo-1-synth-impl.tcl](labo-1-synth-impl.tcl).

À partir de votre répertoire labo1\\synthese-implementation, exécutez la commande suivante dans une fenêtre de ligne de commande :

    C:\Xilinx\Vivado\2020.1\bin\vivado -mode tcl -source ..\labo-1-synth-impl.tcl

(en supposant que Vivado soit installé dans le répertoire C:\\Xilinx\\Vivado\\2020.1\\).

Ce fichier suppose que tous les noms de fichiers, leur localisation et le répertoire d'exécution du script sont conformes aux explications données ici.

En général, il n'est pas nécessaire de refaire toutes les étapes précédentes quand une étape ne fonctionne pas. On peut en général ne refaire que l'étape qui a flanché.

------------------------------------------------------------------------

Partie 4: amélioration du module pour cinq entrées
--------------------------------------------------

Modifiez le module labo1\_vote pour qu'il fonctionne avec une valeur de W = 5. Répétez toutes les étapes du flot de conception. Nommez votre fichier "labo\_1\_vote\_ameliore.vhd".

Utilisez le banc d'essai [vote\_labo1\_tb.vhd](vote_labo1_tb.vhd) pour vérifier le fonctionnement correct de votre module.

Modifiez le fichier [labo-1-Basys-3.xdc](labo-1-Basys-3.xdc) pour accommoder une entrée de plus. Utilisez le commutateur \#4 comme 5e entrée.

Faites la synthèse, l'implémentation, la génération du fichier de configuration, la programmation de la puce et la vérification de la puce.

------------------------------------------------------------------------

Partie 5: au-delà du A - amélioration du module pour un grand nombre d'entrées
------------------------------------------------------------------------------

\[***Mise en garde. Compléter correctement les parties 3 et 4 peut donner une note de 17 / 20 (85%), ce qui peut normalement être interprété comme un A. La partie 5 demande du travail supplémentaire qui sort normalement des attentes du cours. Il n'est pas nécessaire de la compléter pour réussir le cours ni pour obtenir une bonne note. Il n'est pas recommandé de s'y attaquer si vous éprouvez des difficultés dans un autre cours. La partie 5 propose  défi pour les personnes qui souhaitent s'investir davantage dans le cours INF3500 en toute connaissance de cause.***\]

a. Proposez \*\**deux*\*\* manières de décrire le module en VHDL afin qu'il accommode un grand nombre d'entrées. Expliquez complètement vos deux suggestions à l'aide d'exemples.

b. Remettez le code de votre module qui fonctionne avec W = 16, ainsi que le fichier de configuration correspondant qui peut être programmé sur la carte utilisant les 16 commutateurs.

c. Remettez le code de votre module qui fonctionne avec toute valeur de W entre 3 et 63 inclusivement.

------------------------------------------------------------------------
Remise
------------------------------------------------------------------------
La remise se fait directement sur votre repo git, donc assurez vous de push toute vos modification.
Voici les fichiers qui sont attendu, placé les à la racine du repo.

### partie 3c et d:
- vote_labo1.vhd: ou vous avez corrigé les erreurs

### partie 4 
- vote_labo1_ameliore.vhd 
- fichier-de-programmation.bit: qui fonctionne pour W=5

### partie 5
- partie5.md : pour décrire vos deux solutions (Partie 5 a.)
- vote_labo1_partie5.vhd 
- fichier-de-programmation-partie5.bit: qui fonctionne pour W=16 


### (optionel) CARTE.md: si vous utilisez la carte nexys mettez l'info dans ce fichier, il me faut aussi votre .xdc

------------------------------------------------------------------------

Barème de correction
--------------------

Le barème de correction est progressif. Il est relativement facile d'obtenir une note de passage (&gt;10) au laboratoire et il faut mettre du travail pour obtenir l'équivalent d'un A (17/20). Obtenir une note plus élevée (jusqu'à 20/20) nécessite plus de travail que ce qui est normalement demandé dans le cadre du cours.
<span class="examen"></span>

<table>
<thead>
<tr class="header">
<th>critère<br />
</th>
<th>points<br />
</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Partie 3 c. : fichier vote_labo1.vhd corrigé et commenté montrant chacune des erreurs de syntaxe</td>
<td>8</td>
</tr>
<tr class="even">
<td>Partie 3 d. : fichier vote_labo1.vhd corrigé et commenté montrant chacune des erreurs de fonctionnalité</td>
<td>4</td>
</tr>
<tr class="odd">
<td>Partie 4 :  fichier vote_labo1_ameliore.vhd et le fichier de configuration correspondant fichier-de-programmation.bit qui fonctionnent pour W = 5</td>
<td>3</td>
</tr>
<tr class="even">
<td>Élégance et lisibilité du code : alignement, choix des identificateurs, qualité et pertinence des commentaires, respect des consignes de remise incluant les noms des fichiers, etc.</td>
<td>2</td>
</tr>
<tr class="odd">
<td>Partie 5 a., b. et c.: au-delà du A</td>
<td>3</td>
</tr>
<tr class="even">
<td>Maximum possible sur 20 points<br />
</td>
<td>20<br />
</td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

Références pour creuser plus loin
---------------------------------

Les liens suivants ont été vérifiés en juillet 2020.

Aldec Active-HDL User Guide : accessible en faisant F1 dans l'application, et accessible [à partir du site de la compagnie](https://www.aldec.com/en/support/resources/documentation/manuals/).

Tous les manuels de Xilinx :  <https://www.xilinx.com/products/design-tools/vivado.html#documentation>

Vivado Design Suite Tcl Command Reference Guide : <https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug835-vivado-tcl-commands.pdf>

Vivado Design Suite User Guide - Design Flows Overview : <https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug892-vivado-design-flows-overview.pdf>

Vivado Design Suite User Guide - Synthesis : <https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug901-vivado-synthesis.pdf>

Vivado Design Suite User Guide - Implementation : <https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug904-vivado-implementation.pdf>

[](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug892-vivado-design-flows-overview.pdf)


