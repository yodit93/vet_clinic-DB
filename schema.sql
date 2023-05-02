/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    name varchar(100),
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal(5,2),
    species VARCHAR(100)
);
