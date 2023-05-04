/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, false, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Angemon', '2005-06-12', 1, true, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Ditto', '2022-05-14', 4, true, 22);

--insert owners data
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
	   ('Jennifer Orwell', 19),
	   ('Bob', 45),
	   ('Melody Pond', 77),
	   ('Dean Winchester', 14),
	   ('Jodie Whittaker', 38);

--insert species data
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

--Modify inserted animals so it includes the species_id value:
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

--Modify inserted animals so it includes the owner_id value:

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');

--Insert data to vets table:

INSERT INTO vets (name, age, date_of_graduation)
	VALUES ('William Tatcher', 45, '2000-04-23'),
		   ('Maisy Smith', 26, '2019-01-17'),
		   ('Stephanie Mendez', 38, '1981-05-4'),
		   ('Jack Harkness', 38, '2008-01-08');

--Insert data to specializations table:
INSERT INTO visits
	VALUES (12, 1, '2020-05-24'), (12, 3, '2020-07-22'), (13, 4, '2021-01-02'), 
	(14, 2, '2020-01-05'), (14, 2, '2020-03-08'), (14, 2, '2020-05-14'), (15, 3, '2020-05-04');
INSERT INTO visits
	VALUES (16, 4, '2021-02-21'), (17, 2, '2019-12-21'), (17, 1, '2020-08-10'), 
	(17, 2, '2021-04-07'), (18, 3, '2019-09-29'), (19, 4, '2020-10-03'), (19, 4, '2020-11-04');
INSERT INTO visits
	VALUES (20, 2, '2019-01-24'), (20, 2, '2019-05-15'), (20, 2, '2020-02-27'), 
	(20, 2, '2020-08-03'), (21, 3, '2020-05-24'), (21, 1, '2021-01-11');