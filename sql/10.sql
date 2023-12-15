SELECT
    e.nome,
    e.salario,
    e.dep_id,
    avg.avg_salario
FROM
    empregados e
    JOIN (
        SELECT
            e.dep_id,
            AVG(e.salario) AS avg_salario
        FROM
            empregados e
        GROUP BY
            e.dep_id
    ) avg ON e.dep_id = avg.dep_id
WHERE
    e.salario >= avg.avg_salario;