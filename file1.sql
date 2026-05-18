CREATE DATABASE weekend_activity_recommender;
USE weekend_activity_recommender;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE activities (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    location VARCHAR(150),
    price DECIMAL(10,2) DEFAULT 0,
    rating DECIMAL(3,2) DEFAULT 0,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE user_preferences (
    preference_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    category_id INT,
    budget_min DECIMAL(10,2),
    budget_max DECIMAL(10,2),
    preferred_location VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE favorites (
    favorite_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    activity_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (activity_id) REFERENCES activities(activity_id)
);

CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    activity_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (activity_id) REFERENCES activities(activity_id)
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    activity_id INT,
    booking_date DATETIME,
    number_of_people INT DEFAULT 1,
    total_price DECIMAL(10,2),
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (activity_id) REFERENCES activities(activity_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    payment_method ENUM('paypal', 'card', 'cash'),
    amount DECIMAL(10,2),
    payment_status ENUM('pending', 'completed', 'failed') DEFAULT 'pending',
    transaction_id VARCHAR(100),
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

INSERT INTO categories (name, description) VALUES
('Nature', 'Outdoor activities like hiking, beaches, parks'),
('Nightlife', 'Clubs, bars, party events'),
('Culture', 'Museums, theaters, exhibitions'),
('Sports', 'Football, gym, adventure sports'),
('Food', 'Restaurants and food experiences');

INSERT INTO activities (title, description, location, price, rating, category_id) VALUES
('Hiking in Dajti Mountain', 'Beautiful nature hike near Tirana', 'Tirana', 10, 4.7, 1),
('Beach Party', 'Weekend beach event with DJ', 'Durrës', 25, 4.5, 2),
('Museum Visit', 'Explore history and culture', 'Tirana', 5, 4.2, 3),
('Football Match', 'Local amateur football game', 'Shkodër', 0, 4.0, 4),
('Traditional Dinner', 'Albanian traditional food experience', 'Berat', 20, 4.8, 5);