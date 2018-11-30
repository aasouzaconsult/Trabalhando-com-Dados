--------------------------------
-- LER DIRETO DO BI (PowerBI) --
--------------------------------
-- BI (exemplos .xml, .csv)

------------------------------------- 
-- MONTAGEM DO AMBIENTE SQL SERVER --
-------------------------------------
-- Criar o Banco de Dados > BancoSistemaVendas
CREATE DATABASE BancoSistemaVendas
USE BancoSistemaVendas -- Setar como principal para a seção

---------------------------------------
-- IMPORTAR ARQUIVO (.xls) PARA O BD --
---------------------------------------
-- BD > Tarefas > Importar Dados

--> BaseDemonstracao.xlsx (TbVendas)
--> BaseDemonstracao_Produto.xlsx (TbProdutos)

Select * From TbVendas;
Select * From TbProdutos;

-- Relacionamento
-- Relação de Vendas
Select Ven.[Data Venda]
     , Ven.Cliente
	 , Pro.Produto
	 , Ven.Und
	 , Ven.Quantidade
	 , Ven.[Vr Unitário]
	 , Ven.Total
	 , Ven.Estado
	 , Ven.Cidade
  From BancoSistemaVendas..TbVendas Ven
  join BancoSistemaVendas..TbProdutos Pro on Pro.Codigo = Ven.Codigo;

------------------------------------- 
-- MONTAGEM DO AMBIENTE SQL SERVER --
-------------------------------------
-- Usar o banco de dados criado para o BancoSistemaVendas
USE BancoSistemaVendas;

-- Criando as Tabelas
CREATE TABLE TbPessoa (
   CodigoPessoa int identity(1,1) primary key
 , Pessoa varchar(200)
 , Sexo   char(1)
 , Endereco varchar(200)
 , Cidade varchar (100)
 , EMail varchar(90)
 , Numero_Cartao VARCHAR(16) 
 , DtAdmissao smalldatetime
 , DtDemissao smalldatetime )
-- Delete from TbPessoa

-- Versão 2016 ou superior
-- ALTER TABLE TbPessoa ALTER COLUMN EMail ADD MASKED WITH(FUNCTION = 'email()')
-- ALTER TABLE TbPessoa ALTER COLUMN Numero_Cartao ADD MASKED WITH(FUNCTION = 'partial(4, "********", 4)')

CREATE TABLE TbVendedor (
   CodigoVendedor int identity(1,1) primary key
 , Vendedor varchar(50)
 , VrBonus decimal(19,2) 
 , CodigoPessoa int )

CREATE TABLE TbDependente (
   CodigoDependente int identity(1,1) primary key
 , CodigoVendedor int
 , Depedente varchar(200)
 , Sexo smallint
 , DtNasc smalldatetime
)

-- Populando (gerando DADOS)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 1', 'M', 'Rua do teste 1', 'Eusébio', 'e-mail_x@e-mail.com', '1254125414562366', '20150512', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 2', 'M', 'Rua do teste 3', 'Euzebio', 'e-mail_y@e-mail.com', '1254125414562386', '20150515', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 3', 'F', 'Rua do teste 7', 'Fortaleza', 'e-mail_a@e-mail.com', '1254125414562266', '20140712', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 4', 'M', 'Rua do teste 2', 'Fortaleza', 'e-mail_v@e-mail.com', '1254125414562166', '20150612', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 5', 'M', 'Rua do teste 3', 'Eusébio', 'e-mail_c@e-mail.com', '1254125414562766', '20150810', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 6', 'M', 'Rua do teste 4', 'Maracanaú', 'e-mail_d@e-mail.com', '1254125414562366', '20170419', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 7', 'F', 'Rua do teste 5', 'Aquiraz', 'e-mail_j@e-mail.com', '1253125414562366', '20150705', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 8', 'M', 'Rua do teste 8', 'Fortalesa', 'e-mail_l@e-mail.com', '1244125414562366', '20130211', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 9', 'F', 'Rua do teste 1', 'Eusébio', 'e-mail_m@e-mail.com', '1253125414562346', '20180512', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 10', 'M', 'Rua do teste 03', 'Euzebio', 'e-mail_n@e-mail.com', '1254125414562366', '20150515', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 11', 'M', 'Rua do teste 17', 'Fortaleza', 'e-mail_o@e-mail.com', '1253125414562366', '20140712', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 12', 'F', 'Rua do teste 22', 'Fortaleza', 'e-mail_p@e-mail.com', '1254125414562366', '20150612', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 13', 'M', 'Rua do teste 33', 'Eusébio', 'e-mail_q@e-mail.com', '1284125414562366', '20150810', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 14', 'M', 'Rua do teste 34', 'Maracanaú', 'e-mail_r@e-mail.com', '1254125414562366', '20170419', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 15', 'F', 'Rua do teste 25', 'Aquiraz', 'e-mail_s@e-mail.com', '1244125414562366', '20150705', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 16', 'M', 'Rua do teste 18', 'Fotaleza', 'e-mail_t@e-mail.com', '1254125414562226', '20130211', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 17', 'M', 'Rua do teste 28', 'Fortaleza', 'e-mail_u@e-mail.com', '1454125414562266', '20170211', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 18', 'F', 'Rua do teste 38', 'Fortaleza', 'e-mail_vr@e-mail.com', '1204125414561366', '20160211', null)
INSERT INTO TbPessoa VALUES ('Nome da Pessoa 19', 'M', 'Rua do teste 48', 'Fortaleza', 'e-mail_z@e-mail.com', '1294125414562266', '20160211', null)
Select * From TbPessoa

INSERT INTO TbVendedor VALUES ('Vendedor 1', 10.00, 1)
INSERT INTO TbVendedor VALUES ('Vendedor 2', 12.00, 2)
INSERT INTO TbVendedor VALUES ('Vendedor 3', 13.00, 3)
INSERT INTO TbVendedor VALUES ('Vendedor 4', 14.00, 4)
INSERT INTO TbVendedor VALUES ('Vendedor 5', 15.00, 5)
INSERT INTO TbVendedor VALUES ('Vendedor 6', 16.00, 6)
INSERT INTO TbVendedor VALUES ('Vendedor 7', 17.00, 7)
INSERT INTO TbVendedor VALUES ('Vendedor 8', 18.00, 8)
INSERT INTO TbVendedor VALUES ('Vendedor 9', 10.00, 9)
INSERT INTO TbVendedor VALUES ('Vendedor 10', 12.00, 10)
INSERT INTO TbVendedor VALUES ('Vendedor 11', 13.00, 11)
INSERT INTO TbVendedor VALUES ('Vendedor 12', 14.00, 12)
INSERT INTO TbVendedor VALUES ('Vendedor 13', 15.00, 13)
INSERT INTO TbVendedor VALUES ('Vendedor 14', 10.00, 14)
INSERT INTO TbVendedor VALUES ('Vendedor 15', 17.00, 15)
INSERT INTO TbVendedor VALUES ('Vendedor 16', 11.00, 16)
INSERT INTO TbVendedor VALUES ('Vendedor 17', 18.00, 17)
INSERT INTO TbVendedor VALUES ('Vendedor 18', 18.00, 100)
INSERT INTO TbVendedor VALUES ('Vendedor 19', 18.00, 200) -- Solucionar - Integridade Relacional - Foreign Key
Select * From TbVendedor

INSERT INTO TbDependente VALUES (1, 'Dependente A', 1, '20150101')
INSERT INTO TbDependente VALUES (3, 'Dependente B', 1, '20160601')
INSERT INTO TbDependente VALUES (5, 'Dependente C', 2, '20170101')
INSERT INTO TbDependente VALUES (7, 'Dependente D', 2, '20140501')
INSERT INTO TbDependente VALUES (9, 'Dependente E', 1, '20150101')
INSERT INTO TbDependente VALUES (11, 'Dependente F', 1, '20150101')
INSERT INTO TbDependente VALUES (13, 'Dependente G', 2, '20150101')
INSERT INTO TbDependente VALUES (1,  'Dependente AA', 1, '20181005')
INSERT INTO TbDependente VALUES (13,  'Dependente GG', 1, '20171005')
Select * From TbDependente

-------------------------------------------
-- Relacionamentos (gerando INFORMAÇÕES) --
-------------------------------------------
Select * 
  From TbVendedor Ven
  Join TbPessoa   Pes ON Pes.CodigoPessoa = Ven.CodigoPessoa

Select * 
  From TbVendedor Ven
  Left Join TbPessoa   Pes ON Pes.CodigoPessoa = Ven.CodigoPessoa -- Retorna tudo da Tabela da Esquerda

Select * 
  From TbVendedor Ven
  Right Join TbPessoa   Pes ON Pes.CodigoPessoa = Ven.CodigoPessoa -- Retorna tudo da Tabela da Direita

-- Informações de Vendas por Vendedor - Detalhe
Select Ven.[Data Venda]
     , Ven.Cliente
	 , Pro.Produto
	 , Ven.Und
	 , Ven.Quantidade
	 , Ven.[Vr Unitário]
	 , Ven.Total
	 , Ven.Estado
	 , Ven.Cidade
	 , Vdd.Vendedor
  From BancoSistemaVendas..TbVendas   Ven
  join BancoSistemaVendas..TbProdutos Pro on Pro.Codigo = Ven.Codigo
  left join BancoSistemaVendas..TbVendedor Vdd on Vdd.CodigoVendedor = Ven.CodigoVendedor -- 2 Vendas sem vendedor
  Order by Vdd.Vendedor
-- Relação de Dependentes por Vendedor
  
-------------------------------------------------------------
-- Business Intelligence (gerando CONHECIMENTO, SABEDORIA) --
------------------------------------------------------------- 
-- Criando o banco de dados para o BI
CREATE DATABASE ArmazemDeDados
USE ArmazemDeDados;

-- Colando essa consulta para o Armazem de Dados (gerando diversas - INFORMAÇÕES)
-- Gerando nossa base de Vendas
Select Ven.Cod 
     , Ven.[Data Venda]
     , Ven.Cliente
	 , Pro.Produto
	 , Ven.Und
	 , Ven.Quantidade
	 , Ven.[Vr Unitário]
	 , Ven.Total
	 , Ven.Estado
	 , Ven.Cidade
	 , Vdd.Vendedor
	 , Vdd.VrBonus as TaxaComissao
	 , Comissao = (Ven.Total*Vdd.VrBonus)/100
  INTO ArmazemDeDados..Visao_Vendas
  From BancoSistemaVendas..TbVendas        Ven
  join BancoSistemaVendas..TbProdutos      Pro on Pro.Codigo         = Ven.Codigo
  left join BancoSistemaVendas..TbVendedor Vdd on Vdd.CodigoVendedor = Ven.CodigoVendedor -- 2 Vendas sem vendedor

-- ABRIR NO POWERBI
--> ExemploPowerBI_ConhecimentoESabedoria.pbix

------------------------
-- Qualidade de Dados --
------------------------
-- Erros digitação - Muito comum
Select Cidade, count(*)
  From TbVendedor Ven
  Join TbPessoa   Pes ON Pes.CodigoPessoa = Ven.CodigoPessoa
 Group by Cidade
-- Solução: Ajustes Manuais, Ajustes via Banco de Dados, Cadastro único de Endereços (minimiza)
 
-- Padronização de Nomenclaturas - Campo Sexo
Select Ven.Vendedor, Pes.Sexo, Dep.Depedente, Dep.Sexo
  From TbVendedor   Ven
  Join TbPessoa     Pes ON Pes.CodigoPessoa   = Ven.CodigoPessoa
  Join TbDependente Dep ON Dep.CodigoVendedor = Ven.CodigoVendedor
 Order by Ven.CodigoVendedor

-- Solução (Padronização de Nomenclaturas - Campo Sexo)
Select Ven.Vendedor
     , Pes.Sexo
     , Dep.Depedente
     , CASE WHEN Dep.Sexo = 1 THEN 'M' ELSE 'F' END
  From TbVendedor   Ven
  Join TbPessoa     Pes ON Pes.CodigoPessoa   = Ven.CodigoPessoa
  Join TbDependente Dep ON Dep.CodigoVendedor = Ven.CodigoVendedor
 Order by Ven.CodigoVendedor

---------------------------
-- Mascaramento de Dados --
---------------------------
--https://www.dirceuresende.com/blog/sql-server-mascaramento-de-dados-com-o-dynamic-data-masking-ddm/

-- Vamos criar um usuário para conseguirmos visualizar os dados mascarados
-- Lembre-se: Usuários com permissão db_owner ou sysadmin SEMPRE vão ver os dados sem máscara
IF (USER_ID('Teste_DDM') IS NULL)
    CREATE USER [Teste_DDM] WITHOUT LOGIN
    
GRANT SELECT ON dbo.TbPessoa TO [Teste_DDM]

Select * From TbPessoa;

-- Visualizando os dados mascarados (Como se fosse o usuário Teste_DDM, que acabamos de criar)
EXECUTE AS USER = 'Teste_DDM'
GO
SELECT * FROM TbPessoa
GO
REVERT -- Reverte as permissões para o seu usuário
GO