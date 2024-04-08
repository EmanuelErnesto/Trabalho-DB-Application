CREATE DATABASE IF NOT EXISTS Casa_Adocao;
USE Casa_Adocao;

CREATE TABLE IF NOT EXISTS Endereco (
cep INT (8) UNSIGNED PRIMARY KEY NOT NULL,
bairro VARCHAR (255) NOT NULL,
cidade VARCHAR (255) NOT NULL,
estado VARCHAR (255) NOT NULL,
logradouro VARCHAR (255) NOT NULL,
num_casa SMALLINT(4) UNSIGNED NOT NULL

);

CREATE TABLE IF NOT EXISTS Estabelecimento (
cnpj BIGINT (14) UNSIGNED PRIMARY KEY NOT NULL,
nome_estab VARCHAR (255) NOT NULL,
cep_endereco INT (8) UNSIGNED NOT NULL,
FOREIGN KEY (cep_endereco) 
REFERENCES Endereco(cep) 

);

CREATE TABLE IF NOT EXISTS Tutor (
cod_tutor INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
nome_tutor VARCHAR (255) NOT NULL,
cpf BIGINT (11) UNSIGNED NOT NULL, 
idade SMALLINT (3) UNSIGNED NOT NULL,
email VARCHAR (255) NOT NULL,
cep_endereco INT (8) UNSIGNED NOT NULL,
FOREIGN KEY (cep_endereco)
REFERENCES Endereco(cep)

);

CREATE TABLE IF NOT EXISTS Animal (
cod_animal INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
idade_animal FLOAT (4) UNSIGNED NOT NULL,
apelido_ani VARCHAR (30) NOT NULL,
sexo CHAR (1) NOT NULL,
cor VARCHAR (255) NOT NULL,
castrado BOOLEAN NOT NULL,
tamanho CHAR (1) NOT NULL,
cod_estab BIGINT (14) UNSIGNED NOT NULL,
cod_tutor INT NOT NULL,
FOREIGN KEY (cod_estab)
REFERENCES Estabelecimento (cnpj),
FOREIGN KEY (cod_tutor)
REFERENCES Tutor (cod_tutor)

);

CREATE TABLE IF NOT EXISTS Cachorro (
cod_animal INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
raca_cachorro VARCHAR (255) NOT NULL,
FOREIGN KEY (cod_animal)
REFERENCES Animal (cod_animal)
);

CREATE TABLE IF NOT EXISTS Gato (
cod_animal INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
raca_gato VARCHAR (255) NOT NULL,
FOREIGN KEY (cod_animal)
REFERENCES Animal (cod_animal)

);

INSERT INTO Endereco (cep, bairro, cidade, estado, logradouro, num_casa) VALUES
(54780000, 'Centro', 'Recife', 'Pernambuco', 'Rua dos Bobos', 123),
(54780001, 'Boa Vista', 'Recife', 'Pernambuco', 'Avenida da Alegria', 456),
(54780002, 'Praia', 'Recife', 'Pernambuco', 'Rua da Paz', 789),
(54780003, 'Canas', 'Recife', 'Pernambuco', 'Beco da Esperança', 0),
(54780004, 'Ipanema', 'Recife', 'Pernambuco', 'Travessa do Sossego', 321);

INSERT INTO Estabelecimento (cnpj, nome_estab, cep_endereco) VALUES
(12345678000100, 'RecifeAdota+', 54780001);


INSERT INTO Tutor (nome_tutor, cpf, idade, email, cep_endereco) VALUES
('Ana Maria da Silva', 00011122233, 35, 'anamaria@gmail.com', 54780002),
('Mauron', 44455566677, 28, 'mauronbrocador@gmail.com', 54780000),
('Mr Big Data', 88899900011, 42, 'bigdataking@gmail.com', 54780003),
('Junin Ruindade Pura', 22233344455, 51, 'shaolinmatadorporco@outlook.com', 54780004),
('Kaian Mimijei', 55566677788, 25, 'trabalhanosolquente@hotmail.com', 54780001);

INSERT INTO Animal (idade_animal, apelido_ani, sexo, cor, castrado, tamanho, cod_estab, cod_tutor) VALUES
(2.5, 'Pipoca', 'F', 'Branco e Preto', 1, 'M', 12345678000100, 1),
(1.8, 'Juca', 'M', 'Caramelo', 0, 'P', 12345678000100, 2),
(4.2, 'Mimosa', 'F', 'Cinza', 1, 'M', 12345678000100, 3),
(0.8, 'Soneca', 'F', 'Amarelo', 0, 'P', 12345678000100, 4),
(6.7, 'Major', 'M', 'Preto', 1, 'G', 12345678000100, 5);


INSERT INTO Cachorro (cod_animal, raca_cachorro) VALUES
(1, 'SRD'),
(2, 'Poodle'),
(4, 'Yorkshire');

INSERT INTO Gato (cod_animal, raca_gato) VALUES
(3, 'Siamês'),
(5, 'Persa');


/* Query 1 - Retorna todos os animais, bem como o código e nome de seus tutores, 
   além de suas respectivas raças 

*/

SELECT Animal.*, 
       Tutor.nome_tutor,
       Cachorro.raca_cachorro,
       Gato.raca_gato
FROM Animal
INNER JOIN Tutor ON Animal.cod_tutor = Tutor.cod_tutor
LEFT JOIN Cachorro ON Animal.cod_animal = Cachorro.cod_animal
LEFT JOIN Gato ON Animal.cod_animal = Gato.cod_animal;


/* Query 2 - Encontra o nome do tutor de um animal específico

*/

SELECT Tutor.nome_tutor
FROM Animal
INNER JOIN Tutor ON Animal.cod_tutor = Tutor.cod_tutor
WHERE Animal.cod_animal = 5;


/* Query 3 - Obtém a quantidade de animais para cada tamanho (P, M, G)

*/

SELECT Animal.tamanho, COUNT(*) AS quantidade
FROM Animal
GROUP BY Animal.tamanho;

/* Query 4 - Retorna uma lista com todos os animais que foram castrados.

*/

SELECT Animal.*, Tutor.nome_tutor
FROM Animal
INNER JOIN Tutor ON Animal.cod_tutor = Tutor.cod_tutor
WHERE Animal.castrado = 1;

/* Query 5 - Retorna uma lista com todos os cachorros e suas reespectivas raças

*/

SELECT Animal.*, Cachorro.raca_cachorro
FROM Animal
INNER JOIN Cachorro ON Animal.cod_animal = Cachorro.cod_animal;

/* Query 6 - Retorna a raça de um gato específico, bem como o código do tutor,
   nome do tutor e o apelido do gato.
   
*/

SELECT Tutor.nome_tutor AS Nome_Tutor, 
        Animal.cod_tutor AS Cod_Tutor,
		Animal.apelido_ani AS Apelido_Ani,
		Gato.raca_gato AS Raca 
FROM Animal
INNER JOIN Gato ON Animal.cod_animal = Gato.cod_animal
INNER JOIN Tutor ON Animal.cod_tutor = Tutor.cod_tutor
WHERE Animal.cod_animal = 3;


/* Query 7 - Retorna os animais de um tutor específico, bem como o nome de seu respectivo tutor e código.

*/

SELECT Animal.*,
	   Tutor.nome_tutor AS Nome_Tutor
FROM Animal
INNER JOIN Tutor ON Animal.cod_tutor = Tutor.cod_tutor
WHERE Animal.cod_tutor = 4;

/* Query 8 - Retorna todos os animais que não foram castrados 

*/

SELECT Animal.*
FROM Animal
WHERE Animal.castrado = 0;

/* Query 9 - Retorna o endereço do estabelecimento

*/

SELECT Endereco.* 
FROM Estabelecimento
INNER JOIN Endereco ON  Estabelecimento.cep_endereco = Endereco.cep;

/* Query 10 - Lista todos os animais do sexo feminino e sua cor

*/

SELECT Animal.apelido_ani,
	   Animal.cor
FROM Animal
WHERE Animal.sexo = 'F'