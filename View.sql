-- views 

-- 1° view 
CREATE VIEW view_vendas_por_genero AS
SELECT 
    l.genero AS "Gênero",
    COUNT(i.id_Itens_pedido) AS "Total_Vendas",
    SUM(i.preco * i.quantidade) AS "Receita_Total",
    CONCAT('R$ ', FORMAT(SUM(i.preco * i.quantidade), 2, 'de_DE')) AS "Receita_Total_Formatada"
FROM Livros l
INNER JOIN Itens_pedido i ON l.ISBN = i.Livros_ISBN
GROUP BY l.genero
ORDER BY SUM(i.preco * i.quantidade) DESC;

-- 2° view 
CREATE VIEW view_clientes_top AS
SELECT 
    c.nome AS "Cliente",
    c.email AS "Email",
    COUNT(p.id_Pedido) AS "Quantidade_Pedidos",
    SUM(p.valor_total) AS "Total_Gasto",
    CONCAT('R$ ', FORMAT(SUM(p.valor_total), 2, 'de_DE')) AS "Total_Gasto_Formatado"
FROM Cliente c
INNER JOIN Pedidos_has_Cliente pc ON c.id_Cliente = pc.Cliente_id_Cliente
INNER JOIN Pedidos p ON pc.Pedidos_id_Pedido = p.id_Pedido
WHERE p.status_pedido = 'Pago'
GROUP BY c.id_Cliente, c.nome, c.email
ORDER BY SUM(p.valor_total) DESC;

-- 3° view 
CREATE VIEW view_estoque_baixo AS
SELECT 
    l.titulo AS "Livro",
    l.genero AS "Gênero",
    e.quantidade AS "Estoque_Atual",
    e.localizacao AS "Localizacao",
    e.estado AS "Estado_Conservacao"
FROM Livros l
INNER JOIN Exemplares e ON l.ISBN = e.Livros_ISBN
WHERE e.quantidade < 5
ORDER BY e.quantidade ASC;

-- 4° view 
CREATE VIEW view_autores_receita AS
SELECT 
    a.nome AS "Autor",
    a.nacionalidade AS "Nacionalidade",
    COUNT(DISTINCT al.Livros_ISBN) AS "Quantidade_Livros",
    SUM(i.preco * i.quantidade) AS "Receita_Gerada",
    CONCAT('R$ ', FORMAT(SUM(i.preco * i.quantidade), 2, 'de_DE')) AS "Receita_Formatada"
FROM Autores a
LEFT JOIN Autores_has_Livros al ON a.id_Autor = al.Autores_id_Autor
LEFT JOIN Itens_pedido i ON al.Livros_ISBN = i.Livros_ISBN
GROUP BY a.id_Autor, a.nome, a.nacionalidade
ORDER BY SUM(i.preco * i.quantidade) DESC;

-- 5° view 
CREATE VIEW view_vendas_mensais AS
SELECT 
    DATE_FORMAT(p.data_pedido, '%m-%Y') AS "Mes_Ano",
    YEAR(p.data_pedido) AS "Ano",
    MONTH(p.data_pedido) AS "Mes",
    COUNT(p.id_Pedido) AS "Total_Pedidos",
    SUM(p.valor_total) AS "Receita_Total",
    AVG(p.valor_total) AS "Ticket_Medio",
    CONCAT('R$ ', FORMAT(SUM(p.valor_total), 2, 'de_DE')) AS "Receita_Formatada",
    CONCAT('R$ ', FORMAT(AVG(p.valor_total), 2, 'de_DE')) AS "Ticket_Medio_Formatado"
FROM Pedidos p
WHERE p.status_pedido = 'Pago'
GROUP BY DATE_FORMAT(p.data_pedido, '%m-%Y'), YEAR(p.data_pedido), MONTH(p.data_pedido)
ORDER BY YEAR(p.data_pedido) DESC, MONTH(p.data_pedido) DESC;

-- 6° view 
CREATE VIEW view_folha_pagamento_departamento AS
SELECT 
    d.nome_departamento AS "Departamento",
    COUNT(f.CPF) AS "Quantidade_Funcionarios",
    SUM(f.salario) AS "Total_Folha",
    AVG(f.salario) AS "Media_Salarial",
    MAX(f.salario) AS "Maior_Salario",
    MIN(f.salario) AS "Menor_Salario",
    CONCAT('R$ ', FORMAT(SUM(f.salario), 2, 'de_DE')) AS "Total_Folha_Formatado",
    CONCAT('R$ ', FORMAT(AVG(f.salario), 2, 'de_DE')) AS "Media_Salarial_Formatada"
FROM Departamento d
JOIN Cargo c ON d.Cargo_id_Cargo = c.id_Cargo
JOIN Funcionario f ON c.Funcionario_CPF = f.CPF
GROUP BY d.id_Departamento, d.nome_departamento
ORDER BY SUM(f.salario) DESC;

-- 7° view 
CREATE VIEW view_livros_sem_vendas AS
SELECT 
    l.titulo AS "Livro",
    l.genero AS "Gênero",
    l.ISBN AS "ISBN",
    e.quantidade AS "Estoque",
    e.estado AS "Estado_Conservacao",
    (SELECT AVG(preco) FROM Itens_pedido) AS "Preco_Sugerido",
    CONCAT('R$ ', FORMAT((SELECT AVG(preco) FROM Itens_pedido), 2, 'de_DE')) AS "Preco_Sugerido_Formatado"
FROM Livros l
LEFT JOIN Itens_pedido i ON l.ISBN = i.Livros_ISBN
INNER JOIN Exemplares e ON l.ISBN = e.Livros_ISBN
WHERE i.id_Itens_pedido IS NULL
ORDER BY l.titulo;

-- 8° view 
CREATE VIEW view_funcionarios_departamento AS
SELECT 
    d.nome_departamento AS "Departamento",
    d.supervisor AS "Supervisor_CPF",
    (SELECT nome FROM Funcionario WHERE CPF = d.supervisor) AS "Supervisor_Nome",
    COUNT(DISTINCT f.CPF) AS "Quantidade_Funcionarios",
    GROUP_CONCAT(f.nome SEPARATOR ', ') AS "Funcionarios"
FROM Departamento d
INNER JOIN Cargo c ON d.Cargo_id_Cargo = c.id_Cargo
INNER JOIN Funcionario f ON c.Funcionario_CPF = f.CPF
GROUP BY d.id_Departamento, d.nome_departamento, d.supervisor
ORDER BY d.nome_departamento ASC;

-- 9° view 
CREATE VIEW view_palavras_chave_populares AS
SELECT 
    p.descricao AS "Palavra_Chave",
    COUNT(lp.Livros_ISBN) AS "Quantidade_Livros",
    SUM(COALESCE(i.preco * i.quantidade, 0)) AS "Receita_Total",
    CONCAT('R$ ', FORMAT(SUM(COALESCE(i.preco * i.quantidade, 0)), 2, 'de_DE')) AS "Receita_Formatada"
FROM Palavra_Chave p
LEFT JOIN Livros_has_Palavra_Chave lp ON p.id_Palavra_Chave = lp.Palavra_Chave_id_Palavra_Chave
LEFT JOIN Itens_pedido i ON lp.Livros_ISBN = i.Livros_ISBN
GROUP BY p.id_Palavra_Chave, p.descricao
ORDER BY SUM(COALESCE(i.preco * i.quantidade, 0)) DESC;

-- 10° view
CREATE VIEW view_estatisticas_funcionarios AS
SELECT 
    c.nome_cargo AS "Cargo",
    d.nome_departamento AS "Departamento",
    COUNT(f.CPF) AS "Quantidade_Funcionarios",
    CONCAT('R$ ', FORMAT(AVG(f.salario), 2, 'de_DE')) AS "Salario_Medio",
    CONCAT('R$ ', FORMAT(SUM(f.salario), 2, 'de_DE')) AS "Total_Salarios",
    -- Faixa etária
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, f.data_nascimento, CURDATE()) < 30 THEN 'Até 30 anos'
        WHEN TIMESTAMPDIFF(YEAR, f.data_nascimento, CURDATE()) BETWEEN 30 AND 40 THEN '30 a 40 anos'
        WHEN TIMESTAMPDIFF(YEAR, f.data_nascimento, CURDATE()) BETWEEN 41 AND 50 THEN '41 a 50 anos'
        ELSE 'Acima de 50 anos'
    END AS "Faixa_Etaria"
FROM Funcionario f
JOIN Cargo c ON f.CPF = c.Funcionario_CPF
JOIN Departamento d ON c.id_Cargo = d.Cargo_id_Cargo
GROUP BY c.nome_cargo, d.nome_departamento, 
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, f.data_nascimento, CURDATE()) < 30 THEN 'Até 30 anos'
        WHEN TIMESTAMPDIFF(YEAR, f.data_nascimento, CURDATE()) BETWEEN 30 AND 40 THEN '30 a 40 anos'
        WHEN TIMESTAMPDIFF(YEAR, f.data_nascimento, CURDATE()) BETWEEN 41 AND 50 THEN '41 a 50 anos'
        ELSE 'Acima de 50 anos'
    END
ORDER BY d.nome_departamento, c.nome_cargo;