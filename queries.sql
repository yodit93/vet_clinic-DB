/*Queries that provide answers to the questions from all projects.*/
--Find all animals whose name ends in "mon".
SELECT * from animals WHERE name LIKE '%mon';

--List the name of all animals born between 2016 and 2019.
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

--List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

--List name and escape attempts of animals that weigh more than 10.5kg
SELECT name escape_attempts FROM animals WHERE weight_kg < 10.5;

--Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

--Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'GAbumon';

--Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--Add a new column to the animals table called species with the data type of varchar(100).
ALTER TABLE animals ADD COLUMN species VARCHAR(100);

--update the animals table by setting the species column to unspecified
BEGIN;
UPDATE animals SET species = 'unspecified';
--roll back the transaction
ROLLBACK;
--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;
--Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;
--delete all records in the animals table, then roll back the transaction and verify.
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;
--Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
--Create a savepoint for the transaction.
SAVEPOINT update_animals;
--Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;
--Roll back the transaction to the savepoint.
ROLLBACK TO update_animals;
--Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
--Commit the transaction.
COMMIT;

--How many animals are there?
SELECT COUNT(*) FROM animals;
--How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
--What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
--Who escapes the most, neutered or not neutered animals?
SELECT neutered, count(*) AS escape_count FROM animals GROUP BY neutered;
--What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY species;
 
--What animals belong to Melody Pond?
SELECT name, full_name 
	FROM animals
	JOIN owners 
	ON animals.owner_id = owners.id
	Where owners.full_name = 'Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).
SELECT name, species
  FROM animals
  JOIN species
  ON animals.species_id = species.id
  WHERE species.name = 'Pokemon';

  --List all owners and their animals, including those that don't own any animal.
SELECT name, full_name
	FROM animals
	RIGHT JOIN owners
	ON animals.owner_id = owners.id;

--How many animals are there per species?
SELECT species.name, COUNT(*) AS animal_count
  FROM animals
  JOIN species
  ON animals.species_id = species.id
  GROUP BY species.name;
--List all Digimon owned by Jennifer Orwell.
SELECT animals.name, owners.full_name, species.name
	FROM animals
	JOIN owners
	ON animals.owner_id = owners.id
	JOIN species
	ON animals.species_id = species.id
	WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';
--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, owners.full_name, animals.escape_attempts
  FROM animals
  JOIN owners
  ON animals.owner_id = owners.id
  WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
--Who owns the most animals?
SELECT owners.full_name, COUNT(*) as count
	FROM animals
	JOIN owners
	ON animals.owner_id = owners.id
	GROUP BY owners.full_name
	ORDER BY count DESC;

--Who was the last animal seen by William Tatcher?
SELECT animals.name, vets.name, visits.date_of_visit
	FROM animals
	JOIN visits
	ON animals.id = visits.animal_id
	JOIN vets
	ON visits.vet_id = vets.id
	WHERE vets.name = 'William Tatcher'
	ORDER BY visits.date_of_visit DESC
	LIMIT 1;

	--How many animals have been seen by Stephanie Mendez?
	SELECT animals.name, vets.name
		FROM visits
		JOIN animals
		ON animals.id = visits.animal_id
		JOIN vets
		ON vets.id = visits.vet_id
		WHERE vets.name = 'Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name
	FROM vets
	LEFT JOIN specializations
	ON vets.id = specializations.vet_id
	LEFT JOIN species
	ON specializations.species_id = species.id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, vets.name, visits.date_of_visit
	FROM animals
	JOIN visits
	ON animals.id = visits.animal_id
	JOIN vets
	ON visits.vet_id = vets.id
	WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

	--what animal has the most visits to vets?

	SELECT animals.name, COUNT(animals.name) AS visit_count
		FROM animals
		JOIN visits
		ON animals.id = visits.animal_id
		GROUP BY animals.name
		ORDER BY visit_count DESC;

--Who was Maisy Smith's first visit?
SELECT animals.name, vets.name, visits.date_of_visit
	FROM animals
	JOIN visits
	ON animals.id = visits.animal_id
	JOIN vets
	ON vets.id = visits.vet_id
	WHERE vets.name = 'Maisy Smith'
	ORDER BY visits.date_of_visit ASC;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, vets.name, visits.date_of_visit
	FROM animals
	JOIN visits
	ON animals.id = visits.animal_id
	JOIN vets
	ON vets.id = visits.vet_id
	ORDER BY visits.date_of_visit DESC;

	--How many visits were with a vet that did not specialize in that animal's species?
	SELECT COUNT(*)
	FROM visits 
	JOIN (SELECT vets.id
			FROM vets
			FULL JOIN specializations 
		  	ON vets.id = specializations.vet_id
			FULL JOIN species 
		  	ON species.id = specializations.species_id
			WHERE specializations.species_id IS NULL) 
			vet 
	ON vet.id = visits.vet_id;
	
--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(species.name) AS species_count
	FROM animals
	JOIN visits
	ON animals.id = visits.animal_id
	JOIN vets
	ON vets.id = visits.vet_id
	JOIN specializations
	ON vets.id = specializations.vet_id
	JOIN species
	ON specializations.species_id = species.id
	WHERE vets.name = 'Maisy Smith'
	GROUP BY species.name;
	
