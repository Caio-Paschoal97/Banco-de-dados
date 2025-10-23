# Editora_Gorette - Banco de Dados

👥 Equipe de Desenvolvimento
Caio Victor • Luciana Borges • Priscila Barbosa

📚 Descrição

O projeto Editora_Gorette consiste em um banco de dados relacional desenvolvido em MySQL, projetado para gerenciar todas as informações de uma editora de livros, incluindo:

Livros, autores e suas relações

Exemplares físicos

Áreas de conhecimento e palavras-chave

Pedidos e itens de pedidos

Clientes e funcionários, com contatos e endereços

Departamentos e cargos

O modelo foi desenvolvido respeitando a 1ª, 2ª e 3ª formas normais, garantindo integridade e consistência dos dados.

# 🗂 Estrutura do Banco de Dados
Tabelas Principais

Livros – Armazena informações detalhadas sobre livros, como ISBN, título, gênero e número de páginas.

Autores – Cadastro de autores, com nome, nacionalidade, biografia e data de nascimento.

Pedidos – Registra os pedidos realizados, detalhando data, status e valor total.

Cliente – Cadastro de clientes.

Funcionario – Cadastro de funcionários, incluindo dados de contato.

# Tabelas de Relacionamento

Autores_has_Livros – Relacionamento muitos-para-muitos entre autores e livros.

Livros_has_Palavra_Chave – Relacionamento muitos-para-muitos entre livros e palavras-chave.

Pedidos_has_Cliente – Relacionamento muitos-para-muitos entre pedidos e clientes.

Pedidos_has_Funcionario – Relacionamento muitos-para-muitos entre pedidos e funcionários.

# Outras Tabelas

Exemplares – Controle de exemplares físicos de livros.

Area_Conhecimento – Áreas de conhecimento associadas a cada livro.

Palavra_Chave – Palavras-chave para categorização de livros.

Telefone_funcionario e Endereco_Funcionario – Contatos de funcionários.

Telefone_Cliente e Endereco_cliente – Contatos de clientes.

Cargo – Cargos de funcionários.

Departamento – Departamentos da editora vinculados a cargos e livros.

Itens_pedido – Itens de cada pedido, vinculando livros a pedidos.

# 🔗 Relacionamentos

O banco de dados implementa:

Relacionamentos muitos-para-muitos: livros ↔ autores, livros ↔ palavras-chave, pedidos ↔ clientes, pedidos ↔ funcionários.

Relacionamentos um-para-muitos: livros ↔ exemplares, livros ↔ áreas de conhecimento, clientes ↔ endereços/telefones, funcionários ↔ cargos/departamentos.

Integridade referencial com FOREIGN KEY e ON DELETE CASCADE.
