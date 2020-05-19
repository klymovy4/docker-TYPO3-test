docker-compose up --detach
docker exec php7-fpm             bash /bootstrap.sh
docker-compose ps
@echo Docker containers have been successfully started