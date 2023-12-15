-- SQL script 07.sql
SELECT
    DISTINCT d.nome,
    COALESCE(SUM(e.salario) OVER (PARTITION BY d.dep_id), 0) AS total_salarios
FROM
    departamentos d
    LEFT JOIN empregados e ON d.dep_id = e.dep_id;