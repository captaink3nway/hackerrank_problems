CREATE database school;

use school;

CREATE TABLE Student(
    regno VARCHAR(5) PRIMARY KEY,
    Student_name VARCHAR(30) NOT NULL,
    age INT,
    student_address VARCHAR(150) NOT NULL CONSTRAINT CHECK(student_address IN("chennai","pune","mumbai","delhi")),
    cgpa FLOAT CONSTRAINT CHECK(9.5 <= CGPA <= 6.5),
    doj DATE NOT NULL,
    procid INT
);

CREATE TABLE Faculty(
    id VARCHAR(5) PRIMARY KEY,
    Faculty_name VARCHAR(30) NOT NULL,
    Designation VARCHAR(20)
);

CREATE TABLE Course(
    code INT PRIMARY KEY,
    c_name VARCHAR(10) NOT NULL,
    credits INT
);

CREATE TABLE Registered(
    CONSTRAINT FOREIGN KEY (regno) REFERENCES Student(regno),
    CONSTRAINT FOREIGN KEY (code) REFERENCES Course(code)
);

INSERT INTO Student VALUES("18BCE001", "ramesh", 15, "delhi", 7.1, "2010-1-2", 101);
INSERT INTO Student VALUES("18BCE002", "sam", 15, "delhi", 1.0, "2010-1-2", 102);
INSERT INTO Student VALUES("18BCE001", "ram", 15, "delhi", 5.0, "2010-1-2", 103);
INSERT INTO Student VALUES("18BCE004", "prakash", 15, "delhi", 9.1, "2010-1-2", 104);

INSERT INTO Faculty VALUES("F001", "suresh", "Math teacher");
INSERT INTO Faculty VALUES("F002", "Reshma", "Physics teacher");
INSERT INTO Faculty VALUES("F003", "Parimal", "english teacher");
INSERT INTO Faculty VALUES("F004", "Yash", "Chemistry teacher");

INSERT INTO Course VALUES(101, "DSA", 4);
INSERT INTO Course VALUES(102, "OOPS", 3);
INSERT INTO Course VALUES(103, "JAVA", 2);
INSERT INTO Course VALUES(104, "DBMS", 4);

insert INTO Registered VALUES("18BCE001", 101);
insert INTO Registered VALUES("18BCE002", 102);
insert INTO Registered VALUES("18BCE003", 103);
insert INTO Registered VALUES("18BCE004", 104);


ALTER TABLE registered ADD Date_of_registeration DATE;

SELECT * FROM Student WHERE Student_name LIKE '___';
SELECT * FROM Student WHERE regno >="18BCE001" AND regno >= "18BCE003";

UPDATE Course SET c_name = "C++" WHERE code = 102;

ALTER TABLE Course RENAME COLUMN c_name TO Course_name; 

SELECT * FROM Student WHERE procid = 101;

DELETE FROM Student WHERE cgpa BETWEEN 0.0 AND 3.9;