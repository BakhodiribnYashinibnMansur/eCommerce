
CREATE TABLE company(
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
company_name VARCHAR(255) PRIMARY KEY NOT NULL,
email VARCHAR(255)  NOT NULL,
descriptions VARCHAR(255)  NOT NULL
);

CREATE TABLE  company_employees(
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
username VARCHAR(255)  NOT NULL UNIQUE,
roler VARCHAR(25)  NOT NULL DEFAULT 'admin',
password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE company_employees_controller(
id          serial       NOT NULL unique,
company_id INT REFERENCES company(id) ON DELETE CASCADE ,
employee_id INT REFERENCES company_employees(id) ON DELETE CASCADE
);

CREATE TABLE menu_categories(
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
title VARCHAR(255) NOT NULL,
descriptions VARCHAR(255) NULL,
picture_path VARCHAR(255)  NULL,
active BOOLEAN DEFAULT TRUE
);

CREATE TABLE file_upload (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
file_name VARCHAR(255) NOT NULL,
file_path VARCHAR(255) NOT NULL,
original_name VARCHAR(255) NOT NULL,
file_size INT NOT NULL
);

CREATE TABLE menu_categories_file (
id          serial       NOT NULL unique,
menu_categories_id INT REFERENCES menu_categories(id) ON DELETE CASCADE ,
photo_path INT REFERENCES file_upload(id) ON DELETE CASCADE
);

CREATE TABLE employees_menu_categories (
id          serial       NOT NULL unique,
menu_categories_id INT REFERENCES menu_categories(id) ON DELETE CASCADE ,
company_employee_id INT REFERENCES company_employees(id) ON DELETE CASCADE
);

CREATE TABLE product_categories(
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
title VARCHAR(255) NOT NULL,
descriptions VARCHAR(255) NULL,
picture_path VARCHAR(255)  NULL,
active BOOLEAN DEFAULT TRUE
);

CREATE TABLE product_categories_file (
id          serial       NOT NULL unique,
product_categories_id INT REFERENCES product_categories(id) ON DELETE CASCADE ,
photo_path INT REFERENCES file_upload(id) ON DELETE CASCADE
);

CREATE TABLE employees_product_categories (
id          serial       NOT NULL unique,
product_categories_id INT REFERENCES product_categories(id) ON DELETE CASCADE ,
company_employee_id INT REFERENCES company_employees(id) ON DELETE CASCADE
);

CREATE TABLE menu_product_categories (
id          serial       NOT NULL unique,
menu_categories_id INT REFERENCES menu_categories(id) ON DELETE CASCADE ,
product_categories_id INT REFERENCES product_categories(id) ON DELETE CASCADE
);

CREATE TABLE products(
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
title VARCHAR(255) NOT NULL,
descriptions VARCHAR(255) NULL,
picture_path VARCHAR(255)  NULL,
active BOOLEAN DEFAULT TRUE,
created_by_employees VARCHAR(255) NOT NULL,
price    INT NOT  NULL,
stock   INT  NOT NULL,
discount   INT NOT  NULL,
weights INT NOT NULL,
veiws INT NOT NULL,
likes INT NOT NULL,
color VARCHAR NOT NULL
);

CREATE TABLE brand (
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
name VARCHAR(255) NOT NULL,
logo VARCHAR(255) NOT NULL
);

CREATE TABLE product_brand (
id          serial       NOT NULL unique,
product_id INT REFERENCES products(id) ON DELETE CASCADE ,
brand_id INT REFERENCES brand(id) ON DELETE CASCADE
);

CREATE TABLE employees_product (
id          serial       NOT NULL unique,
product INT REFERENCES products(id) ON DELETE CASCADE ,
company_employee_id INT REFERENCES company_employees(id) ON DELETE CASCADE
);

CREATE TABLE products_file (
id          serial       NOT NULL unique,
products_id INT REFERENCES products(id) ON DELETE CASCADE ,
photo_path INT REFERENCES file_upload(id) ON DELETE CASCADE
);

CREATE TABLE product_categories_products (
id          serial       NOT NULL unique,
product_categories_id INT REFERENCES product_categories(id) ON DELETE CASCADE ,
product_id INT REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE  costumers(
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
username VARCHAR(255)  NOT NULL UNIQUE,
phone_number INT NOT NULL,
password_hash VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
email_verified_at BOOLEAN NOT NULL
);

CREATE TABLE addresses (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
country VARCHAR(255) NOT NULL,
city VARCHAR(255)  NULL,
region VARCHAR(255) NOT NULL,
street VARCHAR(255) NOT NULL,
zipcode VARCHAR(255) NOT NULL
);

CREATE TABLE users_address (
id          serial       NOT NULL unique,
users_id INT REFERENCES costumers(id) ON DELETE CASCADE ,
adress_id INT REFERENCES addresses(id) ON DELETE CASCADE
);

CREATE TABLE comments (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
content VARCHAR(2048)  NULL,
rating INT NULL
);

CREATE TABLE users_comments (
id          serial       NOT NULL unique,
users_id INT REFERENCES costumers(id) ON DELETE CASCADE ,
comments_id INT REFERENCES comments(id) ON DELETE CASCADE
);

CREATE TABLE orders (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
order_status BOOLEAN DEFAULT FALSE,
tranking_number VARCHAR(255) NOT NULL,
total INT NOT NULL
);

CREATE TABLE users_orders (
id          serial       NOT NULL unique,
users_id INT REFERENCES costumers(id) ON DELETE CASCADE ,
orders_id INT REFERENCES orders(id) ON DELETE CASCADE
);

CREATE TABLE order_items (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
product_id INT NOT NULL,
product_name VARCHAR(255) NOT NULL,
quantity INT NOT NULL,
total INT NOT NULL,
item_status BOOLEAN DEFAULT FALSE,
ship_date TIMESTAMP NOT NULL,
color VARCHAR NOT NULL
);

CREATE TABLE orders_order_item (
id          serial       NOT NULL unique,
order_id INT REFERENCES orders(id) ON DELETE CASCADE ,
order_item_id INT REFERENCES order_items(id) ON DELETE CASCADE
);

CREATE TABLE users_orders_items (
id          serial       NOT NULL unique,
users_id INT REFERENCES costumers(id) ON DELETE CASCADE ,
order_item_id INT REFERENCES order_items(id) ON DELETE CASCADE
);

CREATE TABLE employees_file (
id          serial       NOT NULL unique,
company_employee_id INT REFERENCES company_employees(id) ON DELETE CASCADE ,
file_id INT REFERENCES file_upload(id) ON DELETE CASCADE
);

CREATE TABLE payments (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
amount INT NOT NULL,
paymented BOOLEAN DEFAULT FALSE,
payment_type VARCHAR(255) NOT NULL
);

CREATE TABLE orders_payments (
id          serial       NOT NULL unique,
orders_id INT REFERENCES orders(id) ON DELETE CASCADE ,
payment_id INT REFERENCES payments(id) ON DELETE CASCADE
);


CREATE TABLE shipping_products (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
total DECIMAL NOT NULL
);

CREATE TABLE user_shipping_products (
id          serial       NOT NULL unique,
user_id INT REFERENCES costumers(id) ON DELETE CASCADE ,
shipping_product_id INT REFERENCES shipping_products(id) ON DELETE CASCADE
);

CREATE TABLE cart_items (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
quantity INT NOT NULL
);

CREATE TABLE cart_items_products (
id          serial       NOT NULL unique,
product_id INT REFERENCES products(id) ON DELETE CASCADE ,
cart_item_id INT REFERENCES cart_items(id) ON DELETE CASCADE
);

CREATE TABLE shipping_cart (
id          serial       NOT NULL unique,
shipping_products INT REFERENCES shipping_products(id) ON DELETE CASCADE ,
cart_item_id INT REFERENCES cart_items(id) ON DELETE CASCADE
);
