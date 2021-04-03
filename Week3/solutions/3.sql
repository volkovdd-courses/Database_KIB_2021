-- Вывести сотрудников, которые старше своего менеджера, но были наняты позже своего менеджера.
-- Вывести полное имя сотрудника(Фамилия<Пробел>Имя), день рождения, дата найма, полное имя менеджера, день рождения, дата найма.
-- (employee_full_name, employee_birth_date, employee_hire_date, manager_full_name, manager_birth_date, manager_hire_date)

SELECT employee.last_name || ' ' || employee.first_name as employee_full_name,
       employee.birth_date as employee_birth_date,
       employee.hire_date as employee_hire_date,
       manager.last_name || ' ' || manager.first_name as manager_full_name,
       manager.birth_date as manager_birth_date,
       manager.hire_date as manager_hire_date
FROM
     employee
     JOIN employee as manager ON employee.reports_to = manager.employee_id
WHERE
    (employee.birth_date < manager.birth_date) AND
    (employee.hire_date > manager.hire_date);
