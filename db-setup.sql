-- Create notifications_preferences table
CREATE TABLE notifications_preferences (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,  
    media_types JSON,     
    genres JSON,           
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)  
);

-- Create notifications_history table
CREATE TABLE notifications_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,   
    notification_type VARCHAR(50),  
    message TEXT NOT NULL,  
    status VARCHAR(20),     
    media_id INT,           
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)  
);

-- Create notifications_subscriptions table
CREATE TABLE notifications_subscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,   
    media_types JSON,       
    genres JSON,            
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)  
);

-- Create notification_queue table
CREATE TABLE notification_queue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,        
    notification_type VARCHAR(50),  
    message TEXT NOT NULL,       
    status VARCHAR(20),          
    media_id INT,                
    retry_count INT DEFAULT 0,   
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)  
);