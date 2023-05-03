/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    name varchar(100),
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal(5,2)
);

--create owners table

CREATE TABLE owners (
    id  SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

--create species table

CREATE TABLE species (
    id  SERIAL PRIMARY KEY,
    name VARCHAR(100)
);
