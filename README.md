# Revela

Revela est une application mobile de skincare. Tu scannes un produit, et elle te dit en premier s'il est compatible avec TA peau, avec les ingrédients responsables et leurs sources.

Projet de fin d'études, en cours de développement. La Phase 1 couvre le scan, la fiche produit et le verdict de compatibilité.

## Stack

| Partie | Technologies |
|---|---|
| Mobile | Flutter, Riverpod, go_router, package `http`, shared_preferences |
| Backend | Java 25, Spring Boot 4.1, Maven |
| Données | PostgreSQL 16, Flyway |
| API | OpenAPI généré avec springdoc |

Les choix et leurs raisons sont expliqués dans [ADR-001](docs/adr/001-stack.md).

## Structure du repo

| Dossier | Contenu |
|---|---|
| `backend/` | API Spring Boot |
| `mobile/` | Application Flutter |
| `docs/` | Décisions d'architecture et design |

## Lancer le backend en local

Prérequis : JDK 25 et Docker Desktop.

1. Copier le fichier d'exemple :

   ```bash
   cp backend/.env.example backend/.env
   ```

2. Renseigner `DB_PASSWORD` dans `backend/.env`.

3. Lancer PostgreSQL :

   ```bash
   docker compose --env-file backend/.env up -d
   ```

4. Lancer le backend depuis IntelliJ.

Flyway applique les migrations au démarrage.

## Lancer les tests du backend

Docker Desktop doit être démarré : les tests lancent un PostgreSQL temporaire avec Testcontainers.

```bash
cd backend
./mvnw test
```

## Variables d'environnement

| Variable | Rôle |
|---|---|
| `DB_URL` | Adresse JDBC de la base (port 5433 en local) |
| `DB_NAME` | Nom de la base |
| `DB_USERNAME` | Utilisateur de la base |
| `DB_PASSWORD` | Mot de passe de la base, à ne jamais commiter |

Le fichier `backend/.env` est ignoré par Git.

---

© 2026 Ikram Ikou — tous droits réservés
