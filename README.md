# Supabase Self-Hosted

Plateforme backend open source complète avec base de données Postgres, authentification, stockage de fichiers et API temps réel.

## Fonctionnalités

- **Base de données Postgres 15** avec extensions
- **Authentification JWT** (GoTrue)
- **API REST automatique** (PostgREST)
- **Stockage de fichiers** avec gestion des permissions
- **WebSockets temps réel** pour les mises à jour en direct
- **Interface d'administration** (Studio)
- **Métadonnées Postgres** pour la gestion du schéma
- **API Gateway** (Kong) pour le routage

## Prérequis

- Docker et Docker Compose
- 2 Go de RAM minimum (4 Go recommandé)
- 10 Go d'espace disque

## Installation

1. Clonez ce template
2. Copiez `.env.example` vers `.env` et configurez les variables
3. Démarrez avec `docker-compose up -d`

## Variables d'environnement

| Variable | Requise | Description | Valeur par défaut |
|----------|---------|-------------|-------------------|
| DB_PASSWORD | Oui | Mot de passe pour tous les rôles Postgres | `supabase` |
| JWT_SECRET | Oui | Secret JWT (min 32 caractères) | généré |
| ANON_KEY | Oui | Clé JWT pour rôle anonyme | généré |
| SERVICE_ROLE_KEY | Oui | Clé JWT pour rôle service | généré |
| API_EXTERNAL_URL | Oui | URL publique de l'API | `https://votre-domaine.com/supabase` |
| SITE_URL | Oui | URL du frontend | `https://votre-domaine.com` |
| SMTP_HOST | Non | Serveur SMTP | - |
| SMTP_PORT | Non | Port SMTP | `587` |
| SMTP_USER | Non | Utilisateur SMTP | - |
| SMTP_PASS | Non | Mot de passe SMTP | - |

## Services

### Services principaux (toujours démarrés)

1. **db** - Base de données Postgres (port 5432)
2. **kong** - API Gateway (port 8000)
3. **auth** - Authentification (port 9999)
4. **rest** - API REST (port 3000)
5. **storage** - Stockage fichiers (port 5000)
6. **realtime** - Temps réel (port 4000)
7. **meta** - Métadonnées (port 8080)

### Services optionnels (profils Docker)

- **studio** - Interface d'administration
- **analytics** - Analyse des logs
- **vector** - Traitement des logs
- **imgproxy** - Optimisation d'images

Pour démarrer avec un service optionnel :
```bash
docker-compose --profile studio up -d
```

## Accès après installation

- **Studio** : https://votre-domaine.com/studio/
- **API** : https://votre-domaine.com/supabase/
- **Documentation API** : https://votre-domaine.com/supabase/rest/v1/
- **Santé auth** : https://votre-domaine.com/supabase/auth/v1/health

## Volumes persistants

- `./volumes/db/data` - Données Postgres
- `./volumes/storage` - Fichiers uploadés
- `./volumes/api/kong.yml` - Configuration Kong

## Configuration Nginx (Hamayni)

Le template configure automatiquement :
- `/supabase/*` → Kong (127.0.0.1:8000)
- `/studio/*` → Studio (127.0.0.1:3000)

## Sécurité

- Tous les mots de passe sont générés automatiquement
- JWT secrets doivent avoir au moins 32 caractères
- Connexions SMTP recommandées pour la production
- Health checks sur tous les services

## Dépannage

### Vérifier l'état des services
```bash
docker-compose ps
docker-compose logs [service]
```

### Redémarrer un service
```bash
docker-compose restart [service]
```

### Accéder à la base de données
```bash
docker exec -it supabase_db psql -U postgres
```

## Ressources

- [Documentation Supabase](https://supabase.com/docs)
- [Guide d'auto-hébergement](https://supabase.com/docs/guides/self-hosting)
- [Référence API](https://supabase.com/docs/reference)

## Licence

MIT - Basé sur Supabase Open Source