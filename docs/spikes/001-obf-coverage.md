# Spike 001 — Couverture Open Beauty Facts sur mes produits

**Ticket :** REV-1 · **Sprint :** 0 · **Règles :** RG-02, RG-04, RG-05 · **Date :** octobre 2026

## La question

Est-ce qu'Open Beauty Facts (OBF) connaît assez mes produits, surtout coréens, pour être la source principale de Revela ? La réponse décide de la priorité du plan B (OCR de la liste d'ingrédients).

Règle fixée avant le test : si moins de 50 % des produits coréens ont leurs ingrédients dans OBF, l'OCR passe en P0.

## TL;DR

- 16 produits testés : **6 trouvés (38 %)**, **3 avec des ingrédients exploitables (19 %)**.
- K-beauty : **1 produit sur 5 avec ingrédients (20 %)**. On est loin des 50 %.
- Même quand OBF trouve le code-barres, la fiche est souvent une coquille vide : 3 des 6 produits trouvés n'ont aucun ingrédient.
- **Décision : l'OCR passe en P0.** Le spike OCR (REV-24) est remonté au Sprint 1, et la photo de la liste d'ingrédients devient un parcours principal de l'app, pas un secours.

## Méthode

- 14 produits de ma salle de bain + 2 best-sellers K-beauty que je n'ai pas (COSRX, Anua), pour vérifier que l'absence ne venait pas juste de mes choix de produits.
- Appel direct : `GET https://world.openbeautyfacts.org/api/v2/product/<barcode>.json` depuis le navigateur.
- Quand le flacon n'avait pas de code-barres : recherche par nom sur le site OBF, puis contre-vérification par marque.
- Pour chaque produit : trouvé ou pas, `ingredients_text` renseigné ou pas.

## Échantillon

| # | Produit | Origine | Méthode | Code-barres | Trouvé | Ingrédients | Note |
|---|---|---|---|---|---|---|---|
| 1 | L'Arbre Vert — Lait corps argan & karité | France | Code (EAN-13) | 3450601036613 | Non | — | Produit de grande surface absent |
| 2 | Dove Original — crème anti-transpirant 50 ml | Autre | Code (EAN-8) | 80466468 | Oui | Oui (19) | Fiche alimentée par Unilever. Liste à comparer au flacon (reformulation ?) |
| 3 | Aroma-Zone — Sérum niacinamide 10 % | France | Nom | — | Non | — | |
| 4 | Florame — Masque purifiant charbon 2-en-1 | France | Nom | — | Non | — | |
| 5 | Patyka — Hydra crème lactée apaisante | France | Nom | — | Non | — | |
| 6 | Beesline — Hydrating day cream | Autre (Liban) | Nom | — | Non | — | QR code seulement sur le flacon |
| 7 | ISDIN — Isdinceutics K-Ox Eyes | Autre (Espagne) | Nom | — | Non | — | |
| 8 | Medicube — One Day Exosome Shot 7500 | Corée | Nom | — | Non | — | Absent même en cherchant par marque |
| 9 | K-Secret — Seoul 1988 Serum Retinal 2 % | Corée | Nom | — | Non | — | Absent même en cherchant par marque |
| 10 | Beauty of Joseon — Revive Eye Serum | Corée | Nom | 8809738316146 | Oui | Oui | Fiche marquée incomplète mais ingrédients complets (en, fr, nl, tr) |
| 11 | COSRX — Snail 96 Mucin Essence *(pas à moi)* | Corée | Nom | — | Non | — | Absent alors que c'est un best-seller mondial |
| 12 | Anua — Heartleaf 77 Soothing Toner *(pas à moi)* | Corée | Nom | 8809640736025 | Oui | Non | Créé par un scraper Kruidvat. Clé `ingredients_text` absente |
| 13 | Pure & Care — Gommage corps | Autre | Code | — | Non | — | |
| 14 | CeraVe — Gel moussant (Foaming Cleanser) | France | Code (EAN-13) | 3337875597197 | Oui | Oui (28) | Scraper Kruidvat, fiche en NL. Texte brut déjà abîmé (voir plus bas) |
| 15 | Soft (Carrefour) — Eau micellaire waterproof | France | Code (EAN-13) | 3560071324803 | Oui | Non | Import Carrefour : `ingredients_text` **et** `product_name` vides |
| 16 | Caudalie — Vinoclean huile de soin démaquillante | France | Code (EAN-13) | 3522930003175 | Oui | Non | Nom + photo des ingrédients présents, mais texte jamais saisi |

## Résultats

| Groupe | Testés | Trouvés | Avec ingrédients |
|---|---|---|---|
| **Global** | 16 | 6 (38 %) | **3 (19 %)** |
| **K-beauty** | 5 | 2 (40 %) | **1 (20 %)** |
| France | 7 | 3 (43 %) | 1 (14 %) |
| Autres | 4 | 1 (25 %) | 1 (25 %) |
| Recherche par code-barres | 6 | 4 (67 %) | 2 (33 %) |
| Recherche par nom | 10 | 2 (20 %) | 1 (10 %) |

Le constat le plus important : **trouvé ≠ exploitable**. Sur 6 fiches trouvées, la moitié n'a pas d'ingrédients, et chacune d'une façon différente :

1. **Scraper sans ingrédients** (Anua) : la clé `ingredients_text` n'existe pas du tout.
2. **Import producteur vide** (Carrefour) : `ingredients_text: ""` et `product_name: ""`. Je n'ai même pas de nom à afficher, juste la marque et une photo. Complétude OBF : 16 %.
3. **Photo sans texte** (Caudalie) : un contributeur a uploadé la photo des ingrédients, mais personne n'a saisi le texte. `states_tags` contient à la fois `en:ingredients-photo-selected` et `en:ingredients-to-be-completed`.

## Ce que j'ai appris sur l'API

### Les états de réponse

| Cas | HTTP | `status` | Ce qu'il faut regarder |
|---|---|---|---|
| Introuvable | 404 | 0 | `status_verbose: "product not found"`, pas de clé `product`. Le corps JSON est quand même renvoyé |
| Trouvé, ingrédients OK | 200 | 1 | `product.ingredients_text` non vide |
| Trouvé, sans ingrédients | 200 | 1 | `ingredients_text` **absent** (Anua) **ou** `""` (Carrefour, Caudalie) |
| Trouvé, sans nom | 200 | 1 | `product_name: ""` (Carrefour) |

Côté code : un 404 n'est pas une erreur technique, c'est un cas métier (RG-04). Et « clé absente » et « chaîne vide » doivent être traités exactement pareil (RG-05).

### Les champs utiles

- **Nom :** `product_name`, avec des variantes par langue (`product_name_fr`, `product_name_en`…). Peut être vide.
- **Marque :** `brands`.
- **Images :** `image_front_url`, et `image_ingredients_url` quand la photo des ingrédients existe.
- **Ingrédients (texte brut) :** `ingredients_text`, plus des variantes par langue (`ingredients_text_en`, `ingredients_text_fr`…). Sur le CeraVe, `ingredients_text_fr` est vide alors que `ingredients_text` est rempli. Donc : lire `ingredients_text` d'abord, les variantes par langue en secours.
- **Ingrédients (parsés) :** `ingredients[]`, avec `id`, `text` et `is_in_taxonomy`.

### Ni le parsing OBF ni le texte brut ne sont fiables

Le tableau `ingredients[]` d'OBF découpe mal les noms INCI :

- Il coupe sur `/` et sur `( )` : sur le Beauty of Joseon, `Caprylic/Capric Triglyceride` est coupé en deux.
- Les préfixes de langue (`nl:`) ne sont pas reconnus.
- Il se trompe d'identifiant : sur le CeraVe, `tetrasodium edta` est rattaché à `en:disodium-edta`.

Et sur le CeraVe, c'est déjà le **texte brut** qui est abîmé : `ingredients_text` contient `peg-6 caprylic, capric glycerides` (le `/` de `PEG-6 Caprylic/Capric Glycerides` est devenu une virgule à la saisie, probablement par le scraper), et `aqua` et `water` apparaissent comme deux ingrédients séparés.

Conséquence : Revela ne s'appuie pas sur `ingredients[]`. On prend `ingredients_text` et on le passe dans notre propre parser INCI (ticket « Parser et normaliser la liste d'ingrédients INCI »), en gardant en tête que même le texte brut n'est pas garanti propre.

### Autres observations

- Les réponses sont énormes et pleines de champs alimentaires inutiles pour nous (Nutri-Score, NOVA, Eco-Score, Agribalyse). À tester : le paramètre `fields=` pour ne récupérer que ce qu'on utilise.
- `completeness` n'est pas un bon signal : le Beauty of Joseon est marqué incomplet mais a ses ingrédients complets. Le seul vrai test, c'est `ingredients_text` non vide.
- La qualité dépend complètement de qui a créé la fiche : imports producteurs (Unilever, Carrefour), scrapers (Kruidvat), contributeurs isolés.
- Une fiche peut venir d'un autre pays (CeraVe en NL) ou être ancienne : la formule peut différer du flacon que l'utilisatrice a en main. À vérifier avec le Dove.
- UPC-A (12 chiffres) : pas testé, aucun produit UPC-A dans l'échantillon. Reporté dans REV-9.

## Décision

**20 % < 50 % → le plan B OCR passe en P0.**

- REV-24 (spike OCR avec ML Kit) : P1 → **P0**, Sprint 5 → **Sprint 1**.
- La photo de la liste d'ingrédients devient un parcours principal de Revela, au même niveau que le scan de code-barres.
- OBF reste la source de vérité pour ce qu'il connaît (RG-02), mais ce n'est plus le seul point d'entrée.

## Ce que ça change pour la suite

- **Lookup produit :** 4 issues à modéliser (introuvable, trouvé sans nom, trouvé sans ingrédients, OK). Les 3 premières doivent proposer directement la photo des ingrédients.
- **Piste pour REV-24 :** quand OBF a la photo des ingrédients mais pas le texte (cas Caudalie), on pourrait lancer l'OCR sur `image_ingredients_url`. À évaluer pendant le spike.
- **Parser INCI :** toujours à partir de `ingredients_text`, jamais de `ingredients[]`.
- **Fixtures de test** dans `docs/spikes/obf-samples/` : au moins un cas de chaque type.

| Cas | Produit |
|---|---|
| Introuvable | L'Arbre Vert (3450601036613) |
| Trouvé + ingrédients | CeraVe (3337875597197) |
| Trouvé, clé `ingredients_text` absente | Anua (8809640736025) |
| Trouvé, `ingredients_text` et `product_name` vides | Carrefour (3560071324803) |
| Trouvé, nom + photo mais texte vide | Caudalie (3522930003175) |

## Limites

- 16 produits, c'est petit, et l'échantillon est biaisé : ma salle de bain + 2 best-sellers.
- Les 4 derniers produits ont été choisis parce qu'ils avaient un code-barres, ce qui gonfle un peu le taux « trouvé ». Sur les 10 premiers, seulement 2 flacons en avaient un (6 sur 14 produits physiques au total).
- Recherche par nom (10 produits) et recherche par code (6 produits) ne sont pas vraiment comparables.
- Mais la décision n'est pas serrée : 20 % contre un seuil de 50 %. Un échantillon plus grand ne la ferait probablement pas basculer.
