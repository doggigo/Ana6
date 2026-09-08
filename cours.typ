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

= Pourquoi oune nouvelle théorie de l'intégration ?
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