CREATE VIEW cond_menos_21 AS
SELECT pf.CPF, pf.idade
FROM (SELECT CPF, TIMESTAMPDIFF(YEAR, Nasc, CURDATE()) AS idade
	  FROM pessoa_fisica) AS pf
JOIN condutor c ON pf.CPF = c.CPF
WHERE pf.idade < 21;

CREATE VIEW num_reser_vei AS
SELECT Placa, COUNT(Placa)
FROM subsis_locacao
GROUP BY Placa;

SELECT Placa, COUNT(Placa)
FROM subsis_locacao
GROUP BY Placa;