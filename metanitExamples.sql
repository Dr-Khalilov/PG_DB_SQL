CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    login varchar(60) NOT NULL CHECK (login != ''),
    email varchar(64) NOT NULL UNIQUE CHECK(email != ''),
    password varchar(100) NOT NULL UNIQUE CHECK (password != '')
);

CREATE TABLE employees(
    user_id int PRIMARY KEY REFERENCES users,
    salary decimal(10, 2) NOT NULL CHECK(salary >0),
    department varchar(20) NOT NULL CHECK(department != ''),
    position varchar(20) NOT NULL CHECK(position != ''),
    hire_date TIMESTAMP NOT NULL DEFAULT current_timestamp
);

ALTER TABLE users DROP COLUMN password;
ALTER TABLE users ADD COLUMN password_hash TEXT NOT NULL;
ALTER TABLE employees DROP COLUMN user_id;
DROP TABLE employees;


INSERT INTO users(login, email, password_hash)
VALUES('TEST23','TEST@mail.com','34fgew34s98eru32o0-urf'),
('TESt34','TEST@gmail.com','34fgeergrfw34s98eru32o0-urf'),
('TESt3','TEST@gmail3.com','34fgeergrfw34s98eru3rrf');

INSERT INTO users(login, email,password_hash) 
VALUES('TEeees','TEST@gmal3.com','34fgefeeergrfw34s98eru3rrf');

DROP TABLE users CASCADE;

INSERT INTO employees(user_id,salary,department,position)
VALUES(1,10000, 'Software','Java-developer'),
(2,1000, 'Software','JavaScript-developer'),
(3,100, 'HR','Project-manager');

SELECT users.*, COALESCE( employees.salary,0) FROM users
 LEFT JOIN employees ON employees.user_id = users.id;

SELECT * FROM users
WHERE users.id NOT IN(SELECT employees.user_id FROM employees);

/* 
 WINDOW FUNCTIONS 
 */
CREATE SCHEMA wf;
/*  */
CREATE TABLE wf.employees(
  id serial PRIMARY KEY,
  "name" varchar(256) NOT NULL CHECK("name" != ''),
  salary numeric(10, 2) NOT NULL CHECK (salary >= 0),
  hire_date timestamp NOT NULL DEFAULT current_timestamp
);
/*  */
CREATE TABLE wf.departments(
  id serial PRIMARY KEY,
  "name" varchar(64) NOT NULL
);
/*  */
ALTER TABLE wf.employees
ADD COLUMN department_id int REFERENCES wf.departments;
/*  */
INSERT INTO wf.departments("name")
VALUES ('SALES'),
  ('HR'),
  ('DEVELOPMENT'),
  ('QA'),
  ('TOP MANAGEMENT');
INSERT INTO wf.employees ("name", salary, hire_date, department_id)
VALUES ('TEST TESTov', 10000, '1990-1-1', 1),
  ('John Doe', 6000, '2010-1-1', 2),
  ('Matew Doe', 3456, '2020-1-1', 2),
  ('Matew Doe1', 53462, '2020-1-1', 3),
  ('Matew Doe2', 124543, '2012-1-1', 4),
  ('Matew Doe3', 12365, '2004-1-1', 5),
  ('Matew Doe4', 1200, '2000-8-1', 5),
  ('Matew Doe5', 2535, '2010-1-1', 2),
  ('Matew Doe6', 1000, '2014-1-1', 3),
  ('Matew Doe6', 63456, '2017-6-1', 1),
  ('Matew Doe7', 1000, '2020-1-1', 3),
  ('Matew Doe8', 346434, '2015-4-1', 2),
  ('Matew Doe9', 3421, '2018-1-1', 3),
  ('Matew Doe0', 34563, '2013-2-1', 5),
  ('Matew Doe10', 2466, '2011-1-1', 1),
  ('Matew Doe11', 9999, '1999-1-1', 5),
  ('TESTing 1', 1000, '2019-1-1', 2);
/*  */
SELECT d.name,
  count(e.id)
FROM wf.departments d
  JOIN wf.employees e ON e.department_id = d.id
GROUP BY d.id;
/*  */
SELECT e.*,
  d.name
FROM wf.departments d
  JOIN wf.employees e ON e.department_id = d.id
  /*  */
SELECT avg(e.salary),
  d.id
FROM wf.departments d
  JOIN wf.employees e ON e.department_id = d.id
GROUP BY d.id;
/* JOIN
 user|dep|avg dep salary
 
 */
SELECT e.*,
  d.name,
  "d_a_s"."avg_salary"
FROM wf.departments d
  JOIN wf.employees e ON e.department_id = d.id
  JOIN (
    SELECT avg(e.salary) AS "avg_salary",
      d.id
    FROM wf.departments d
      JOIN wf.employees e ON e.department_id = d.id
    GROUP BY d.id
  ) AS "d_a_s" ON d.id = d_a_s.id;
  /* WINDOW FUNC 
   user|dep|avg dep salary
   */
SELECT e.*,
  d.name,
  round(sum(e.salary) OVER (PARTITION BY d.id)) as "avg_dep_salary",
  sum(e.salary) OVER ()
FROM wf.departments d
  JOIN wf.employees e ON e.department_id = d.id;
