--  Tạo Database
CREATE DATABASE SalesManagement;
USE SalesManagement;

--  Tạo bảng PRODUCT (Sản phẩm)
CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    brand VARCHAR(100),
    unit_price DECIMAL(15, 2) NOT NULL CHECK (unit_price >= 0),
    stock_quantity INT DEFAULT 0
);

-- Tạo bảng CUSTOMER (Khách hàng)
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) UNIQUE,
    address TEXT
);

-- Tạo bảng ORDER (Đơn hàng)
CREATE TABLE `Order` (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(15, 2),
    customer_id INT,
    CONSTRAINT FK_Order_Customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Tạo bảng ORDER_DETAIL (Chi tiết đơn hàng)
CREATE TABLE Order_Detail (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    sale_price DECIMAL(15, 2) NOT NULL,
    PRIMARY KEY (order_id, product_id), -- Khóa chính kết hợp
    CONSTRAINT FK_Detail_Order FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    CONSTRAINT FK_Detail_Product FOREIGN KEY (product_id) REFERENCES Product(product_id)
);


ALTER TABLE `Order` 
ADD COLUMN note TEXT;

ALTER TABLE Product 
RENAME COLUMN brand TO NhaSanXuat;

DROP TABLE Order_Detail;
DROP TABLE `Order`;

-- Nhập dữ liệu cho bảng Product (Sản phẩm)
INSERT INTO Product (product_name, NhaSanXuat, unit_price, stock_quantity) VALUES
('iPhone 15 Pro', 'Apple', 28000000, 10),
('MacBook Air M2', 'Apple', 25000000, 5),
('Samsung Galaxy S24', 'Samsung', 22000000, 15),
('Dell XPS 13', 'Dell', 35000000, 3),
('Logitech MX Master 3S', 'Logitech', 2500000, 20);

-- Nhập dữ liệu cho bảng Customer (Khách hàng)
INSERT INTO Customer (full_name, email, phone, address) VALUES
('Nguyễn Văn A', 'anguyen@gmail.com', '0912345678', 'Hà Nội'),
('Trần Thị B', 'btran@yahoo.com', NULL, 'Hồ Chí Minh'),
('Lê Văn C', 'cle@gmail.com', '0987654321', 'Đà Nẵng'),
('Phạm Thị D', 'dpham@hotmail.com', NULL, 'Cần Thơ'),
('Hoàng Văn E', 'ehoang@gmail.com', '0905111222', 'Hải Phòng');

-- Nhập dữ liệu cho bảng Order (Đơn hàng)
INSERT INTO `Order` (order_date, total_amount, customer_id, note) VALUES
('2026-04-20 10:00:00', 53000000, 1, 'Giao gấp'),
('2026-04-21 14:30:00', 25000000, 3, NULL),
('2026-04-22 09:15:00', 22000000, 5, 'Khách quen'),
('2026-04-23 16:45:00', 2500000, 1, NULL),
('2026-04-24 11:20:00', 28000000, 3, 'Kiểm tra kỹ hàng');

-- Nhập dữ liệu cho bảng Order_Detail (Chi tiết đơn hàng)
INSERT INTO Order_Detail (order_id, product_id, quantity, sale_price) VALUES
(1, 1, 1, 28000000),
(1, 2, 1, 25000000),
(2, 2, 1, 25000000),
(3, 3, 1, 22000000),
(4, 5, 1, 2500000),
(5, 1, 1, 28000000);

-- Tăng giá bán thêm 10% cho tất cả sản phẩm của Apple
UPDATE Product
SET unit_price = unit_price * 1.1
WHERE NhaSanXuat = 'Apple';


SELECT product_name, unit_price FROM Product WHERE NhaSanXuat = 'Apple';

-- Xóa thông tin khách hàng có SĐT là NULL
DELETE FROM Customer
WHERE phone IS NULL;

SELECT * FROM Customer;

-- Tìm sản phẩm trong khoảng giá (10 triệu đến 20 triệu)
SELECT * FROM Product 
WHERE unit_price BETWEEN 10000000 AND 20000000;

-- Liệt kê tên sản phẩm trong đơn hàng 'DH001'
SELECT p.product_name 
FROM Order_Detail od
JOIN Product p ON od.product_id = p.product_id
WHERE od.order_id = 'DH001';

