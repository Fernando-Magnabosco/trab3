-- SQL script 09.sql
SELECT
    e.dep_id,
    e.nome,
    e.salario,
    AVG(e.salario) OVER (PARTITION BY e.dep_id) AS avg_salario
FROM
    empregados e;