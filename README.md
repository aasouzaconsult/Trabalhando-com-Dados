# Curso: Ciência de Dados com aplicação em Inteligência de Negócio e em Dados Textuais
- Alex Souza
- E-mail: aasouzaconsult@gmail.com (dúvidas, pode me enviar!)
- Lattes: http://lattes.cnpq.br/3318149614519892
- Blog: https://pessoalex.wordpress.com/
- Linkedin: https://www.linkedin.com/in/alex-souza/

Softwares
---------
- Microsoft SQL Server 2017 (https://www.microsoft.com/pt-br/sql-server/sql-server-downloads)
- Power BI Desktop (https://powerbi.microsoft.com/pt-br/desktop/)

Apresentação
------------
Dados.pdf

Materiais
------------
Dísponivel em: https://drive.google.com/drive/folders/1kMuictsfTVKPQGt3c3QXo5uvbfQVGIF8?usp=sharing

- Apostila SQL Server - Editora Impacta.pdf
- Apostila DMBOK.pdf
- Apostila PowerBI - Editora Impacta.pdf

--------------------------------------------------------------------------------------------------
1° Dia
-----------
Dados, Banco de Dados, Qualidade de Dados

Dicas
-----
- Download SQL Server 2017: https://go.microsoft.com/fwlink/?linkid=853016 (mecanismo)
- Download SQL Server Management Studio: https://go.microsoft.com/fwlink/?linkid=2043154 (gerenciador)
- Instalação SQL Server 2017: https://www.tiagoneves.net/blog/instalando-o-sql-server-2017/ (Windows / Linux)

- Banco de Dados (https://pessoalex.wordpress.com/dados/estruturados/banco-de-dados/)
- SQL Server (Backup - https://pessoalex.wordpress.com/2011/05/25/backup_restore/)
- SQL Server (Alta Disponibilidade - https://pessoalex.wordpress.com/dados/estruturados/banco-de-dados/relacionais/sql-server/alta-disponibilidade-no-sql-server/)
- SQL Server (Segurança - https://pessoalex.wordpress.com/dados/estruturados/banco-de-dados/relacionais/sql-server/seguranca-no-sql-server/)
- SQL Server (Arquitetura - https://pessoalex.wordpress.com/dados/estruturados/banco-de-dados/relacionais/sql-server/arquitetura-no-sql-server/)
- SQL Server (Desempenho - https://pessoalex.wordpress.com/dados/estruturados/banco-de-dados/relacionais/sql-server/desempenho/)
- Qualidade de Dados (https://gpdiceblog.wordpress.com/2017/09/12/a-importancia-da-qualidade-dos-dados-nas-empresas-com-enfase-no-apoio-a-tomada-de-decisao-um-estudo-exploratorio/)

Bases em Arquivos
-------------
- BaseDemonstracao.xlsx
- BaseDemonstracao_Produto.xlsx

Scripts (.sql)
-------------
- AmbienteSQLServer.sql

Praticando em casa...
-------------
Usando o SQL Server ou qualquer outro SGBD, criar um banco de dados para Controle de Vendas, algumas das condições:
- Cada Venda tem que ter um Vendedor associado
- Cada Venda deve estar associada a um Cliente
- Cada Cliente terá um Nome, CPF, Telefone, Endereço completo (sugestão: Logradouro, CEP, Bairro, Cidade, Estado. Em campos separados)
- Cada Venda pode ter mais de um Produto (Item de Venda)
- Cada Produto deve ter um código, Descrição
- Para cada Item de Venda deve ser informado, o código e descrição do produto, quantidade vendida, o valor unitário e o Valor total

* Sugestão: alimentar com dados desde Janeiro de 2016, com clientes em diversos Bairros, Cidades e Estado. Usem a criatividade, exemplos (Ambiente_Exemplo_ControleDeVendas.sql e AmbienteSQLServer.sql) e experiência!

Gráficos (no Power BI ou qualquer outra ferramenta de Self-Service BI)
- Usem a criatividades
- Alguns exemplos: Total de Vendas por Ano, por Mês, por Estado (Mapa), Gráfico de Vendas e etc

--------------------------------------------------------------------------------------------------
2° Dia
-----------
ETL, Business Intelligence

Dicas
-----
- PowerBI (https://pessoalex.wordpress.com/bi-3/microsoft/power-bi/)
- Tableau (https://pessoalex.wordpress.com/bi-3/tableau/)

Scripts (.sql)
-------------
- AmbienteBI.sql
- Ambiente_Exemplo_ControleDeVendas.sql

Arquivos PowerBI (.pbix)
-------------
- ExemploPowerBI.pbix
- Exemplo_Relacionamento.pbix
- ExemploPowerBI_Dispersao_ENEM2014.pbix
- ExemploPowerBI_ConhecimentoESabedoria.pbix
