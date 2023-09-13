## Intro

### Problem space / motivation

### Approche

### À la fin : dire que les choses sont présentées pour GHC

D'autant plus intéressant que pureté obligatoire

## Explication

### Exemples (à quoi ressemble la solution)

1. Perf : difference list
2. Expr : parcours en largeur
3. Perf : désérialisation (insister en détail sur ce point)

### Définir le problème précisément et en détail

## Développement technique

- Détails API
- Implémentation en Haskell
- Changements RTS

## Évaluation

- Quelques remarques sur `map` tail recursif et donc pertinence pour OCaml / `map` en termes de `foldL`

## Conclusion / Mise en perspective / Discussion

- Comparaison à Minamide
- Parler des optimisations mémoire (F~)
