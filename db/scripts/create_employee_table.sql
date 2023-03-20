CREATE TABLE employee
(
    id     serial PRIMARY KEY,
    name   text,
    age    int,
    salary int
);

insert into employee (name, age, salary) VALUES ('emp_1', 23, 500);
insert into employee (name, age, salary) VALUES ('emp_2', 45, 700);
insert into employee (name, age, salary) VALUES ('emp_3', 36, 1000);