/*Projeto Final Completo da Disciplina Banco de Dados da UnB
Alunos: Davi Martinez e Eduardo Lafetá*/

CREATE DATABASE `Projeto_BD`;
USE `Projeto_BD` ;

CREATE TABLE `serie` (
  `Série` VARCHAR(45) NOT NULL,
  `Turma` VARCHAR(45) NOT NULL,
  `Turno` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Série`, `Turma`));


CREATE TABLE `aluno` (
  `Cod_Aluno` INT NOT NULL,
  `Nome` VARCHAR(255) NOT NULL,
  `Sobrenome` VARCHAR(255) NOT NULL,
  `Internet_em_casa` VARCHAR(45) NOT NULL,
  `Série` VARCHAR(45) NOT NULL,
  `Turma` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cod_Aluno`),
  INDEX `Turma_idx` (`Turma` ASC) ,
  INDEX `fk_aluno_serie1_idx` (`Série` ASC) );

CREATE TABLE `email_aluno` (
  `Email` VARCHAR(255) NOT NULL,
  `Cod_Aluno` INT NOT NULL,
  PRIMARY KEY (`Email`, `Cod_Aluno`),
  INDEX `Matricula_idx` (`Cod_Aluno` ASC) ,
  CONSTRAINT `Matricula`
    FOREIGN KEY (`Cod_Aluno`)
    REFERENCES `Projeto_BD`.`aluno` (`Cod_Aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `professor` (
  `Cod_Professor` INT NOT NULL,
  `Nome` VARCHAR(255) NOT NULL,
  `Sobrenome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Cod_Professor`));

CREATE TABLE `disciplina` (
  `Cod_Disciplina` INT NOT NULL,
  `Cod_Professor` INT NOT NULL,
  `Série` VARCHAR(255) NOT NULL,
  `Nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Cod_Disciplina`, `Cod_Professor`, `Série`),
  INDEX `Cod_Professor_idx` (`Cod_Professor` ASC) ,
  INDEX `Série_idx` (`Série` ASC) ,
  CONSTRAINT `Cod_Professor`
    FOREIGN KEY (`Cod_Professor`)
    REFERENCES `Projeto_BD`.`professor` (`Cod_Professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Série`
    FOREIGN KEY (`Série`)
    REFERENCES `Projeto_BD`.`serie` (`Série`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
  
CREATE TABLE `aula` (
  `Cod_Disciplina` INT NOT NULL,
  `Plataforma` VARCHAR(255) NOT NULL,
  `Atividades` VARCHAR(255) NULL,
  `professor_Cod_Professor` INT NOT NULL,
  PRIMARY KEY (`Cod_Disciplina`, `professor_Cod_Professor`),
  INDEX `fk_aula_professor1_idx` (`professor_Cod_Professor` ASC) ,
  CONSTRAINT `fk_aula_professor1`
    FOREIGN KEY (`professor_Cod_Professor`)
    REFERENCES `Projeto_BD`.`professor` (`Cod_Professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cod_Disciplina`
    FOREIGN KEY (`Cod_Disciplina`)
    REFERENCES `Projeto_BD`.`disciplina` (`Cod_Disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `quadro_de_notas` (
  `Cod_Aluno` INT NOT NULL,
  `Cod_Disciplina` INT NOT NULL,
  `Cod_Professor` INT NOT NULL,
  `Nota` INT NOT NULL,
  PRIMARY KEY (`Cod_Aluno`, `Cod_Disciplina`, `Cod_Professor`),
  INDEX `Cod_Disciplina_idx` (`Cod_Disciplina` ASC) ,
  INDEX `Cod_Professor_idx` (`Cod_Professor` ASC) ,
  CONSTRAINT `Cod_Aluno`
    FOREIGN KEY (`Cod_Aluno`)
    REFERENCES `Projeto_BD`.`aluno` (`Cod_Aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cod_Disciplina1`
    FOREIGN KEY (`Cod_Disciplina`)
    REFERENCES `Projeto_BD`.`disciplina` (`Cod_Disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cod_Professor1`
    FOREIGN KEY (`Cod_Professor`)
    REFERENCES `Projeto_BD`.`professor` (`Cod_Professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `documentação` (
  `Cod_Solicitação` INT NOT NULL,
  `Data_gerado` DATE NOT NULL,
  `Validade` DATE NOT NULL,
  `Atendimento` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Cod_Solicitação`));
  
CREATE TABLE `secretaria` (
  `Cod_Solicitação` INT NOT NULL,
  `Resultado` VARCHAR(255) NOT NULL,
  `Cod_Professor_Solicitante` INT NULL,
  `Cod_Aluno_Solicitante` INT NULL,
  PRIMARY KEY (`Cod_Solicitação`),
  INDEX `Cod_Solicitação_idx` (`Cod_Solicitação` ASC) ,
  INDEX `Cod_Aluno_idx` (`Cod_Aluno_Solicitante` ASC) ,
  CONSTRAINT `Cod_Professor2`
    FOREIGN KEY (`Cod_Professor_Solicitante`)
    REFERENCES `Projeto_BD`.`professor` (`Cod_Professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cod_Aluno1`
    FOREIGN KEY (`Cod_Aluno_Solicitante`)
    REFERENCES `Projeto_BD`.`aluno` (`Cod_Aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cod_Solicitação`
    FOREIGN KEY (`Cod_Solicitação`)
    REFERENCES `Projeto_BD`.`documentação` (`Cod_Solicitação`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `email_professor` (
  `Email` VARCHAR(255) NOT NULL,
  `Cod_Professor` INT NOT NULL,
  PRIMARY KEY (`Email`, `Cod_Professor`),
  INDEX `Cod_Professor_idx` (`Cod_Professor` ASC) ,
  CONSTRAINT `Cod_Professor3`
    FOREIGN KEY (`Cod_Professor`)
    REFERENCES `Projeto_BD`.`professor` (`Cod_Professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `horario` (
  `Horario` TIME NOT NULL,
  `Cod_Disciplina` INT NOT NULL,
  PRIMARY KEY (`Horario`, `Cod_Disciplina`),
  CONSTRAINT `Cod_Disciplina2`
    FOREIGN KEY (`Cod_Disciplina`)
    REFERENCES `Projeto_BD`.`disciplina` (`Cod_Disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `data` (
  `Data` DATE NOT NULL,
  `Cod_Disciplina` INT NOT NULL,
  PRIMARY KEY (`Data`, `Cod_Disciplina`),
  CONSTRAINT `Cod_Disciplina3`
    FOREIGN KEY (`Cod_Disciplina`)
    REFERENCES `Projeto_BD`.`disciplina` (`Cod_Disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `presença` (
  `Cod_Disciplina` INT NOT NULL,
  `Cod_Aluno` INT NOT NULL,
  `Data_Aula` DATE NOT NULL,
  `Presença` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cod_Disciplina`, `Cod_Aluno`),
  CONSTRAINT `Cod_Disciplina4`
    FOREIGN KEY (`Cod_Disciplina`)
    REFERENCES `Projeto_BD`.`aula` (`Cod_Disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cod_Aluno2`
    FOREIGN KEY (`Cod_Aluno`)
    REFERENCES `Projeto_BD`.`aluno` (`Cod_Aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
 
 /*POVOANDO - Para inserir os dados utilizamos os comandos abaixo:*/
 
 insert into serie(Série, Turma, Turno)
 values ("1º","A","Matutino"), ("1º","B","Matutino"), ("1º","C","Vespertino"), ("1º","D","Vespertino"), 
 ("2º","A","Matutino"), ("2º","B","Matutino"), ("2º","C","Vespertino"), ("2º","D","Vespertino"),
 ("3º","A","Matutino"), ("3º","B","Matutino"), ("3º","C","Vespertino"), ("3º","D","Vespertino");
 
insert into aluno(Cod_Aluno, Nome, Sobrenome, Internet_em_casa, Série, Turma) 
values(1234, "João", "da Silva", "Sim", "3º", "A"), (1235, "Maria", "da Dores", "Não", "2º", "B"), 
(1236, "José", "Carneiro", "Sim", "1º", "B"), (1237, "Lourdes", "da Conceição", "Não", "3º", "C"), 
(1238, "Michel", "Jordão", "Sim", "2º", "D") ;
 
 insert into email_aluno(Email, Cod_Aluno) 
 values ("joaodasilva@gmail.com", 1234), ("mariadasdores@gmail.com", 1235), 
("zecarneiro@#yahoo.com", 1236),("lourdinhaconceicao@yahoo.com", 1237),("micheljordao@uol.com.br",1238); 
 
insert into professor(Cod_Professor, Nome, Sobrenome) 
values (915, "Gilmar", "Tomate"), (916, "Alexandre", "Pimenta"),
(917, "Carmen", "Cebola"), (918, "Celso", "Alface"), (919, "Marco", "Cenoura");

insert into disciplina(Cod_Disciplina, Cod_Professor, Série, Nome) 
values(121510, 915, "3º", "Português"), (121511, 916, "2º", "Matemática"),
(121512, 917, "1º", "Quimica"),
(121513, 918, "2º", "Filosofia"), (121514, 919, "3º", "Física") ;
 
insert into aula(Cod_Disciplina, Plataforma, Atividades, professor_Cod_Professor) 
values(121510, "Moodle", "Síncrona", 915), (121511, "Aprender", "Assíncrona", 916), 
(121512, "Google Classroom", "Síncrona", 917), (121513, "Teams", "Assíncrona", 918), 
(121514, "Moodle", "Assíncrona", 919) ;
 
insert into quadro_de_notas(Cod_Aluno, Cod_Disciplina, Cod_Professor, Nota) 
values(1234, 121510, 915, 7.8), (1235, 121511, 916, 5.3), (1236, 121512, 917, 4.2),
(1238, 121513, 918, 8.5), (1237, 121514, 919, 4.0) ;

insert into documentação(Cod_Solicitação, Data_gerado, Validade, Atendimento) 
values(1010, '2020-05-01', '2020-12-31', "comprovante de matrícula"), 
(1015, '2020-05-03', '2020-12-31', "Entrega de atestado"), 
(1020, '2020-05-15', '2020-12-31', "Histórico Escolar"),
(1030, '2020-06-01', '2020-12-31', "Comprovante de Renda"),
(1040, '2020-06-15', '2020-12-31', "Registro de Folga Eleitoral") ;

insert into secretaria(Cod_Solicitação, Resultado, Cod_Professor_Solicitante, Cod_Aluno_Solicitante) 
values(1010,"Atendido",null,1234), (1015,"Em análise",null,1235), (1020,"Em análise",null,1236),
(1030,"Em análise",915,null), (1040,"Em análise",916,null);

insert into email_professor(Email, Cod_Professor) 
values ("tomate@gmail.com", 915), ("pimenta@gmail.com", 916), 
("carmencebola@#yahoo.com", 917),("alface@yahoo.com", 918),
("cenoura@uol.com.br",919); 

insert into horario(horario, Cod_Disciplina) 
values ('08:00:00', 121510), ('16:00:00', 121511), 
('10:00:00', 121512), ('19:00:00', 121513),
('21:00:00', 121514);
 
insert into data(data, Cod_Disciplina) 
values ('2020-01-01', 121510), ('2020-01-01', 121511), 
('2020-06-01', 121512), ('2020-09-01', 121513),
('2020-06-01', 121514);
 
insert into presença(Cod_Disciplina, Cod_Aluno, Data_Aula, Presença) 
values (121510, 1234, '2020-03-15', "Presente"), (121511, 1235, '2020-04-03', "Faltou"), 
(121513, 1238, '2020-09-03', "Faltou"), (121512, 1237, '2020-07-03', "Presente"),
(121514, 1235, '2020-10-15', "Presente");


/*ALGEBRA RELACIONAL - a seguir comandos em álgebra relacional*/

select a.Nome, q.nota, d.nome as nome_disciplina from aluno as a
join quadro_de_notas as q
on a.Cod_aluno = q.Cod_aluno
join disciplina as d
on q.Cod_disciplina = d.Cod_disciplina;

select * from disciplina
join data 
on disciplina.Cod_disciplina = data.Cod_disciplina
join horario
on disciplina.Cod_disciplina = horario.Cod_disciplina;

select professor.nome, email_professor.*, disciplina.nome as nome_disiplina from professor
join email_professor
on professor.Cod_professor = email_professor.Cod_professor
join disciplina
on professor.Cod_professor = disciplina.Cod_professor
order by professor.nome;

select aluno.nome, presença.data_aula, presença.presença, disciplina.nome from aluno
join presença
on aluno.cod_aluno = presença.cod_aluno
join disciplina
on presença.cod_disciplina = disciplina.cod_disciplina;

select aluno.nome, documentação.atendimento, secretaria.resultado  from aluno 
join secretaria
on aluno.cod_aluno = secretaria.cod_aluno_solicitante
join documentação
on secretaria.cod_solicitação = documentação.cod_solicitação;

/*VIEW - a view abaixo tem o objetivo de subsidiar a tomada de decisão em relação aos alunos 
que ficaram com notas inferiores a 5 e tem o curzamento de dados com a tabela email, ou seja, já pode 
ser enviado um e-mail para os alunos que tiraram notas não satisfatórias.*/

Create or replace View vw_aprovados AS
Select quadro_de_notas.Nota, quadro_de_notas.Cod_Aluno, email_aluno.Email 
from quadro_de_notas Inner Join email_aluno on quadro_de_notas.Cod_Aluno = email_aluno.Cod_Aluno
where Nota < 5;
select * from vw_aprovados;

/*PROCEDURE - verificar os documentos que contém mais de 200 dias da data de entrada, para permitir ao gestor verificar 
como anda o prazo de atendimento das demandas.*/

create procedure pr_tempo_solicitação (Tempo int)
select documentação.Cod_Solicitação, secretaria.Resultado
from documentação inner join secretaria on documentação.Cod_Solicitação = secretaria.Cod_Solicitação
where TIMESTAMPDIFF (DAY, DATA_GERADO, CURRENT_DATE) >= Tempo;
call pr_tempo_solicitação (200);
*/
 
 
