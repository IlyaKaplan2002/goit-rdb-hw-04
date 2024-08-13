CREATE SCHEMA LibraryManagement;

USE LibraryManagement;

CREATE TABLE IF NOT EXISTS authors (
    author_id INT auto_increment PRIMARY KEY,
    author_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS genres (
    genre_id INT auto_increment PRIMARY KEY,
    genre_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS books (
    book_id INT auto_increment PRIMARY KEY,
    title VARCHAR(255),
    publication_year YEAR,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) references authors (author_id),
    FOREIGN KEY (genre_id) references genres (genre_id)
);

CREATE TABLE IF NOT EXISTS users (
    user_id INT auto_increment PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS borrowed_books (
    borrow_id INT auto_increment PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date date,
    return_date date,
    FOREIGN KEY (book_id) references books (book_id),
    FOREIGN KEY (user_id) references users (user_id)
);

INSERT INTO
    authors (author_name)
VALUES ('Test Author 1'),
    ('Test Author 2');

SELECT * FROM authors;

INSERT INTO
    genres (genre_name)
VALUES ('Test Genre 1'),
    ('Test Genre 2');

SELECT * FROM genres;

INSERT INTO
    books (
        title,
        publication_year,
        author_id,
        genre_id
    )
VALUES ('Test Book 1', 2000, 1, 1),
    ('Test Book 2', 2001, 1, 1);

SELECT * FROM books;

INSERT INTO
    users (username, email)
VALUES (
        'Test User 1',
        'test1@mail.com'
    ),
    (
        'Test User 2',
        'test2@mail.com'
    );

SELECT * FROM users;

INSERT INTO
    borrowed_books (
        book_id,
        user_id,
        borrow_date,
        return_date
    )
VALUES (
        1,
        1,
        '2024-01-01',
        '2024-01-02'
    ),
    (
        2,
        2,
        '2024-02-02',
        '2024-02-03'
    );

SELECT * FROM borrowed_books;

USE mydb;

SELECT *
FROM
    orders o
    INNER JOIN order_details od ON o.id = od.order_id
    INNER JOIN customers cs ON o.customer_id = cs.id
    INNER JOIN employees em ON o.employee_id = em.employee_id
    INNER JOIN shippers sh ON o.shipper_id = sh.id
    INNER JOIN products pr ON od.product_id = pr.id
    INNER JOIN categories ct ON pr.category_id = ct.id
    INNER JOIN suppliers su ON pr.supplier_id = su.id;

SELECT count(*)
FROM
    orders o
    INNER JOIN order_details od ON o.id = od.order_id
    INNER JOIN customers cs ON o.customer_id = cs.id
    INNER JOIN employees em ON o.employee_id = em.employee_id
    INNER JOIN shippers sh ON o.shipper_id = sh.id
    INNER JOIN products pr ON od.product_id = pr.id
    INNER JOIN categories ct ON pr.category_id = ct.id
    INNER JOIN suppliers su ON pr.supplier_id = su.id;

SELECT count(*)
FROM
    orders o
    LEFT JOIN order_details od ON o.id = od.order_id
    LEFT JOIN customers cs ON o.customer_id = cs.id
    LEFT JOIN employees em ON o.employee_id = em.employee_id
    LEFT JOIN shippers sh ON o.shipper_id = sh.id
    LEFT JOIN products pr ON od.product_id = pr.id
    LEFT JOIN categories ct ON pr.category_id = ct.id
    LEFT JOIN suppliers su ON pr.supplier_id = su.id;

SELECT count(*)
FROM
    orders o
    LEFT JOIN order_details od ON o.id = od.order_id
    RIGHT JOIN customers cs ON o.customer_id = cs.id
    LEFT JOIN employees em ON o.employee_id = em.employee_id
    LEFT JOIN shippers sh ON o.shipper_id = sh.id
    LEFT JOIN products pr ON od.product_id = pr.id
    LEFT JOIN categories ct ON pr.category_id = ct.id
    LEFT JOIN suppliers su ON pr.supplier_id = su.id;

SELECT count(*)
FROM
    orders o
    INNER JOIN order_details od ON o.id = od.order_id
    INNER JOIN customers cs ON o.customer_id = cs.id
    INNER JOIN employees em ON o.employee_id = em.employee_id
    INNER JOIN shippers sh ON o.shipper_id = sh.id
    INNER JOIN products pr ON od.product_id = pr.id
    INNER JOIN categories ct ON pr.category_id = ct.id
    INNER JOIN suppliers su ON pr.supplier_id = su.id
WHERE
    o.employee_id > 3
    AND o.employee_id <= 10;

SELECT ct.name, count(*), AVG(od.quantity)
FROM
    orders o
    INNER JOIN order_details od ON o.id = od.order_id
    INNER JOIN customers cs ON o.customer_id = cs.id
    INNER JOIN employees em ON o.employee_id = em.employee_id
    INNER JOIN shippers sh ON o.shipper_id = sh.id
    INNER JOIN products pr ON od.product_id = pr.id
    INNER JOIN categories ct ON pr.category_id = ct.id
    INNER JOIN suppliers su ON pr.supplier_id = su.id
WHERE
    o.employee_id > 3
    AND o.employee_id <= 10
GROUP BY
    ct.name;

SELECT ct.name, count(*), AVG(od.quantity)
FROM
    orders o
    INNER JOIN order_details od ON o.id = od.order_id
    INNER JOIN customers cs ON o.customer_id = cs.id
    INNER JOIN employees em ON o.employee_id = em.employee_id
    INNER JOIN shippers sh ON o.shipper_id = sh.id
    INNER JOIN products pr ON od.product_id = pr.id
    INNER JOIN categories ct ON pr.category_id = ct.id
    INNER JOIN suppliers su ON pr.supplier_id = su.id
WHERE
    o.employee_id > 3
    AND o.employee_id <= 10
GROUP BY
    ct.name
HAVING
    AVG(od.quantity) > 21;

SELECT ct.name, count(*), AVG(od.quantity)
FROM
    orders o
    INNER JOIN order_details od ON o.id = od.order_id
    INNER JOIN customers cs ON o.customer_id = cs.id
    INNER JOIN employees em ON o.employee_id = em.employee_id
    INNER JOIN shippers sh ON o.shipper_id = sh.id
    INNER JOIN products pr ON od.product_id = pr.id
    INNER JOIN categories ct ON pr.category_id = ct.id
    INNER JOIN suppliers su ON pr.supplier_id = su.id
GROUP BY
    ct.name
HAVING
    AVG(od.quantity) > 21
ORDER BY count(*) DESC;

SELECT ct.name, count(*), AVG(od.quantity)
FROM
    orders o
    INNER JOIN order_details od ON o.id = od.order_id
    INNER JOIN customers cs ON o.customer_id = cs.id
    INNER JOIN employees em ON o.employee_id = em.employee_id
    INNER JOIN shippers sh ON o.shipper_id = sh.id
    INNER JOIN products pr ON od.product_id = pr.id
    INNER JOIN categories ct ON pr.category_id = ct.id
    INNER JOIN suppliers su ON pr.supplier_id = su.id
GROUP BY
    ct.name
HAVING
    AVG(od.quantity) > 21
ORDER BY count(*) DESC
LIMIT 1, 4;