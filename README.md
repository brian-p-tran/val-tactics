# val-tactics

## Installation Instructions

Required:

* Java 17
* Maven
* Docker
* PostgreSQL Docker Image

```bash
    docker pull postgres
```

1. Clone Github Repo

2. Compose Postgres Container
```bash
    docker-compose up -d
```
3. (Optional) Use psql terminal
```bash
    docker exec -it database-postgres-1 psql -U admin -d val_tactics
```
