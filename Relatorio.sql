-- Relarotio

-- 1° Vendas por Gênero
SELECT l.genero "Gênero",
       COUNT(i.id_Itens_pedido) "Total Vendas",
       FORMAT(SUM(i.preco * i.quantidade), 2, 'de_DE') "Receita Total"
FROM Livros l
INNER JOIN Itens_pedido i ON l.ISBN = i.Livros_ISBN
GROUP BY l.genero
ORDER BY SUM(i.preco * i.quantidade) DESC;

-- 2° Clientes que Mais Compram
SELECT c.nome "Cliente",
       COUNT(p.id_Pedido) "Qtd Pedidos",
       FORMAT(SUM(p.valor_total), 2, 'de_DE') "Total Gasto"
FROM Cliente c
INNER JOIN Pedidos_has_Cliente pc ON c.id_Cliente = pc.Cliente_id_Cliente
INNER JOIN Pedidos p ON pc.Pedidos_id_Pedido = p.id_Pedido
WHERE p.status_pedido = 'Pago'
GROUP BY c.id_Cliente, c.nome
ORDER BY SUM(p.valor_total) DESC;

-- 3° Estoque Baixo
SELECT l.titulo "Livro",
       e.quantidade "Estoque Atual",
       l.genero "Gênero"
FROM Livros l
INNER JOIN Exemplares e ON l.ISBN = e.Livros_ISBN
WHERE e.quantidade < 5
ORDER BY e.quantidade ASC;

-- 4° Media de Preço por Genero
SELECT l.genero "Gênero",
       COUNT(*) "Qtd Livros",
       FORMAT(AVG(i.preco), 2, 'de_DE') "Preço Médio",
       FORMAT(MIN(i.preco), 2, 'de_DE') "Menor Preço",
       FORMAT(MAX(i.preco), 2, 'de_DE') "Maior Preço"
FROM Livros l
INNER JOIN Itens_pedido i ON l.ISBN = i.Livros_ISBN
GROUP BY l.genero;

-- 5° Funcionários e Pedidos Processados
SELECT f.nome "Funcionário",
       COUNT(pf.Pedidos_id_Pedido) "Pedidos Processados",
       FORMAT(SUM(p.valor_total), 2, 'de_DE') "Valor Total Processado"
FROM Funcionario f
LEFT JOIN Pedidos_has_Funcionario pf ON f.CPF = pf.Funcionario_CPF
LEFT JOIN Pedidos p ON pf.Pedidos_id_Pedido = p.id_Pedido
GROUP BY f.CPF, f.nome
ORDER BY SUM(p.valor_total) DESC;

-- 6° Livros sem Vendas
SELECT l.titulo "Livro",
       l.genero "Gênero",
       e.quantidade "Estoque",
       FORMAT((SELECT AVG(preco) FROM Itens_pedido), 2, 'de_DE') "Preço Sugerido"
FROM Livros l
LEFT JOIN Itens_pedido i ON l.ISBN = i.Livros_ISBN
INNER JOIN Exemplares e ON l.ISBN = e.Livros_ISBN
WHERE i.id_Itens_pedido IS NULL;

-- 7° Autores e Sua Receita
SELECT a.nome "Autor",
       a.nacionalidade "Nacionalidade",
       COUNT(DISTINCT al.Livros_ISBN) "Qtd Livros",
       FORMAT(SUM(i.preco * i.quantidade), 2, 'de_DE') "Receita Gerada"
FROM Autores a
LEFT JOIN Autores_has_Livros al ON a.id_Autor = al.Autores_id_Autor
LEFT JOIN Itens_pedido i ON al.Livros_ISBN = i.Livros_ISBN
GROUP BY a.id_Autor
ORDER BY SUM(i.preco * i.quantidade) DESC;

-- 8° Departamento e seus Supervisores
SELECT d.nome_departamento "Departamento",
       f.nome "Supervisor",
       c.nome_cargo "Cargo",
       COUNT(pf.Pedidos_id_Pedido) "Pedidos Relacionados"
FROM Departamento d
INNER JOIN Funcionario f ON d.supervisor = f.CPF
INNER JOIN Cargo c ON f.CPF = c.Funcionario_CPF
LEFT JOIN Pedidos_has_Funcionario pf ON f.CPF = pf.Funcionario_CPF
GROUP BY d.id_Departamento, d.nome_departamento, f.nome, c.nome_cargo
ORDER BY COUNT(pf.Pedidos_id_Pedido) DESC;

-- 9° Palavras chaves 
SELECT p.descricao "Palavra Chave",
       COUNT(lp.Livros_ISBN) "Qtd Livros",
       FORMAT(SUM(i.preco * i.quantidade), 2, 'de_DE') "Receita Total"
FROM Palavra_Chave p
LEFT JOIN Livros_has_Palavra_Chave lp ON p.id_Palavra_Chave = lp.Palavra_Chave_id_Palavra_Chave
LEFT JOIN Itens_pedido i ON lp.Livros_ISBN = i.Livros_ISBN
GROUP BY p.id_Palavra_Chave
ORDER BY SUM(i.preco * i.quantidade) DESC;

-- 10° Vendas mensais
SELECT DATE_FORMAT(p.data_pedido, '%m-%Y') "Mês",
       COUNT(p.id_Pedido) "Total Pedidos",
       FORMAT(SUM(p.valor_total), 2, 'de_DE') "Receita Total",
       FORMAT(AVG(p.valor_total), 2, 'de_DE') "Ticket Médio"
FROM Pedidos p
WHERE p.status_pedido = 'Pago'
GROUP BY DATE_FORMAT(p.data_pedido, '%m-%Y')
ORDER BY DATE_FORMAT(p.data_pedido, '%m-%Y') DESC;

-- 11° Funcionários por Departamento
SELECT d.nome_departamento "Departamento",
       COUNT(DISTINCT f.CPF) "Qtd Funcionários",
       GROUP_CONCAT(f.nome SEPARATOR ', ') "Funcionários"
FROM Departamento d
INNER JOIN Cargo c ON d.Cargo_id_Cargo = c.id_Cargo
INNER JOIN Funcionario f ON c.Funcionario_CPF = f.CPF
GROUP BY d.id_Departamento
ORDER BY d.nome_departamento ASC;

-- 12° Autores e quantidade de Livros
SELECT a.nome "Autor",
       a.nacionalidade "Nacionalidade",
       COUNT(al.Livros_ISBN) "Qtd Livros"
FROM Autores a
LEFT JOIN Autores_has_Livros al ON a.id_Autor = al.Autores_id_Autor
GROUP BY a.id_Autor, a.nome, a.nacionalidade
ORDER BY a.nome ASC;

-- 13° Funcionários por Cargo
SELECT c.nome_cargo "Cargo",
       COUNT(f.CPF) "Qtd Funcionários",
       GROUP_CONCAT(f.nome SEPARATOR ', ') "Funcionários"
FROM Cargo c
JOIN Funcionario f ON c.Funcionario_CPF = f.CPF
GROUP BY c.nome_cargo
ORDER BY c.nome_cargo ASC;

-- 14° Cliente e Telefone
SELECT c.nome "Cliente",
       c.email "E-mail",
       GROUP_CONCAT(t.numero_telefone SEPARATOR ', ') "Telefones"
FROM Cliente c
LEFT JOIN Telefone_Cliente t ON c.id_Cliente = t.Cliente_id_Cliente
GROUP BY c.id_Cliente, c.nome, c.email
ORDER BY c.nome;

-- 15° Quantidade do estado de conservação dos livros
SELECT estado "Estado",
       COUNT(*) "Qtd Exemplares",
       SUM(quantidade) "Total Unidades"
FROM Exemplares
GROUP BY estado
ORDER BY COUNT(*) DESC;

-- 16° Endereço do Funcionario
SELECT f.nome "Funcionário",
       e.rua "Rua",
       e.bairro "Bairro", 
       e.numero "Número"
FROM Funcionario f
JOIN Endereco_Funcionario e ON f.CPF = e.Funcionario_CPF
ORDER BY f.nome;

-- 17° Faixa Etaria dos funcionarios
SELECT 
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) < 30 THEN 'Até 30 anos'
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) BETWEEN 30 AND 40 THEN '30 a 40 anos'
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) BETWEEN 41 AND 50 THEN '41 a 50 anos'
        ELSE 'Acima de 50 anos'
    END "Faixa Etária",
    COUNT(*) "Qtd Funcionários"
FROM Funcionario
GROUP BY 
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) < 30 THEN 'Até 30 anos'
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) BETWEEN 30 AND 40 THEN '30 a 40 anos'
        WHEN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) BETWEEN 41 AND 50 THEN '41 a 50 anos'
        ELSE 'Acima de 50 anos'
    END
ORDER BY COUNT(*) DESC; 

