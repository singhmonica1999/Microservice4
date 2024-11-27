# Notifications Service

## **About** 

This microservice is a part of project, '**MediaNest**' - It conveys the idea of a cozy, organized space (a "nest") where users can collect, manage, and track all their favorite media—movies, series, books, and games—in one place. 

It manages and sends notifications to users about updates, new media additions, or progress changes, based on their preferences and subscription settings.

- **Notification Service Features**:
  - **User Notification Preferences**: Allows users to set and manage their notification preferences (e.g., media genre, type, or progress updates).
  - **New Media Notifications**: Sends notifications to users when new media of a specific genre or type is added to the platform.
  - **Progress Update Notifications**: Notifies users when their progress on a specific media item is updated or when a new episode or chapter is released.
  - **Email and Push Notifications**: Supports different types of notifications, including email and push notifications.
  - **Subscription Management**: Users can subscribe to receive notifications for certain media genres or types.
  - **Notification History**: Stores the history of notifications sent to users for tracking purposes.
  - **Real-Time Notifications**: Uses message queues to send notifications in real-time when events occur (e.g., new media added or progress updated).
- **Endpoints**:
  - **POST /notifications/preferences**: Allows users to set or update their notification preferences, including media genres or types they're interested in.
  - **GET /notifications/preferences/{userId}**: Retrieves the notification preferences of a specific user.
  - **POST /notifications**: Sends a notification to a user (e.g., about new media or progress updates).
  - **GET /notifications/{userId}**: Retrieves the notification history for a given user.
  - **DELETE /notifications/{userId}**: Deletes all notifications for a given user.
  - **POST /notifications/subscribe**: Allows users to subscribe to notifications for specific types of media or genres.
  - **POST /notifications/unsubscribe**: Allows users to unsubscribe from specific media notifications or genres.
  - **GET /notifications/status/{notificationId}**: Retrieves the delivery status of a specific notification by its ID (e.g., whether the notification was successfully sent).
  - **POST /notifications/send-batch**: Sends batch notifications to multiple users, typically for new media or progress updates.

These endpoints and features allow the **Notification Service** to handle notification preferences, history, and sending real-time notifications to users based on their preferences and media activity.

----

## **API Specification**

------

### **1. POST /notifications/preferences**

- **Description**: Allows users to set or update their notification preferences, including media genres or types they are interested in.

- **Request Body**:

  ```json
  {
    "user_id": 10001,
    "notification_preferences": {
      "media_types": ["Movie", "Series"],
      "genres": ["Action", "Comedy"]
    }
  }
  ```

  - `user_id`: Unique identifier for the user.

  - ```
    notification_preferences
    ```

    : Object containing user's preferred media types and genres.

    - `media_types`: List of media types the user wants to receive notifications for (e.g., Movie, Series, Book).
    - `genres`: List of media genres the user wants to receive notifications for (e.g., Action, Drama, Comedy).

- **Response**:

  - **Status**: 201 Created
  - **Body**:

  ```json
  {
    "message": "Notification preferences set successfully"
  }
  ```

- **Validations**:

  - `user_id` should exist in the User Management Service.
  - `media_types` should be from a predefined list of accepted media types (Movie, Series, Game, Book).
  - `genres` should be from a list of supported genres.

------

### **2. GET /notifications/preferences/{userId}**

- **Description**: Retrieves the notification preferences of a specific user.

- **Path Parameter**:

  - `userId`: The unique identifier of the user.

- **Response**:

  - **Status**: 200 OK
  - **Body**:

  ```json
  {
    "user_id": 10001,
    "notification_preferences": {
      "media_types": ["Movie", "Series"],
      "genres": ["Action", "Comedy"]
    }
  }
  ```

- **Validations**:

  - `userId` must exist in the User Management Service.

------

### **3. POST /notifications**

- **Description**: Sends a notification to a user (e.g., about new media or progress updates).

- **Request Body**:

  ```json
  {
    "user_id": 10001,
    "message": "New movie 'Avengers: Endgame' released!",
    "notification_type": "New Media",
    "media_id": 12345
  }
  ```

  - `user_id`: Unique identifier for the user to send the notification to.
  - `message`: The notification content.
  - `notification_type`: The type of notification (e.g., "New Media", "Progress Update").
  - `media_id`: The ID of the media item related to the notification (optional).

- **Response**:

  - **Status**: 200 OK
  - **Body**:

  ```json
  {
    "message": "Notification sent successfully"
  }
  ```

- **Validations**:

  - `user_id` must exist in the User Management Service.
  - `media_id` must exist in the Media Management Service (optional depending on notification type).

------

### **4. GET /notifications/{userId}**

- **Description**: Retrieves the notification history for a given user.

- **Path Parameter**:

  - `userId`: The unique identifier of the user.

- **Response**:

  - **Status**: 200 OK
  - **Body**:

  ```json
  [
    {
      "notification_id": 1,
      "user_id": 10001,
      "message": "New movie 'Avengers: Endgame' released!",
      "notification_type": "New Media",
      "status": "Sent",
      "timestamp": "2024-11-27T10:00:00Z"
    },
    {
      "notification_id": 2,
      "user_id": 10001,
      "message": "Your progress in 'The Witcher' has been updated.",
      "notification_type": "Progress Update",
      "status": "Sent",
      "timestamp": "2024-11-28T15:30:00Z"
    }
  ]
  ```

- **Validations**:

  - `userId` must exist in the User Management Service.

------

### **5. DELETE /notifications/{userId}**

- **Description**: Deletes all notifications for a given user.

- **Path Parameter**:

  - `userId`: The unique identifier of the user.

- **Response**:

  - **Status**: 200 OK
  - **Body**:

  ```json
  {
    "message": "All notifications deleted successfully"
  }
  ```

- **Validations**:

  - `userId` must exist in the User Management Service.

------

### **6. POST /notifications/subscribe**

- **Description**: Allows users to subscribe to notifications for specific types of media or genres.

- **Request Body**:

  ```json
  {
    "user_id": 10001,
    "subscription_preferences": {
      "media_types": ["Movie", "Game"],
      "genres": ["Adventure", "Action"]
    }
  }
  ```

  - `user_id`: Unique identifier for the user.
  - `subscription_preferences`: List of media types and genres the user wants to subscribe to for notifications.

- **Response**:

  - **Status**: 200 OK
  - **Body**:

  ```json
  {
    "message": "User successfully subscribed to notifications"
  }
  ```

- **Validations**:

  - `user_id` should exist in the User Management Service.
  - `media_types` and `genres` must be valid.

------

### **7. POST /notifications/unsubscribe**

- **Description**: Allows users to unsubscribe from notifications for specific types of media or genres.

- **Request Body**:

  ```json
  {
    "user_id": 10001,
    "subscription_preferences": {
      "media_types": ["Series"],
      "genres": ["Drama"]
    }
  }
  ```

- **Response**:

  - **Status**: 200 OK
  - **Body**:

  ```json
  {
    "message": "User successfully unsubscribed from notifications"
  }
  ```

- **Validations**:

  - `user_id` should exist in the User Management Service.
  - `media_types` and `genres` must be valid.

------

### **8. GET /notifications/status/{notificationId}**

- **Description**: Retrieves the delivery status of a specific notification by its ID.

- **Path Parameter**:

  - `notificationId`: The unique identifier of the notification.

- **Response**:

  - **Status**: 200 OK
  - **Body**:

  ```json
  {
    "notification_id": 1,
    "status": "Sent",
    "timestamp": "2024-11-27T10:00:00Z"
  }
  ```

------

### **9. POST /notifications/send-batch**

- **Description**: Sends batch notifications to multiple users, typically for new media or progress updates.

- **Request Body**:

  ```json
  {
    "notifications": [
      {
        "user_id": 10001,
        "message": "New movie 'Avengers: Endgame' released!",
        "notification_type": "New Media",
        "media_id": 12345
      },
      {
        "user_id": 10002,
        "message": "Your progress in 'The Witcher' has been updated.",
        "notification_type": "Progress Update",
        "media_id": 67890
      }
    ]
  }
  ```

- **Response**:

  - **Status**: 200 OK
  - **Body**:

  ```json
  {
    "message": "Batch notifications sent successfully"
  }
  ```

------

### **Message Queue Integration Details**:

The **Notification Service** uses message queues for communication with other services and sending notifications in real-time.

1. **Queue**: `media-updated-queue`

   - **Producer**: Media Management Service
   - **Consumer**: Notification Service
   - **Purpose**: When new media is added or updated, a message is published to this queue to notify relevant users about new media.
   - **Message Payload**:

   ```json
   {
     "media_id": 12345,
     "media_title": "Avengers: Endgame",
     "media_type": "Movie",
     "notification_message": "New movie 'Avengers: Endgame' released!"
   }
   ```

2. **Queue**: `progress-updated-queue`

   - **Producer**: Progress Tracking Service
   - **Consumer**: Notification Service
   - **Purpose**: When a user updates their progress for a media item, a message is published to notify the user of the progress change.
   - **Message Payload**:

   ```json
   {
     "user_id": 10001,
     "media_id": 12345,
     "progress_percentage": 50,
     "notification_message": "Your progress on 'Avengers: Endgame' is now 50%!"
   }
   ```

------

### **Common Response Codes**:

- **200 OK**: Successful request.
- **201 Created**: A new resource (e.g., notification preference) was created.
- **400 Bad Request**: Invalid request (e.g., missing required fields).
- **404 Not Found**: Resource not found (e.g., user or media).
- 

**500 Internal Server Error**: Unexpected server error.

This specification outlines the API structure for the **Notification Service** with message queue details, allowing for seamless real-time notifications and user-specific updates.

----

## **Database Schema**

------

### **1. notifications_preferences**

This table stores the notification preferences for users, including which media types and genres they are interested in.

```sql
CREATE TABLE notifications_preferences (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,  -- User ID linked to the User Management Service
    media_types JSON,      -- List of media types user wants to receive notifications for (Movie, Series, Game, Book)
    genres JSON,           -- List of genres user wants to receive notifications for (Action, Comedy, Drama)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)  -- Assuming the users table exists in the User Management Service
);
```

- **`user_id`**: Foreign key referencing the `users` table from the User Management Service.
- **`media_types`**: A JSON field containing the types of media the user wants to be notified about.
- **`genres`**: A JSON field containing the genres of media the user is interested in.
- **`created_at`** and **`updated_at`**: Timestamps to track when the preferences were created or updated.

------

### **2. notifications_history**

This table tracks the history of notifications sent to users.

```sql
CREATE TABLE notifications_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,   -- User ID who received the notification
    notification_type VARCHAR(50),  -- Type of the notification (New Media, Progress Update)
    message TEXT NOT NULL,  -- Notification content/message
    status VARCHAR(20),     -- Status of the notification (Sent, Failed)
    media_id INT,           -- Media ID associated with the notification (if applicable)
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)  -- Assuming the users table exists in the User Management Service
);
```

- **`user_id`**: Foreign key referencing the `users` table from the User Management Service.
- **`notification_type`**: The type of notification being sent (e.g., "New Media", "Progress Update").
- **`message`**: The content of the notification sent to the user.
- **`status`**: The status of the notification (e.g., "Sent", "Failed").
- **`media_id`**: The ID of the media item that is associated with the notification (optional, depending on the notification type).
- **`timestamp`**: The timestamp when the notification was sent.

------

### **3. notifications_subscriptions**

This table manages user subscriptions to specific media types and genres.

```sql
CREATE TABLE notifications_subscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,   -- User ID who subscribed
    media_types JSON,       -- Media types user is subscribed to (Movie, Series, Game, Book)
    genres JSON,            -- Genres user is subscribed to (Action, Drama, Comedy)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)  -- Assuming the users table exists in the User Management Service
);
```

- **`user_id`**: Foreign key referencing the `users` table from the User Management Service.
- **`media_types`**: JSON field containing the media types the user is subscribed to.
- **`genres`**: JSON field containing the genres the user is subscribed to.
- **`created_at`** and **`updated_at`**: Timestamps to track the subscription creation and updates.

------

### **4. notification_queue** (Optional for message queuing)

If you're using a queue to manage real-time notifications, you could create a queue table to store pending notifications.

```sql
CREATE TABLE notification_queue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,        -- User to receive the notification
    notification_type VARCHAR(50),  -- Type of notification (New Media, Progress Update)
    message TEXT NOT NULL,       -- Notification message
    status VARCHAR(20),          -- Status (Pending, Sent, Failed)
    media_id INT,                -- Media ID related to the notification (optional)
    retry_count INT DEFAULT 0,   -- Number of times the notification has been retried
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)  -- Assuming the users table exists in the User Management Service
);
```

- **`user_id`**: The user who will receive the notification.
- **`notification_type`**: The type of notification (e.g., "New Media", "Progress Update").
- **`message`**: The notification content.
- **`status`**: Status of the notification (e.g., Pending, Sent, Failed).
- **`media_id`**: Media ID that is associated with the notification (optional).
- **`retry_count`**: Number of attempts made to send the notification if there was a failure.
- **`created_at`**: Timestamp of when the notification was added to the queue.

------

### **Database Relationships and Notes**:

- The **`users` table** in the **User Management Service** will be referenced in these tables, especially for foreign keys (`user_id`).
- **JSON fields** are used for `media_types` and `genres` to allow flexibility in storing lists of types or genres. This is suitable for situations where users can select multiple values.
- The **`notification_queue`** table is optional but useful for systems that rely on message queues like ActiveMQ for handling notifications asynchronously.

------

This schema allows you to manage user preferences, notification history, and subscriptions efficiently while providing flexibility for handling notifications in a scalable, event-driven manner.