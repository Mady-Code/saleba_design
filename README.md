# saleba_design

Design system partagé de **Saleba** : une seule identité pour Saleba Pro, Saleba Market, Saleba TV,
Saleba Admin / Studio et le web.

| Chemin | Contenu |
|---|---|
| `tokens/tokens.json` | **Source de vérité** : tokens au format W3C Design Tokens (DTCG). Rien n'est défini ailleurs. |
| `docs/CHARTE_GRAPHIQUE.md` | Charte graphique : identité, couleurs, typographie, formes, règles par surface, personnalisation par commerce. |
| `flutter/` | Paquet Dart/Flutter `saleba_design` : `SalebaTokens` (généré), `SalebaTheme`, `SalebaColors`, `SalebaSpacing`, `SalebaTypography`, `SalebaContrast`, `SalebaMotion`, polices embarquées. |
| `web/` | Sorties web générées : variables CSS (`saleba-tokens.css`) et thème Tailwind CSS v4 (`saleba-tailwind.css`). |
| `package.json` | Paquet npm `@saleba/design` (tokens, CSS, Tailwind). |

## Modifier un token

1. Éditer `tokens/tokens.json` (et la charte si la règle change).
2. Régénérer toutes les sorties :
   ```sh
   cd flutter && dart run tool/gen_tokens.dart
   ```
3. `flutter test` : échoue si une sortie générée n'est pas à jour, si une couleur est codée en dur dans
   le paquet ou si un contraste promis par la charte n'est plus tenu.
4. Ouvrir une PR. La CI refait ces vérifications.

Les fichiers `flutter/lib/src/saleba_tokens.dart` et `web/*.css` sont **générés** : ne jamais les éditer à la main.

## Utiliser le paquet Flutter

```yaml
# pubspec.yaml de l'app
dependencies:
  saleba_design:
    git:
      url: https://github.com/Mady-Code/saleba_design.git
      path: flutter
      ref: v0.1.0   # une étiquette, jamais une branche mouvante
```

```dart
import 'package:saleba_design/saleba_design.dart';

MaterialApp(
  theme: SalebaTheme.light(),
  darkTheme: SalebaTheme.dark(),
);

// Dans un widget
final colors = SalebaColors.of(context);     // bg, surface, text, primary, accent, success…
final space = SalebaSpacing.of(context);     // s1…s12, radiusSm…radiusXl, touchMin, posKey
Text('12 500 F', style: SalebaTypography.amount(size: 28, color: colors.text));
AnimatedOpacity(duration: SalebaMotion.duration(context), curve: SalebaMotion.curve, …);
```

- **Couleur du commerce** (charte §6) : `SalebaTheme.light(tenantAccent: couleurDuTenant)` ne remplace
  que l'accent, calcule la couleur du texte posé dessus et ignore une couleur illisible
  (`SalebaContrast.isUsableAccent`). Navigation, états et erreurs restent aux couleurs Saleba.
- **Écran TV** : `SalebaTheme.dark(spacing: SalebaSpacing.standard.scaled(1.5))`.
- **Polices** : Plus Jakarta Sans (titres, chiffres clés) et Inter (texte) sont embarquées dans le paquet ;
  l'app n'a rien à déclarer. Voir `flutter/fonts/FONTS.md`.
- Les noms de `SalebaTokens` sont ceux du générateur de Saleba Pro : l'app peut remplacer son
  `lib/core/theme/saleba_tokens.dart` par ce paquet sans rien renommer.

## Utiliser les tokens sur le web

```css
/* CSS seul */
@import "@saleba/design/tokens.css";
.carte { background: var(--saleba-surface); color: var(--saleba-text); border-radius: var(--saleba-radius-md); }
```

```css
/* Tailwind CSS v4 */
@import "tailwindcss";
@import "@saleba/design/tailwind.css";
/* <button class="bg-primary text-on-primary rounded-sm px-4 py-3 font-body"> */
```

Le mode sombre suit `prefers-color-scheme`, et se force avec `data-theme="dark"` ou `data-theme="light"`
sur `<html>`. Les durées d'animation passent à 0 sous `prefers-reduced-motion`. La palette Tailwind par
défaut est retirée : seules les couleurs Saleba existent.

Installation depuis Git : `npm install github:Mady-Code/saleba_design#v0.1.0`.

## Versions

Versionnage sémantique, étiquettes `vX.Y.Z` sur `main`. Renommer ou retirer un token est un changement
majeur ; en ajouter un est mineur.
