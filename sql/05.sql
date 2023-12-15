-- SQL script 05.sql
SELECT
    d.nome,
    employee_count
FROM
    (
        SELECT
            d.dep_id,
            d.nome,
            COUNT(e) AS employee_count
        FROM
            departamentos d
            LEFT JOIN empregados e ON e.dep_id = d.dep_id
        GROUP BY
            d.dep_id,
            d.nome
    ) d;