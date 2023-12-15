-- SQL script 06.sql
SELECT
    e.nome
from
    empregados e
    join empregados e2 on e.supervisor_id = e2.emp_id
where
    e.dep_id != e2.dep_id;