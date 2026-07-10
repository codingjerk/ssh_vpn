default:
    @just --list

start:
    docker compose up -d

stop:
    docker compose down

restart:
    docker compose restart

status:
    docker compose ps
    docker compose logs --tail 20

logs:
    docker compose logs --tail 100 -f

add-user name:
    ./scripts/add-user.sh {{name}}
