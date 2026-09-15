#import "@local/utils:0.1.0": *
#import "@local/doc_fac:0.1.0" as theme_colors
#import "@local/doc_cours_nb:0.1.0" as theme_nb

#let theme_default = "colors"

#let theme_name = sys.inputs.at("theme", default: theme_default)


#let theme = if theme_name == "colors" { theme_colors } else { theme_nb }

#let theorem = theme.theorem
#let corollary = theme.corollary
#let lemma = theme.lemma
#let property = theme.property
#let proposition = theme.proposition
#let exercice = theme.exercice
#let example = theme.example
#let notation = theme.notation
#let remark = theme.remark
#let method = theme.method
#let definition = theme.definition
#let vocabulary = theme.vocabulary
#let proof = theme.proof

#let only-thms = sys.inputs.at("only-thms", default: "false") == "true"

#show: theme.doc_fac.with(
  title: "Cours Ana6",
  numbering: "I. 1. 1. a) i)",
  show-examples: not only-thms,
  show-exercises: not only-thms,
  show-proofs: not only-thms,
  page-numbering: "1",
)

#show: setup_maths.with()

#outline()

== Remarques

- Le cours n'est pas sur moodle
- Le TD est radicalement different du cours (pas de démos, ou quoique ce soit)
- Structure des CCs :
  - 1/3 de cours
  - 1/3 d'exo du TD
  - 1/3 d'un nouvel exo
- Les CCs :
  - Deux épreuves écrites de 1h30, chacune comptant pour 45%
  - 1 à 4 évaluations (QCM, oral, ...) comptant au total pour 10%

= Pourquoi une nouvelle théorie de l'intégration ?
On a des fonctions non-intégrables...

== Pourquoi intégrer ?

=== Qu'est-ce qu'intégrer ?
Pendant longtemps, l'intégration est essentiellement présentée comme l'opération inverse de la dérivation :

Si $F' = f$, alors : $ integral_a^b f(x)d x = F(b) - F(a) $

Mais cette formule nous dit-elle ce qu'est une intégrale ?

=== Pourquoi aller au-delà des primitives ?
La formule $integral_a^b f(x)d x = F(b)-F(a)$ est un outil extrêmement puissant.

Mais elle suppose que l'on dispose d'une primitive suffisamment explicite.

Par exemple, la fonction $ f : x |-> e^(-x^2) $ est continue sur $RR$, donc admet des primitives, mais aucune ne s'exprime á l'aide des fonctions élémentaires usuelles.

Portant des intégrales comme $ integral_0^t e^(-x^2)d x $ ont parfaitement un sens et interviennent naturellement dans de nombreuses questions.

=== L'intégrale comme objet d'analyse

L'integration ne sert pas seulement à calculer des aires ou des primitives.

Elle permet aussi de :
- mesurer la taille moyenne d'une fonction
- étudier des suites de fonctions et leurs passages á la limite
- définir des espaces de fonctions, comme les espaces $L^p$
- donner un sens á des objets fondamentaux en probabilités, en analyse de Fourier et en équations aux dérivées partielles.

Dans cette perspective, l'application $ f mapsto integral f $ est elle-même un objet mathématique que l'on souhaite étudier.

C'est l'une des portes d'entrée de l'analyse fonctionnelle.

#remark("Rappel")[
  Si $f : [a,b] --> RR$, le nombre $ integral_a^b f(x) d x $ s'il a un sens, s'interprête comme l'aire située sous le graphe de $f$.

  // TODO illustration 
]

L'intégration est donc d'abord un problème de mesure.

=== Comment mesurer cette aire ?

Considérons la fonction $ f : application([0,2],RR,x,1+(x-1)^2)$ et la subdivision non-régulière 
$ D = (0,1/2,6/5,3/2,2) $

// TODO approximation supérieure (à gauche)
// TODO approximation inférieure (à droite)

Sur chaque sous-intervalle, la hauteur du rectangle est exactement $inf f$ á gauche, $sup f$ à droite

#remark("Rappel")[
  Soit $D = (x_0,dots,x_n)$ une subdivision de $[a,b]$ et $f : [a,b] --> RR$ une fonction bornée.

  Les sommes de Darboux sont :
  $
    S^-_p (f) = sum_(i = 1)^n (x_k - x_(k-1)) inf_(x_k,x_(k-1)) f \
    S^+_p (f) = sum_(i = 1)^n (x_k - x_(k-1)) sup_(x_k,x_(k-1)) f
  $

  Les briques êlêmentaires de la construction sont donc les intervalles.

  Et leur mesure est connue :
  $
    m([u,v]) = v - u
  $
]

#remark("Rappel")[
  Soit $f : [a,b] --> RR$ une fonction bornée. On dêfinit les intégrales inferieures et superieure de Darboux de $f$ par :
  $
    I_*(f) = sup_(D) S^-_D(f) #h(2em) I^*(f) = inf_(D) S^+_D(f)
  $

  où le supremum et l'infimum sont pris sur toutes les subdivisions $D$ de $[a,b]$.

  La fonction $f$ est dite *Riemann-intégrable* lorsque $I_*(f) = I^*(f)$

  Dans ce cas, leur valeur commune est notee $integral_a^b f(x)d x$
]

=== Une fonction pourtant très simple...

Considérons la fonction $f = bb(1)_(Q inter [0,1])$

Autrement dit, $ f(x) = cases(1 & "si" x in QQ,0 &"si" x in.not QQ) $

Tout intervalle non-reduit à un point contient à la fois des rationnels et des irrationnels. Par conséquent, pour tout intervalle $I$ non-triviale :
$ inf_I f = 0 #h(2em) Sup_I f = 1 $

Donc $f$ n'est pas Riemann-intégrable, puisque $I_*(f) = 0$ et $I^*(f) = 1$. Pourtant $f$ ne prend que deux valeurs.

Et si l'on savait donner un sens à la "longueur" de $QQ inter [0,1]$, on serait naturellement tenté d'ecrire $integral_0^1 bb(1)_QQ d x = "longueur de "QQ inter [0,1]$

*Le problème vient-il vraiment de la fonction ?*

== Mesurer davantages d'ensembles

La construction de Riemann repose sur des ensembles particulièment simples : les intervalles.

Mais l'analyse fait naturellement apparaitre des ensembles beaucoup plus compliqués :
- les ensembles de Cantor
- $QQ inter [0,1]$
- ${x | f(x) > t}$
- et bien d'autres

Les ensembles ${x | f(x) > t}$ sont les ensembles de niveau supérieur de $f$. Ils décrivent la manière dont les valeurs de $f$ se répartissent et joueront un rôle naturel dans la notion de fonction mesurable.

Avant d'apprendre a intégrer davantage de fonctions, apprenons à mesurer davantage d'ensembles.

#exercice[

  On part de l'intervalle $C_0 = [0,1]$

  À l'étape $n >= 1$, on retire du milieu de chacun des $2^(n-1)$ intervalles constituant $C_(n-1)$, un intervalle ouvert de longueur $ alpha/3^n quad quad 0<alpha<=1 $

  et l'on note $C_n$ l'ensemble restant.

  On pose enfin $C_alpha =  inter_(n>=0)C_n$
  
  + Quelle est la longueur totale retirée après $n$ étapes ? Que devient la construction lorsque $alpha = 1$ ?
  + Quelle est la limite de cette longueur lorsque $n --> infinity$ ?
  + Quelle "longueur" doit-on naturellement attribuer à $C_a$ ?
  + Montrer que $C_alpha$ ne contient aucun intervalle non-réduit a un point.

]
// TODO changer template et mettre juste un #solution
#proof("/ Solution")[
  + À l'étape $n$, on retire $2^(n-1)$ intervalles, chacun de longueur $alpha/(3^n)$.
    
    La longueur retirée à l'étape $n$ vaut donc $ 2^(n-1) alpha/3^n $

    Après $N$ étapes, la longueur totale retirée est $L_N = sum_(n=1)^N alpha/3^n = alpha/3 sum_(n=0)^(N-1)(2/3)^n$.

    Pour $alpha = 1$, on retrouve la construction usuelle de l'ensemble de Cantor triadique.

  + On a donc $L_N -->_infinity alpha/3 (1/(1-2/3)) = alpha(1/(3-2)) = alpha = L_infinity$

  + La longueur que l'on est conduit à attribuer à l'ensemble restant est donc $ 1-alpha $

    Pour $0 < alpha < 1$, il reste donc un ensemble de longueur strictement positive.

  + À l'etape $n$, l'ensemble $C_n$ est la reunion de $2^n$ intervalles fermées deux-à-deux disjoints et de même longueur. Come la longueur totale restante vaut $ 1-L_n = 1-alpha + alpha(2/3)^n $
  Chacun de ce intervalles a pour longueur $ lll_n = (1-alpha + alpha (2/3)^n)/2^n $En particulier, $lll_n --> 0$

    Raisonnons par l'absurde et supposons qu'il existe un intervalle non-réduit à un point $ [a,b] subset C_alpha, quad a < b $
    Comme $ C_alpha subset C_n $ pour tout $n$, on a $[a,b] subset C_n$ pour tout $n$. Or $[a,b]$ est connexe.Il doit donc être contenu dans l'une des composantes intervalles $lll_n$ de $C_n$.

    Ainsi, pour tout $n$ : $ b-a <= lll_n $

    Par passage à la limite, on obtient $ b-a <= 0 $ ce qui est absurde.

]

=== La leçon de l'exercice

L'ensemble $C_alpha$ ne contient aucun intervalle non-réduit à un point. Pourtant, le calcul précédent suggère fortement qu'il devrait avoir une longueur.

Et cette longueur dépend du paramètre $alpha$, car $ "longueur"(C_alpha) = 1-alpha $

Il nous faut donc une theorie capable de mesurer des ensembles bienplus generaux que les intervalles.

C'est exactement le role des *tribus* et des *mesures*.

== Quels ensembles voulons-nous mesurer ?

Nous voulons disposer d'une  famille $AAAA$ de parties de $X$ auxquelles nous pouvos attribuer une mesure.

Cette famille doit être suffisamment riche pour les opérations que l'analyse fait naturellement apparaitre.

Par exemple, si $A$ est mesurable, on est naturel de vouloir mesurer ce qu'il reste : $ X without A $

Et si $A_1,A_2,...$ sont mesurables, nous voulons pouvoir mesurer : $ bigunion_(n >= 1) A_n $

Nous demandons donc une stabilité par complémentaire et par réunion dénombrable.

#definition[
  Soit $X$ un ensemble. One famille $AAA subset PPP(X)$ est appelé *tribu* sur $X$ si :
  + $X in AAA$
  + si $A in AAA$, alors $X without A in AAA$
  + Si $(A_n)_(n>=1)$ est une suite d'élements de $AAA$, alors $bigunion_(n>=1) A_n in AAA$
  
  Le couple $(X,AAA)$ est alors appelé *espace mesurable*.
]

#remark[
La théorie de la mesure ne sert pas seulement à integrer davantage de fonctions sur $RR$

Elle permet aussi de définir une intégrale lorsque la variable appartient à une espace beaucoup plus grand : $f : X --> RR$

L'ensemble $X$ peut être, par exemple,
+ $RR^d$ ou une partie de $RR^d$
+ Une surface, comme la sphère $SS^2$
+ Un ensemble discret, par exemple $NN$
+ un espace de fonctions, donc un espace de dimension infinie.

La mesure fournit le cadre dans lequel "integrer sur une partie de $X$" prend un sens.

]

#proposition[
  Soit $AAAA$ une tribu sur $X$. Alors :
  + $emptyset in AAAA$
  + Si $(A_n)_(n >= 1) subset A$, alors : $ biginter_(n>=1)A_n in AAAA $
  + Si $A,B in AAAA$, alors $ A without B in AAAA $
]

#proof[
  + $emptyset = X without X$
  + D'après de Morgan : $ biginter_(n >= 1) A_n = X without (bigunion_(n >= 1) X without A_n) = (bigunion_(n >= 1) (A_n)^F)^F $
  + $A without B = $
]

#example[
  Sur tout ensemble $X$ : ${emptyset, X}$ et $PPP(X)$ sont des tribus.

  Ce sont deux cas extrême : la première est la plus petite tribu possible, la seconde est la plus grande possible.
]

#exercice[
  Soit $X = {1,2,3,4}$

  + Déterminer la plus petite tribu contenant $A = {1,2}$
  + Déterminer la plus petite tribu contenant $A = {1,2}, B = {2,3}$
]

#proof[
  + $AAAA = {emptyset, {1,2}, {3,4}, X}$
  + $A inter B = {2}, A without B = {1}, B without A = {3}, X without (A union B) = {4}$, donc $AAAA = PPP(X)$
]

=== Engendrer une tibu

L'exercice précédent conduit a une question naturelle.

Étant donnee une famille quelcoque $CCCC subset PPPP(X)$, existe-t-il une plus petite tribu contenant $CCCC$ ?

#proposition[
  Soit $(AAAA_i)_(i in I)$ une famille de tribus sur $X$. Alors $ biginter_(i in I) AAAA_i $ est une tribu sur $X$.
]

#proof[
  Pour tout $i in I$, on a $X in AAAA$, donc $ X in biginter_(i in I) AAAA_i $

  Si $A$ appartient a tous les $AAAA_i$, alors $X without A$ appartient à tous les $AAAA_i$. Enfin si chaque $A_n$ appartient à tous les $AAAA_i$, alors $bigunion_(n >= 1) A_n$ appartient a tous les $AAAA_i$
]

#definition[
  Soit $CCCC in PPP(X)$. On appelle *tribu engendrée par $CCC$* la tribu $ sigma(CCCC) = biginter_(AAAA "tribu sur" X \ CCCC subset A) AAAA $
]
_Autrement dit, $sigma(CCCC)$ est la plus petite tribu contenant $CCCC$._

#remark[
  Cette definition est bien legitime, il existe toujours au moims une tribu contenant $CCCC$ à savoir $PPPP(X)$
]

=== Engendrer : une operation de fermeture

Nous avons déja rencontre plusieurs constructions du meme type :
$
Vect(E), quad E^F, quad sigma(CCCC)
$ 

Dans chaque cas, on cherche le plus petit objet d'une certaine nature contenant les données initiales.

On ajoute exactement ce que les propriétés de l'objet nous obligent à ajouter.

#exercice[
  Soit $X$ un ensemble et $A subset X$
  + Déterminer explicitement $ sigma({A}) $ engendree par le seul ensemble $A$.
  + A quelle condition cette tribu possède-t-elle exactement quatre éléments ?.
]

#proof[

  + Toute tribu contenant $A$ doit contenir son complémentaire $ A^' = X without A $ ainsi que $emptyset$ et $X$. On est nécessairement conduit à considérer $ AAAA = {emptyset, A, A^C, X} $Or cette famille est elle-même une tribu.

  + La famille $ {emptyset, A, A^C, X} $ possède quatre element distincts ssi $A != emptyset$, $A != X$. En effet, si $A = emptyset$ ou $A = X$, alors $ sigma({A}) = {emptyset,X} $
    
    Ainsi $ Card(sigma({A})) = cases(2 &"si" A = emptyset "ou" A = X,4 &"sinon") $

]

== Les boréliens de $RR$

La topologie de $RR$ nous fournit une famille naturelle d'ensembles : les ouverts.

#definition[
  La *tribu borélienne* de $RR$ notée $BBBB(RR)$

  est la tribu engendrée par les ouverts de $RR$ : $ BBBB(RR) = sigma({O subset RR | O "ouvert"}) $

  Les éléments de $BBBB(RR)$ sont appelés des *boréliens* de $RR$.
]

#proposition[
  La tribu borélienne de $RR$ est également engendrée par les intervalles ouverts : $BBBB(RR) = sigma({(a,b) | a < b})$
]

#proof[

  Tous les intervalles ouverts sont dans $BBBB(RR)$, donc on a l'inclusion dans un sens.

  Réciproquement, soit $O$ un ouvert de $RR$. Considérons $ SSSS_O = {(p,q) | p,q in QQ, (p,q) subset O} $
  Comme $QQ^2$ est dénombrable, $SSSS_O$ est denombrable.

  Montrons que $O = bigunion_(I in SSSS_O) I$

  l'inclusion de droite à gauche est immediate.

  Réciproquememt : soit $x in O$. Comme $O$ est ouvert, il existe $epsilon > 0$ tel que $ (x-epsilon, x+epsilon) subset O $

  Par densité de $QQ$ dans $RR$, on peut choisir $p,q in QQ$ tels que : $ x-epsilon < p < x < q < x + epsilon $

  Ainsi $x in (p,q) subset O$

  Donc tout ouvert est réunion dénombrable d'intervalles ouverts à extrémités rationnelles, et appartient donc à la tribu engendrée par les intervalles ouverts.
]


== Nous savons quels ensembles mesurer...

Au chapitre précédent, nous avons choisi une famille $AAAA$ de parties de $X$ stable sous les operations ensemblistes dont bous vons besoin. Il reste maintenant à attribuer à chaque ensemble mesurable $A in AAAA$ une "taille" : $ mu(A) in [0,infinity] $

*Quelles propriétés doit satisfaire une telle notion de taille ?*

=== Que doit faire une mesure ?

Quelques exigences paraissent naturelles. L'ensemble vide doit avoir unetaille nulle : $mu(emptyset) = 0$

Si deux ensembles mesurables $A$ et $B$ sont disjoints, on souhaite $ mu(A union B) = mu(A) + mu(B) $

Mais l'analyse fait intervenir des suites d'ensembles. Il faut donc demander davatage : pour les ensembles mesurables deux-à-deux disjoints $(A_n)_(n in I)$, $ mu(bigunion_(n in I) A_n) = sum_(n in I) mu(A_n) $

#definition[
  Soit $(X,AAAA)$ une mesure sur $(X,AAAA)$ est une application $ mu : AAAA --> [0,infinity] $ telle que :
  + $mu(emptyset) = 0$
  + Pour toute suite $(A_n)_(n>=1)$ d'éléments de $AAAA$ deux-à-deux disjoints $ mu(bigunion_(n in I)A_n) = sum_(n in I)mu(A_n) $
  
  Le triplet $(X,AAAA,mu)$ est appele *espace mesuré*.
]

=== Trois premiers exemples

+ Sur un ensemble quelconque $X$, la *mesure de comptage* est définie par $mu(A) --> Card(A)$ avec $mu(A) = infinity$ lorsque $A$ est infini.
+ Si $x_0 in X$, la *mesure de Dirac* en $x_0$ est :
  $ delta_(x_0)(A) = cases(1 quad &x_0 in A, 0 &x_0 in.not A) $
+ Sur $RR$, nous cherchons une mesure qui attribue à un intervalle sa longueur :
  $ mu([a,b]) = b - a $

#exercice[
  Soit $X$ un ensemble muni de la tribu $PPP(X)$.
  + Vérifier que la mesure de comptage est bien une mesure sur $X$.
  + Vérifier que pour tout $x_0 in X$, $delta_(x_0)$ est une mesure.
  + Que vaut $delta_(x_0)(A) + delta_(x_1)(A)$ lorsque $x_0,x_1 in X$ ? Interpréter cette expression.
]

#proof[
  + Soit $(A_n)_(n>=1) A_n$ une suite de parties de $X$ deux-à-deux disjointes. Si l'un des ensembles $A_n$ est infini, alors $mu(bigunion_(n>=1)A_n) = infinity = sum_(n>=1)mu(A_n)$

    Supposons maintenant tous les $A_n$ finis.

    Si une infinité d'entre eux sont non-vides, alors $ sum_(n >= 1) mu(A_n) = infinity $

    Et leur réunion est infinie.

    Enfin, si seulement un nombre fini d'entre eux sont non-vides, l'additivite finie du cardinal donne $ mu(bigunion_(n>=1)A_n) = sum_(n>=1)mu(A_n) $
]