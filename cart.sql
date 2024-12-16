SELECT * FROM zayas.Customers;
CREATE TABLE cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique cart identifier
    customer_id INT NOT NULL,                   -- Foreign key to associate cart with a user
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp when the cart is created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Timestamp when cart is last updated
    FOREIGN KEY (customer_id) REFERENCES customercart_items(customer_id)  -- Assuming a 'users' table exists
);
CREATE TABLE cart_item (
    cart_item_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique cart item identifier
    cart_id INT NOT NULL,                        -- Foreign key to the cart
    perfume_id INT NOT NULL,                     -- Foreign key to the product
    quantity INT NOT NULL,                       -- Quantity of the product in the cart
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the item was added to the cart
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id),  -- Foreign key to the cart table
    FOREIGN KEY (perfume_id) REFERENCES perfumes(perfume_id)  -- Assuming a 'products' table exists
);