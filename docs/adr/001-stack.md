# ADR-001 — Choix de stack et d'architecture

- **Statut :** Accepté
- **Date :** 2026-10-31
- **Ticket :** REV-3

## Contexte

Revela est une application mobile qui scanne un produit cosmétique et dit s'il convient au profil de peau de l'utilisatrice, avec les ingrédients responsables et leurs sources. La Phase 1 est développée seule, sur un rythme d'alternance, et sera défendue devant un jury de PFE.

Le projet doit aussi servir à apprendre le génie logiciel de bout en bout. Après le socle sont prévus l'empreinte carbone, l'authenticité par blockchain, le déploiement cloud, puis le chatbot et d'autres briques d'IA. Les comptes utilisateurs viendront aussi plus tard.

Contraintes retenues : temps limité, pas de compte utilisateur en Phase 1, profil de peau gardé sur le téléphone (RG-23), sources obligatoires pour chaque règle (RG-30).

## Décisions

### 1. Langage et framework du backend

**Décision :** Java 25 (LTS) et Spring Boot 4.1.1.

**Alternatives écartées :**
- Python : excellent pour l'IA, mais son typage est moins strict. Il reste possible plus tard pour un service d'IA séparé.
- Node.js : adapté aux API, mais je perdrais mon expérience de Java.
- Kotlin : très bon, mais je le maîtrise moins que Java.
- Go : performant, mais il aurait fallu l'apprendre en plus du reste.
- Quarkus et Micronaut : plus légers, mais leur communauté est plus petite que celle de Spring.
- Java 21 : encore supporté, mais Java 25 est la LTS la plus récente.

**Conséquences :** le typage strict détecte beaucoup d'erreurs à la compilation. Spring fournit déjà l'API, JPA, la validation et Spring Security pour les futurs comptes. En contrepartie, le démarrage et la mémoire seront à surveiller sous Kubernetes. Le passage à Java 25 reste à faire : installer le JDK 25, changer `java.version` dans `pom.xml`, puis vérifier le build et les tests.

### 2. Build du backend

**Décision :** Maven, avec le wrapper du projet (`mvnw`).

**Alternatives écartées :**
- Gradle : plus souple, mais cette souplesse n'est pas utile pour un seul module, et j'utilise Maven en alternance.

**Conséquences :** le build reste déclaratif et se lit directement dans `pom.xml`.

### 3. Base de données

**Décision :** PostgreSQL 16, lancé en local avec Docker Compose.

**Alternatives écartées :**
- MongoDB : le domaine est relationnel (produits, ingrédients, règles) et les liens entre ces données comptent.
- MySQL : convient aussi, mais n'offre pas JSONB, utile si je dois stocker des données brutes.

**Conséquences :** le conteneur écoute sur le port 5433, car le 5432 est déjà pris sur le poste. Les tests d'intégration utilisent la même image via Testcontainers.

### 4. Migrations

**Décision :** Flyway, avec des migrations en SQL pur dans `db/migration`.

**Alternatives écartées :**
- Liquibase : plus lourd que le besoin d'une base unique.
- `ddl-auto=update` : le schéma changerait sans trace ni relecture.

**Conséquences :** Hibernate reste en `ddl-auto=validate` : il vérifie le schéma et ne le modifie jamais. Une migration déjà appliquée n'est pas réécrite, toute évolution passe par un nouveau fichier.

### 5. Architecture du backend

**Décision :** une architecture par couche, avec des packages `controller`, `service` et `repository`.

**Alternatives écartées :**
- Package par fonctionnalité (`product`, `ingredient`, `compatibility`) : le code d'une fonctionnalité est mieux groupé, mais cette organisation n'apporte pas assez pour le socle, et la séparation par couche est plus lisible pour moi.

**Conséquences :** les rôles sont bien séparés et les dépendances vont toujours dans le même sens : contrôleur, service, repository. Les tests suivent la même logique. En contrepartie, une fonctionnalité est répartie entre plusieurs dossiers, ce qui sera moins lisible quand le projet grandira. Si cela devient gênant, je réorganiserai les packages sans changer les couches.

### 6. Application mobile

**Décision :** Flutter.

**Alternatives écartées :**
- Kotlin et Swift : deux applications à écrire et à maintenir seule.
- React Native : bonne option, mais Flutter contrôle mieux le rendu visuel.
- Ionic : web embarqué, moins adapté aux animations prévues.

**Conséquences :** un seul code couvre Android et iOS, et les animations restent identiques sur les deux. Les tests sur iPhone demandent toutefois un Mac.

### 7. Gestion d'état Flutter

**Décision :** Riverpod.

**Alternatives écartées :**
- GetX : très rapide à prendre en main, mais il concentre l'état, la navigation et les dépendances dans un seul package, ce qui rendrait tout le projet dépendant de lui.
- Bloc : solide, mais demande plus de code.
- Provider : trop limité pour la suite du projet.

**Conséquences :** l'état et la navigation restent séparés, et les dépendances se remplacent facilement dans les tests. Je dois apprendre Riverpod, que je ne connais pas encore.

### 8. Client HTTP Flutter

**Décision :** le package `http`.

**Alternatives écartées :**
- dio : plus complet, avec des intercepteurs et une gestion d'erreurs déjà prévue, mais je veux maîtriser et écrire moi-même la gestion des réponses et des erreurs.

**Conséquences :** tous les appels passent par une seule classe dans `lib/core/api`. Elle vérifie le code de chaque réponse, car un 404 ne déclenche pas d'exception, convertit les erreurs ProblemDetail (RG-61) et applique un timeout. Les tests utilisent `MockClient`. Avec les comptes, cette classe ajoutera aussi le token. L'URL de l'API vient de `--dart-define`.

### 9. Stockage local Flutter

**Décision :** shared_preferences pour le profil de peau et les préférences simples. Le choix pour l'historique est reporté à son ticket (RG-42).

**Alternatives écartées :**
- Hive : une base locale est disproportionnée pour un petit profil.

**Conséquences :** shared_preferences est déjà utilisé pour le splash du premier lancement. Ce stockage n'est pas chiffré : il ne contiendra jamais de token ni de secret. Avec les comptes, le token ira dans un stockage sécurisé.

### 10. Navigation Flutter

**Décision :** go_router.

**Alternatives écartées :**
- Navigator seul : suffisant aujourd'hui, mais la redirection selon le profil (RG-22) serait dispersée dans les écrans.
- Navigation GetX : écartée avec GetX (voir section 7).

**Conséquences :** les routes et la redirection vers l'onboarding sont centralisées. Les transitions existantes doivent être conservées : `RevelaPageRoute` sera à brancher dans go_router, et le passage du splash à l'application devra suivre le nouveau routeur.

### 11. Contrat d'API

**Décision :** OpenAPI généré depuis le code avec springdoc.

**Alternatives écartées :**
- Contrat écrit à la main avant le code : il risque de diverger du code, sans gain pour une seule développeuse.
- Pas de contrat formel : ce ne serait pas compatible avec la Definition of Done, qui exige un contrat à jour.

**Conséquences :** le contrat sert de documentation et de référence pour le mobile. Swagger UI devra être fermé ou protégé avant tout déploiement public.
