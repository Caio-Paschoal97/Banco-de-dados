#📚 Banco de Dados — Editora Gorette
Este projeto apresenta o desenvolvimento completo de um banco de dados relacional para uma Editora Literária, implementado em MySQL Workbench. O sistema foi modelado para gerenciar todo o ecossistema editorial, desde o cadastro de autores e livros até vendas, estoque e recursos humanos, garantindo integridade, consistência e normalização dos dados.

#📘 Etapas do Projeto
O sistema foi desenvolvido em três camadas de modelagem:

#🧩 Modelo Conceitual
Define as entidades principais (Livros, Autores, Clientes, Funcionários, Pedidos) e seus relacionamentos, com cardinalidades bem estabelecidas (1:1, 1:N, N:N). Essa etapa garantiu o entendimento claro do domínio editorial antes da implementação técnica.

💾 Modelo Lógico
Traduziu o modelo conceitual para estrutura relacional, especificando:

Chaves primárias e estrangeiras

Tipos de dados apropriados

Regras de integridade referencial

Cardinalidades aplicadas

⚙️ Modelo Físico
Implementado via scripts SQL, com criação de tabelas, relacionamentos, índices e regras de exclusão em cascata para manter a consistência do banco.

🧰 Stacks Utilizadas
Camada	Ferramenta	Finalidade
Modelo Conceitual	brModelo	Criação do diagrama Entidade-Relacionamento (DER)
Modelo Lógico	MySQL Workbench	Conversão do modelo conceitual em estrutura relacional
Modelo Físico	MySQL Server / Workbench	Implementação real do banco via scripts SQL
🧠 Normalização
O projeto segue as três primeiras formas normais para garantir integridade e eliminar redundâncias:

Forma Normal	Aplicação no Projeto
1FN	Todos os atributos possuem valores atômicos (ex: ISBN, título único)
2FN	Atributos dependem totalmente das chaves primárias (ex: dados do livro dependem do ISBN)
3FN	Sem dependências transitivas (ex: departamentos separados de cargos)
🏗️ Estrutura das Tabelas
📚 Tabelas Principais do Negócio
Tabela	Descrição
Livros	Cadastro completo das obras publicadas (ISBN, título, gênero, páginas)
Autores	Dados biográficos dos escritores e colaboradores
Exemplares	Controle físico de estoque e localização
Pedidos	Registro de vendas e encomendas
Clientes	Cadastro de compradores e leitores
👥 Tabelas de Recursos Humanos
Tabela	Descrição
Funcionario	Dados completos dos colaboradores da editora
Cargo	Definição de funções e responsabilidades
Departamento	Estrutura organizacional da editora
🏷️ Tabelas de Classificação
Tabela	Descrição
Area_Conhecimento	Categorização temática das obras
Palavra_Chave	Sistema de tags para indexação e busca
🔗 Tabelas de Relacionamento
Tabela	Tipo	Descrição
Autores_has_Livros	N:N	Relacionamento entre autores e suas obras
Livros_has_Palavra_Chave	N:N	Associação de tags aos livros
Pedidos_has_Cliente	N:N	Vínculo entre pedidos e clientes
Pedidos_has_Funcionario	N:N	Funcionários responsáveis pelos pedidos
🔗 Tipos de Relacionamento e CASCADE
O banco utiliza regras de integridade referencial para manter coerência entre as tabelas:

Regra	Aplicação no Sistema
ON DELETE CASCADE	Remove automaticamente registros dependentes (ex: exemplares ao excluir livro)
Chaves Estrangeiras	Garantem integridade nos relacionamentos entre entidades
Constraints UNIQUE	Evitam duplicidades em campos críticos (título, número de série)
💡 Destaques do Sistema
🔄 Fluxos Integrados
Publicação: Autor → Livro → Classificação → Exemplares

Vendas: Cliente → Pedido → Itens → Estoque

RH: Funcionário → Cargo → Departamento

🎯 Funcionalidades Chave
Controle completo do catálogo bibliográfico

Gestão de autores e direitos autorais

Sistema de classificação por área e tags

Controle de estoque e exemplares

Processamento de vendas e pedidos

Administração de recursos humanos

🧮 Consultas Relacionais
Os JOINS são essenciais para relacionar informações entre as tabelas do sistema:

📊 Exemplos de Consultas:
Listar livros e seus autores:

sql
SELECT l.titulo, a.nome as autor
FROM Livros l
INNER JOIN Autores_has_Livros al ON l.ISBN = al.Livros_ISBN
INNER JOIN Autores a ON al.Autores_id_Autor = a.id_Autor;
Consultar pedidos com clientes:

✨ Autoria
Caio Victor, Luciana Borges, Priscila Barbosa
