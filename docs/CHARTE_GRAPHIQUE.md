# Saleba — Charte graphique

> Une seule identité pour toutes les surfaces : **Saleba Pro** (gestion), **Saleba Market** (grand public),
> **Saleba TV**, le **back-office** et le **web**. Source de vérité technique : `tokens/tokens.json` de ce dépôt.

## 1. Identité

**Saleba** = *sale* + *ba* (« grand » en bambara) : la grande vente, le grand marché.
Personnalité : **fiable, chaleureuse, ambitieuse, simple**. On parle à un commerçant occupé :
clair avant d'être joli, rapide avant d'être riche.

Déclinaisons : `Saleba Pro` · `Saleba Market` · `Saleba TV` · `Saleba Studio` (configuration) ·
`Saleba Admin` (back-office).

## 2. Couleurs

| Rôle | Nom | Hex | Usage |
|---|---|---|---|
| Primaire | Vert Saleba | `#0B6E5A` | Actions principales, navigation, marque |
| Primaire forte | | `#07513F` | Survol, appui |
| Primaire douce | | `#E6F4EF` | Fonds de sélection, badges |
| Accent | Safran | `#F2A93B` | Appels à l'action marketing, prix, « à la une » (texte foncé dessus) |
| Appoint | Terracotta | `#C2410C` | Promotions, remises |
| Fond clair | Sable | `#FBF8F3` | Arrière-plan des apps |
| Texte | Ébène | `#1C1917` | Texte principal |
| Texte secondaire | | `#57534E` | Libellés, aides |
| Succès / Alerte / Erreur / Info | | `#15803D` / `#B45309` / `#B42318` / `#1D4ED8` | États |
| Fonds d'état (doux) | | `#EAF6EE` / `#FDF3E7` / `#FCEDEC` / `#EAF0FC` | Bandeaux et badges d'état |

**Mode sombre** : fond `#121110`, surfaces `#1A1816`, primaire éclaircie `#3FD1A8`, accent `#F5B651`.

**Pourquoi ce vert** : il évoque la prospérité et la confiance, et se distingue volontairement des
couleurs des opérateurs de paiement (orange d'Orange Money, bleu de Wave, jaune de MTN) pour que leurs
logos restent lisibles dans nos écrans de paiement sans conflit de marque.

**Accessibilité (WCAG 2.2)** — contrastes vérifiés :
vert sur blanc 6,2:1 · texte ébène sur sable 16,5:1 · ébène sur safran 8,8:1 ·
vert clair sur fond sombre 9,8:1. Le safran **ne porte jamais de texte blanc**.
Ne jamais transmettre une information uniquement par la couleur (ajouter icône ou libellé).

**Graphiques KPI** : palette catégorielle fixe `data.1…6` (vert, safran, bleu, terracotta, violet, cyan),
toujours dans cet ordre.

## 3. Typographie

| Usage | Police | Tailles |
|---|---|---|
| Titres, chiffres clés | **Plus Jakarta Sans** (600–700) | 22 / 28 / 36 |
| Texte courant, formulaires | **Inter** (400–600) | 14 / 16 / 18 |
| Montants en caisse | Inter, **chiffres tabulaires** | 18 à 36 |
| Écran TV | Plus Jakarta Sans | ≥ 48 |

Repli : **Noto Sans**, obligatoire pour couvrir les caractères des langues locales
(bambara, wolof, peul… : ɛ, ɔ, ɲ, ŋ, ɓ, ɗ, ƴ) et les écritures non latines (arabe pour le Maghreb et le Sahel).
À vérifier sur appareils réels avant validation.
Polices **embarquées** dans les apps (pas de chargement réseau) pour l'offline : Plus Jakarta Sans et Inter
sont fournies par le paquet Flutter `saleba_design` ; Noto Sans est encore celle du système (à embarquer).

## 4. Espacements, formes, mouvement

- Grille de **4 px** : 4, 8, 12, 16, 24, 32, 48.
- Rayons : 8 (champs), 12 (cartes), 16 (feuilles), 24 (modales), pilule (badges, puces).
- Ombres légères (`sm`, `md`) ; préférer les bordures `neutral.100` sur fond sable.
- Animations 120 / 200 / 320 ms, courbe `(0.2, 0, 0, 1)` ; respecter « réduire les animations ».
- Cible tactile minimale **48 px** ; touches de caisse **72 px** (utilisation rapide, doigts mouillés,
  écrans bas de gamme).

## 5. Composants et règles par surface

- **Saleba Pro** : dense mais lisible ; caisse plein écran en grille de produits ; total toujours visible ;
  confirmation visuelle et sonore à chaque vente.
- **Saleba Market** : photos produits en avant, badges **Pro** (vert) / **Particulier** (neutre),
  prix en ébène gras, « à la une » en safran.
- **Saleba TV** : contraste maximal, textes ≥ 48 px, un message par écran, numéro de ticket géant.
- **Back-office / Studio** : fond sable, canevas neutre, la couleur est réservée à l'état et à la sélection.
- Les **icônes** : un seul jeu (style trait arrondi, 1,75 px), adapté aux métiers locaux.
- Les **logos de moyens de paiement** sont des ressources configurables fournies par chaque fournisseur
  (jamais redessinés), affichés sur fond neutre.

## 6. Personnalisation par commerce (configurable, encadrée)

Chaque tenant peut définir **son logo et une couleur de marque** pour sa vitrine, ses tickets,
ses reçus et son écran TV. Garde-fous automatiques :
- la couleur du tenant remplace uniquement le jeton `accent` de sa vitrine, jamais la structure ;
- le contraste est vérifié à l'enregistrement ; la couleur de texte associée est calculée automatiquement ;
- l'interface de l'application (navigation, états, erreurs) reste aux couleurs Saleba.

## 7. Mise en œuvre technique

- `tokens/tokens.json` (dépôt `saleba_design`) au format **W3C Design Tokens (DTCG)** = source unique.
- Génération par `flutter/tool/gen_tokens.dart` (`cd flutter && dart run tool/gen_tokens.dart`) vers :
  - **Flutter** : paquet partagé `saleba_design` (Pro, Market, TV, back-office) : constantes
    `SalebaTokens`, thèmes `SalebaTheme.light()` / `dark()` (`ThemeData`), extensions de thème
    `SalebaColors` et `SalebaSpacing`, typographie `SalebaTypography`, polices embarquées ;
  - **Web** : variables CSS `web/saleba-tokens.css` (clair, sombre, réduction des animations) et
    thème Tailwind CSS v4 `web/saleba-tailwind.css`, publiés sous le nom npm `@saleba/design` ;
  - **Documentation** : cette charte (page de référence visuelle à venir).
- Le test `flutter/test/generated_test.dart` échoue si une sortie générée n'est plus à jour ou si un
  `Color(0x…)` ou un `Colors.…` de Material apparaît dans le paquet hors des tokens générés.
- Interdit : couleur ou taille codée en dur dans un widget, dans quelque projet que ce soit. Aucun projet
  ne redéfinit de couleur, de typographie ou d'espacement localement.
- Le catalogue de composants du Runtime Builder et les rendus A2UI utilisent exclusivement ces tokens.
- Historique : le 26/11/2026, Saleba Pro a abandonné ses palettes multiples (`lib/core/brand.dart`) au profit
  d'un générateur local depuis `design/tokens.json`. Ce dépôt reprend ce générateur avec les mêmes noms de
  constantes, pour que l'app passe au paquet sans rien renommer.

## 8. Logo (à concevoir)

Pistes : monogramme **« S »** formé de deux flèches ou de deux étals qui se rejoignent
(le commerçant et le client, le Pro et le Market), en vert Saleba avec un point safran.
Contraintes : lisible à 16 px (favicon), sur fond clair et sombre, en monochrome pour les tickets thermiques.
