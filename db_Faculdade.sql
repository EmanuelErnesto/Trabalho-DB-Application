CREATE DATABASE IF NOT EXISTS Faculdade;
USE Faculdade;

CREATE TABLE IF NOT EXISTS Endereco (
cep BIGINT (11) UNSIGNED PRIMARY KEY NOT NULL,
bairro VARCHAR (255) NOT NULL,
cidade VARCHAR (255) NOT NULL,
estado VARCHAR (255) NOT NULL,
logradouro VARCHAR (255) NOT NULL

);

CREATE TABLE IF NOT EXISTS Faculdade (
cnpj_faculdade BIGINT (14) UNSIGNED PRIMARY KEY,
nome_faculdade VARCHAR (255) NOT NULL,
cep_facul BIGINT (11) UNSIGNED NOT NULL,
FOREIGN KEY (cep_facul)
REFERENCES Endereco(cep)

);


CREATE TABLE IF NOT EXISTS Funcionario (
matric_funcionario INT (8) UNSIGNED PRIMARY KEY NOT NULL,
nome_func VARCHAR (255) NOT NULL,
idade_func SMALLINT (3) UNSIGNED NOT NULL,
data_nasc_func DATE NOT NULL,
cpf_func BIGINT (11) UNSIGNED NOT NULL,
salario_func FLOAT (6) UNSIGNED NOT NULL,
email_func VARCHAR (255) NOT NULL,
turno_func VARCHAR (7) NOT NULL,
cod_faculdade BIGINT (14) UNSIGNED NOT NULL,
ender_funcionario BIGINT (11) UNSIGNED NOT NULL,
FOREIGN KEY (cod_faculdade)
REFERENCES Faculdade (cnpj_faculdade),
FOREIGN KEY (ender_funcionario)
REFERENCES Endereco (cep)
);

CREATE TABLE IF NOT EXISTS Administrativo (
matric_administrativo INT (8) UNSIGNED NOT NULL,
nome_setor VARCHAR (255) NOT NULL,
FOREIGN KEY (matric_administrativo) 
REFERENCES Funcionario (matric_funcionario)

);

CREATE TABLE IF NOT EXISTS Professor (
matric_professor INT (8) UNSIGNED PRIMARY KEY NOT NULL,
titulacao VARCHAR (255) NOT NULL,
area_expertise VARCHAR (255) NOT NULL

);

CREATE TABLE IF NOT EXISTS Curso (
cod_curso INT AUTO_INCREMENT PRIMARY KEY,
nome_curso VARCHAR (255) NOT NULL,
carga_horaria INT (4) UNSIGNED NOT NULL,
descricao VARCHAR (255) NOT NULL,
qtd_semestres SMALLINT (2) UNSIGNED NOT NULL,
cod_faculdade BIGINT (14) UNSIGNED NOT NULL,
FOREIGN KEY (cod_faculdade)
REFERENCES Faculdade (cnpj_faculdade)

);

CREATE TABLE IF NOT EXISTS Semestre (
num_semestre INT (3) UNSIGNED PRIMARY KEY NOT NULL

);

CREATE TABLE IF NOT EXISTS Disciplina (
cod_disciplina INT AUTO_INCREMENT PRIMARY KEY,
nome_disciplina VARCHAR (255) NOT NULL,
carga_horaria_disciplina SMALLINT (4) UNSIGNED NOT NULL

);

CREATE TABLE IF NOT EXISTS Turma (
cod_turma INT AUTO_INCREMENT PRIMARY KEY,
nome_turma VARCHAR (255) NOT NULL,
turno_turma VARCHAR (255) NOT NULL,
ano_letivo FLOAT (6) UNSIGNED NOT NULL,
num_semestre INT(3) UNSIGNED NOT NULL,
FOREIGN KEY (num_semestre)
REFERENCES Semestre(num_semestre)
);

CREATE TABLE IF NOT EXISTS Curso_Semestre_Disciplina (
cod_curso INT NOT NULL,
num_semestre INT (3) UNSIGNED NOT NULL,
cod_disciplina INT NOT NULL,
FOREIGN KEY (cod_curso)
REFERENCES Curso(cod_curso),
FOREIGN KEY (num_semestre)
REFERENCES Semestre (num_semestre),
FOREIGN KEY (cod_disciplina)
REFERENCES Disciplina (cod_disciplina)

);


CREATE TABLE IF NOT EXISTS Professor_Disciplina_Turma_Semestre (
matric_professor INT (8) UNSIGNED NOT NULL,
cod_disciplina INT NOT NULL,
cod_turma INT NOT NULL,
num_semestre INT (3) UNSIGNED NOT NULL,
FOREIGN KEY (matric_professor)
REFERENCES Professor(matric_professor),
FOREIGN KEY (cod_disciplina)
REFERENCES Disciplina (cod_disciplina),
FOREIGN KEY (cod_turma) 
REFERENCES Turma (cod_turma),
FOREIGN KEY (num_semestre)
REFERENCES Semestre (num_semestre)
); 


CREATE TABLE IF NOT EXISTS Aluno (
matric_aluno INT (9) UNSIGNED PRIMARY KEY NOT NULL,
nome_aluno VARCHAR (255) NOT NULL,
idade_aluno INT (3) UNSIGNED NOT NULL,
cpf_aluno BIGINT (11) UNSIGNED NOT NULL,
data_nasc_aluno DATE NOT NULL,
cep_aluno BIGINT (11) UNSIGNED NOT NULL,
cod_turma INT NOT NULL,
cod_curso INT NOT NULL,
cod_faculdade BIGINT (14) UNSIGNED,
FOREIGN KEY (cep_aluno)
REFERENCES Endereco (cep),
FOREIGN KEY (cod_turma)
REFERENCES Turma (cod_turma),
FOREIGN KEY (cod_curso)
REFERENCES Curso (cod_curso),
FOREIGN KEY (cod_faculdade)
REFERENCES Faculdade (cnpj_faculdade)

);

CREATE TABLE IF NOT EXISTS Aluno_Disciplina (
matric_aluno INT (9) UNSIGNED NOT NULL,
cod_disciplina INT NOT NULL,
FOREIGN KEY (matric_aluno)
REFERENCES Aluno (matric_aluno),
FOREIGN KEY (cod_disciplina)
REFERENCES Disciplina (cod_disciplina)

);

CREATE TABLE IF NOT EXISTS Nota (
matric_aluno INT (9) UNSIGNED NOT NULL,
cod_disciplina INT NOT NULL,
valor_nota FLOAT (5) UNSIGNED NOT NULL,
FOREIGN KEY (matric_aluno)
REFERENCES Aluno (matric_aluno),
FOREIGN KEY (cod_disciplina)
REFERENCES Disciplina (cod_disciplina)

);

CREATE TABLE IF NOT EXISTS Telefone (
matric_aluno INT (9) UNSIGNED NOT NULL,
numero_telefone BIGINT (9) UNSIGNED NOT NULL,
FOREIGN KEY (matric_aluno)
REFERENCES Aluno (matric_aluno)

);

CREATE TABLE IF NOT EXISTS Filiacao (
matric_aluno INT (9) UNSIGNED NOT NULL,
tipo_parentesco VARCHAR (255), 
nome_parente VARCHAR (255),
idade_parente INT (3) UNSIGNED NOT NULL,
cpf_parente BIGINT (11) NOT NULL,
email_parente VARCHAR (255) NOT NULL,
telefone_parente BIGINT (9) UNSIGNED NOT NULL,
trabalho_parente VARCHAR (255) NOT NULL,
renda_anual_parente FLOAT (9) UNSIGNED NOT NULL,
FOREIGN KEY (matric_aluno)
REFERENCES Aluno (matric_aluno)

);



INSERT INTO Endereco (cep, bairro, cidade, estado, logradouro) VALUES
(01001000, 'Sé', 'São Paulo', 'SP', 'Praça da Sé, s/n'),
(01046000, 'Consolação', 'São Paulo', 'SP', 'Rua da Consolação, 944'),
(04004002, 'Pinheiros', 'São Paulo', 'SP', 'Rua Teodoro Sampaio, 642'),
(05424000, 'Itaim Bibi', 'São Paulo', 'SP', 'Rua Joaquim Távora, 1241'),
(02548000, 'Vila Madalena', 'São Paulo', 'SP', 'Rua Heitor Penteado, 555');


INSERT INTO Faculdade (cnpj_faculdade, nome_faculdade, cep_facul) VALUES
(12345678987654,'Uninassau', 02548000);

INSERT INTO Funcionario (matric_funcionario, nome_func, idade_func, data_nasc_func, cpf_func, salario_func, email_func, turno_func, cod_faculdade, ender_funcionario) VALUES
(12345678, 'João da Silva', 35, '1989-01-01', 11111111111, 3500.00, 'joao.silva@usp.br', 'Manhã', 12345678987654, 01001000),
(87654321, 'Maria Oliveira', 42, '1982-07-14', 22222222222, 4200.50, 'maria.oliveira@usp.br', 'Tarde', 12345678987654, 01046000),
(99887766, 'Carlos Santos', 28, '1996-03-21', 33333333333, 2800.75, 'carlos.santos@usp.br', 'Noite', 12345678987654, 04004002),
(11223344, 'Ana Souza', 50, '1974-10-25', 44444444444, 5000.25, 'ana.souza@usp.br', 'Manhã', 12345678987654, 02548000),
(55667788, 'Pedro Pereira', 30, '1994-05-12', 55555555555, 3200.00, 'pedro.pereira@usp.br', 'Tarde', 12345678987654,  01046000);

INSERT INTO Administrativo (matric_administrativo, nome_setor) VALUES
(12345678, 'Secretaria');

INSERT INTO Professor (matric_professor, titulacao, area_expertise) VALUES
(87654321, 'Mestre', 'Ciência da Computação'),
(55667788, 'Doutor', 'Estatística');


INSERT INTO Curso (nome_curso, carga_horaria, descricao, qtd_semestres, cod_faculdade) VALUES
('Direito', 4000, 'Formação de profissionais aptos a atuar na área jurídica.', 10, 12345678987654),
('Medicina', 12000, 'Formação de profissionais aptos a atuar na área médica.', 12, 12345678987654),
('Engenharia Civil', 5000, 'Formação de profissionais aptos a projetar e construir obras civis.', 10, 12345678987654),
('Administração', 4000, 'Formação de profissionais aptos a gerenciar empresas e organizações.', 8, 12345678987654),
('Ciências da Computação', 4000, 'Formação de profissionais aptos a desenvolver softwares e sistemas computacionais.', 8, 12345678987654);

INSERT INTO Semestre (num_semestre) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12);

INSERT INTO Turma (nome_turma, num_semestre, turno_turma, ano_letivo) VALUES
('1NA', 1, 'Noturno', 2024.1),
('1NB', 1, 'Noturno', 2024.1),
('1NC', 1, 'Noturno', 2024.1),
('3NB', 2, 'Noturno', 2024.1),
('3NC', 2, 'Noturno', 2024.1);

INSERT INTO Aluno (matric_aluno, nome_aluno, idade_aluno, cpf_aluno, data_nasc_aluno, cep_aluno, cod_turma, cod_curso, cod_faculdade) VALUES
(111222333, 'Ana Rodrigues', 21, 33333333333, '2003-05-10', 04004002, 1, 1, 12345678987654),
(444555666, 'Pedro Souza', 23, 44444444444, '1999-11-25', 01001000, 2, 2, 12345678987654),
(777888999, 'Mariana Santos', 20, 55555555555, '2004-09-18', 02548000, 1, 1, 12345678987654),
(123123123, 'Lucas Oliveira', 22, 66666666666, '2000-02-28', 02548000, 2, 2, 12345678987654),
(456456456, 'Juliana Lima', 24, 77777777777, '1998-07-07', 01001000, 1, 1, 12345678987654);

INSERT INTO Telefone (matric_aluno, numero_telefone) VALUES
(111222333, 123456789),
(777888999, 987654321);

INSERT INTO Filiacao (matric_aluno, tipo_parentesco, nome_parente, idade_parente, cpf_parente, email_parente, telefone_parente, trabalho_parente, renda_anual_parente) VALUES
(777888999, 'Pai', 'José', 50, 12345678900, 'jose@example.com', 123456789, 'Engenheiro', 100000),
(777888999, 'Mãe', 'Maria', 45, 98765432100, 'maria@example.com', 987654321, 'Médica', 120000);


INSERT INTO Disciplina (nome_disciplina, carga_horaria_disciplina) VALUES
('Introdução ao Direito', 60),
('Anatomia Humana', 80),
('Cálculo I', 60),
('Fundamentos de Administração', 60),
('Programação de Computadores I', 60),
('Direito Constitucional', 60),
('Fisiologia Humana', 80),
('Cálculo II', 60),
('Gestão de Projetos', 60),
('Banco de Dados', 60);


INSERT INTO Curso_Semestre_Disciplina  (cod_curso ,num_semestre,cod_disciplina) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(1, 5, 6),
(2, 3, 7),
(3, 2, 8),
(4, 7, 9),
(5, 1, 10);


INSERT INTO Professor_Disciplina_Turma_Semestre (matric_professor, cod_disciplina, cod_turma, num_semestre) VALUES
(87654321, 5, 3, 1),
(55667788, 9, 3, 1),
(87654321, 10, 2, 1),
(55667788, 8, '2', 2),
(87654321, 7, '1', 2);


/* Query 1 - Retorna todos os endereços de faculdades

*/

SELECT Endereco.*
FROM Faculdade
INNER JOIN Endereco ON Faculdade.cep_facul = Endereco.cep;

/* Query 2 - Retorna o endereço de uma faculdade específica

*/

SELECT Endereco.*
FROM Faculdade
INNER JOIN Endereco ON Faculdade.cep_facul = Endereco.cep
WHERE Faculdade.nome_faculdade = 'Uninassau';

/* Query 3 - Retorna todos os funcionários com seus respectivos endereços

*/

SELECT Funcionario.*, Endereco.*
FROM Funcionario
INNER JOIN Endereco ON Funcionario.ender_funcionario = Endereco.cep;


/* Query 4 - Retorna todos os professores com seus respectivos endereços

*/

SELECT Professor.*, Endereco.*, Funcionario.*
FROM Professor
INNER JOIN Funcionario ON Professor.matric_professor = Funcionario.matric_funcionario
INNER JOIN Endereco ON Funcionario.ender_funcionario = Endereco.cep;



/* Query 5 - Retorna todas as filiações cadastradas, bem como o aluno ao qual a filiação está cadastrada. */

SELECT Aluno.*, Filiacao.*
FROM Filiacao
INNER JOIN Aluno ON Filiacao.matric_aluno = Aluno.matric_aluno;


/* Query 6 - Retorna todos os cursos com informações sobre as disciplinas e semestres associados */

SELECT Curso.*, Disciplina.*, Semestre.*
FROM Curso
INNER JOIN Curso_Semestre_Disciplina ON Curso.cod_curso = Curso_Semestre_Disciplina.cod_curso
INNER JOIN Disciplina ON Curso_Semestre_Disciplina.cod_disciplina = Disciplina.cod_disciplina
INNER JOIN Semestre ON Curso_Semestre_Disciplina.num_semestre = Semestre.num_semestre;



/* Query 7 - Retorna todos os alunos

*/

SELECT *
FROM Aluno;

/* Query 8 - Listar os cursos oferecidos pela faculdade juntamente com o número de disciplinas associadas a cada curso  

*/

SELECT Curso.nome_curso, COUNT(Curso_Semestre_Disciplina.cod_disciplina) AS disciplinas_associadas
FROM Curso
LEFT JOIN Curso_Semestre_Disciplina ON Curso.cod_curso = Curso_Semestre_Disciplina.cod_curso
GROUP BY Curso.cod_curso;

/* Query 9 - Listar os professores que ministram disciplinas no primeiro semestre e o
   turno das turmas em que as disciplinas são ministradas

*/

SELECT Professor.*, Disciplina.nome_disciplina, Turma.turno_turma
FROM Professor
INNER JOIN Professor_Disciplina_Turma_Semestre ON Professor.matric_professor = Professor_Disciplina_Turma_Semestre.matric_professor
INNER JOIN Disciplina ON Professor_Disciplina_Turma_Semestre.cod_disciplina = Disciplina.cod_disciplina
INNER JOIN Turma ON Professor_Disciplina_Turma_Semestre.cod_turma = Turma.cod_turma
INNER JOIN Semestre ON Professor_Disciplina_Turma_Semestre.num_semestre = Semestre.num_semestre
WHERE Semestre.num_semestre = 1;


/* Query 10 - Listar todos os alunos e suas informações de contato

*/

SELECT Aluno.*, Telefone.numero_telefone
FROM Aluno
LEFT JOIN Telefone ON Aluno.matric_aluno = Telefone.matric_aluno;

