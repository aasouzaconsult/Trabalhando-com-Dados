------------------------
-- QUALIDADE DE DADOS --
------------------------
--> Pré-Requisito


---------
-- ETL --
---------
-- CREATE DATABASE ArmazemDeDados

-- Dependentes por Vendedor

--CREATE PROCEDURE [dbo].[spCarga_Dados] AS 
--BEGIN
  
  IF EXISTS (SELECT * FROM ArmazemDeDados.sys.objects WHERE object_id = OBJECT_ID(N'ArmazemDeDados..Visao_DependenteVendedor') AND type IN (N'U'))
        DROP TABLE ArmazemDeDados..Visao_DependenteVendedor

Select Ven.Vendedor
     , Pes.Sexo
     , Dep.Depedente
     , [Sexo Dependente] = CASE WHEN Dep.Sexo = 1 THEN 'M' ELSE 'F' END
  Into ArmazemDeDados..Visao_DependenteVendedor
  From TbVendedor   Ven
  Join TbPessoa     Pes ON Pes.CodigoPessoa   = Ven.CodigoPessoa
  Join TbDependente Dep ON Dep.CodigoVendedor = Ven.CodigoVendedor
 Order by Ven.CodigoVendedor

--END