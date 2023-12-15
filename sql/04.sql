-- SQL script 04.sql
-- 4 Listar os nomes departamentos que tem menos de 3 empregados;
SELECT
    d.nome
FROM
    departamentos d
    LEFT JOIN empregados e ON e.dep_id = d.dep_id
GROUP BY
    d.dep_id,
    d.nome
HAVING
    COUNT(*) < 3;