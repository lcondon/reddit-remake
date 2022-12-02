CREATE SCHEMA reddit_remake;

SET SCHEMA 'reddit_remake';

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email varchar(50),
    first_name varchar(50),
    last_name varchar(50)
);

CREATE TABLE IF NOT EXISTS lkp_content_type (
    id SERIAL PRIMARY KEY,
    display varchar(50),
    icon varchar(50)
);

CREATE TABLE IF NOT EXISTS communities (
    id SERIAL PRIMARY KEY,
    title varchar(50),
    about text,
    date_created timestamp
);

CREATE TABLE IF NOT EXISTS posts (
    id SERIAL PRIMARY KEY,
    user_id integer,
    title varchar(250),
    content text,
    date_created timestamp,
    content_type_id integer,
    community_id integer,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_content_type_id FOREIGN KEY (content_type_id) REFERENCES lkp_content_type (id),
    CONSTRAINT fk_community_id FOREIGN KEY (community_id) REFERENCES communities (id)
);

CREATE TABLE IF NOT EXISTS comments (
    id SERIAL PRIMARY KEY,
    user_id integer,
    content text,
    date_created timestamp,
    parent_comment_id integer,
    post_id integer,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_post_id FOREIGN KEY (post_id) REFERENCES posts (id)
);

CREATE TABLE IF NOT EXISTS votes (
    id SERIAL PRIMARY KEY,
    user_id integer,
    post_id integer,
    comment_id integer,
    vote integer,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_post_id FOREIGN KEY (post_id) REFERENCES posts (id),
    CONSTRAINT fk_comment_id FOREIGN KEY (comment_id) REFERENCES comments (id)
);

CREATE TABLE IF NOT EXISTS community_users (
    id SERIAL PRIMARY KEY,
    user_id integer,
    community_id integer,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_community_id FOREIGN KEY (community_id) REFERENCES communities (id)
);




