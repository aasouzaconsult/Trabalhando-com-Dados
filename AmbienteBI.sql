---------------------------
-- Mascaramento de Dados --
---------------------------
--https://www.dirceuresende.com/blog/sql-server-mascaramento-de-dados-com-o-dynamic-data-masking-ddm/

USE BancoSistemaVendas -- Setar como principal para a se��o
-- Vamos criar um usu�rio para conseguirmos visualizar os dados mascarados
-- Lembre-se: Usu�rios com permiss�o db_owner ou sysadmin SEMPRE v�o ver os dados sem m�scara
IF (USER_ID('Teste_DDM') IS NULL)
    CREATE USER [Teste_DDM] WITHOUT LOGIN
    
GRANT SELECT ON dbo.TbPessoa TO [Teste_DDM]

Select * From TbPessoa;

-- Visualizando os dados mascarados (Como se fosse o usu�rio Teste_DDM, que acabamos de criar)
EXECUTE AS USER = 'Teste_DDM'
GO
SELECT * FROM TbPessoa
GO
REVERT -- Reverte as permiss�es para o seu usu�rio
GO

------------------------------------------------------------------------------------------------
------------------- Business Intelligence  (gerando CONHECIMENTO, SABEDORIA) -------------------
------------------------------------------------------------------------------------------------

-- Ferramenta de Visualiza��o de Dados: PowerBI

--------------------------------
-- LER DIRETO DO BI (PowerBI) --
--------------------------------
-- BI (exemplos .xml, .csv)

---------------------------
-- Business Intelligence --
---------------------------
-- Criando o banco de dados para o BI (Boa pr�tica)
CREATE DATABASE ArmazemDeDados
USE ArmazemDeDados;

--------------------------------------------
-- ETL (Extra��o / Transforma��o e Carga) --
--------------------------------------------
-- Manual*
-- Colando essa consulta para o Armazem de Dados (gerando diversas - INFORMA��ES)
-- Gerando nossa base de Vendas
Select Ven.Cod 
     , Ven.[Data Venda]
     , Ven.Cliente
     , Pro.Produto
     , Ven.Und
     , Ven.Quantidade
     , Ven.[Vr Unit�rio]
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

-- Autom�tico*

USE ArmazemDeDados

CREATE PROCEDURE [dbo].[spCarga_Dados] AS 
BEGIN

  -- Vendas
  IF EXISTS (SELECT * FROM ArmazemDeDados.sys.objects WHERE object_id = OBJECT_ID(N'ArmazemDeDados..Visao_Vendas') AND type IN (N'U'))
        DROP TABLE ArmazemDeDados..Visao_Vendas
  
    Select Ven.Cod 
         , Ven.[Data Venda]
         , Ven.Cliente
         , Pro.Produto
         , Ven.Und
         , Ven.Quantidade
         , Ven.[Vr Unit�rio]
         , Ven.Total
         , Ven.Estado
         , Ven.Cidade
         , Vdd.Vendedor
         , Vdd.VrBonus as TaxaComissao
         , Comissao = (Ven.Total*Vdd.VrBonus)/100
      INTO ArmazemDeDados..Visao_Vendas
      From BancoSistemaVendas..TbVendas        Ven
      Join BancoSistemaVendas..TbProdutos      Pro on Pro.Codigo         = Ven.Codigo
      Left Join BancoSistemaVendas..TbVendedor Vdd on Vdd.CodigoVendedor = Ven.CodigoVendedor -- 2 Vendas sem vendedor

  -- Vendedor / Dependentes
  IF EXISTS (SELECT * FROM ArmazemDeDados.sys.objects WHERE object_id = OBJECT_ID(N'ArmazemDeDados..Visao_DependenteVendedor') AND type IN (N'U'))
        DROP TABLE ArmazemDeDados..Visao_DependenteVendedor

    Select Ven.Vendedor
         , Pes.Pessoa
         , Pes.Sexo
         , Pes.Endereco
         , Pes.Cidade
         , Pes.EMail
         , Pes.Numero_Cartao
         , DtAdmissao
         , DtDemissao
         , Dep.Depedente
         , [Sexo Dependente] = CASE WHEN Dep.Sexo = 1 THEN 'M' ELSE 'F' END
      INTO ArmazemDeDados..Visao_VendedorDependente
      From BancoSistemaVendas..TbVendedor   Ven
      Join BancoSistemaVendas..TbPessoa     Pes ON Pes.CodigoPessoa   = Ven.CodigoPessoa
      Left Join BancoSistemaVendas..TbDependente Dep ON Dep.CodigoVendedor = Ven.CodigoVendedor
     Order by Ven.CodigoVendedor

END

-- Rodando a Carga
EXEC [dbo].[spCarga_Dados]