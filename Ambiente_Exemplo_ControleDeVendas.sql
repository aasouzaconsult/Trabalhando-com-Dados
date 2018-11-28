-------------------------
-- Exemplo do Trabalho --
-------------------------

-- Criar o banco de dados: DB_ControleVendas
-- create database DB_ControleVendas

use DB_ControleVendas;

create table TB_Cliente (
   idCli      int          identity(1,1) primary key
,  nmCli      varchar(100)
,  CPF        varchar(15)  unique
,  Tel        varchar(15)
,  Email      varchar(100)
,  Logradouro varchar(100)
,  CEP        varchar(8)
,  Bairro     varchar(50)
,  Cidade     varchar(50)
,  Estado     varchar(50)
) -- Drop table TB_Cliente

create table TB_Vendedor (
   idVen int identity(1,1) primary key
,  nmVen varchar(100)
) -- Drop table TB_Vendedor

create table TB_Produto (
   idPrd int identity(1,1) primary key
,  DescPrd varchar(max)
) -- Drop table TB_Produto

create table TB_Venda (
   idPed int identity(1,1) primary key
,  DataPed smalldatetime
,  idCli int
,  idVen int
,  foreign key (idCli) references TB_Cliente
,  foreign key (idVen) references TB_Vendedor
) -- Drop table TB_Venda

create table TB_VendaItem (
   idItemPed int identity(1,1) primary key
,  Qtd       decimal(19,2)
,  VrUnt     decimal(19,2)
,  VrTot     decimal(19,2)
,  idPrd     int
,  idPed     int
,  foreign key (idPrd) references TB_Produto
,  foreign key (idPed) references TB_Venda
) -- Drop table TB_VendaItem

-- Select´s
Select * from TB_Cliente
Select * from TB_Vendedor
Select * from TB_Produto
Select * from TB_Venda
Select * from TB_VendaItem

-- Inserts
insert into TB_Cliente values 
  ('nome Cliente 1', '12345678', '5555-5555', 'a@b.com.br', 'Rua A', '60877777', 'Montese'  , 'Fortaleza', 'Ceará')
, ('nome Cliente 2', '13345678', '5655-5555', 'b@b.com.br', 'Rua B', '60877774', 'PArangaba', 'Fortaleza', 'Ceará')
, ('nome Cliente 3', '14345678', '5755-5555', 'c@b.com.br', 'Rua C', '60877773', 'Aldeota'  , 'Fortaleza', 'Ceará')
, ('nome Cliente 4', '15345678', '5855-5555', 'd@b.com.br', 'Rua D', '60877772', 'Messejana', 'Fortaleza', 'Ceará')
, ('nome Cliente 5', '16345678', '5955-5555', 'e@b.com.br', 'Rua E', '60877771', 'PAssaré'  , 'Fortaleza', 'Ceará')

Insert into TB_Vendedor values ('Vendedor 1'), ('Vendedor 3'),('Vendedor 4'),('Vendedor 4'),('Vendedor 5')

Insert into TB_Produto values ('Produto 1'), ('Produto 5'), ('Produto 2'), ('Produto 3'), ('Produto 4')

Insert into TB_Venda values (getdate()     , 1, 2);
Insert into TB_Venda values (getdate() -1  , 2, 3);
Insert into TB_Venda values (getdate() -2  , 3, 1);
Insert into TB_Venda values (getdate() -40 , 4, 5);
Insert into TB_Venda values (getdate() -250, 5, 5);

Insert into TB_VendaItem values (100,  10.50,  10.50*100, 1, 1);
Insert into TB_VendaItem values ( 50,  50.00,  50.00* 50, 3, 1);
Insert into TB_VendaItem values (170, 100.99, 100.99*170, 5 ,1);

Insert into TB_VendaItem values (100,  10.50,  10.50*100, 2, 5);
Insert into TB_VendaItem values ( 50, 150.00, 150.00* 50, 4, 5);
Insert into TB_VendaItem values ( 10, 100.99, 100.99*10 , 5 ,5);

Insert into TB_VendaItem values (200,  11.50,  11.50*200, 1, 4);
Insert into TB_VendaItem values ( 50,  55.00,  55.00* 50, 3, 4);
Insert into TB_VendaItem values (170, 100.00, 100.00*170, 5 ,4);

Select * from TB_Cliente
Select * from TB_Vendedor
Select * from TB_Produto
Select * from TB_Venda
Select * from TB_VendaItem

------------------------------------
-- Banco de Dados: ArmazemDeDados --
------------------------------------
-- Criar o banco de dados
-- CREATE DATABASE ArmazemDeDados;

USE ArmazemDeDados;

CREATE VIEW vwPedidoTrabalho AS
SELECT Ped.idPed
     , Ped.DataPed
     , Cli.*
     , Ven.*
     , Ite.idItemPed
     , Prd.idPrd
     , Prd.DescPrd
     , Ite.Qtd
     , Ite.VrUnt
     , Ite.VrTot
  FROM DB_ControleVendas..TB_Venda      Ped
  JOIN DB_ControleVendas..TB_Cliente    Cli ON Cli.idCli = Ped.idCli
  JOIN DB_ControleVendas..TB_Vendedor   Ven ON Ven.idVen = Ped.idVen
  JOIN DB_ControleVendas..TB_VendaItem  Ite ON Ite.idPed = Ped.idPed
  JOIN DB_ControleVendas..TB_Produto    Prd ON Prd.idPrd = Ite.idPrd