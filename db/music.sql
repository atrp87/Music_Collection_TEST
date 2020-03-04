DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS artist;

CREATE TABLE artist (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  second_name VARCHAR(255)
 );


CREATE TABLE album (
  id SERIAL PRIMARY KEY,
  artist_id integer references artist(id),
  title VARCHAR(255),
  genre VARCHAR(255)
);
