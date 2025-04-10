create database db;
use db;
CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    email_verified_at TIMESTAMP NULL,
    password VARCHAR(255),
    photo VARCHAR(255),
    role ENUM('admin', 'user') DEFAULT 'user',
    provider VARCHAR(255),
    provider_id VARCHAR(255),
    status ENUM('active', 'inactive') DEFAULT 'active',
    remember_token VARCHAR(100),
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE password_resets (
    email VARCHAR(255),
    token VARCHAR(255),
    created_at TIMESTAMP NULL
);

CREATE TABLE failed_jobs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    connection TEXT,
    queue TEXT,
    payload LONGTEXT,
    exception LONGTEXT,
    failed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE brands (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    slug VARCHAR(255) UNIQUE,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE banners (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    slug VARCHAR(255) UNIQUE,
    photo VARCHAR(255),
    description TEXT,
    status ENUM('active', 'inactive') DEFAULT 'inactive',
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE categories (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    slug VARCHAR(255) UNIQUE,
    summary TEXT,
    photo VARCHAR(255),
    is_parent TINYINT(1) DEFAULT 1,
    parent_id BIGINT UNSIGNED,
    added_by BIGINT UNSIGNED,
    status ENUM('active', 'inactive') DEFAULT 'inactive',
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL,
    FOREIGN KEY (added_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE products (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    slug VARCHAR(255) UNIQUE,
    summary TEXT,
    description LONGTEXT,
    photo TEXT,
    stock INT DEFAULT 1,
    size VARCHAR(255) DEFAULT 'M',
    product_condition ENUM('default', 'new', 'hot') DEFAULT 'default',
    status ENUM('active', 'inactive') DEFAULT 'inactive',
    price FLOAT,
    discount FLOAT,
    is_featured TINYINT(1) DEFAULT 0,
    cat_id BIGINT UNSIGNED,
    child_cat_id BIGINT UNSIGNED,
    brand_id BIGINT UNSIGNED,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (cat_id) REFERENCES categories(id) ON DELETE SET NULL,
    FOREIGN KEY (child_cat_id) REFERENCES categories(id) ON DELETE SET NULL,
    FOREIGN KEY (brand_id) REFERENCES brands(id) ON DELETE SET NULL
);

CREATE TABLE post_categories (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    slug VARCHAR(255) UNIQUE,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE post_tags (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    slug VARCHAR(255) UNIQUE,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE posts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    slug VARCHAR(255) UNIQUE,
    summary TEXT,
    description LONGTEXT,
    quote TEXT,
    photo VARCHAR(255),
    tags VARCHAR(255),
    post_cat_id BIGINT UNSIGNED,
    post_tag_id BIGINT UNSIGNED,
    added_by BIGINT UNSIGNED,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (post_cat_id) REFERENCES post_categories(id) ON DELETE SET NULL,
    FOREIGN KEY (post_tag_id) REFERENCES post_tags(id) ON DELETE SET NULL,
    FOREIGN KEY (added_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE messages (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    subject TEXT,
    email VARCHAR(255),
    photo VARCHAR(255),
    phone VARCHAR(255),
    message LONGTEXT,
    read_at TIMESTAMP NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE shippings (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(255),
    price DECIMAL(10,2),
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE orders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(255) UNIQUE,
    user_id BIGINT UNSIGNED,
    sub_total FLOAT,
    shipping_id BIGINT UNSIGNED,
    coupon FLOAT,
    total_amount FLOAT,
    quantity INT,
    payment_method ENUM('cod', 'paypal') DEFAULT 'cod',
    payment_status ENUM('paid', 'unpaid') DEFAULT 'unpaid',
    status ENUM('new', 'process', 'delivered', 'cancel') DEFAULT 'new',
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255),
    country VARCHAR(255),
    post_code VARCHAR(255),
    address1 TEXT,
    address2 TEXT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (shipping_id) REFERENCES shippings(id) ON DELETE SET NULL
);

CREATE TABLE carts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT UNSIGNED,
    order_id BIGINT UNSIGNED,
    user_id BIGINT UNSIGNED,
    price FLOAT,
    status ENUM('new', 'progress', 'delivered', 'cancel') DEFAULT 'new',
    quantity INT,
    amount FLOAT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE SET NULL
);

CREATE TABLE notifications (
    id BINARY(16) PRIMARY KEY,
    type VARCHAR(255),
    notifiable_id BIGINT UNSIGNED,
    notifiable_type VARCHAR(255),
    data TEXT,
    read_at TIMESTAMP NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE coupons (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(255) UNIQUE,
    type ENUM('fixed', 'percent') DEFAULT 'fixed',
    value DECIMAL(20,2),
    status ENUM('active', 'inactive') DEFAULT 'inactive',
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE wishlists (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT UNSIGNED,
    cart_id BIGINT UNSIGNED,
    user_id BIGINT UNSIGNED,
    price FLOAT,
    quantity INT,
    amount FLOAT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE SET NULL
);

CREATE TABLE product_reviews (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED,
    product_id BIGINT UNSIGNED,
    rate TINYINT DEFAULT 0,
    review TEXT,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
);

CREATE TABLE post_comments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED,
    post_id BIGINT UNSIGNED,
    comment TEXT,
    status ENUM('active', 'inactive') DEFAULT 'active',
    replied_comment TEXT,
    parent_id BIGINT UNSIGNED,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE SET NULL,
    FOREIGN KEY (parent_id) REFERENCES post_comments(id) ON DELETE SET NULL
);

CREATE TABLE settings (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    description LONGTEXT,
    short_des TEXT,
    logo VARCHAR(255),
    photo VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(255),
    email VARCHAR(255),
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE jobs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    queue VARCHAR(255),
    payload LONGTEXT,
    attempts TINYINT UNSIGNED,
    reserved_at INT UNSIGNED,
    available_at INT UNSIGNED,
    created_at INT UNSIGNED
);

INSERT INTO users (name, email, password, role, status, created_at) VALUES
('Alice', 'alice@example.com', 'pass123', 'user', 'active', NOW()),
('Bob', 'bob@example.com', 'pass123', 'user', 'active', NOW()),
('Charlie', 'charlie@example.com', 'pass123', 'admin', 'inactive', NOW()),
('David', 'david@example.com', 'pass123', 'user', 'active', NOW()),
('Eve', 'eve@example.com', 'pass123', 'admin', 'active', NOW()),
('Frank', 'frank@example.com', 'pass123', 'user', 'inactive', NOW()),
('Grace', 'grace@example.com', 'pass123', 'user', 'active', NOW()),
('Hank', 'hank@example.com', 'pass123', 'user', 'inactive', NOW()),
('Ivy', 'ivy@example.com', 'pass123', 'user', 'active', NOW()),
('Jake', 'jake@example.com', 'pass123', 'user', 'active', NOW());
INSERT INTO brands (title, slug, status, created_at) VALUES
('Nike', 'nike', 'active', NOW()),
('Adidas', 'adidas', 'active', NOW()),
('Puma', 'puma', 'inactive', NOW()),
('Reebok', 'reebok', 'active', NOW()),
('Apple', 'apple', 'active', NOW()),
('Samsung', 'samsung', 'active', NOW()),
('Sony', 'sony', 'inactive', NOW()),
('Asus', 'asus', 'active', NOW()),
('Dell', 'dell', 'active', NOW()),
('HP', 'hp', 'inactive', NOW());

INSERT INTO categories (title, slug, summary, is_parent, status, created_at) VALUES
('Electronics', 'electronics', 'All gadgets', 1, 'active', NOW()),
('Clothing', 'clothing', 'Wearables', 1, 'active', NOW()),
('Footwear', 'footwear', 'Shoes and more', 1, 'active', NOW()),
('Laptops', 'laptops', 'All laptops', 0, 'active', NOW()),
('Mobiles', 'mobiles', 'Smartphones', 0, 'active', NOW()),
('Accessories', 'accessories', 'Add-ons', 0, 'inactive', NOW()),
('Cameras', 'cameras', 'DSLRs etc.', 1, 'active', NOW()),
('Watches', 'watches', 'Timewear', 1, 'active', NOW()),
('Furniture', 'furniture', 'Home stuff', 1, 'active', NOW()),
('Books', 'books', 'Knowledge', 1, 'active', NOW());
INSERT INTO products (title, slug, price, discount, stock, status, cat_id, brand_id, created_at) VALUES
('iPhone 13', 'iphone-13', 999.99, 10, 50, 'active', 5, 5, NOW()),
('Galaxy S21', 'galaxy-s21', 849.99, 15, 30, 'active', 5, 6, NOW()),
('Dell XPS', 'dell-xps', 1299.99, 20, 20, 'active', 4, 9, NOW()),
('Nike Air Max', 'nike-air-max', 149.99, 5, 100, 'active', 3, 1, NOW()),
('Sony DSLR', 'sony-dslr', 599.99, 8, 25, 'active', 7, 7, NOW()),
('Adidas T-shirt', 'adidas-tshirt', 29.99, 2, 200, 'active', 2, 2, NOW()),
('Apple Watch', 'apple-watch', 399.99, 12, 40, 'active', 8, 5, NOW()),
('HP Pavilion', 'hp-pavilion', 899.99, 10, 15, 'inactive', 4, 10, NOW()),
('Samsung Tab', 'samsung-tab', 649.99, 9, 35, 'active', 5, 6, NOW()),
('Reebok Sneakers', 'reebok-sneakers', 89.99, 3, 120, 'active', 3, 4, NOW());
INSERT INTO orders (order_number, user_id, sub_total, total_amount, quantity, payment_method, status, created_at) VALUES
('ORD001', 1, 200, 210, 2, 'cod', 'new', NOW()),
('ORD002', 2, 150, 157, 1, 'paypal', 'process', NOW()),
('ORD003', 3, 350, 360, 3, 'paypal', 'delivered', NOW()),
('ORD004', 4, 100, 105, 1, 'cod', 'new', NOW()),
('ORD005', 5, 500, 520, 5, 'paypal', 'cancel', NOW()),
('ORD006', 6, 250, 260, 2, 'cod', 'process', NOW()),
('ORD007', 7, 300, 315, 3, 'paypal', 'delivered', NOW()),
('ORD008', 8, 400, 415, 4, 'cod', 'new', NOW()),
('ORD009', 9, 180, 185, 2, 'paypal', 'delivered', NOW()),
('ORD010', 10, 600, 620, 6, 'cod', 'cancel', NOW());
INSERT INTO carts (product_id, order_id, user_id, price, quantity, amount, status, created_at) VALUES
(1, 1, 1, 999.99, 1, 999.99, 'new', NOW()),
(2, 2, 2, 849.99, 1, 849.99, 'progress', NOW()),
(3, 3, 3, 1299.99, 1, 1299.99, 'delivered', NOW()),
(4, 4, 4, 149.99, 2, 299.98, 'cancel', NOW()),
(5, 5, 5, 599.99, 1, 599.99, 'new', NOW()),
(6, 6, 6, 29.99, 3, 89.97, 'progress', NOW()),
(7, 7, 7, 399.99, 1, 399.99, 'delivered', NOW()),
(8, 8, 8, 899.99, 1, 899.99, 'cancel', NOW()),
(9, 9, 9, 649.99, 2, 1299.98, 'new', NOW()),
(10, 10, 10, 89.99, 1, 89.99, 'progress', NOW());
SELECT id, name, email 
FROM users 
WHERE status = 'active'
ORDER BY created_at DESC;
SELECT payment_method, COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method;


SELECT name, email
FROM users
WHERE id = (
    SELECT user_id
    FROM orders
    GROUP BY user_id
    ORDER BY COUNT(*) DESC
    limit 1
);
SELECT user_id, SUM(total_amount) AS total_spent, AVG(total_amount) AS avg_order
FROM orders
GROUP BY user_id;

SELECT c.title AS category, SUM(p.stock) AS total_stock
FROM products p
JOIN categories c ON p.cat_id = c.id
GROUP BY c.id;
CREATE VIEW monthly_revenue as
SELECT DATE_FORMAT(created_at, '%Y-%m') AS month,
       SUM(total_amount) AS total_revenue
FROM orders
GROUP BY month;
SELECT * FROM monthly_revenue WHERE month >= '2024-01';
CREATE INDEX idx_user_id ON orders(user_id);
CREATE INDEX idx_product_id ON carts(product_id);
CREATE INDEX idx_created_at ON orders(created_at);

SELECT u.name, u.email, SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE YEAR(o.created_at) = YEAR(CURDATE())
GROUP BY u.id
ORDER BY total_spent DESC
LIMIT 5;
-- Step 1: Create a VIEW for detailed order info
CREATE OR REPLACE VIEW user_order_summary AS
SELECT 
    u.id AS user_id,
    u.name,
    o.id AS order_id,
    o.total_amount,
    o.created_at AS order_date,
    c.product_id,
    p.brand_id,
    b.title AS brand_name
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN carts c ON o.id = c.order_id
JOIN products p ON c.product_id = p.id
JOIN brands b ON p.brand_id = b.id;
SELECT 
    u.name AS user_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    COUNT(c.product_id) AS total_products_bought,
    MAX(o.order_date) AS last_order_date,
    
    -- Subquery to find most frequent brand bought by user
    (
        SELECT brand_name
        FROM (
            SELECT brand_name, COUNT(*) AS brand_count
            FROM user_order_summary
            WHERE user_id = u.id
            GROUP BY brand_name
            ORDER BY brand_count DESC
            LIMIT 1
        ) AS fav_brand
    ) AS most_frequent_brand

FROM user_order_summary o
JOIN users u ON o.user_id = u.id
JOIN carts c ON o.order_id = c.order_id

GROUP BY u.id
ORDER BY total_spent DESC
LIMIT 5;



