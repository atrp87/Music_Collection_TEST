DROP TABLE IF EXISTS album;
-- DROP TABLE IF EXISTS artist;

CREATE TABLE album ( id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(255)
);

-- CREATE TABLE artist (
--   id SERIAL PRIMARY KEY,
--   first_name VARCHAR(255),
--   second_name VARCHAR(255)
-- );
