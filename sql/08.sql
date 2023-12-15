-- SQL script 08.sql
SELECT
    e.nome,
    e.salario
from
    empregados e
    join (
        SELECT
            e.dep_id,
            avg(e.salario) as avg_salario
        from
            empregados e
        group by
            e.dep_id
    ) avg on e.dep_id = avg.dep_id
where
    e.salario > avg.avg_salario;