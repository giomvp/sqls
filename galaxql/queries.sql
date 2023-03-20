--- 2. Use SQL to calculate the number of seconds in one day (where day is 24 hours, hour is 60 minutes and a minute is 60 seconds).
SELECT 24*60*60;

--- 3. Get x, y and z information from all the rows from the table 'stars'.
SELECT x, y, z 
FROM stars;

--- 4. Make a query which returns starid, x, y and z for all stars where x is greater than zero and starid is less than one hundred. Sort the results by the y-coordinate so that the smallest values come first.
SELECT starid, x, y, z  
FROM stars 
WHERE x>0 AND starid<100 
ORDER BY y ASC;

--- 5. Build a query where you calculate the sum of all y values divided by all x values.
SELECT SUM(y/x) 
FROM stars;

--- 6. Hilight five stars which have star id between 5000 and 15000, and have class 7. (Hint: don't try to do this with a single query at this point).
INSERT INTO hilight (starid)
SELECT starid
FROM stars
WHERE starid BETWEEN 5000 AND 15000 AND class=7
ORDER BY starid ASC
LIMIT 5;

--- 7. Hilight all the stars with starid between 10000 and 11000. (I know, this is not too difficult, but it looks neat).
INSERT INTO hilight (starid)
SELECT starid
FROM stars
WHERE starid BETWEEN 10000 AND 11000;


--- 8. Kill off all stars with starid lower than 10000. Do this inside a transaction, so that when I run the ROLLBACK command, we're back with the original galaxy.
BEGIN; 
DELETE FROM stars 
WHERE starid<10000;

--- 9. Starting from the normal galaxy, update it so that you swap the x and z coordinates for stars which have star id between 10000 and 15000.
BEGIN; 
UPDATE stars SET x=z, z=x 
WHERE starid BETWEEN 10000 AND 15000;

--- 10.	Hilight all stars with starid of at least 20000, which have planets with moons that have an orbit distance of at least 3000. Remember to remove any old hilights before starting.
INSERT INTO hilight (starid)
SELECT DISTINCT p.starid 
FROM planets AS p, moons AS m 
WHERE p.planetid=m.planetid AND p.starid>20000 AND m.orbitdistance>3000;

---- 11. Hilight the star (or stars) which has the planet with the highest orbit distance in the galaxy. Remember to clear the old hilights before beginning.
INSERT INTO hilight (starid)
SELECT starid 
FROM planets, (SELECT MAX(orbitdistance) as maxob FROM planets) 
WHERE orbitdistance=maxob

--- 12. Generate a list of stars with star ids between 500 and 600 (but not including 500 and 600) with columns "starname", "startemp", "planetname", and "planettemp". The list should have all stars, with the unknown data filled out with NULL. These values are, as usual, fictional. Calculate the temperature for a star with ((class+7)*intensity)*1000000, and a planet's temperature is calculated from the star's temperature minus 50 times orbit distance.
SELECT s.name AS starname, ((s.class+7)*intensity)*1000000 AS startemp, p.name AS planetname, (((s.class+7)*intensity)*1000000) - (50*p.orbitdistance) AS planettemp
FROM stars AS s LEFT OUTER JOIN planets AS p ON s.starid=p.starid
WHERE s.starid>500 AND s.starid<600

-- 13. Create a VIEW called "numbers" with the columns "three", "intensity" and "x", where "x" and "intensity" come from the stars table, "three" contains the number 3 on all rows. For additional fun, sort the whole thing by "x" - although I won't care.
CREATE VIEW numbers AS 
SELECT 3 AS three, stars.intensity, stars.x
FROM stars
ORDER BY x

--- 14. Create a table named 'colors' with the columns 'color' and 'description'. Color is integer, description is text. Populate the table with color values from -3 to 10; each star class has its own color; fill the description with something (I won't care exactly what). Basic idea is that it will be possible to make a join between stars and colors where stars' class is compared to colors' color number.
CREATE TABLE colors (color INTEGER PRIMARY KEY, description  TEXT);
INSERT INTO colors (color, description) VALUES (-3, 'red');
INSERT INTO colors (color, description) VALUES (-2, 'blue');
INSERT INTO colors (color, description) VALUES (-1, 'gree');
INSERT INTO colors (color, description) VALUES (-0, 'yellow');
INSERT INTO colors (color, description) VALUES (1, 'orange');
INSERT INTO colors (color, description) VALUES (2, 'purple');
INSERT INTO colors (color, description) VALUES (3, 'pink');
INSERT INTO colors (color, description) VALUES (4, 'black');
INSERT INTO colors (color, description) VALUES (5, 'white');
INSERT INTO colors (color, description) VALUES (6, 'brown');
INSERT INTO colors (color, description) VALUES (7, 'gray');
INSERT INTO colors (color, description) VALUES (8, 'turquoise');
INSERT INTO colors (color, description) VALUES (9, 'magenta');
INSERT INTO colors (color, description) VALUES (10, 'teal');

--- 15. Create a table called "quotes" with two columns: "id", which is primary key, and takes integers, and "quote" which contains non-null text strings, such as quote of the day (http://www.qotd.org/). Fill in a couple of rows so that I have something to query for.
CREATE TABLE quotes (id INTEGER PRIMARY KEY, quote TEXT NOT NULL);
INSERT INTO quotes (quote) VALUES ('A nickel aint worth a dime anymore.');
INSERT INTO quotes (quote) VALUES ('In no other country in the world is the love of property keener or more alert than in the United States, and nowhere …');
INSERT INTO quotes (quote) VALUES ('In a world awash in debt, power shifts to creditors.');

--- 16. First, create and populate a table using this command*. Rename the table to 'my_table', and add a column called 'moredata'. Add one whole new row and change the 'moredata' value of at least one existing row. (Yes, I'm aware you could do all that by changing the creation commands, but that is not the point of this exercise).
CREATE TABLE alter_test (id INTEGER PRIMARY KEY, data TEXT NOT NULL);
INSERT INTO alter_test (data) VALUES ('Foo');
INSERT INTO alter_test (data) VALUES ('Bar');
INSERT INTO alter_test (data) VALUES ('Baz');

ALTER TABLE alter_test RENAME TO my_table; 
ALTER TABLE my_table ADD COLUMN moredata TEXT;
INSERT INTO my_table (data, moredata) VALUES ('Cars', 'Red');
UPDATE my_table SET moredata = 'Blue' WHERE id=1;
UPDATE my_table SET moredata = 'Green' WHERE id=2;
UPDATE my_table SET moredata = 'Gray' WHERE id=3;

--- 17. Hilight the star with the most orbitals (combined planets and moons). If multiple stars have the highest number of orbitals, highlight the one with the lowest star id.
INSERT INTO hilight (starid)
SELECT starid 
FROM (
    SELECT stars.starid AS starid, COUNT(planets.planetid) + COUNT(moons.moonid) AS orbits
    FROM stars LEFT OUTER JOIN planets ON stars.starid=planets.starid
    LEFT OUTER JOIN moons ON planets.planetid = moons.planetid
    GROUP BY stars.starid    
    ORDER BY orbits DESC
    LIMIT 1
);

--- 18.	Build a query which returns starids from planets.The starids should be selected so that for each starid (x) in the list: 1) there should exist a planet with a starid that's three times x, but there should not exist a planet with starid two times x. Only use starids from the planets table.
SELECT DISTINCT starid
FROM planets
INTERSECT
SELECT DISTINCT starid * 3
FROM planets
EXCEPT
SELECT DISTINCT starid * 2
FROM planets;

--- 19.	Create a trigger which, when a new star is created, clears the hilight table and inserts the new star id to the hilight table. 
CREATE TRIGGER new_star_trigger
AFTER INSERT ON stars
BEGIN
    DELETE FROM hilight;
    INSERT INTO hilight (starid) VALUES (NEW.starid);
END;

--- 20.	Use ALTER TABLE to rename the 'gateway' table to 'gateways'. (ALTER TABLE was covered in chapter 16).
ALTER TABLE gateway RENAME TO gateways;
