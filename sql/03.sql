SELECT DISTINCT ON (dep_id)
    dep_id,
    nome,
    salario
FROM empregados
ORDER BY dep_id, salario DESC;

-- WITH EmpregadoSalarioRank AS (
--     SELECT
--         dep_id,
--         nome,
--         salario,
--         ROW_NUMBER() OVER (
--             PARTITION BY dep_id
--             ORDER BY
--                 salario DESC
--         ) AS salario_rank
--     FROM
--         empregados
-- )
-- SELECT
--     dep_id,
--     nome,
--     salario
-- FROM
--     EmpregadoSalarioRank
-- WHERE
--     salario_rank = 1;