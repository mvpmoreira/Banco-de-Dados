CREATE VIEW Contagem_por_tema AS
SELECT Nome_tema, COUNT(*) FROM Projeto
GROUP BY Nome_tema;