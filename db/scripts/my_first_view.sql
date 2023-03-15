create table students
(
    id   serial primary key,
    name varchar(50)
);

insert into students (name)
values ('Иван Иванов');
insert into students (name)
values ('Петр Петров');
insert into students (name)
values ('Андрей Сидоров');

create table authors
(
    id   serial primary key,
    name varchar(50)
);

insert into authors (name)
values ('Александр Пушкин');
insert into authors (name)
values ('Николай Гоголь');
insert into authors (name)
values ('Николай Носов');

create table books
(
    id        serial primary key,
    name      varchar(200),
    author_id integer references authors (id)
);

insert into books (name, author_id)
values ('Евгений Онегин', 1);
insert into books (name, author_id)
values ('Капитанская дочка', 1);
insert into books (name, author_id)
values ('Дубровский', 1);
insert into books (name, author_id)
values ('Мертвые души', 2);
insert into books (name, author_id)
values ('Вий', 2);
insert into books (name, author_id)
values ('Живая шляпа', 3);
insert into books (name, author_id)
values ('Затейники', 3);
insert into books (name, author_id)
values ('Огурцы', 3);

create table orders
(
    id         serial primary key,
    active     boolean default true,
    book_id    integer references books (id),
    student_id integer references students (id)
);

insert into orders (book_id, student_id)
values (1, 1);
insert into orders (book_id, student_id)
values (3, 1);
insert into orders (book_id, student_id)
values (5, 2);
insert into orders (book_id, student_id)
values (4, 1);
insert into orders (book_id, student_id)
values (2, 2);
insert into orders (book_id, student_id)
values (6, 3);
insert into orders (book_id, student_id)
values (7, 2);
insert into orders (book_id, student_id)
values (8, 1);


create view my_first_view as
select s.name as student, b.name as book, a.name as author
from students as s
         join orders o on o.student_id = s.id
         join books b on b.id = o.id
         join authors a on a.id = b.author_id
where a.name like 'Николай%'
  and s.name like 'Иван%';