CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT
);

INSERT INTO Categories (category_name)
VALUES
    ('floral'),
    ('woody'),
    ('fruity'),
    ('spicy');

CREATE TABLE Perfumes (
    perfume_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,  -- Storing price with two decimal places
    stock_quantity INT NOT NULL DEFAULT 0,
    category_id INT,  -- Foreign key to Categories table
    image_url VARCHAR(255),  -- Optional: To store the URL of the perfume image
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
--    first_name VARCHAR(100) NOT NULL,
--     last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    shipping_address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,  -- Foreign key to Customers table
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',  -- Order status (Pending, Shipped, Delivered, etc.)
    shipping_address TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,  -- Foreign key to Orders table
    perfume_id INT,  -- Foreign key to Perfumes table
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10, 2) NOT NULL,  -- Price at the time of the order
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (perfume_id) REFERENCES Perfumes(perfume_id)
);

select * from Customers;