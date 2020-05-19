FROM nginx:latest

# Copy custom configuration
COPY config/nginx.conf /etc/nginx/
COPY hosts/typo3.nginx /etc/nginx/sites-available/

RUN rm /etc/nginx/conf.d/default.conf

RUN apt-get update && apt-get install -y \
    curl \
    git \
    nano

RUN usermod -u 1000 www-data
