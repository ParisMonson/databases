TRUNCATE TABLE posts RESTART IDENTITY;

INSERT INTO posts (title, content, views, user_id) VALUES ('Happy Birthday', 'Have a good day', 122, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Morning', 'Random stuff', 600, 2);