CREATE DATABASE courseplan;
--CREATE USER 'webapp'@'%' IDENTIFIED BY 'password'; --delete when using github stuff
GRANT ALL PRIVILEGES ON courseplan.* TO 'webapp'@'%';
FLUSH PRIVILEGES;
USE courseplan;

CREATE TABLE Department (
    DeptName VARCHAR(20) NOT NULL PRIMARY KEY,
    CollegeName VARCHAR(20) NOT NULL
);

CREATE TABLE Class (
    CourseNumber CHAR(4) NOT NULL,
    Department VARCHAR(4) NOT NULL,
    CourseHours CHAR(1) NOT NULL,
    Professor VARCHAR(20) NOT NULL,
    Rating VARCHAR(5) NOT NULL,
    PrerequisiteCourseNumber CHAR(4),
    PrerequisiteDepartment VARCHAR(4),
    CorequisiteCourseNumber CHAR(4),
    CorequisiteDepartment VARCHAR(4),

    PRIMARY KEY (CourseNumber, Department),
    FOREIGN KEY (Department) REFERENCES Department(DeptName),
    FOREIGN KEY (PrerequisiteCourseNumber) REFERENCES Class(CourseNumber),
    FOREIGN KEY (PrerequisiteDepartment) REFERENCES Class(Department),
    FOREIGN KEY (CorequisiteCourseNumber) REFERENCES Class(CourseNumber),
    FOREIGN KEY (CorequisiteDepartment) REFERENCES Class(Department)
);

CREATE TABLE Major (
    MajorName VARCHAR(20) NOT NULL PRIMARY KEY
);

CREATE TABLE Plan (
    MajorName VARCHAR(20) NOT NULL,
    SemesterNumber CHAR(1) NOT NULL,
    CourseNumber CHAR(4) NOT NULL,
    DepartmentName VARCHAR(4) NOT NULL,

    PRIMARY KEY (MajorName,CourseNumber,DepartmentName),
    FOREIGN KEY (MajorName) REFERENCES Major(MajorName),
    FOREIGN KEY (CourseNumber) REFERENCES Class(CourseNumber),
    FOREIGN KEY (DepartmentName) REFERENCES Class(Department)
);

CREATE TABLE PlanClass(
    MajorName VARCHAR(20) NOT NULL,
    CourseNumber CHAR(4) NOT NULL,
    DepartmentName VARCHAR(4) NOT NULL,

    PRIMARY KEY(MajorName,CourseNumber,DepartmentName),
    FOREIGN KEY (MajorName) REFERENCES Plan(MajorName),
    FOREIGN KEY (CourseNumber) REFERENCES Class(CourseNumber),
    FOREIGN KEY (DepartmentName) REFERENCES Class(Department)
);
CREATE TABLE Advisor (
    NUID VARCHAR(9) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    MiddleName VARCHAR(20),
    LastName VARCHAR(20) NOT NULL,
    BirthDate DATE NOT NULL,
    StreetAddress VARCHAR(40) NOT NULL,
    City VARCHAR(20) NOT NULL,
    State CHAR(20),
    Country CHAR(20) NOT NULL,
    ZipCode CHAR(25),
    HireYear YEAR NOT NULL
);


CREATE TABLE HighSchool (
    CEEB VARCHAR(6) NOT NULL,
    Name VARCHAR(50) NOT NULL,

    PRIMARY KEY(CEEB)
);


CREATE TABLE Student (
    NUID CHAR(9) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    MiddleName VARCHAR(20),
    LastName VARCHAR(20) NOT NULL,
    BirthDate DATE NOT NULL,
    StreetAddress VARCHAR(40) NOT NULL,
    City VARCHAR(20) NOT NULL,
    State CHAR(30),
    Country CHAR(26) NOT NULL,
    ZipCode CHAR(25),
    CoopCycle CHAR(25) NOT NULL,
    GradYear CHAR(20) NOT NULL,
    Minor VARCHAR(20),
    MajorName VARCHAR(20) NOT NULL,
    HighschoolCEEB VARCHAR(6) NOT NULL,
    AdvisorID VARCHAR (9) NOT NULL,

    FOREIGN KEY (MajorName) REFERENCES Major(MajorName),
    FOREIGN KEY (AdvisorID) REFERENCES Advisor(NUID),
    FOREIGN KEY (HighschoolCEEB) REFERENCES HighSchool (CEEB)
);

CREATE TABLE TransferCollege (
    FederalCode CHAR(6) NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE TransferClass (
    FederalCode CHAR(6) NOT NULL,
    CourseNumber VARCHAR(4) NOT NULL,
    CourseDepartment VARCHAR(20) NOT NULL,
    Hours CHAR(1) NOT NULL,

    PRIMARY KEY(FederalCode,CourseNumber,CourseDepartment,Hours),
    FOREIGN KEY (FederalCode) REFERENCES TransferCollege(FederalCode)

);




CREATE TABLE HighSchoolClass (
    Name VARCHAR(20) NOT NULL,
    StudentID CHAR(9) NOT NULL,
    HSDepartment VARCHAR(20) NOT NULL,
    Hours CHAR(1) NOT NULL,
    CEEB CHAR(6) NOT NULL,

    PRIMARY KEY(Name,StudentID,CEEB),
    FOREIGN KEY (StudentID) REFERENCES Student(NUID),
    FOREIGN KEY (CEEB) REFERENCES HighSchool(CEEB)
);


INSERT INTO Department (DeptName,CollegeName)
VALUES
       ('CS','Khoury'),
       ('DS','Khoury'),
       ('CY','Khoury'),
       ('MUSC','CAMD'),
       ('ME','NUCE'),
       ('EE','NUCE'),
       ('CE','NUCE'),
       ('EECE','NUCE');

INSERT INTO Class (CourseNumber,Department,CourseHours,Professor,Rating)
VALUES
        (3500,'CS',4,'Apple',8.5),
        (3000,'CS',4,'Apple',8.5),
        (2500,'CS',4,'Goodman',9),
        (2510,'CS',4,'Goodman',9),
        (3000,'DS',4,'Betterman',9.4),
        (3500,'DS',4,'Betterman',9.4),
        (3560,'CS',4,'Apple',8.5);

INSERT INTO Major (MajorName)
VALUES
       ('Computer Science'),
       ('Data Science'),
       ('Cybersecurity');
INSERT INTO Plan (MajorName,SemesterNumber,CourseNumber,DepartmentName)
VALUES
       ('Computer Science',1,2500,'CS'),
       ('Computer Science',2,2510,'CS'),
       ('Computer Science',3,3000,'CS'),
       ('Computer Science',4,3500,'DS'),
       ('Data Science',1,2500,'CS'),
       ('Data Science',2,2510,'CS'),
       ('Data Science',3,3000,'CS'),
       ('Data Science',4,3500,'DS'),
       ('Cybersecurity',1,2500,'CS');


INSERT INTO PlanClass (MajorName,CourseNumber,DepartmentName)
VALUES
       ('Computer Science',2500,'CS'),
       ('Computer Science',2510,'CS'),
       ('Computer Science',3000,'CS'),
       ('Computer Science',3500,'DS'),
       ('Data Science',2500,'CS'),
       ('Data Science',2510,'CS'),
       ('Data Science',3000,'CS'),
       ('Data Science',3500,'DS'),
       ('Cybersecurity',2500,'CS');

INSERT INTO Advisor (NUID,FirstName,MiddleName,LastName,BirthDate,StreetAddress,City,State,Country,ZipCode,HireYear)
VALUES
(89,'Des','Darn','Leggan','1989-08-29','18 Barby Way','Lypova Dolyna','','Ukraine','',2008),
        (80,'Jacquelin','Evyn','Itzkovwich','1972-09-11','2 Russell Road','Saint-Denis','Île-de-France','France','93285 CEDEX',2009),
        (93,'Lauraine','Fidelia','Cozby','1985-05-25','75 Manitowish Way','Olivia','','Mauritius','',1992),
        (14,'Armstrong','Kalil','Clinch','1966-01-16','25198 Heath Plaza','Zhoinda','','China','',1980),
        (18,'Benn','Martguerita','McKew','1962-09-26','8 Anniversary Park','Dongtian','',
        'China','',1994),
        (33,'Dona','Fallon','Murdoch','1994-09-05','47898 Farwell Trail','Handaqi','','China','',
        1999),
        (38,'Herc','Josey','Pilkington','1979-03-17','22 Graceland Way','Sumberpinang Satu','',
        'Indonesia','',1997),
        (79,'Dulcia','Lazaro','Catterell','1995-09-05','4283 5th Way','Um Jar Al Gharbiyya','',
        'Sudan','',2009),
        (31,'Lila','Prissie','Meneer','1985-08-23','6 Norway Maple Circle','Sukodono','',
        'Indonesia','',2006),
        (1009,'Toni','Tadd','Solan','1997-02-25','72805 Jenna Crossing','Masindi','','Uganda','',
        2010),
        (29935,'Karna','Xylina','Tiddy','1985-11-06','0 Nevada Plaza','Shangwuzhuang','','China','',
        1999),
        (2289,'Anders','Susanne','Blackleech','1963-11-01','16793 Burning Wood Parkway','Kitsuki'
        ,'','Japan','873-0001',2010),
        (48163,'Carree','Stanton','Measor','1995-02-07','7338 Sutteridge Trail','Riosucio','',
        'Colombia','178057',1992),
        (95243,'Katusha','Durant','Thaim','1980-01-06','672 Burrows Road','Sosnovka','','Russia',
        '442064',1994),
        (95722,'Halette','L;urette','Quaintance','1979-02-10','7372 Crescent Oaks Pass','Irahuan'
        ,'','Philippines','5301',1993),
        (84041,'Kevan','Rice','Lyddy','1962-08-23','3592 Jana Drive','Grebnevo','','Russia',
        '141160',1998),
        (54416,'Mendy','Jillane','Prendiville','1981-12-13','9 Red Cloud Road','Shatki','','Russia',
        '607700',2010),
        (5378,'Brucie','Neron','OSuaird','1977-02-20','71890 6th Hill','Chaoyang','','China','',
        1996),
        (32169,'Viola','Lindie','Doble','1963-02-07','7879 Valley Edge Street','Khlung','',
        'Thailand','22110',1993),
        (10567,'Fonz','Leigh','Farra','1982-10-01','16525 Declaration Plaza','Wanganui','',
        'New Zealand','4541',2012);





INSERT INTO HighSchool (CEEB,Name)
VALUES
        (89,'Brandy High School'),
        (80,'Happy High School'),
        (82,'Cheshire High School'),
        (8282,'Hamden High School'),
        (828,'North Haven High School'),
        (23422,'Brooklyn Tech High School'),
        (00222,'Atorn High School');



INSERT INTO Student (NUID,FirstName,MiddleName,LastName,BirthDate,StreetAddress,City,State,Country,ZipCode,CoopCycle,GradYear,MajorName,HighSchoolCEEB,AdvisorID)
VALUES
        (1,'Isac','Tiertza','Brockman','2000-10-16','5196 Eagan Hill','El Paso','Texas','United States',79968,'Fall','2022-05','Data Science',82,89),
        (2,'Marty','Theresina','Putland','2000-09-14','8 Mallory Way','Rochester','New York','United States',14609,'Spring','2022-05','Computer Science',80,80),
 (3,'Reade','Andrea','Mew','2000-11-15','9862 Muir Trail','Springfield','Illinois','United States',62711,'Spring','2022-05','Data Science',89,93),
        (4,'Kippy','Karisa','Westberg','2002-04-12','7123 Messerschmidt Place','Brooklyn','New York','United States',11247,'Spring','2024-05','Data Science',00222,14),
        (5,'Jaimie','Bamby','Storch','2002-06-11','4633 Hoard Avenue','New York City','New York','United States',10029,'Spring','2024-05','Cybersecurity',828,18),
        (6,'Gregory','Karina','Birdwistle','2000-04-26','988 Kings Pass','Saint Paul','Minnesota','United States',55172,'Fall','2022-05','Data Science',8282,33),
        (7,'Erny','Benson','Alywen','2002-12-31','62257 Bayside Terrace','Gary','Indiana','United States',46406,'Spring','2024-05','Data Science',828,38),
        (8,'Estrella','Lydon','Pluck','2001-01-08','11350 Troy Drive','Philadelphia','Pennsylvania','United States',19160,'Fall','2022-12','Computer Science',89,79),
        (9,'Carr','Merle','Hymas','2000-04-23','2461 Florence Pass','Indianapolis','Indiana','United States',46221,'Fall','2022-12','Computer Science',23422,31),
        (10,'Fulton','Eulalie','Heggison','2000-12-25','3224 Kennedy Drive','San Antonio','Texas','United States',78245,'Spring','2022-12','Computer Science',82,31),
        (11,'Zared','Stillmann','Aggott','2000-01-30','736 Browning Point','Melbourne','Florida','United States',32919,'Spring','2022-12','Data Science',80,33),
        (12,'Casar','Romain','Noteyoung','2000-03-07','78 Crownhardt Street','Houston','Texas','United States',77030,'Spring','2022-12','Cybersecurity',82,89),
        (13,'Hector','Meredith','Huglin','2004-09-22','6381 Stone Corner Crossing','Chicago','Illinois','United States',60686,'Spring','2025-05','Computer Science',82,18),
        (14,'Johnna','Joellen','Leek','2002-04-19','00791 Oakridge Hill','Canton','Ohio','United States',44760,'Fall','2025-05','Computer Science',89,18),
        (15,'Ranee','Abdul','Jizhaki','2003-06-04','953 Butterfield Way','Austin','Texas','United States',78749,'Fall','2025-05','Cybersecurity',82,80),
        (16,'Nathaniel','Bradley','Angric','2001-05-12','91720 Granby Junction','Irving','Texas','United States',75062,'Spring','2023-05','Computer Science',80,33),
        (17,'Mahalia','Wendall','Hilhouse','2003-08-03','6617 Talisman Place','Omaha','Nebraska','United States',68105,'Fall','2025-05','Cybersecurity',89,38),
        (18,'Kelwin','Ciro','Liggins','2002-03-25','98 Leroy Crossing','Wichita','Kansas','United States',67205,'Spring','2023-05','Cybersecurity',00222,79),
        (19,'Skye','Sholom','Bondesen','2002-07-02','68 Arrowood Junction','Winston Salem','North Carolina','United States',27110,'Spring','2025-05','Computer Science',828,31),
        (20,'Feliks','Trudie','Tourot','2002-11-12','54 Express Alley','Erie','Pennsylvania','United States',16522,'Fall','2025-05','Cybersecurity',00222,80);

INSERT INTO TransferCollege (FederalCode,Name)
VALUES
       (3869,'Fundamentals of Computer Science 1'),
       (8,'Discrete Structures'),
       (2541,'Intro to Mathematical Reasoning'),
       (331,'Discrete Structures'),
       (98489,'Discrete Structures'),
       (6,'First Year Seminar'),
       (1000,'First Year Seminar'),
       (9,'Intro to Mathematical Reasoning'),
       (1294,'First Year Seminar'),
       (5,'First Year Seminar'),
       (85,'Discrete Structures'),
       (12,'Discrete Structures'),
       (98,'Discrete Structures'),
       (50196,'First Year Seminar'),
       (68985,'Discrete Structures'),
       (1137,'First Year Seminar'),
       (1355,'Fundamentals of Computer Science 1'),
       (457,'First Year Seminar'),
       (1,'Fundamentals of Computer Science 1'),
       (7,'Intro to Mathematical Reasoning');



INSERT INTO TransferClass (FederalCode,CourseNumber,CourseDepartment,Hours)
VALUES
       (3869,8768,'Cybersecurity',3),
       (8,6154,'Computer Science',4),
       (2541,3970,'Cybersecurity',4),
       (331,1250,'Computer Science',4),
       (98489,7839,'Cybersecurity',3),
       (6,2347,'Computer Science',1),
       (1000,2841,'Data Science',1),
       (9,8298,'Computer Science',4),
       (1294,5504,'Data Science',1),
       (5,1631,'Cybersecurity',1),
       (85,9169,'Data Science',4),
       (12,6819,'Cybersecurity',4),
       (98,5977,'Cybersecurity',4),
       (50196,6668,'Data Science',1),
       (68985,1835,'Data Science',4),
       (1137,9701,'Cybersecurity',1),
       (1355,9926,'Data Science',4),
       (457,7714,'Computer Science',1),
       (1,1525,'Cybersecurity',4),
       (7,6475,'Computer Science',4);



INSERT INTO HighSchoolClass (Name,StudentID,HSDepartment,Hours,CEEB)
VALUES
       ('AP Statistics',1,'Math',4,89),
       ('AP Statistics',2,'Math',4,80),
       ('AP BC Calculus',3,'Math',4,89),
       ('AP BC Calculus',6,'Math',4,8282),
       ('AP BC Calculus',7,'Math',4,828),
       ('AP BC Calculus',1,'Math',4,89),
       ('AP BC Calculus',2,'Math',4,80),
       ('AP CSP',2,'Computer Science',4,80),
       ('AP CSP',5,'Computer Science',4,828),
       ('AP CSP',7,'Computer Science',4,828),
       ('AP CSP',6,'Computer Science',4,8282),
       ('AP CSP',4,'Computer Science',4,00222),
       ('AP CSP',3,'Computer Science',4,89),
       ('AP Physics C',10,'Science',4,82),
       ('AP Physics C',11,'Science',4,80),
       ('AP Physics C',15,'Science',4,82),
       ('AP Physics C',16,'Science',4,80),
       ('AP Physics ',9,'Science',4,23422);




