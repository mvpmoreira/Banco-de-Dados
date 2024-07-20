-- Nível básico
-- 1.	Quais são as informações das Categorias cadastradas na base de dados? 

SELECT CategoryName, Description
FROM Categories;

-- 2.	Quais os Nomes e Sobrenomes dos Funcionários nascidos após os anos 50? 

SELECT FirstName AS Nome,
LastName AS Sobrenome,
YEAR(BirthDate) AS Ano_Nascimento
FROM Employees
WHERE YEAR(BirthDate) >= 1960;

-- 3.	Quais os Nomes, Contatos e Endereços dos clientes residentes no ‘Brazil’ ou na ‘Argentina’? 
SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Country IN ('Brazil',  'Argentina');

-- 4.	Quais os Nomes, Contatos e Endereços dos clientes que não residem nem no ‘Brazil’, nem na ‘Germany”, nem na “France”, e nem nos “USA”? 

SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Country NOT IN ('Brazil',  'Germany', 'France', 'USA');

-- 5.	Quais os Nome e valor dos Produtos cujos Preços estão entre 205.0 e 305.0, inclusive? 

SELECT ProductName, Price
FROM Products
WHERE Price BETWEEN 205 AND 305;

-- 6.	Quais os Nomes e as Cidades dos clientes cujos Nomes iniciam por B ou R? 

SELECT CustomerName, City
FROM Customers
WHERE LEFT (CustomerName, 1) IN ('B', 'R');

-- 7.	Qual a lista de Cidades onde há um fornecedor de produto? 

SELECT DISTINCT City
FROM Suppliers;

-- 8.	Qual o Ranking de Produtos por preço? Isto é, liste os nomes e preços dos produtos ordenados do maior para o menor preço. 

SELECT ProductName, Price
FROM Products
ORDER BY Price DESC;

-- 9.	Forneça as quantidades X e Y para o departamento de marketing completar a frase: “Atendemos à cliente de Y nacionalidades diferentes, residentes em X cidades pelo mundo”. 
-- X: 

SELECT COUNT(DISTINCT City) FROM Customers;

--	Y: 

SELECT COUNT(DISTINCT Country) FROM Customers;

-- 10.	Qual o maior preço, o menor preço, a média de preços e a faixa de preços dos produtos comercializados? 

SELECT MIN(Price) AS Preco_Minimo, 
       MAX(Price) AS Preco_Maxino,
       AVG(Price) AS Preco_Medio,
       (MAX(Price) - MIN(Price)) AS Faixa_Preco
FROM Products;

-- 11.	Qual a lista de “nomes completos” dos funcionários e as suas idades em 31 de dezembro do ano corrente? 

SELECT CONCAT(FirstName, ' ', LastName) AS Nome_Completo,
YEAR(NOW()) - YEAR(BirthDate) AS Idade
FROM Employees;

-- 12.	Apresente uma lista com o Nome de Produto, sua unidade de comercialização, e uma nova coluna contendo a classificação do produto por “Faixa de preço”. Essas faixas se dividem em: “Preço baixo”, quando o preço do produto é igual ou menor que $10.00, “Preço médio”, quando o preço varia de $10.01 até $49,99, “Preço alto”, quando este estiver entre $50,00 até $99,99, e “Preço Elevado” para valores maiores que todas as demais faixas. 

SELECT ProductName AS Nome_Produto,
Unit AS Unidade_Comercializacao,
CASE
    WHEN Price <= 10 THEN 'Preço baixo'
    WHEN Price > 10 AND Price < 50 THEN 'Preço médio'
    WHEN Price >= 50 AND Price < 100 THEN 'Preço alto'
    WHEN Price >= 100 THEN 'Preço Elevado'
END AS Faixa_Preco
FROM Products;

-- 13.	Qual o Ranking das Cidades por quantidade de clientes? E o ranking dos países? 
-- Ranking das cidades:

SELECT City AS Cidade,
COUNT(*) AS Numero_Clientes
FROM Customers
GROUP BY Cidade
ORDER BY Numero_Clientes DESC;

-- Ranking dos países:

SELECT Country AS Pais,
COUNT(*) AS Numero_Clientes
FROM Customers
GROUP BY Pais
ORDER BY Numero_Clientes DESC; 

-- Nível Intermediário
-- 14.	Quais os Nomes, Contatos e Endereços dos Clientes que fizeram pedidos em 1998? 

SELECT c.CustomerName, c.ContactName, c.Address
FROM Orders AS o
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 1998;

-- 15.	Quais os países (nacionalidade) dos clientes que fizeram pedidos em fevereiro de 1998?  

SELECT c.CustomerName AS Nome,
c.Country AS Pais,
o.OrderDate AS Data_Pedido
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(OrderDate) = 1998 AND MONTH(OrderDate) = 02;

-- 16.	Quais os clientes que compraram mais de 10 produtos diferentes? E os que compraram mais de 100 produtos repetidos ou não? 
-- 10 produtos diferentes:

SELECT c.CustomerName, COUNT(DISTINCT od.ProductID) AS Num_compras
FROM ((Orders AS o
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID)
INNER JOIN OrderDetails AS od ON o.OrderID = od.OrderID)
GROUP BY c.CustomerID
HAVING Num_compras > 10;

--	100 produtos repetidos ou não:

SELECT c.CustomerName, COUNT(od.ProductID) AS Num_compras
FROM ((Orders AS o
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID)
INNER JOIN OrderDetails AS od ON o.OrderID = od.OrderID)
GROUP BY c.CustomerID
HAVING Num_compras > 100;

-- 17.	Quais as faixas de preços dos produtos de cada Categorias, ou seja, qual o maior e o menor preço dos produtos de cada categoria? 

SELECT cat.CategoryName as Nome_Categoria,
MIN(p.Price) as Valor_minimo,
MAX(p.Price) as Valor_maximo
FROM Categories cat
JOIN Products p ON cat.CategoryID = p.CategoryID
GROUP BY Nome_Categoria;

-- 18.	Quais Empregados atenderam à Clientes brasileiros?  

SELECT DISTINCT(e.FirstName)
FROM ((Employees AS e
INNER JOIN Orders AS o ON e.EmployeeID = o.EmployeeID)
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID)
WHERE c.Country = 'Brazil';

-- 19.	Quais produtos os brasileiros mais compraram? 

SELECT p.ProductName AS Produto,
COUNT(*) AS Num_Compras_Brasileiros
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE c.Country = 'Brazil'
GROUP BY p.ProductName
ORDER BY Num_Compras_Brasileiros DESC;

-- 20.	Quais produtos foram vendidos para clientes dos USA em 1997? 

SELECT DISTINCT(p.ProductName)
FROM (((Products AS p
INNER JOIN OrderDetails AS od ON p.ProductID = od.ProductID)
INNER JOIN Orders AS o ON od.OrderID = o.OrderID)
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID)
WHERE c.Country = 'USA' AND YEAR(o.OrderDate) = 1997
ORDER BY p.ProductName ASC;

-- 21.	Qual o Cliente que comprou mais em 1996, em quantidade de produtos e em valor, e qual foi o Funcionário que mais o atendeu? (Não conseguimos fazer aparecer o funcionário que mais atendeu o cliente)
-- Em quantidade de produtos:

SELECT c.CustomerName AS 'Cliente que mais comprou',
COUNT(DISTINCT o.OrderID) AS 'Número de compras',
SUM(p.Price * od.Quantity) AS 'Valor total comprado',
CONCAT(e.FirstName, ' ', e.LastName) AS 'Funcionário que mais atendeu o cliente que mais comprou'
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerId
JOIN OrderDetails od ON od.OrderID = o.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY c.CustomerName
ORDER BY COUNT(DISTINCT o.OrderID) DESC, SUM(p.Price * od.Quantity) DESC
LIMIT 1;

-- Em valor comprado:

SELECT c.CustomerName AS 'Cliente que mais comprou',
COUNT(DISTINCT o.OrderID) AS 'Número de compras',
SUM(p.Price * od.Quantity) AS 'Valor total comprado',
CONCAT(e.FirstName, ' ', e.LastName) AS 'Funcionário que mais atendeu o cliente que mais comprou'
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerId
JOIN OrderDetails od ON od.OrderID = o.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY c.CustomerName
ORDER BY COUNT(DISTINCT o.OrderID) DESC, SUM(p.Price * od.Quantity) DESC
LIMIT 1;

-- 22.	Quais os clientes que residem na mesma cidade? 

SELECT CustomerID, CustomerName, City
FROM Customers
WHERE City = ANY(SELECT City
          	FROM Customers
          	GROUP BY City
          	HAVING COUNT(CustomerID) > 1)
ORDER BY City, CustomerName;

-- 23.	Quais os clientes que não fizeram pedidos? 

SELECT c.CustomerName
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- 24.	Há funcionários que não venderam? 

SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE EmployeeID NOT IN (
    SELECT DISTINCT EmployeeID
    FROM Orders
);

-- 25.	Quais funcionários foram responsáveis por menos de 50 pedidos? 

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS Nome_Funcionario,
COUNT(DISTINCT o.OrderID) as Contagem
FROM Employees e
JOIN Orders o ON o.EmployeeID = e.EmployeeID
GROUP BY Nome_Funcionario
HAVING Contagem < 50;

-- 26.	Quais Cliente e Fornecedor são do mesmo país? 

SELECT c.CustomerName AS Cliente,
s.SupplierName AS Fornecedor,
c.Country as Pais
FROM Customers c 
JOIN Suppliers s ON c.Country = s.Country
ORDER BY Pais;

-- 27.	Quais os Produtos vendidos cujos Fornecedores e Clientes são ambos dos USA? 

SELECT p.ProductName AS Produto,
c.CustomerName AS Cliente,
s.SupplierName AS Fornecedor
FROM Products p
JOIN OrderDetails od ON od.ProductID = p.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.Country = c.Country and s.Country = 'USA';

-- 28.	Qual o total de vendas em quantidades de produtos e valor por Categoria de Produtos? 

SELECT cat.CategoryName AS Categoria,
SUM(od.Quantity) AS Quantidade_Vendida,
SUM(p.Price * od.Quantity) AS Valor_Vendido
FROM Categories cat 
JOIN Products p ON cat.CategoryID = p.CategoryID
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY Categoria
ORDER BY Valor_Vendido DESC;

-- 29.	Qual(is) a(s) Cidade(s) com o maior número de vendas em quantidade e em valor? 
-- Em vendas:

SELECT c.City AS Cidade,
SUM(od.Quantity) AS Produtos_Vendidos
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY Cidade
ORDER BY Produtos_Vendidos DESC;

-- Em valor:

SELECT c.City AS Cidade,
SUM(od.Quantity * p.Price) AS Valor_Vendido
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY Cidade
ORDER BY Valor_Vendido DESC;

-- 30.	Quais os clientes que não fizeram pedidos? 

SELECT CustomerID, CustomerName
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID
                     			FROM Orders);

-- 31.	Qual o Top-10 (ranking dos dez primeiros) clientes que fizeram mais compras? (faça três SQL, uma para cada opção de quantificação: “por quantidade de pedidos”, “por quantidade de produtos comprados” e “por valor total das compras”). 
-- Por quantidade de pedidos:

SELECT c.CustomerName AS Nome_Cliente,
COUNT(DISTINCT o.OrderId) AS Quantidade_Pedidos
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY Nome_Cliente
ORDER BY Quantidade_Pedidos DESC
LIMIT 10;

-- Por quantidade de produtos comprados:

SELECT c.CustomerName AS Nome_Cliente,
SUM(od.Quantity) AS Quantidade_Produtos_Comprados
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY Nome_Cliente
ORDER BY Quantidade_Produtos_Comprados DESC
LIMIT 10;

●	Por valor total das compras:

SELECT c.CustomerName AS Nome_Cliente,
SUM(od.Quantity * p.Price) AS Valor_Total_Compras
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductId = p.ProductID
GROUP BY Nome_Cliente
ORDER BY Valor_Total_Compras DESC
LIMIT 10;

-- 32.	Qual o Top-10 das nacionalidades que mais compraram? Depois separe por ano. (Não conseguimos separar por ano)

SELECT c.Country AS Pais,
SUM(od.Quantity) AS Quantidade_Produtos_Comprados
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY Pais
ORDER BY Quantidade_Produtos_Comprados DESC
LIMIT 10;

-- 33.	Qual o Top-10 dos Funcionários que mais venderam? (faça pelas três quantificações). Depois responda: qual a idade que mais vendeu? 
-- Por quantidade de pedidos:

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS Funcionario,
COUNT(DISTINCT o.OrderID) AS Quantidade_Pedidos
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY Funcionario
ORDER BY Quantidade_Pedidos DESC
LIMIT 10;

-- Por quantidade de produtos vendidos:

SELECT c.CustomerName AS Cliente,
SUM(od.Quantity) AS Produtos_Comprados,
(
SELECT CONCAT(e.FirstName, ' ', e.LastName)
FROM Orders o2
JOIN Employees e ON o2.EmployeeID = e.EmployeeID
WHERE o2.CustomerID = c.CustomerID
GROUP BY e.EmployeeID
ORDER BY COUNT(o2.OrderID) DESC
LIMIT 1
) AS Funcionario_Atendeu_Mais
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY c.CustomerID, c.CustomerName
ORDER BY Produtos_Comprados DESC
LIMIT 1;

-- Por valor total das vendas:

SELECT c.CustomerName AS Cliente,
SUM(p.Price * od.Quantity) AS Valor_Total_Comprado,
(
SELECT CONCAT(e.FirstName, ' ', e.LastName)
FROM Orders o2
JOIN Employees e ON o2.EmployeeID = e.EmployeeID
WHERE o2.CustomerID = c.CustomerID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY COUNT(o2.OrderID) DESC
LIMIT 1
) AS Funcionario_Atendeu_Mais
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY c.CustomerID, c.CustomerName
ORDER BY Valor_Total_Comprado DESC
LIMIT 1;

-- 34.	Qual o Top-10 dos Produtos que mais venderam? 

SELECT p.ProductName AS Nome_Produto,
SUM(od.Quantity) AS Quantidade_Vendida
FROM Products p 
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY Nome_Produto
ORDER BY Quantidade_Vendida DESC
LIMIT 10;

-- 35.	Há Frentista que entrega em todos os países? Qual o que entrega em mais países? 

SELECT ship.ShipperName AS Nome_Frentista,
COUNT(DISTINCT c.Country) AS Numero_Paises_Entrega,
CASE
WHEN (COUNT(DISTINCT c.Country) = (SELECT COUNT(DISTINCT Country) FROM Customers)) = 1 THEN 'Sim'
ELSE 'Não'
END AS 'Entrega mundialmente?'
FROM Shippers ship
JOIN Orders o ON ship.ShipperID = o.ShipperID
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY ship.ShipperName
ORDER BY Numero_Paises_Entrega DESC;

-- Nível Avançado
-- 36.	Quais Funcionários são mais novos que a funcionária “Margaret Peacock”? 

SELECT CONCAT(FirstName, ' ', LastName) AS Nome_Funcionario
FROM Employees
WHERE BirthDate > (SELECT BirthDate
              	FROM Employees
              	WHERE FirstName = 'Margaret'
              	AND LastName = 'Peacock');

-- 37.	Quantos pedidos foram feitos depois do último pedido feito por “Anne Dodsworth”? 

SELECT COUNT(DISTINCT o.OrderID) AS Num_Pedidos
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE o.OrderDate > (
SELECT MAX(o.OrderDate)
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE e.LastName = 'Dodsworth' AND e.FirstName = 'Anne'
);

-- 38.	Quais Funcionários atenderam à Clientes que a funcionária “Margaret Peacock” também atendeu? 

SELECT DISTINCT CONCAT(e.FirstName, ' ', e.LastName) AS Nome_Funcionario
FROM Orders AS o
INNER JOIN Employees AS e ON o.EmployeeID = e.EmployeeID
WHERE o.CustomerID IN (SELECT CustomerID
                 		    FROM Orders
                 		    WHERE EmployeeID = (SELECT EmployeeID
                                    			FROM Employees
                                    			WHERE FirstName = 'Margaret'
                                      			AND LastName = 'Peacock')
                 		    )
AND o.EmployeeID <> (SELECT EmployeeID
              		FROM Employees
              		WHERE FirstName = 'Margaret'
              		AND LastName = 'Peacock');

-- 39.	Qual o ranking de percentagem de participação de cada produto no total de vendas de produtos, por valor total, em cada ano? 

SELECT p.ProductName AS Produto,
YEAR(o.OrderDate) AS Ano,
SUM(p.Price * od.Quantity) AS Total_Vendas,
SUM(p.Price * od.Quantity) / (
        SELECT SUM(p2.Price * od2.Quantity)
        FROM Products p2
        JOIN OrderDetails od2 ON p2.ProductID = od2.ProductID
        JOIN Orders o2 ON od2.OrderID = o2.OrderID
        WHERE YEAR(o2.OrderDate) = YEAR(o.OrderDate)
    ) * 100 AS 'Participacao_%'
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY p.ProductName, Ano
ORDER BY Ano DESC, Total_Vendas DESC;

-- 40.	Qual o ranking de percentagem de participação no total de vendas de produtos, por quantidade de produtos vendidos, por país do fornecedor? 

SELECT s.Country AS Pais_Fornecedor,
       s.SupplierName AS Nome_Fornecedor,
       SUM(od.Quantity) AS Total_Produtos_Vendidos,
       SUM(od.Quantity) / TotalQuantity.Total * 100 AS Participacao_Percentual
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN (
    SELECT s2.Country AS Pais_Fornecedor, SUM(od2.Quantity) AS Total
    FROM Suppliers s2
    JOIN Products p2 ON s2.SupplierID = p2.SupplierID
    JOIN OrderDetails od2 ON p2.ProductID = od2.ProductID
    GROUP BY Pais_Fornecedor
) AS TotalQuantity ON s.Country = TotalQuantity.Pais_Fornecedor
GROUP BY s.Country, s.SupplierName, TotalQuantity.Total
ORDER BY Pais_Fornecedor, Participacao_Percentual DESC;
