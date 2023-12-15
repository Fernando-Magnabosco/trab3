-- SQL script 01.sql
SELECT
    *
from
    empregados e
    join empregados e1 on e.supervisor_id = e1.emp_id
where
    e.salario > e1.salario;