FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=root

COPY ./Casa_Adocao.sql /docker-entrypoint-initdb.d/

