CREATE DATABASE f1;
USE f1;

/* -------------------------------------------- CREATE TABLES -------------------------------------------- */
# records of all racing tracks & locations used
CREATE TABLE circuits (
circuitID	INT				NOT NULL, 	-- circuit id
circuitRef	VARCHAR(60),				-- reference name of circuit
name		VARCHAR(120),				-- actual name of circuit
location	VARCHAR(60),				
country		VARCHAR(60),

PRIMARY KEY (circuitID)
);

# records of car constructors
CREATE TABLE constructors (
constructorID	INT		NOT NULL,
constructorRef	VARCHAR(60),
name			VARCHAR(120),
nationality		VARCHAR(120),

PRIMARY KEY (constructorID)
);

# records of driver's details
CREATE TABLE drivers (
driverID	INT		NOT NULL,
driverRef	VARCHAR(60),
number		INT,
code		VARCHAR(5),
surname		VARCHAR(50),
dob			VARCHAR(10),
nationality	VARCHAR(25),

PRIMARY KEY (driverID)
);

# record of pit stops taken by driver in every race
CREATE TABLE pit_stops (
raceID		INT		NOT NULL	UNIQUE,
driverID	INT		NOT NULL,
stop		INT,
lap			INT,
time		TEXT,
duration	DECIMAL(6,3),

FOREIGN KEY (raceID) REFERENCES races(raceID),
FOREIGN KEY (driverID) REFERENCES drivers(driverID)
);

DROP TABLE qualifying;
# records of the results of qualifying with the positions of the drivers
CREATE TABLE qualifying (
qualifyingID	INT 	NOT NULL,
raceID			INT		NOT NULL,
driverID		INT 	NOT NULL,
constructorID 	INT 	NOT NULL,
number			INT,
position 		INT,
q1				TEXT,
q2				TEXT,
q3				TEXT,

PRIMARY KEY (qualifyingID),
FOREIGN KEY (raceID) REFERENCES races(raceID),
FOREIGN KEY (driverID) REFERENCES drivers(driverID),
FOREIGN KEY (constructorID) REFERENCES constructors(constructorID)
);

# records of all races in F1 history
CREATE TABLE races (
raceID			INT 			NOT NULL,
year			INT,
round			INT,
circuitID		INT				NOT NULL,
name			VARCHAR(25),
date			DATE,
time			TEXT,
url				VARCHAR(500),
fp1_date		DATE,
fp1_time		TEXT,
fp2_date		DATE,
fp2_time		TEXT,
fp3_date		DATE,
fp3_time		TEXT,
quali_date		DATE,
quali_time		TEXT,
sprint_date		DATE,
sprint_time		TEXT,

PRIMARY KEY (raceID)
);

# records of all results of races + fastest lap time
CREATE TABLE results (
resultID		INT 	NOT NULL,
raceID			INT 	NOT NULL,
driverID		INT 	NOT NULL,
constructorID	INT 	NOT NULL,
number			INT,
grid			INT,
position		INT,
points			INT,
laps			INT,
time			TEXT,
fastestLap		INT,
ranked			INT,
statusID		INT 	NOT NULL,

PRIMARY KEY (resultID),
FOREIGN KEY (raceID) REFERENCES races(raceID),
FOREIGN KEY (driverID) REFERENCES drivers(driverID),
FOREIGN KEY (constructorID) REFERENCES constructors(constructorID),
FOREIGN KEY (statusID) REFERENCES status(statusID)
);

# records of all Friday sprints
CREATE TABLE sprint_results (
resultID		INT 	NOT NULL,
raceID			INT 	NOT NULL,
driverID		INT 	NOT NULL,
constructorID	INT 	NOT NULL,
number			INT,
grid			INT,
position		INT,
points			INT,
laps			INT,
time			TEXT,
milliseconds	INT,
fastestLap		INT,
fastestLapTime	TEXT,
statusID		INT,

PRIMARY KEY (resultID),
FOREIGN KEY (raceID) REFERENCES races(raceID),
FOREIGN KEY (driverID) REFERENCES drivers(driverID),
FOREIGN KEY (constructorID) REFERENCES constructors(constructorID)
);

#  records of all possible racing statuses
CREATE TABLE status (
statusID 	INT 	NOT NULL,
status		VARCHAR(120),

PRIMARY KEY (statusID)
);