TRUNCATE TABLE posts, users RESTART IDENTITY;



INSERT INTO users (username, email) VALUES ('David432', 'david432@yahoo.com');
INSERT INTO users (username, email) VALUES ('Anna123', 'anna123@gmail.com');

INSERT INTO posts (title, content, views, user_id) VALUES ('Happy Birthday', 'Have a good day', 122, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Morning', 'Random stuff', 600, 2);