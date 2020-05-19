docker-compose down
git fetch
git pull

docker-compose up -d --build
docker exec mysql_5.7 sh /opt/create_db_users.sh
docker exec php7-fpm bash /bootstrap.sh
docker restart mysql_5.7
docker-compose ps
@echo Docker Updated!