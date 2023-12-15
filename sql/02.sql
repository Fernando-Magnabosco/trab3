-- SQL script 02.sql
SELECT
    max(salario)
from
    empregados
group by
    dep_id;