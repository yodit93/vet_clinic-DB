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

--Modify animals table

--Remove the species column from the animals table.
ALTER TABLE animals DROP COLUMN species;
--Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);
--Add column owner_id which is a foreign key referencing owners table
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);

--Create a table named vets
CREATE TABLE vets (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	age INT,
	date_of_graduation DATE
);
--Create a "join table" called specializations
CREATE TABLE specializations (
	species_id INT,
	vet_id INT
);

--Create a "join table" called visits
CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    date_of_visit DATE
);

