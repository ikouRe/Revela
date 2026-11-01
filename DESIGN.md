---
name: Revela
description: "Sans te mentir."
colors:
  accent: "#b92b52"
  accent-fort: "#961f41"
  degrade-debut: "#ffb296"
  degrade-milieu: "#d64a72"
  peche: "#ffc4ab"
  rose: "#f8b3c8"
  lilas: "#dcd0f4"
  perle: "#fbf1f0"
  blanc: "#fffbfa"
  blanc-pur: "#ffffff"
  creux: "#fbeeee"
  trait: "#f2e3e4"
  poignee: "#e2cfd6"
  desactive: "#d9c6cf"
  encre: "#3a1a2b"
  encre-2: "#6b4557"
  nuit: "#26101d"
  nuit-lueur: "#6d3a52"
  nuit-texte: "#f2dfe6"
  bon: "#1c6e53"
  bon-fond: "#dff2e9"
  prudence: "#8c4c00"
  prudence-fond: "#fdecd2"
  prudence-texte: "#5c3200"
  mauvais: "#a8261f"
  mauvais-fond: "#fce1de"
  inconnu: "#5e4d57"
  inconnu-fond: "#eee6ea"
typography:
  note:
    fontFamily: "Zen Maru Gothic, Hiragino Maru Gothic ProN, Arial Rounded MT Bold, system-ui, sans-serif"
    fontSize: "40px"
    fontWeight: 900
    lineHeight: 1
    letterSpacing: "-0.02em"
    fontFeature: "tnum"
  chiffre:
    fontFamily: "Zen Maru Gothic, Hiragino Maru Gothic ProN, Arial Rounded MT Bold, system-ui, sans-serif"
    fontSize: "25px"
    fontWeight: 900
    lineHeight: 1.1
    fontFeature: "tnum"
  note-mini:
    fontFamily: "Zen Maru Gothic, Hiragino Maru Gothic ProN, Arial Rounded MT Bold, system-ui, sans-serif"
    fontSize: "18px"
    fontWeight: 900
    lineHeight: 1
    fontFeature: "tnum"
  display:
    fontFamily: "Zen Maru Gothic, Hiragino Maru Gothic ProN, Arial Rounded MT Bold, system-ui, sans-serif"
    fontSize: "42px"
    fontWeight: 700
    lineHeight: 1.05
    letterSpacing: "-0.02em"
  headline:
    fontFamily: "Zen Maru Gothic, Hiragino Maru Gothic ProN, Arial Rounded MT Bold, system-ui, sans-serif"
    fontSize: "38px"
    fontWeight: 700
    lineHeight: 1.05
    letterSpacing: "-0.02em"
  headline-scan:
    fontFamily: "Zen Maru Gothic, Hiragino Maru Gothic ProN, Arial Rounded MT Bold, system-ui, sans-serif"
    fontSize: "34px"
    fontWeight: 700
    lineHeight: 1.1
  headline-produit:
    fontFamily: "Zen Maru Gothic, Hiragino Maru Gothic ProN, Arial Rounded MT Bold, system-ui, sans-serif"
    fontSize: "30px"
    fontWeight: 700
    lineHeight: 1.1
    letterSpacing: "-0.01em"
  title:
    fontFamily: "Zen Maru Gothic, Hiragino Maru Gothic ProN, Arial Rounded MT Bold, system-ui, sans-serif"
    fontSize: "21px"
    fontWeight: 700
    lineHeight: 1.2
  title-barre:
    fontFamily: "Zen Maru Gothic, Hiragino Maru Gothic ProN, Arial Rounded MT Bold, system-ui, sans-serif"
    fontSize: "18px"
    fontWeight: 700
    lineHeight: 1
  body-lead:
    fontFamily: "Figtree, system-ui, -apple-system, Segoe UI, sans-serif"
    fontSize: "17px"
    fontWeight: 400
    lineHeight: 1.35
  body:
    fontFamily: "Figtree, system-ui, -apple-system, Segoe UI, sans-serif"
    fontSize: "16px"
    fontWeight: 400
    lineHeight: 1.45
  body-small:
    fontFamily: "Figtree, system-ui, -apple-system, Segoe UI, sans-serif"
    fontSize: "15px"
    fontWeight: 400
    lineHeight: 1.45
  caption:
    fontFamily: "Figtree, system-ui, -apple-system, Segoe UI, sans-serif"
    fontSize: "14px"
    fontWeight: 400
    lineHeight: 1.45
  button:
    fontFamily: "Figtree, system-ui, -apple-system, Segoe UI, sans-serif"
    fontSize: "17px"
    fontWeight: 700
    lineHeight: 1.45
  label:
    fontFamily: "Figtree, system-ui, -apple-system, Segoe UI, sans-serif"
    fontSize: "15px"
    fontWeight: 600
    lineHeight: 1.45
  label-verdict:
    fontFamily: "Figtree, system-ui, -apple-system, Segoe UI, sans-serif"
    fontSize: "14px"
    fontWeight: 600
    lineHeight: 1.45
  label-exemple:
    fontFamily: "Figtree, system-ui, -apple-system, Segoe UI, sans-serif"
    fontSize: "13px"
    fontWeight: 600
    lineHeight: 1.45
  label-onglet:
    fontFamily: "Figtree, system-ui, -apple-system, Segoe UI, sans-serif"
    fontSize: "12px"
    fontWeight: 500
    lineHeight: 1.45
rounded:
  exemple: "12px"
  vignette-mini: "14px"
  vignette: "16px"
  champ: "18px"
  creux: "20px"
  pilule: "22px"
  tuile: "24px"
  carte: "28px"
  squircle: "44px"
  rond: "9999px"
spacing:
  micro: "4px"
  serre: "8px"
  proche: "10px"
  ligne: "12px"
  carte: "16px"
  marge: "20px"
  bloc: "22px"
  haut: "56px"
  bas: "124px"
components:
  button-primary:
    backgroundColor: "{colors.accent}"
    textColor: "{colors.blanc-pur}"
    typography: "{typography.button}"
    rounded: "{rounded.carte}"
    height: "56px"
  button-primary-active:
    backgroundColor: "{colors.accent-fort}"
    textColor: "{colors.blanc-pur}"
  button-primary-disabled:
    backgroundColor: "{colors.desactive}"
    textColor: "{colors.inconnu}"
  coque-verre:
    backgroundColor: "rgba(255, 251, 250, 0.62)"
    textColor: "{colors.encre}"
    rounded: "{rounded.carte}"
    padding: "12px 16px"
  liste:
    backgroundColor: "{colors.blanc}"
    textColor: "{colors.encre}"
    rounded: "{rounded.carte}"
    padding: "4px 16px"
  carte-verdict-prudence:
    backgroundColor: "{colors.prudence-fond}"
    textColor: "{colors.prudence-texte}"
    rounded: "{rounded.carte}"
    padding: "16px"
  post:
    backgroundColor: "{colors.blanc}"
    textColor: "{colors.encre}"
    rounded: "{rounded.carte}"
    padding: "14px 16px 6px"
  tuile:
    backgroundColor: "{colors.blanc}"
    textColor: "{colors.encre}"
    rounded: "{rounded.tuile}"
    padding: "12px"
    width: "136px"
    height: "186px"
  etape:
    backgroundColor: "{colors.blanc}"
    textColor: "{colors.encre}"
    rounded: "{rounded.tuile}"
    padding: "10px 16px 10px 12px"
    height: "72px"
  chip-filtre:
    backgroundColor: "rgba(255, 251, 250, 0.75)"
    textColor: "{colors.encre}"
    typography: "{typography.label}"
    rounded: "{rounded.pilule}"
    padding: "0 16px"
    height: "44px"
  chip-choix:
    backgroundColor: "{colors.creux}"
    textColor: "{colors.encre}"
    typography: "{typography.label}"
    rounded: "{rounded.pilule}"
    padding: "0 16px"
    height: "44px"
  chip-actif:
    backgroundColor: "{colors.encre}"
    textColor: "{colors.blanc-pur}"
  mention-exemple:
    backgroundColor: "rgba(255, 251, 250, 0.7)"
    textColor: "{colors.encre-2}"
    typography: "{typography.label-exemple}"
    rounded: "{rounded.exemple}"
    padding: "5px 10px"
  champ-texte:
    backgroundColor: "{colors.blanc-pur}"
    textColor: "{colors.encre}"
    typography: "{typography.body}"
    rounded: "{rounded.champ}"
    padding: "12px 14px"
  feuille:
    backgroundColor: "{colors.blanc}"
    textColor: "{colors.encre}"
    rounded: "{rounded.carte}"
    padding: "8px 20px 24px"
  toast:
    backgroundColor: "{colors.encre}"
    textColor: "{colors.blanc-pur}"
    typography: "{typography.body-small}"
    rounded: "{rounded.creux}"
    padding: "12px 16px"
  barre-onglets:
    backgroundColor: "{colors.blanc}"
    textColor: "{colors.encre-2}"
    typography: "{typography.label-onglet}"
    rounded: "{rounded.carte}"
    height: "86px"
  bulle-onglet:
    textColor: "{colors.blanc-pur}"
    rounded: "{rounded.rond}"
    size: "54px"
  mini-goutte:
    textColor: "{colors.encre}"
    typography: "{typography.note-mini}"
    width: "46px"
    height: "54px"
---

# Design System: Revela

## Overview

**Creative North Star: "La goutte de vérité"**

Dans Revela, la note n'est pas un badge posé sur une tuile : c'est une goutte. Elle tombe après le scan, se pose, montre la note du produit, puis une deuxième goutte vient la rejoindre pour dire si le produit convient à ta peau. Le reste de l'interface se tient en retrait pour laisser passer cet objet.

Le monde s'appelle Perle et verre. Le fond est une perle rosée, éclairée par des taches de pêche, de rose et de lilas. Le texte est une encre prune, jamais du noir. Une seule framboise sert aux actions. Les textes longs et les verdicts restent sur des surfaces presque opaques, pour qu'on les lise sans effort avec un produit dans l'autre main.

Le ton est honnête, doux et précis. La densité est celle d'une appli de téléphone utilisée d'une main : une colonne, de grandes cibles, peu de choses à la fois. Le premier brouillon de 22 écrans (`../brand/screens/`) a été refusé pour son style : il ne sert que d'inventaire. Ce fichier décrit le prototype HTML livré. L'appli sera en Flutter : les valeurs se reprennent telles quelles, le code non.

**Key Characteristics:**
- Une goutte en 3D porte la note, de l'atterrissage à la fusion des deux gouttes.
- La forme de la goutte revient partout : verdicts, mini-notes, réaction « Utile », logo.
- Fond perle lumineux, encre prune, un seul accent framboise.
- Deux voix : Zen Maru Gothic pour les titres et les notes, Figtree pour lire et agir.
- Coins très ronds, ombres prune, mouvements sur ressorts.
- Un seul écran sombre : le Scanner.

## Colors

Une perle chaude éclairée de lumières pastel, une encre prune et une framboise franche, avec quatre couleurs de verdict réservées au sens.

### Primary
- **Framboise** (#b92b52) : boutons principaux, réaction « Utile » active, curseur de saisie, contour de focus, ligne de balayage du scan.
- **Framboise foncée** (#961f41) : état appuyé du bouton, libellé de l'onglet actif, icônes de réglage, ajout d'un produit.
- **Dégradé de la bulle** (`linear-gradient(150deg, #ffb296, #d64a72 60%, #961f41)`) : uniquement la bulle de l'onglet actif et les avatars. C'est le dégradé de l'icône d'appli.

### Secondary
- **Pêche** (#ffc4ab) : lumière de fond en haut à droite, cadre du scanner quand le produit est trouvé.
- **Rose** (#f8b3c8) : lumière de fond à gauche, sélection de texte, pastille de la carte Routine (à 55 %).

### Tertiary
- **Lilas** (#dcd0f4) : lumière de fond en bas à droite. Rien d'autre.

### Neutral
- **Perle** (#fbf1f0) : fond de tous les écrans clairs.
- **Blanc rosé** (#fffbfa) : listes, cartes, feuilles, barre d'onglets. On n'y pose jamais de blanc pur.
- **Blanc pur** (#ffffff) : texte sur Framboise, sur Encre et sur le Scanner, fond du champ de texte.
- **Creux** (#fbeeee) : vignettes de produit, produit lié d'un avis, choix non sélectionnés.
- **Trait** (#f2e3e4) : séparateur entre deux lignes d'une liste.
- **Poignée** (#e2cfd6) : poignée de la feuille. Décoratif seulement.
- **Désactivé** (#d9c6cf) : fond du bouton désactivé.
- **Encre** (#3a1a2b) : texte principal, logo, choix sélectionnés, toast.
- **Encre douce** (#6b4557) : texte secondaire, onglets au repos, aides.
- **Nuit** (#26101d), **Lueur** (#6d3a52), **Texte de nuit** (#f2dfe6) : fond, halo central et texte du Scanner.

### Verdicts
- **Compatible** (#1c6e53 sur #dff2e9)
- **Prudence** (#8c4c00 sur #fdecd2, texte de la carte #5c3200)
- **Déconseillé** (#a8261f sur #fce1de)
- **Inconnu** (#5e4d57 sur #eee6ea)

### Named Rules
**La règle de la Framboise seule.** La Framboise est le seul accent et elle veut dire « agis ici ». Pêche, Rose et Lilas sont de la lumière : ils ne portent ni texte ni action.

**La règle du verdict en trois.** Un verdict se dit toujours par sa couleur, sa goutte et son mot. Passé en gris, il doit rester compréhensible. Ces quatre couleurs ne servent à rien d'autre, à part le vert de l'étape cochée et de l'interrupteur actif.

**La règle du fond éclairé.** Le fond n'est jamais une perle plate : trois halos (pêche en haut à droite, rose à gauche, lilas en bas à droite) se fondent dans la Perle.

## Typography

**Display Font:** Zen Maru Gothic (avec Hiragino Maru Gothic ProN, Arial Rounded MT Bold, system-ui)
**Body Font:** Figtree (avec system-ui, -apple-system, Segoe UI)

**Character:** Zen Maru Gothic a des terminaisons rondes, de la même famille que la goutte : elle donne la voix douce des titres et le poids des notes. Figtree reste nette et discrète pour lire une liste d'ingrédients en magasin.

### Hierarchy
- **Note** (900, 40px dans une goutte de 100px, interligne 1, -0,02em, chiffres alignés) : la note dans la goutte 3D. Elle grandit avec la goutte, jusqu'à 72px sur l'écran Résultat. Le « /20 » suit à côté en 700, 13px, encre douce.
- **Chiffre** (900, 25px, 1,1) : les compteurs du Profil.
- **Note mini** (900, 18px, 1) : la note dans une mini-goutte de liste.
- **Display** (700, 42px, 1,05, -0,02em) : le salut de l'Accueil.
- **Headline** (700, 38px, 1,05, -0,02em) : le titre d'un onglet. 32px pour un nom de profil.
- **Headline Scanner** (700, 34px, 1,1) : le titre sur fond sombre.
- **Headline produit** (700, 30px, 1,1, -0,01em) : le nom du produit sur Résultat.
- **Title** (700, 21px, 1,2) : titres de bloc, de feuille et de verdict.
- **Title barre** (700, 18px, 1) : la barre du haut d'un écran poussé.
- **Body lead** (400, 17px, 1,35, 15ch au plus) : la phrase sous le salut.
- **Body** (400, 16px, 1,45) : le texte courant.
- **Body small** (400, 15px, 1,45) : raisons, détails, réponses, toast.
- **Caption** (400, 14px, 1,45) : sous-lignes et mentions d'aide.
- **Button** (700, 17px) : le bouton principal.
- **Label** (600, 15px) : filtres et choix. Le nom d'un produit garde le même poids à 16px.
- **Label verdict** (600, 14px) : le mot du verdict à côté de sa goutte.
- **Label exemple** (600, 13px) : la mention « Exemple ».
- **Label onglet** (500, 12px, 700 pour l'onglet actif).

### Named Rules
**La règle des deux voix.** Zen Maru Gothic pour ce qui se regarde (titres, notes, chiffres), Figtree pour ce qui se lit et se touche (texte, boutons, listes). Jamais l'inverse.

**La règle de la note honnête.** Une note est toujours en 900 et en chiffres alignés. Sans analyse, on écrit « ? », jamais un nombre deviné.

Les fontes doivent être embarquées dans l'appli : les replis ne sont là que pour le cas d'une panne.

## Layout

Le modèle est un téléphone de 390 × 844 avec une seule colonne qui défile sous une barre d'onglets fixe. Les marges latérales sont de 20px, plus la zone de sécurité si elle est plus grande. Un écran commence à 56px du haut sur le cadre de démonstration, 28px en plein écran, et finit à 124px du bas pour passer sous la barre.

Le rythme : 22px entre les blocs, 10px entre un titre de bloc et son contenu, 8 à 12px entre des éléments de même nature, 16px dans une carte. Les étagères horizontales (filtres, Ma salle de bain) débordent des marges et s'alignent à 20px quand on les fait défiler.

Le titre et la goutte se partagent le haut de l'écran : le texte à gauche, la goutte à droite, qui passe de 170px sur l'Accueil à 122px sur Routine et 92px sur Profil. Sur Résultat, la goutte est seule et centrée (196px), puis les deux gouttes se placent côte à côte (150px chacune). Le prototype n'a pas d'autre format que le téléphone.

Toute cible tactile fait au moins 44px de haut, et 48px pour un retour ou un lien sur le Scanner.

## Elevation & Depth

Le système est en couches, avec trois matières. Tout au fond, le fond éclairé. Au milieu, la goutte en 3D, dessinée en shader, translucide au centre et presque opaque sur les bords : elle passe devant le fond et derrière l'interface. Au-dessus, les surfaces de l'interface, qui flottent grâce à une ombre prune, large et douce.

Le verre dépoli est rare. Il n'est livré que sur la carte Routine de l'Accueil (flou 16px, saturation 1,3, fond à 62 %). Les autres surfaces translucentes (bascule, chiffres, filtres) n'ont pas de flou, et les listes et les verdicts restent pleins. Si le système demande moins de transparence, ces surfaces passent en Blanc rosé plein.

### Shadow Vocabulary
- **Ombre de carte** (`box-shadow: 0 12px 28px rgba(122, 48, 80, .12)`) : toutes les cartes, listes et coques.
- **Ombre de tuile** (`box-shadow: 0 8px 18px rgba(122, 48, 80, .1)`) : les tuiles de Ma salle de bain, plus serrées.
- **Ombre du bouton** (`box-shadow: 0 10px 22px rgba(185, 43, 82, .3)`) : le bouton principal. Elle prend la couleur de la Framboise.
- **Ombre de bulle** (`box-shadow: 0 8px 16px rgba(150, 31, 65, .34), inset 0 1px 1px rgba(255, 255, 255, .55)`) : la bulle de l'onglet actif, avec un petit reflet en haut.
- **Ombre de barre** (`filter: drop-shadow(0 -6px 14px rgba(70, 24, 46, .13))`) : la barre d'onglets. Elle suit la forme de l'encoche.
- **Ombre de feuille** (`box-shadow: 0 -14px 34px rgba(58, 26, 43, .2)`) : la feuille ouverte seulement.

### Named Rules
**La règle de l'ombre prune.** Sur fond clair, une ombre est teintée de prune ou de framboise, jamais grise ou noire.

**La règle du texte au sec.** Un texte long et un verdict ne reposent jamais sur du verre : ils ont une surface pleine.

## Shapes

Tout est rond, sans angle vif. Les grandes surfaces ont 28px, les tuiles et les étapes 24px, les choix 22px, les petites zones entre 12 et 20px. Les boutons d'action, les avatars et les pastilles sont des pilules ou des cercles.

Si l'écran sait dessiner un coin continu, les grandes surfaces (coque de verre, listes, carte de verdict, avis, carte Ma peau) passent à un squircle de 44px, plus doux que le rayon de 28px.

La goutte a un seul tracé, à toutes les tailles : en 24px `M12 2.5C12 2.5 19.5 9.6 19.5 14.6A7.5 7.5 0 0 1 4.5 14.6C4.5 9.6 12 2.5 12 2.5Z`. Les icônes d'interface ont un trait de 1,8 à bouts ronds, sur 24px.

**La règle de la forme unique.** Tout ce qui concerne une note, un verdict ou une réaction « Utile » prend la forme de la goutte, sans la déformer. Le logo garde son propre dessin : on ne le redessine pas, on ne le retape pas.

## Components

### Buttons
Doux, francs, et toujours à portée du pouce.
- **Shape :** pilule pleine largeur (56px de haut, rayon 28px).
- **Primary :** fond Framboise, texte blanc pur, Figtree 700 en 17px, avec une icône à gauche si besoin. Un seul par zone visible.
- **Appui :** rétrécit à 97 % en 160ms et passe en Framboise foncée.
- **Focus :** contour de 3px en Framboise, décalé de 2px.
- **Désactivé :** fond Désactivé, texte Inconnu, sans ombre.
- **Lien du Scanner :** texte blanc 600 souligné, 48px de haut.

### Chips
- **Style :** pilule de 44px de haut, 16px de marge intérieure, Figtree 600 en 15px. Blanc rosé à 75 % pour les filtres de Discussion, Creux pour les choix de peau du Profil.
- **State :** sélectionné en fond Encre et texte blanc pur. Appui à 96 %. Pas de Framboise ici : la sélection n'est pas une action.
- **Bascule Matin / Soir :** deux moitiés dans une coque de 26px de rayon, avec un repère Encre qui glisse en 240ms.
- **Mention « Exemple » :** petite étiquette sur toute donnée inventée, en haut à droite de l'écran.

### Cards / Containers
- **Corner Style :** 28px (ou le squircle de 44px), 24px pour les tuiles et les étapes.
- **Background :** Blanc rosé plein pour tout ce qui se lit.
- **Shadow Strategy :** ombre de carte, ombre de tuile pour l'étagère.
- **Border :** aucune, sauf le filet blanc de 1px de la coque de verre. Dans une liste, un trait de 1px sépare les lignes.
- **Internal Padding :** 16px, et 4px en haut et en bas d'une liste pour que les lignes de 68px respirent seules.
- **Ligne de produit :** vignette de 48px, nom en 600, marque, mot du verdict avec sa goutte, mini-goutte à droite.
- **Tuile :** 136 × 186px, vignette de 56px, mini-goutte en haut à droite, verdict en bas.
- **Avis :** auteur, texte, image éventuelle, produit lié, puis les actions « Utile » et « Réponses ». Un menu à trois points ouvre Signaler, Masquer et Bloquer.
- **Comparateur avant-après :** 196px de haut, rayon 20px, un trait blanc de 2px et une poignée ronde de 30px, deux étiquettes « Avant » et « Après ».

### Inputs / Fields
- **Style :** dans une feuille, zone de texte de 128px de haut au moins, rayon 18px, fond blanc pur, libellé au-dessus en 600, compteur en bas à droite.
- **Focus :** contour de 3px en Framboise, sans décalage.
- **Contour au repos :** le contour livré (#e2cfd6) est trop pâle, à 1,5:1. Ce n'est pas une règle : il faut l'assombrir jusqu'à 3:1 au moins avant de le coder.

### Navigation
- **Style :** une barre de 86px en Blanc rosé, coins hauts de 28px, cinq onglets dans l'ordre Accueil, Routine, Scanner, Discussion, Profil. Scanner est au centre, c'est l'action principale.
- **Encoche :** une encoche de 100px de large et 39px de profondeur est creusée dans le bord haut, sous l'onglet actif.
- **Bulle :** un cercle de 54px avec le dégradé de la marque flotte dans l'encoche et porte l'icône de l'onglet actif en blanc. L'icône de l'onglet disparaît et son libellé passe en Framboise foncée, 700.
- **Déplacement :** l'encoche glisse sur un ressort, et un second appui repart de la position réelle. Pendant le trajet, la bulle s'enfonce dans la barre et s'étire, puis remonte en se posant.
- **Sur le Scanner :** la barre garde son Blanc rosé, le fondu au-dessus d'elle disparaît.
- **Écrans poussés :** Résultat garde l'onglet Scanner actif et ajoute en haut un retour de 48px.

### Feuille
Tout ce qui s'ouvre par-dessus un écran est une feuille qui monte du bas, jamais une fenêtre centrée. Coins hauts de 28px, poignée de 40 × 5px, voile `rgba(38, 16, 29, .46)`, ouverture en 320ms. Elle se ferme en la tirant de 90px, d'un geste rapide, en touchant le voile ou avec Échap, et le focus revient à son point de départ.

### Toast
Un court message en Encre, texte blanc pur, rayon 20px, posé au-dessus de la barre. Il reste 2,2 secondes.

### La goutte 3D
L'objet central. Une goutte calculée en temps réel, avec un cœur de perle translucide, un bord prune, un reflet pêche en bas et deux points de lumière. Une petite ombre floue la pose au sol.
- **Les chemins :** elle garde une seule identité d'écran en écran. Elle se déplace, change de taille et s'étire avec sa vitesse. Elle est absente du Scanner et de Discussion.
- **La pointe :** marquée au repos sur Accueil et Profil, moyenne sur Routine, ronde sur Résultat.
- **La note :** elle est un vrai texte posé par-dessus la goutte, jamais dans l'image. Les lecteurs d'écran la reçoivent par une annonce à part.
- **Le récit de la note :** après le scan, la goutte tombe du haut de l'écran, la note compte jusqu'à sa valeur en 700ms. Le bouton « Voir si ça me convient » fait entrer la seconde goutte par la droite. Les deux se touchent et leurs bords fondent, puis le verdict apparaît.
- **Sur Routine :** elle compte les étapes faites (3/4). Elle vit à chaque case cochée.
- **Au doigt :** elle se laisse attraper, suit le doigt, et une onde la parcourt quand on la lâche. Sa lumière suit le doigt.
- **Si la 3D manque :** un cercle en dégradé CSS garde la même place et la même note.
- **Mouvement réduit :** la goutte va droit à sa place et reste immobile.

**La règle de l'irisation méritée.** L'irisation nacrée éclate quand une note apparaît ou quand la routine est finie, puis redescend à 30 % le temps de l'écran. Un doigt proche l'allume à 50 %. Au repos, la goutte n'est jamais irisée.

### Mini-goutte
La note dans une liste : une goutte de 46 × 54px teintée du verdict, avec un filet blanc et un reflet, la note en bas, « ? » si elle manque. Dégradés : Compatible `#eefaf3` vers `#9fd8bd`, Prudence `#fff4e2` vers `#f8ca8c`, Déconseillé `#ffeae6` vers `#f4a79e`, Inconnu `#f7f1f4` vers `#d6c9d1`. Sa teinte ne suffit pas à dire le verdict : le mot l'accompagne.

### Icônes de verdict
Une même goutte de 24px, dans quatre états qui se distinguent sans la couleur. 20px dans une liste, 24px dans les raisons, 34px dans la carte de verdict.
- **Compatible :** goutte pleine avec une coche blanche.
- **Prudence :** contour, à moitié remplie, le haut du liquide en vague.
- **Déconseillé :** contour barré en diagonale.
- **Inconnu :** contour en pointillés, un point au centre.

Le contour seul, sans remplissage, marque une étape pas encore faite.

### Carte de verdict
Fond de la couleur du verdict, grande icône de 34px, le mot en titre, une phrase personnelle. Elle apparaît en glissant de 10px en 500ms, avec les raisons. Dessous, chaque raison s'ouvre pour montrer sa source. Seule la version Prudence est livrée.

### Scanner
Le seul écran sombre, centré sur le flacon. Le viseur fait 160 × 76px, avec des coins blancs de 3px et une ligne de balayage Framboise. Quand le produit est trouvé, la ligne s'arrête, le cadre se resserre à 90 % et passe en Pêche.

## Do's and Don'ts

### Do:
- **Do** montrer le verdict avec sa couleur, sa goutte et son mot, partout.
- **Do** garder « Information, pas un avis médical. » sur chaque écran de verdict, en Caption.
- **Do** marquer toute donnée inventée par la mention « Exemple ».
- **Do** écrire « ? » et « Analyse insuffisante » quand la note manque.
- **Do** donner à chaque note ses raisons et ses sources, à portée d'un toucher.
- **Do** garder 44px de cible au minimum.
- **Do** utiliser des ressorts pour les gouttes et la barre, pour qu'un geste puisse en reprendre un autre en cours.
- **Do** couper le balayage, l'oscillation et les ressorts quand le système demande moins d'animations.
- **Do** utiliser `logo/revela-symbole-petit.svg` sous 32px, et garder autour du logo un vide égal à la largeur de la goutte.

### Don't:
- **Don't** poser le r goutte à côté du nom, sinon on lit « r revela ».
- **Don't** ajouter une ombre ou un dégradé au logo, ni l'étirer ou le pencher. Cette règle vise le logo seul : le dégradé de la bulle et les ombres font partie du monde.
- **Don't** coller une note dans un badge rond ou carré sur une tuile : la note vit dans une goutte.
- **Don't** utiliser les couleurs de verdict pour décorer.
- **Don't** mettre de la Framboise sur une simple sélection : la sélection est en Encre.
- **Don't** laisser la goutte irisée au repos.
- **Don't** mettre du noir pur en texte ou en ombre sur fond clair.
- **Don't** poser un texte long ou un verdict sur du verre.
