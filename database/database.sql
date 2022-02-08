
CREATE TABLE company (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
company_name VARCHAR(255) PRIMARY KEY NOT NULL,
email VARCHAR(255)  NOT NULL,
descriptions VARCHAR(255)  NOT NULL,
)

CREATE TABLE  company_users(
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
username VARCHAR(255)  NOT NULL UNIQUE,
roler TEXT(25)  NOT NULL DEFAULT 'admin',
password_hash VARCHAR(255) NOT NULL
)

CREATE TABLE menu_categories(
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
title VARCHAR(255) NOT NULL,
descriptions VARCHAR(255) NULL,
picture_path VARCHAR(255)  NULL,
active BOOLEN DEFAULT TRUE,
)

CREATE TABLE menu_categories_file (
id          serial       not null unique,
menu_categories_id INTEGER REFERENCES menu_categories(id) ON DELETE CASCADE NOT NULL,
photo_path INTEGER REFERENCES file_upload(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE admin_menu_categories (
id          serial       not null unique,
menu_categories_id INTEGER REFERENCES menu_categories(id) ON DELETE CASCADE NOT NULL,
company_user_id INTEGER REFERENCES company_users(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE product_categories(
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
title VARCHAR(255) NOT NULL,
descriptions VARCHAR(255) NULL,
picture_path VARCHAR(255)  NULL,
active BOOLEN DEFAULT TRUE,
)

CREATE TABLE product_categories_file (
id          serial       not null unique,
product_categories_id INTEGER REFERENCES product_categories(id) ON DELETE CASCADE NOT NULL,
photo_path INTEGER REFERENCES file_upload(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE admin_menu_categories (
id          serial       not null unique,
product_categories_id INTEGER REFERENCES product_categories(id) ON DELETE CASCADE NOT NULL,
company_user_id INTEGER REFERENCES company_users(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE menu_product_categories (
id          serial       not null unique,
menu_categories_id INTEGER REFERENCES menu_categories(id) ON DELETE CASCADE NOT NULL,
product_categories_id INTEGER REFERENCES product_categories(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE products(
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
title VARCHAR(255) NOT NULL,
descriptions VARCHAR(255) NULL,
picture_path VARCHAR(255)  NULL,
active BOOLEN DEFAULT TRUE,
created_by_admin VARCHAR(255) NOT NULL,
price    INTEGER NOT  NULL,
stock   INTEGER  NOT NULL,
discount   INTEGER NOT  NULL,
weights INTEGER NOT NULL,
veiws INTEGER NOT NULL,
likes INTEGER NOT NULL,
color TEXT NOT NULL,
)

CREATE TABLE brand (
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
name VARCHAR(255) NOT NULL,
logo VARCHAR(255) NOT NULL,
)

CREATE TABLE product_brand (
id          serial       not null unique,
product_id INTEGER REFERENCES products(id) ON DELETE CASCADE NOT NULL,
brand_id INTEGER REFERENCES brand(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE admin_product (
id          serial       not null unique,
product INTEGER REFERENCES products(id) ON DELETE CASCADE NOT NULL,
company_user_id INTEGER REFERENCES company_users(id) ON DELETE CASCADE NOT NULL,
)
CREATE TABLE products_file (
id          serial       not null unique,
products_id INTEGER REFERENCES products(id) ON DELETE CASCADE NOT NULL,
photo_path INTEGER REFERENCES file_upload(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE product_categories_products (
id          serial       not null unique,
product_categories_id INTEGER REFERENCES product_categories(id) ON DELETE CASCADE NOT NULL,
product_id INTEGER REFERENCES products(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE  costumers(
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
username VARCHAR(255)  NOT NULL UNIQUE,
phone_number INTEGER NOT NULL,
password_hash VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
email_verified_at BOOLEN NOT NULL,
)

CREATE TABLE addresses (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
country VARCHAR(255) NOT NULL,
city VARCHAR(255)  NULL,
region VARCHAR(255) NOT NULL,
street VARCHAR(255) NOT NULL,
zipcode VARCHAR(255) NOT NULL,
)

CREATE TABLE users_address (
id          serial       not null unique,
users_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
adress_id INTEGER REFERENCES addresses(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE comments (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
content VARCHAR(2048)  NULL,
rating INTEGER NULL,
)

CREATE TABLE users_comments (
id          serial       not null unique,
users_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
comments_id INTEGER REFERENCES comments(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE orders (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
order_status BOOLEN DEFAULT FALSE,
tranking_number VARCHAR(255) NOT NULL,
total DEMICAL NOT NULL,
)

CREATE TABLE users_orders (
id          serial       not null unique,
users_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
orders_id INTEGER REFERENCES orders(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE order_items (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
product_id INTEGER NOT NULL,
product_name VARCHAR(255) NOT NULL,
quantity INTEGER NOT NULL,
total INTEGER NOT NULL,
item_status BOOLEN DEFAULT FALSE,
ship_date TIMESTAMP NOT NULL,
color TEXT NOT NULL,
)

CREATE TABLE orders_order_item (
id          serial       not null unique,
order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE NOT NULL,
order_item_id INTEGER REFERENCES order_items(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE users_orders (
id          serial       not null unique,
users_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
order_item_id INTEGER REFERENCES order_items(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE file_uploads (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
file_name VARCHAR(255) NOT NULL,
file_path VARCHAR(255) NOT NULL,
original_name VARCHAR(255) NOT NULL,
file_size INTEGER NOT NULL,
)
CREATE TABLE admin_file (
id          serial       not null unique,
company_user_id INTEGER REFERENCES company_users(id) ON DELETE CASCADE NOT NULL,
file_id INTEGER REFERENCES file_upload(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE payments (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
amount INTEGER NOT NULL,
paymented BOOLEN DEFAULT FALSE,
payment_type VARCHAR(255) NOT NULL,
)

CREATE TABLE orders_payments (
id          serial       not null unique,
orders_id INTEGER REFERENCES orders(id) ON DELETE CASCADE NOT NULL,
payment_id INTEGER REFERENCES payments(id) ON DELETE CASCADE NOT NULL,
)


CREATE TABLE shipping_products (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
total DECIMAL NOT NULL,
)

CREATE TABLE user_shipping_products (
id          serial       not null unique,
user_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
shipping_product_id INTEGER REFERENCES shipping_products(id) ON DELETE CASCADE NOT NULL,
)

CREATE TABLE cart_items (
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
updated_at TIMESTAMP,
deleted_at TIMESTAMP,
id SERIAL NOT NULL UNIQUE,
quantity INTEGER NOT NULL,
)

CREATE TABLE cart_items_products (
id          serial       not null unique,
product_id INTEGER REFERENCES products(id) ON DELETE CASCADE NOT NULL,
cart_item_id INTEGER REFERENCES cart_items(id) ON DELETE CASCADE NOT NULL,
)
CREATE TABLE shipping_cart (
id          serial       not null unique,
shipping_products INTEGER REFERENCES shippin_products(id) ON DELETE CASCADE NOT NULL,
cart_item_id INTEGER REFERENCES cart_items(id) ON DELETE CASCADE NOT NULL,
)
