CREATE DATABASE web;

CREATE TABLE web.ClientView
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    client_username TEXT NOT NULL,
    case_name TEXT NOT NULL,
    priority INT,
    target_date TEXT,
    product_area TEXT NOT NULL,
    status TEXT NOT NULL,
    description TEXT NOT NULL
);


RENAME USER 'root'@'localhost' TO 'root'@'%';