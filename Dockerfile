FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=root

# COPY ./Casa_Adocao.sql /docker-entrypoint-initdb.d/
COPY ./db_Faculdade.sql /docker-entrypoint-initdb.d/
