---------------------------
-- Mascaramento de Dados --
---------------------------
--https://www.dirceuresende.com/blog/sql-server-mascaramento-de-dados-com-o-dynamic-data-masking-ddm/

USE BancoSistemaVendas -- Setar como principal para a seção

-- Lembram...
-- Versão 2016 ou superior (Mascaramento de Dados)
-- ALTER TABLE TbPessoa ALTER COLUMN EMail ADD MASKED WITH(FUNCTION = 'email()')
-- ALTER TABLE TbPessoa ALTER COLUMN Numero_Cartao ADD MASKED WITH(FUNCTION = 'partial(4, "********", 4)')

-- Vamos criar um usuário para conseguirmos visualizar os dados mascarados
-- Lembre-se: Usuários com permissão db_owner ou sysadmin SEMPRE vão ver os dados sem máscara
IF (USER_ID('Teste_DDM') IS NULL)
    CREATE USER [Teste_DDM] WITHOUT LOGIN
    
GRANT SELECT ON dbo.TbPessoa TO [Teste_DDM]

Select * From TbPessoa; -- meu usuário

-- Visualizando os dados mascarados (Como se fosse o usuário Teste_DDM, que acabamos de criar)
EXECUTE AS USER = 'Teste_DDM'
GO
SELECT * FROM TbPessoa
GO
REVERT -- Reverte as permissões para o meu usuário
GO

------------------------------------------------------------------------------------------------
------------------- Business Intelligence  (gerando CONHECIMENTO, SABEDORIA) -------------------
------------------------------------------------------------------------------------------------

-- Ferramenta de Visualização de Dados: PowerBI

--------------------------------
-- LER DIRETO DO BI (PowerBI) --
--------------------------------
-- BI (exemplos .xml, .csv)

---------------------------
-- Business Intelligence --
---------------------------
-- Criando o banco de dados para o BI (Boa prática)
-- CREATE DATABASE ArmazemDeDados (já criamos na prática anterior)
USE ArmazemDeDados;

--------------------------------------------
-- ETL (Extração / Transformação e Carga) --
--------------------------------------------
-- Manual*
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
     , Municipio = Ven.Cidade
     , Vdd.Vendedor
     , Vdd.VrBonus as TaxaComissao
     , Comissao = (Ven.Total*Vdd.VrBonus)/100
  INTO ArmazemDeDados..Visao_Vendas
  From BancoSistemaVendas..TbVendas        Ven
  join BancoSistemaVendas..TbProdutos      Pro on Pro.Codigo         = Ven.Codigo
  left join BancoSistemaVendas..TbVendedor Vdd on Vdd.CodigoVendedor = Ven.CodigoVendedor -- 2 Vendas sem vendedor

-- ABRIR NO POWERBI
--> ExemploPowerBI_ConhecimentoESabedoria.pbix

-- Procedure para Carga de Dados

USE ArmazemDeDados

ALTER PROCEDURE [dbo].[spCarga_Dados] AS 
BEGIN

  -- Vendas
  IF EXISTS (SELECT * FROM ArmazemDeDados.sys.objects WHERE object_id = OBJECT_ID(N'ArmazemDeDados..Visao_Vendas') AND type IN (N'U'))
        DROP TABLE ArmazemDeDados..Visao_Vendas
  
    Select CodigoVenda = Convert(varchar, Ven.Cod) 
         , Ven.[Data Venda]
         , Ven.Cliente
         , Pro.Produto
         , Ven.Und
         , Ven.Quantidade
         , Ven.[Vr Unitário]
         , Ven.Total
         , Ven.Estado
         , Municipio = Ven.Cidade
         , Vdd.Vendedor
         , Vdd.VrBonus as TaxaComissao
         , Comissao = (Ven.Total*Vdd.VrBonus)/100
      INTO ArmazemDeDados..Visao_Vendas
      From BancoSistemaVendas..TbVendas        Ven
      Join BancoSistemaVendas..TbProdutos      Pro on Pro.Codigo         = Ven.Codigo
      Left Join BancoSistemaVendas..TbVendedor Vdd on Vdd.CodigoVendedor = Ven.CodigoVendedor -- 2 Vendas sem vendedor

  -- Vendedor / Dependentes
  IF EXISTS (SELECT * FROM ArmazemDeDados.sys.objects WHERE object_id = OBJECT_ID(N'ArmazemDeDados..Visao_VendedorDependente') AND type IN (N'U'))
        DROP TABLE ArmazemDeDados..Visao_VendedorDependente

    Select CodigoVendedor = Convert(varchar, Ven.CodigoVendedor)
	     , Ven.Vendedor
         , Pes.Pessoa
         , Pes.Sexo
         , Pes.Endereco
         , Pes.Cidade
         , Pes.EMail
         , Pes.Numero_Cartao
		 , TempoEmpresa = DATEDIFF(year, Pes.DtAdmissao, getdate())
         , DtAdmissao
         , DtDemissao
		 , CodigoDependente = Convert(varchar, Dep.CodigoDependente)
         , Dep.Depedente
         , SexoDependente = CASE WHEN Dep.Sexo = 1 THEN 'M' 
	                             WHEN Dep.Sexo = 2 THEN 'F'
	                        ELSE 'Erro' END
		 , IdadeDependente = DATEDIFF(year, Dep.DtNasc, getdate())
      INTO ArmazemDeDados..Visao_VendedorDependente
      From BancoSistemaVendas..TbVendedor        Ven
      Join BancoSistemaVendas..TbPessoa          Pes ON Pes.CodigoPessoa   = Ven.CodigoPessoa
      Left Join BancoSistemaVendas..TbDependente Dep ON Dep.CodigoVendedor = Ven.CodigoVendedor
     Order by Ven.CodigoVendedor

  -- Vendas Completa
  IF EXISTS (SELECT * FROM ArmazemDeDados.sys.objects WHERE object_id = OBJECT_ID(N'ArmazemDeDados..Visao_VendasCompleta') AND type IN (N'U'))
        DROP TABLE ArmazemDeDados..Visao_VendasCompleta

	Select CodigoVenda = Convert(varchar, Ven.Cod)
         , Ven.[Data Venda]
         , Ven.Cliente
		 , CodigoProduto = Convert(varchar, Pro.Codigo)
         , DescricaoProduto = Pro.Produto
		 , TipoProduto      = Pro.Tipo
         , Ven.Und
         , Ven.Quantidade
         , Ven.[Vr Unitário]
         , Ven.Total
         , Ven.Estado
         , Ven.Cidade
		 , CodigoVendedor       = Convert(varchar, Vdd.CodigoVendedor)
         , ApelidoVendedor      = Vdd.Vendedor
		 , NomeVendedor         = Pes.Pessoa
		 , SexoVendedor         = Pes.Sexo
		 , EnderecoVendedor     = Pes.Endereco
		 , CidadeVendedor       = Pes.Cidade
		 , EmailVendedor        = Pes.Email
		 , CartaoVendedor       = Pes.Numero_Cartao
		 , TempoEmpresaVendedor = DATEDIFF(year, Pes.DtAdmissao, getdate())
		 , AdmissaoVendedor     = Pes.DtAdmissao
		 , DemissaoVendedor     = Pes.DtDemissao
         , TaxaComissaoVendedor = Vdd.VrBonus
         , ComissaoVendedor     = (Ven.Total*Vdd.VrBonus)/100
      INTO ArmazemDeDados..Visao_VendasCompleta
      From BancoSistemaVendas..TbVendas          Ven
      Join BancoSistemaVendas..TbProdutos        Pro on Pro.Codigo         = Ven.Codigo
      Left Join BancoSistemaVendas..TbVendedor   Vdd on Vdd.CodigoVendedor = Ven.CodigoVendedor -- 2 Vendas sem vendedor
	  Left Join BancoSistemaVendas..TbPessoa     Pes on Pes.CodigoPessoa   = Vdd.CodigoPessoa

END

-- Rodando a Carga (Manual)
EXEC [dbo].[spCarga_Dados]

-- Job de Carga (Automático) - SQL Server
-- Nome do Job: Carga_ArmazemDados

-----------------------------------
-- Teste de atualização de dados --
-----------------------------------
Select * From ArmazemDeDados..Visao_VendasCompleta
-- observar o campo: DemissaoVendedor

-- Vamos demitir a pessoa de código 1 (No sistema em "Produção")
Update BancoSistemaVendas..TbPessoa
Set DtDemissao = getdate()
Where CodigoPessoa = 1

-- Rodar o JOB (forçar)
Select * From ArmazemDeDados..Visao_VendasCompleta
-- observar novamente o campo: DemissaoVendedor