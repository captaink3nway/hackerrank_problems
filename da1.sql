CREATE database Hospital;

use Hospital;

CREATE TABLE Doctor(
	Doc_ID VARCHAR(5) PRIMARY KEY CONSTRAINT CHECK(SUBSTRING(Doc_ID,1,1)="D"),
    Doc_Name VARCHAR(30) NOT NULL,
    Gender VARCHAR(1) NOT NULL CONSTRAINT CHECK(Gender IN('M','F','T')) ,
    DOB Date NOT NULL,
    Specialist VARCHAR(20) NOT NULL CONSTRAINT CHECK(Specialist IN("Diabetes","Ophthalmology","Cardiology","General medicine")),
    Qualification VARCHAR(10) NOT NULL CONSTRAINT CHECK(Qualification IN("MBBS","MS","MD","BDS","MDS")),
    Contact VARCHAR(10),
    Address VARCHAR(30),
    Dept_No VARCHAR(5) REFERENCES Department(Dept_No)
);

CREATE TABLE Department(
	Dept_No VARCHAR(5) PRIMARY KEY CONSTRAINT CHECK(SUBSTRING(Dept_No,1,1)="D"),
    Dept_Name VARCHAR(30) NOT NULL CONSTRAINT CHECK(Dept_Name IN("Cardiology","Intensive care unit","Neurology","Oncology","Obstetrics and gynaecology","Diabetes")),
    Room_No INT NOT NULL,
    Floor INT NOT NULL,
    HOD VARCHAR(5),
    Constraint Foreign key (HOD) References Doctor(Doc_ID),
    Estd_Date DATE NOT NULL CONSTRAINT CHECK(DATE_FORMAT(Estd_Date,"%Y %M %d")>DATE_FORMAT('2001-01-01',"%Y %M %d"))
);

CREATE TABLE Staff(
	Staff_ID VARCHAR(5) PRIMARY KEY CONSTRAINT CHECK(SUBSTRING(Staff_ID,1,1)="S"),
    Staff_Name VARCHAR(30),
    Catagory VARCHAR(15) NOT NULL CONSTRAINT CHECK(Catagory IN("Nurse","Lab technician","Attender","Helper")),
    Designation VARCHAR(20) NOT NULL CONSTRAINT CHECK(Designation IN("Staff nurse","Head nurse","Technician","Senior technician","Senior attender","Junior attender")),
    DOB Date,
    Contact VARCHAR(10),
    Address VARCHAR(30),
    Dept_No VARCHAR(5),
    constraint Foreign key (Dept_No) REFERENCES Department(Dept_No)
);

CREATE TABLE Patient(
	PAT_ID VARCHAR(5) PRIMARY KEY CONSTRAINT CHECK(SUBSTRING(PAT_ID,1,1)="P"),
    Pat_Name VARCHAR(30),
    DOB DATE,
    Gender VARCHAR(1) NOT NULL CONSTRAINT CHECK(Gender IN("F","M","T")),
    Contact VARCHAR(10),
    Address VARCHAR(30)
);

CREATE TABLE In_Patient(
	Pat_ID VARCHAR(6) CONSTRAINT CHECK(SUBSTRING(PAT_ID,1,1)="P"),
    Constraint foreign key (Pat_ID) REFERENCES Patient(Pat_ID),
    Date_Of_Admission DATE,
    BED_No INT,
    Start_Time DATE NOT NULL,
    End_Time DATE,
    CONSTRAINT PRIMARY KEY(Pat_ID,Date_Of_Admission)
);

CREATE TABLE Prescription(
	Pres_ID VARCHAR(7) PRIMARY KEY CONSTRAINT CHECK(SUBSTRING(Pres_ID,1,2)="PR"),
    App_ID VARCHAR(6) CONSTRAINT CHECK(SUBSTRING(App_ID,1,2)="PT"),
    Date DATE,
    Time TIME,
    Diagnosis_Detail VARCHAR(40)
);

CREATE TABLE In_Patient_Prescription(
	Pat_ID VARCHAR(7) CONSTRAINT CHECK(SUBSTRING(Pat_ID,1,1)="P"),
    Constraint Foreign key (Pat_ID) REFERENCES Patient(PAT_ID),
    Pres_ID VARCHAR(7) CONSTRAINT CHECK(SUBSTRING(Pres_ID,1,2)="PR"),
    Constraint Foreign key (Pres_ID) REFERENCES Prescription(Pres_ID)
);

CREATE TABLE Appointment(
	App_ID VARCHAR(6) PRIMARY KEY CONSTRAINT CHECK(SUBSTRING(App_ID,1,2)="PT"),
    Pat_ID VARCHAR(6) CONSTRAINT CHECK(SUBSTRING(Pat_ID,1,1)="P"),
    Constraint Foreign key (Pat_ID) REFERENCES Patient(PAT_ID),
    Doc_ID VARCHAR(6) CONSTRAINT CHECK(SUBSTRING(Doc_ID,1,1)="D"),
    Constraint Foreign key (Doc_ID) REFERENCES Doctor(Doc_ID),
    Nurse_ID VARCHAR(6) CONSTRAINT CHECK(SUBSTRING(Nurse_ID,1,1)="S"),
    Constraint Foreign key (Nurse_ID) REFERENCES Staff(Staff_ID),
    Cosult_room_No INT,
    Date DATE,
    Time TIME
);

CREATE TABLE Prescribed_Medicines(
	Pres_ID VARCHAR(7) CONSTRAINT CHECK(SUBSTRING(Pres_ID,1,2)="PR"),
    Constraint Foreign key (Pres_ID) REFERENCES Prescription(Pres_ID),
    Medicine_Name VARCHAR(20),
    Dosage VARCHAR(10),
    Brand VARCHAR(15),
    CONSTRAINT PRIMARY KEY (Pres_ID,Medicine_Name)
);

CREATE TABLE Hospital_Bill(
	Inv_No INT,
    Inv_Date DATE,
    Pat_ID VARCHAR(6) CONSTRAINT CHECK(SUBSTRING(Pat_ID,1,1)="P"),
    Constraint Foreign key (Pat_ID) REFERENCES Patient(Pat_ID),
    Bill_Amount INT,
    Payment_Type VARCHAR(10),
    discount INT
);

CREATE TABLE Test_Types (
    TT_ID VARCHAR(7) PRIMARY KEY CONSTRAINT CHECK(SUBSTRING(TT_ID,1,2)="TT"),
    Description VARCHAR(40) NOT NULL CONSTRAINT CHECK(Description IN("Blood test","Urine test")),
    Low_Value INT,
    High_Value INT,
    Test_Method VARCHAR(10),
    Technician VARCHAR(10),
    Constraint Foreign key (Technician) REFERENCES Staff (Staff_ID)
);

CREATE TABLE Lab_Tests(
	Test_ID VARCHAR(7) PRIMARY KEY CONSTRAINT CHECK(SUBSTRING(Test_ID,1,2)="TD"),
    Pat_ID VARCHAR(7) CONSTRAINT CHECK(SUBSTRING(Pat_ID,1,1)="P"),
    Constraint Foreign key (Pat_ID) REFERENCES Patient(Pat_ID),
	Date DATE,
	Time TIME
);

CREATE TABLE Test_Results(
	Test_ID VARCHAR(7) CONSTRAINT CHECK(SUBSTRING(Test_ID,1,2)="TD"),
    Constraint Foreign key (Test_ID) REFERENCES Lab_Tests(Test_ID),
    TT_ID VARCHAR(7) CONSTRAINT CHECK(SUBSTRING(TT_ID,1,2)="TT"),
    Constraint Foreign key (TT_ID) REFERENCES Test_Types(TT_ID),
    CONSTRAINT PRIMARY KEY (Test_ID,TT_ID),
    Result VARCHAR(20)
);



INSERT INTO Doctor VALUES ("D0000","Ramesh","M","2010-01-01","Cardiology","MBBS","2343231981","20 Carter Road","D110");
INSERT INTO Doctor VALUES ("D0001","Suresh","M","2009-02-03","Ophthalmology","BDS","2343937982","20 Carter Road","D102");
INSERT INTO Doctor VALUES ("D0002","Reshma","F","2006-09-28","General medicine","MS","9762377231","12 MG Road","D100");
INSERT INTO Doctor VALUES ("D0003","Parimal","M","2001-06-29","Diabetes","MBBS","9011160960","01 Airport Road","D108"); 

INSERT INTO Department VALUES ("D110","Diabetes",304,3,"D0003","2001-09-04");
INSERT INTO Department VALUES ("D102","Neurology",403,4,"D0002","2001-10-01");
INSERT INTO Department VALUES ("D100","Cardiology",501,5,"D0003","2002-03-10");
INSERT INTO Department VALUES ("D108","Obstetrics and gynaecology",200,2,"D0001","2003-05-04");

INSERT INTO Staff VALUES ("S1001","Sushma","Nurse","Head nurse","2003-07-12","9764352131","MG Road 22","D110");
INSERT INTO Staff VALUES ("S1002","Srishma","Nurse","Staff nurse","2003-02-19","9752252122","Carter Road 01","D102");
INSERT INTO Staff VALUES ("S1003","Jayalaxmi","Attender","Technician","2001-01-02","8775419811","Swamy Road 12","D100");
INSERT INTO Staff VALUES ("S1004","Srimaan","Lab Technician","Senior Technician","2000-08-22","6675438798","Times New Roman Road 8","D108");

INSERT INTO Patient Values ("P1002","Rajeev","2001-03-22","M","9843251678","20 MG Road");
INSERT INTO Patient Values ("P1003","Rajash","2001-05-10","M","8761426789","20 Seva Road");
INSERT INTO Patient Values ("P1004","Kshma","2001-03-18","F","9843982310","20 Tavera Road");
INSERT INTO Patient Values ("P1005","Seran","2001-02-28","F","9878987890","20 Quick Road");

INSERT INTO In_Patient VALUES ("P1002","2020-10-02",304,"2020-10-03","2020-10-07");
INSERT INTO In_Patient VALUES ("P1003","2019-11-16",329,"2019-11-16","2019-11-20");
INSERT INTO In_Patient VALUES ("P1004","2018-12-22",471,"2018-12-23","2018-12-24");
INSERT INTO In_Patient VALUES ("P1005","2009-01-02",200,"2009-01-03","2009-01-04");

INSERT INTO Appointment VALUES ("PT0001","P1002","D0002","S1002",304,"2020-10-12","12:00:00");
INSERT INTO Appointment VALUES ("PT0002","P1003","D0001","S1004",200,"2020-10-13","11:00:00");
INSERT INTO Appointment VALUES ("PT0003","P1004","D0003","S1003",111,"2020-01-11","13:30:00");
INSERT INTO Appointment VALUES ("PT0004","P1005","D0000","S1001",102,"2020-10-15","14:30:00");

INSERT INTO Prescription VALUES ("PR00012","PT0001","2020-10-12","12:45:00","Little bit of Cough");
INSERT INTO Prescription VALUES ("PR0003","PT0002","2020-10-13","11:45:00","COVID mild");
INSERT INTO Prescription VALUES ("PR0004","PT0003","2020-01-11","14:15:00","Too much stress Due to Study");
INSERT INTO Prescription VALUES ("PR0005","PT0004","2020-10-15","15:15:00","Chronic Insomnia Due to Depression");

INSERT INTO In_Patient_Prescription VALUES ("P1002","PR00012");
INSERT INTO In_Patient_Prescription VALUES ("P1003","PR0003");
INSERT INTO In_Patient_Prescription VALUES ("P1004","PR0004");
INSERT INTO In_Patient_Prescription VALUES ("P1005","PR0005");

INSERT INTO Prescribed_Medicines VALUES ("PR00012","ABC","2 per day","XYZ");
INSERT INTO Prescribed_Medicines VALUES ("PR0003","XYZ","3 per day","BCA");
INSERT INTO Prescribed_Medicines VALUES ("PR0004","CAB","2 per day","XYZ");
INSERT INTO Prescribed_Medicines VALUES ("PR0005","BAC","1 per day","XYZ");



INSERT INTO Lab_Tests VALUES ("TD0001","P1002","2020-10-12","12:50:00");
INSERT INTO Lab_Tests VALUES ("TD0002","P1003","2020-10-13","11:50:00");
INSERT INTO Lab_Tests VALUES ("TD0003","P1004","2020-01-11","14:20:00");
INSERT INTO Lab_Tests VALUES ("TD0004","P1005","2020-10-15","15:20:00");

INSERT INTO Test_Types VALUES ("TT0001","Urine test",5,35,"A","S1003");
INSERT INTO Test_Types VALUES ("TT0002","Blood test",10,25,"B","S1004");
INSERT INTO Test_Types VALUES ("TT0003","Urine test",35,55,"C","S1003");
INSERT INTO Test_Types VALUES ("TT0004","Blood test",25,75,"D","S1004");

INSERT INTO Test_Results VALUES ("TD0001","TT0001","Positive");
INSERT INTO Test_Results VALUES ("TD0002","TT0002","Negative");
INSERT INTO Test_Results VALUES ("TD0003","TT0003","Positive");
INSERT INTO Test_Results VALUES ("TD0004","TT0004","Positive");

INSERT INTO Hospital_Bill VALUES (3,"2020-10-07","P1002",234500,"Cash",10);
INSERT INTO Hospital_Bill VALUES (4,"2020-10-07","P1003",294500,"Cash",10);
INSERT INTO Hospital_Bill VALUES (5,"2020-10-07","P1004",212500,"Card",10);
INSERT INTO Hospital_Bill VALUES (6,"2020-10-07","P1005",234500,"Card",10);


SELECT * FROM Doctor;

SELECT * FROM Hospital_Bill;

SELECT * FROM Doctor
WHERE Specialist="Cardiology" OR Specialist="Neurology";

SELECT * FROM Appointment
WHERE Cosult_room_No=111 AND Date="2020-01-11";

SELECT * FROM Test_Types
WHERE Low_Value>=25 AND High_Value<=75;

SELECT Diagnosis_Detail FROM Prescription
WHERE Pres_ID="PR00012";

SELECT * FROM Patient
WHERE Gender="F" OR Contact="9878987890";

SELECT Staff_ID,Staff_Name FROM Staff
WHERE NOT Dept_No="D102"; 

SELECT * FROM In_Patient
WHERE Date_Of_Admission="2020-05-01" AND BED_No=100;

DELETE FROM Test_Results
WHERE Result="Positive";

UPDATE Hospital_Bill
SET discount=discount+5
WHERE Bill_Amount>100000;

UPDATE Department
SET HOD="D0003"
WHERE Dept_Name="Cardiology";

DELETE FROM Prescribed_Medicines
WHERE Medicine_Name="XYZ";

UPDATE Test_Types
SET Low_Value=10 AND High_Value=30
WHERE Description="Urine test";

UPDATE Staff
SET Contact="7435645271"
WHERE Catagory="Nurse";

DELETE FROM Staff
WHERE (Designation="Junior attender" OR Designation="Technician") AND Dept_No="D190";
