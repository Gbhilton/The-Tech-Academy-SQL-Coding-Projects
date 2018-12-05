 All information from the habitat table.

SELECT *
FROM tbl_habitat

➤ Retrieve all names from the species_name column that have a species_order value of 3.

SELECT A.species_name
FROM tbl_species A
WHERE A.species_order = 3

➤ Retrieve only the nutrition_type from the nutrition table that have a nutrition_cost of 600.00 or less.

SELECT A.nutrition_type
FROM tbl_nutrition A
WHERE A.nutrition_cost <= 600.00

➤ Retrieve all species_names with the nutrition_id between 2202 and 2206 from the nutrition table.

SELECT B.species_name
FROM tbl_nutrition A
INNER JOIN tbl_species B ON B.species_nutrition = A.nutrition_id
WHERE A.nutrition_id BETWEEN(2202 AND 2206)

➤ Retrieve all names within the species_name column using the alias "Species Name:" from the species table and their corresponding nutrition_type under the alias
	 "Nutrition Type:" from the nutrition table.

SELECT A.species_name as "Species Name:", B.nutrition_type as "Nutrition Type:"
FROM tbl_species A
LEFT JOIN tbl_nutrition B ON A.species_nutrition = B.nutrition_id

➤ From the specialist table, retrieve the first and last name and contact number of those that provide care for the penguins from the species table.

SELECT A.specialist_fname, A.specialist_lname, A.specialist_contact
FROM tbl_specialist A
INNER JOIN tbl_care B ON A.specialist_id = B.care_specialist
INNER JOIN tbl_species C ON B.care_id = C.species_care
WHERE C.species_name = 'penguin'


➤ Create a database with two tables. Assign a foreign key constraint on one table that shares related data with the primary key on the second table. 
	Finally, create a statement that queries data from both tables.

CREATE DATABASE Video_Games;
CREATE TABLE tbl_developers (
		developer_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		developer_name VARCHAR(50) NOT NULL,
		developer_location VARCHAR(50) NOT NULL,
	);
CREATE TABLE tbl_games (
		game_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		game_name VARCHAR(50) NOT NULL,
		game_type VARCHAR(50) NOT NULL,
		game_developer INT NOT NULL CONSTRAINT fk_developer_id FOREIGN KEY REFERENCES tbl_developers(developer_id) ON UPDATE CASCADE ON DELETE CASCADE,
	);

INSERT INTO tbl_developers
(developer_name, developer_location)
VALUES 
('Riot Games', 'Los Angeles, CA'),
('Blizzard Entertainment', 'Anaheim, CA'),
('Grinding Gear Games', 'Auckland, New Zealand')
;
SELECT * FROM tbl_developers;

INSERT INTO tbl_games
(game_name, game_type, game_developer)
VALUES 
('Diablo 2', 'ARPG', 2),
('Diablo 3', 'ARPG', 2),
('World of Warcraft', 'MMORPG', 2),
('Path of Exile', 'ARPG', 3),
('Overwatch', 'FPS', 2),
('League of Legends', 'MOBA', 1),
('Heroes of the Storm', 'MOBA', 2),
('Warcraft 3: Reign of Chaos', 'RTS', 2),
('Warcraft 3: Frozen Throne', 'RTS', 2)
;
SELECT * FROM tbl_games;

--A readable list of my favorite game
SELECT A.game_name "Game", A.game_type "Genre", B.developer_name "Developer"
FROM tbl_games A
INNER JOIN tbl_developers B ON A.game_developer = B.developer_id

--Which company has created most of the games that I like?
SELECT B.developer_name "Developer", COUNT(B.developer_id) "Total Games"
FROM tbl_games A
INNER JOIN tbl_developers B ON A.game_developer = B.developer_id
GROUP BY B.developer_name
ORDER BY COUNT(B.developer_id) DESC

--What is my favorite genre?
SELECT A.game_type "Genre", COUNT(A.game_type) "Total Games"
FROM tbl_games A
GROUP BY A.game_type
ORDER BY COUNT(A.game_type) DESC