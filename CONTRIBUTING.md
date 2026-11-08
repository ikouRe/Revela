# Contribuer à Revela

## Branches

`type/REV-<n>-description-courte`, par exemple `feat/REV-8-product-endpoint`.

Types : `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`.

## Commits

[Conventional Commits](https://www.conventionalcommits.org/fr/) : `type(portée): description`.

```
feat(product): add OBF client
fix(scan): ignore duplicate reads
docs(adr): choose riverpod
```

## Pull requests

- 1 PR = 1 ticket, titre `REV-8 — Endpoint produit`.
- Le modèle de PR se remplit tout seul : ticket lié, ce qui change, comment tester, checklist.
- Squash merge. `main` est protégée : on n'y pousse jamais directement.

## Décisions et suivi

- Une décision d'architecture importante donne un ADR dans `docs/adr/` (modèle : `000-template.md`).
- Chaque ticket terminé ajoute une ligne à `docs/journal.md`.
- Aucun secret dans le repo : les variables vont dans `.env`, qui est ignoré par Git.
