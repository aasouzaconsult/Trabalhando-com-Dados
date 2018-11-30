------------------------
-- QUALIDADE DE DADOS --
------------------------
--> Pré-Requisito

---------
-- ETL --
---------
-- CREATE DATABASE ArmazemDeDados
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
         , Ven.[Vr Unitário]
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