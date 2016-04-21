.LOGON DBC,DBC
/*************************************************/
/* Create a "super user" for Teradata Education */
/* Classroom Lab database/userid installation */
/*************************************************/
/* Note: This script must be run by a user who */
/* has Create Database/User authority and */
/* the right to grant or re-grant select */
/* on the dictionary tables.
/*************************************************/
/* Space limits and account codes may be */
/* modified by the user (RPK 3/97) */
/*************************************************/

CREATE USER Teradata_Education AS PASSWORD = educate
PERM = 20000000 SPOOL = 5000000
ACCOUNT = ('$M_D2102');
GRANT ALL ON Teradata_Education TO Teradata_Education
WITH GRANT OPTION;
GRANT SELECT ON DBC TO Teradata_Education
WITH GRANT OPTION;

.LOGOFF

.SET SESSIONS 8
.SET QUIET ON
.LOGON Teradata_Education,Educate
/********************************************************/
/* Creates Database Customer_Service, defines and */
/* populates nine (9) sample tables (RPK 3/97) */
/********************************************************/

SELECT * FROM DBC.Databases
WHERE DatabaseName = 'Customer_Service';

.IF ActivityCount = 0 THEN .GOTO CreateCS
GRANT DROP DATABASE ON Customer_Service TO Teradata_Education;
DELETE DATABASE Customer_Service;
DROP DATABASE Customer_Service;

.LABEL CreateCS

CREATE DATABASE Customer_Service FROM Teradata_Education AS
	PERM=500000 ACCOUNT = ('$M_P0623');
	
DATABASE Customer_Service;

CREATE TABLE contact, FALLBACK
	(contact_number INTEGER
	,contact_name CHAR(30) NOT NULL
	,area_code SMALLINT NOT NULL
	,phone INTEGER NOT NULL
	,extension INTEGER
	,last_call_date DATE NOT NULL)
	UNIQUE PRIMARY INDEX (contact_number);
	
CREATE TABLE customer, FALLBACK
	(customer_number INTEGER
	,customer_name CHAR(30) NOT NULL
	,parent_customer_number INTEGER
	,sales_employee_number INTEGER
	)
	UNIQUE PRIMARY INDEX (customer_number);
	
CREATE TABLE department, FALLBACK
	(department_number SMALLINT
	,department_name CHAR(30) NOT NULL
	,budget_amount DECIMAL(10,2)
	,manager_employee_number INTEGER
	)
	UNIQUE PRIMARY INDEX (department_number)
	,UNIQUE INDEX (department_name);

CREATE TABLE employee, FALLBACK
	(employee_number INTEGER
	,manager_employee_number INTEGER
	,department_number INTEGER
	,job_code INTEGER
	,last_name CHAR(20) NOT NULL
	,first_name VARCHAR(30) NOT NULL
	,hire_date DATE NOT NULL
	,birthdate DATE NOT NULL
	,salary_amount DECIMAL(10,2) NOT NULL
	)
	UNIQUE PRIMARY INDEX (employee_number);
	
CREATE TABLE employee_phone, FALLBACK
	(employee_number INTEGER NOT NULL
	,area_code SMALLINT NOT NULL
	,phone INTEGER NOT NULL
	,extension INTEGER
	,comment_line CHAR(72)
	)
	PRIMARY INDEX (employee_number);

CREATE TABLE job, FALLBACK
	(job_code INTEGER
	,description VARCHAR(40) NOT NULL
	,hourly_billing_rate DECIMAL(6,2)
	,hourly_cost_rate DECIMAL(6,2)
	)
	UNIQUE PRIMARY INDEX (job_code)
	,UNIQUE INDEX (description);
	
CREATE TABLE location, FALLBACK
	(location_number INTEGER
	,customer_number INTEGER NOT NULL
	,first_address_line CHAR(30) NOT NULL
	,city VARCHAR(30) NOT NULL
	,state CHAR(15) NOT NULL
	,zip_code INTEGER NOT NULL
	,second_address_line CHAR(30)
	,third_address_line CHAR(30)
	)
	PRIMARY INDEX (customer_number);

CREATE TABLE location_employee, FALLBACK
	(location_number INTEGER NOT NULL
	,employee_number INTEGER NOT NULL
	)
	PRIMARY INDEX (employee_number);
	
CREATE TABLE location_phone, FALLBACK
	(location_number INTEGER
	,area_code SMALLINT NOT NULL
	,phone INTEGER NOT NULL
	,extension INTEGER
	,description VARCHAR(40) NOT NULL
	,comment_line LONG VARCHAR
	)
	PRIMARY INDEX (location_number);
	
INSERT INTO contact VALUES
	(8010,'Brayman, Connie',408,1112345,112,870721);
INSERT INTO contact VALUES
	(8001,'Leblanc, James',805,2213456,221,870801);
INSERT INTO contact VALUES
	(8005,'Hughes, Jack',212,5432126,710,870805);
INSERT INTO contact VALUES
	(8007,'Smith, Ginny',408,3792152,333,870801);
INSERT INTO contact VALUES
	(8008,'Torres, Alison',802,5487890,444,880814);
INSERT INTO contact VALUES
	(8009,'Dibble, Nancy',602,2713387,652,880809);
	
INSERT INTO customer VALUES
	(00,'Corporate Headquarters',NULL,NULL);
INSERT INTO customer VALUES
	(01,'A to Z Communications, Inc.',NULL,1015);
INSERT INTO customer VALUES
	(02,'Simple Instruments Co.',1,1015);
INSERT INTO customer VALUES
	(03,'First American Bank',NULL,1023);
INSERT INTO customer VALUES
	(04,'Sum Bank',3,1023);
INSERT INTO customer VALUES
	(05,'Federal Bureau of Rules',NULL,1018);
INSERT INTO customer VALUES
	(06,'Liberty Tours',NULL,1023);
INSERT INTO customer VALUES
	(07,'Cream of the Crop',NULL,1018);
INSERT INTO customer VALUES
	(08,'Colby Co.',NULL,1018);
INSERT INTO customer VALUES
	(09,'More Data Enterprise',NULL,1023);
INSERT INTO customer VALUES
	(10,'Graduates Job Service',NULL,1015);
INSERT INTO customer VALUES
	(11,'Hotel California',NULL,1015);
INSERT INTO customer VALUES
	(12,'Cheap Rentals',NULL,1018);
INSERT INTO customer VALUES
	(13,'First American Bank',3,1023);
INSERT INTO customer VALUES
	(14,'Metro Savings',NULL,1018);
INSERT INTO customer VALUES
	(15,'Cates Modeling',NULL,1015);
INSERT INTO customer VALUES
	(16,'VIP Investments',3,1023);
INSERT INTO customer VALUES
	(17,'East Coast Dating Service',NULL,1023);
INSERT INTO customer VALUES
	(18,'Wall Street Connection',NULL,1023);
INSERT INTO customer VALUES
	(19,'More Data Enterprise',9,1015);
INSERT INTO customer VALUES
	(20,'Metro Savings',14,1018);
	
INSERT INTO department VALUES
	(401,'customer support',982300,1003);
INSERT INTO department VALUES
	(201,'technical operations',293800,1025);
INSERT INTO department VALUES
	(301,'research and development',465600,1019);
INSERT INTO department VALUES
	(302,'product planning',226000,1016);
INSERT INTO department VALUES
	(403,'education',932000,1005);
INSERT INTO department VALUES
	(402,'software support',308000,1011);
INSERT INTO department VALUES
	(501,'marketing sales',308000,1017);
INSERT INTO department VALUES
	(100,'president',400000,0801);
INSERT INTO department VALUES
	(600,'None',,1099);
	
INSERT INTO employee VALUES
	(0801,0801,100,111100,'Trainer','I.B.',730301,450811,100000);
INSERT INTO employee VALUES
	(1001,1003,401,412101,'Hoover','William',760618,500114,25525);
INSERT INTO employee VALUES
	(1002,1003,401,413201,'Brown','Alan',760731,440809,43100);
INSERT INTO employee VALUES
	(1003,0801,401,411100,'Trader','James',760731,470619,37850);
INSERT INTO employee VALUES
	(1004,1003,401,412101,'Johnson','Darlene',761015,460423,36300);
INSERT INTO employee VALUES
	(1005,0801,403,431100,'Ryan','Loretta',761015,550910,31200);
INSERT INTO employee VALUES
	(1006,1019,301,312101,'Stein','John',761015,531015,29450);
INSERT INTO employee VALUES
	(1007,1005,403,432101,'Villegas','Arnando',770102,370131,49700);
INSERT INTO employee VALUES
	(1008,1019,301,312102,'Kanieski','Carol',770201,580517,29250);
INSERT INTO employee VALUES
	(1009,1005,403,432101,'Lombardo','Domingus',770201,451115,31000);
INSERT INTO employee VALUES
	(1010,1003,401,412101,'Rogers','Frank',770301,350423,46000);
INSERT INTO employee VALUES
	(1011,0801,402,421100,'Daly','James',770315,491211,52500);
INSERT INTO employee VALUES
	(1012,1005,403,432101,'Hopkins','Paulene',770315,420218,37900);
INSERT INTO employee VALUES
	(1013,1003,401,412102,'Phillips','Charles',770401,630810,24500);
INSERT INTO employee VALUES
	(1014,1011,402,422101,'Crane','Robert',780115,600704,24500);
INSERT INTO employee VALUES
	(1015,1017,501,512101,'Wilson','Edward',780301,570304,53625);
INSERT INTO employee VALUES
	(1016,0801,302,321100,'Rogers','Nora',780301,590904,56500);
INSERT INTO employee VALUES
	(1017,0801,501,511100,'Runyon','Irene',780501,511110,66000);
INSERT INTO employee VALUES
	(1018,1017,501,512101,'Ratzlaff','Larry',780715,540531,54000);
INSERT INTO employee VALUES
	(1019,0801,301,311100,'Kubic','Ron',780801,421211,57700);
INSERT INTO employee VALUES
	(1020,1005,403,432101,'Charles','John',781001,490621,39500);
INSERT INTO employee VALUES
	(1021,1025,201,222101,'Morrissey','Jim',781001,430429,38750);
INSERT INTO employee VALUES
	(1022,1003,401,412102,'Machado','Albert',790301,570714,32300);
INSERT INTO employee VALUES
	(1023,1017,501,512101,'Rabbit','Peter',790301,621029,26500);
INSERT INTO employee VALUES
	(1024,1005,403,432101,'Brown','Allen',790501,540116,43700);
INSERT INTO employee VALUES
	(1025,0801,201,211100,'Short','Michael',790501,470707,34700);
INSERT INTO employee_phone VALUES
	(0801,213,8278777,101,'Corporate President');
INSERT INTO employee_phone VALUES
	(1001,415,2412021,NULL,'Graduates Job Service');
INSERT INTO employee_phone VALUES
	(1001,415,3563560,NULL,'Hotel California');
INSERT INTO employee_phone VALUES
	(1001,213,2872019,NULL,'Cates Modeling');
INSERT INTO employee_phone VALUES
	(1001,415,6567000,NULL,'More Data');
INSERT INTO employee_phone VALUES
	(1001,415,4491221,NULL,'A TO Z office');
INSERT INTO employee_phone VALUES
	(1001,415,4491225,NULL,'A TO Z System Manager');
INSERT INTO employee_phone VALUES
	(1001,415,4491244,NULL,'A TO Z Secretary');
INSERT INTO employee_phone VALUES
	(1001,415,9234864,NULL,'residence/office');
INSERT INTO employee_phone VALUES
	(1001,415,9237892,NULL,'Simple Instruments');
INSERT INTO employee_phone VALUES
	(1002,213,2721606,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1002,213,8278777,439,'office');
INSERT INTO employee_phone VALUES
	(1003,213,3774534,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1003,213,8278777,401,'office');
INSERT INTO employee_phone VALUES
	(1004,212,7230101,NULL,'First Am. Bank computer room');
INSERT INTO employee_phone VALUES
	(1004,212,7232121,NULL,'First Am. Bank system manager');
INSERT INTO employee_phone VALUES
	(1004,609,5591011,213,'Sum Bank system manager');
INSERT INTO employee_phone VALUES
	(1004,609,5591011,224,'Sum Bank computer room');
INSERT INTO employee_phone VALUES
	(1004,609,5591011,225,'Sum Bank secretary');
INSERT INTO employee_phone VALUES
	(1004,609,5785781,NULL,'residence/office');
INSERT INTO employee_phone VALUES
	(1004,212,5786099,NULL,'Liberty Tours main number');
INSERT INTO employee_phone VALUES
	(1004,919,9789000,NULL,'More Data System Manager');
INSERT INTO employee_phone VALUES
	(1004,617,7567676,NULL,'First Am. Bank Manager');
INSERT INTO employee_phone VALUES
	(1004,212,8282828,NULL,'VIP Investments');
INSERT INTO employee_phone VALUES
	(1004,718,2243283,NULL,'East Coast Dating');
INSERT INTO employee_phone VALUES
	(1004,212,4909190,NULL,'Wall Street Connection');
INSERT INTO employee_phone VALUES
	(1005,213,2514189,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1005,213,8278777,415,'office');
INSERT INTO employee_phone VALUES
	(1006,213,8278777,410,'office');
INSERT INTO employee_phone VALUES
	(1006,213,3716087,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1007,213,2274764,NULL,'residence');
INSERT INTO employee_phone VALUES	
	(1007,213,8278777,440,'office');
INSERT INTO employee_phone VALUES
	(1008,213,3788092,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1008,213,8278777,429,'office');
INSERT INTO employee_phone VALUES
	(1009,213,2482619,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1009,213,8278777,413,'office');
INSERT INTO employee_phone VALUES
	(1010,202,5456187,NULL,'Residence/office');
INSERT INTO employee_phone VALUES
	(1010,213,8278777,NULL,'office');
INSERT INTO employee_phone VALUES
	(1010,202,3239119,NULL,'Fed Bureau of Rules request name');
INSERT INTO employee_phone VALUES
	(1010,804,9230911,NULL,'Cream of the Crop');
INSERT INTO employee_phone VALUES
	(1010,313,4630300,NULL,'Colby Co');
INSERT INTO employee_phone VALUES
	(1010,312,0990988,NULL,'Cheap Rentals');
INSERT INTO employee_phone VALUES
	(1010,804,4563000,370,'Metro Savings');
INSERT INTO employee_phone VALUES
	(1010,804,4563000,375,'Metro Savings');
INSERT INTO employee_phone VALUES
	(1010,312,5692122,NULL,'Metro Savings');
INSERT INTO employee_phone VALUES
	(1011,213,8278777,422,'office');
INSERT INTO employee_phone VALUES
	(1011,213,3549138,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1012,213,8278777,418,'office');
INSERT INTO employee_phone VALUES
	(1012,213,9788422,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1013,213,8278777,411,'office');
INSERT INTO employee_phone VALUES
	1013,213,9857506,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1014,213,8278777,442,'office');
INSERT INTO employee_phone VALUES
	(1014,213,2528809,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1015,213,8278777,436,'office');
INSERT INTO employee_phone VALUES
	(1015,213,3012906,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1015,415,4491225,NULL,'A to Z system manager');
INSERT INTO employee_phone VALUES
	(1015,415,9237892,NULL,'Simple Instruments receptionist');
INSERT INTO employee_phone VALUES
	(1016,213,8278777,412,'office');
INSERT INTO employee_phone VALUES
	(1016,213,2925224,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1017,213,8278777,425,'office');
INSERT INTO employee_phone VALUES
	(1017,213,9231070,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1018,202,3239119,NULL,'Fed Bureau of Rules');
INSERT INTO employee_phone VALUES
	(1018,804,2989791,NULL,'residence/office');
INSERT INTO employee_phone VALUES
	(1019,213,8278777,418,'office');
INSERT INTO employee_phone VALUES
	(1019,213,2640855,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1020,213,8278777,433,'office');
INSERT INTO employee_phone VALUES
	(1020,213,2248513,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1021,213,8278777,428,'office');
INSERT INTO employee_phone VALUES
	(1021,213,2659291,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1022,213,8278777,416,'office');
INSERT INTO employee_phone VALUES
	(1022,213,4982012,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1023,212,7232121,NULL,'First Am. Bank system manager');
INSERT INTO employee_phone VALUES
	(1023,212,8283747,NULL,'residence/office');
INSERT INTO employee_phone VALUES
	(1023,609,5591011,213,'Sum Bank receptionist');
INSERT INTO employee_phone VALUES
	(1024,213,8278777,417,'office');
INSERT INTO employee_phone VALUES
	(1024,213,2724743,NULL,'residence');
INSERT INTO employee_phone VALUES
	(1025,213,8278777,429,'office');
INSERT INTO employee_phone VALUES
	(1025,213,2964652,NULL,'residence');
	
INSERT INTO job VALUES
	(111100,'Corporate President',0,0);
INSERT INTO job VALUES
	(412102,'Product Specialist',0,0);
INSERT INTO job VALUES
	(412103,'System Support Analyst',0,0);
INSERT INTO job VALUES
	(413201,'Dispatcher',0,0);
INSERT INTO job VALUES
	(412101,'Field Engineer',0,0);
INSERT INTO job VALUES
	(512101,'Sales Rep',0,0);
INSERT INTO job VALUES
	(312101,'Software Engineer',0,0);
INSERT INTO job VALUES
	(312102,'Hardware Engineer',0,0);
INSERT INTO job VALUES
	(322101,'Planning Specialist',0,0);
INSERT INTO job VALUES
	(432101,'Instructor',0,0);
INSERT INTO job VALUES
	(222101,'System Analyst',0,0);
INSERT INTO job VALUES
	(422101,'Software Analyst',0,0);
INSERT INTO job VALUES
	(104201,'Electronic Assembler',0,0);
INSERT INTO job VALUES
	(104202,'Mechanical Assembler',0,0);
INSERT INTO job VALUES
	(411100,'Manager - Customer Support',0,0);
INSERT INTO job VALUES
	(421100,'Manager - Software Support',0,0);
INSERT INTO job VALUES
	(431100,'Manager - Education',0,0);
INSERT INTO job VALUES
	(321100,'Manager - Product Planning',0,0);
INSERT INTO job VALUES
	(311100,'Manager - Research and Development',0,0);
INSERT INTO job VALUES
	(511100,'Manager - Marketing Sales',0,0);

INSERT INTO location VALUES
	(05000000,0,'1294 Jefferson Blvd','Los Angeles','California',
	951604032,NULL,NULL);
INSERT INTO location VALUES
	(05000001,1,'101 Middlefield Rd','Palo
	Alto','California',951604032,NULL,NULL);
INSERT INTO location VALUES
	(05000002,2,'49 Fourth St','San Francisco','California',941031066,NULL,NULL);
INSERT INTO location VALUES
	(33000003,3,'10366 25th St','New York City','New
	York',105293045,NULL,NULL);
INSERT INTO location VALUES
	(31000004,4,'55 Madison Av','Trenton','New Jersey',123419199,NULL,NULL);
INSERT INTO location VALUES
	(09000005,5,'1 Lincoln Square','Washington','DC',156075555,NULL,NULL);
INSERT INTO location VALUES
	(33000006,6,'10 River Rd','Schenectady','New York',123016166,NULL,NULL);
INSERT INTO location VALUES
	(47000007,7,'4035 South 35th Av','Arlington','Virginia',222061016,NULL,NULL);
INSERT INTO location VALUES
	(23000008,8,'1100 State St','Detroit','MI',484107888,NULL,NULL);
INSERT INTO location VALUES
	(34000009,9,'4400 Greenwood Rd','Wilmington','NC',284031199,NULL,NULL);
INSERT INTO location VALUES
	(05000010,10,'5171 El Camino Real','Palo Alto','California',94071,NULL,NULL);
INSERT INTO location VALUES
	(05000011,11,'770 Hotel Dr','Menlo Park','California',940585151,NULL,NULL);
INSERT INTO location VALUES
	(14000012,12,'510 Benton Av','Chicago','Illinois',606483930,NULL,NULL);
INSERT INTO location VALUES
	(22000013,13,'1059 Kings Rd','Boston','Massachusetts',012104091,NULL,NULL);
INSERT INTO location VALUES
	(47000014,14,'1690 Miller Av','Richmond','Virginia',223104121,NULL,NULL);
INSERT INTO location VALUES
	(05000015,15,'687 Culver Blvd','Culver
	City','California',900513965,NULL,NULL);
INSERT INTO location VALUES
	(33000016,16,'2255 16th Av','New York City','New
	York',105293033,NULL,NULL);
INSERT INTO location VALUES
	(33000017,17,'4001 Harbor Blvd','Brooklyn','New
	York',105431915,NULL,NULL);
INSERT INTO location VALUES
	(33000018,18,'105 Time Square','New York City','New
	York',105082682,NULL,NULL);
INSERT INTO location VALUES
	(05000019,19,'567 El Camino Real','San
	Mateo','California',942153219,NULL,NULL);
INSERT INTO location VALUES
	(14000020,20,'876 Winston St','Chicago','Illinois',606316166,NULL,NULL);
	
INSERT INTO location_employee VALUES
	(05000001,1001);
INSERT INTO location_employee VALUES
	(05000002,1001);
INSERT INTO location_employee VALUES
	(33000003,1004);
INSERT INTO location_employee VALUES
	(31000004,1004);
INSERT INTO location_employee VALUES
	(09000005,1010);
INSERT INTO location_employee VALUES
	(33000006,1004);
INSERT INTO location_employee VALUES
	(47000007,1010);
INSERT INTO location_employee VALUES
	(23000008,1010);
INSERT INTO location_employee VALUES
	(34000009,1004);
INSERT INTO location_employee VALUES
	(05000010,1001);
INSERT INTO location_employee VALUES
	(05000011,1001);
INSERT INTO location_employee VALUES
	(14000012,1010);
INSERT INTO location_employee VALUES
	(22000013,1004);
INSERT INTO location_employee VALUES
	(47000014,1010);
INSERT INTO location_employee VALUES
	(05000015,1001);
INSERT INTO location_employee VALUES
	(33000016,1004);
INSERT INTO location_employee VALUES
	(33000017,1004);
INSERT INTO location_employee VALUES
	(33000018,1004);
INSERT INTO location_employee VALUES
	(33000019,1001);
INSERT INTO location_employee VALUES
	(14000020,1010);
	
INSERT INTO location_phone VALUES
	(05000000,213,8278777,101,'Corporate Presidents office',NULL);
INSERT INTO location_phone VALUES
	(05000001,415,4491221,NULL,'FEs office',NULL);
INSERT INTO location_phone VALUES
	(05000001,415,4491225,NULL,'System Manager',NULL);
INSERT INTO location_phone VALUES
	(05000001,415,4491244,NULL,'Secretary','available 9:00 to 5:00');
INSERT INTO location_phone VALUES
	(05000002,415,9237892,NULL,'Receptionist','ask for page');
INSERT INTO location_phone VALUES
	(33000003,212,7230101,NULL,'Computer Room',NULL);
INSERT INTO location_phone VALUES
	(33000003,212,7232121,NULL,'System Manager',NULL);
INSERT INTO location_phone VALUES
	(31000004,609,5591011,213,'Receptionist','leave message');
INSERT INTO location_phone VALUES
	(31000004,609,5591011,224,'System Manager',NULL);
INSERT INTO location_phone VALUES
	(31000004,609,5591011,225,'Computer Room',NULL);
INSERT INTO location_phone VALUES
	(09000005,202,3239119,NULL,'Switchboard',NULL);
INSERT INTO location_phone VALUES
	(33000006,212,5786099,NULL,'Small office',NULL);
INSERT INTO location_phone VALUES
	(47000007,804,9230911,NULL,'Switchboard',NULL);
INSERT INTO location_phone VALUES
	(23000008,313,4630300,NULL,'Receptionist',NULL);
INSERT INTO location_phone VALUES
	(34000009,919,9789000,NULL,'Receptionist',NULL);
INSERT INTO location_phone VALUES
	(34000009,919,9789000,601,'John Moore','Vice President');
INSERT INTO location_phone VALUES
	(05000010,415,2412021,NULL,'Alice Hamm','President');
INSERT INTO location_phone VALUES
	(05000011,415,3563560,NULL,'J.R. Stern','Owner');
INSERT INTO location_phone VALUES
	(14000012,312,9880988,NULL,'Tom Thumb','Owner');
INSERT INTO location_phone VALUES
	(22000013,617,7567676,NULL,'Computer Room',NULL);
INSERT INTO location_phone VALUES
	(22000013,617,7562918,NULL,'System Manager',NULL);
INSERT INTO location_phone VALUES
	(47000014,804,4563000,370,'Alan Monday','System Manager');
INSERT INTO location_phone VALUES
	(47000014,804,4563000,375,'Receptionist',NULL);
INSERT INTO location_phone VALUES
	(05000015,213,2872019,NULL,'Charles Cates','Owner');
INSERT INTO location_phone VALUES
	(33000016,212,8282828,NULL,'Andy Moore',NULL);
INSERT INTO location_phone VALUES
	(33000017,718,2243283,NULL,'various contacts',NULL);
INSERT INTO location_phone VALUES
	(33000018,212,4909190,NULL,'Tom Sellers',NULL);
INSERT INTO location_phone VALUES
	(05000019,415,6567000,NULL,'Receptionist',NULL);
INSERT INTO location_phone VALUES
	(14000020,312,5692122,NULL,'Receptionist',NULL);
INSERT INTO location_phone VALUES
	(14000020,312,5692136,NULL,'System Manager',NULL);
	






SELECT DatabaseName FROM DBC.Databases
WHERE DatabaseName = 'CS_VIEWS';

.IF ActivityCount = 0 THEN .GoTo CreateVM

GRANT DROP DATABASE ON CS_VIEWS TO Teradata_Education;
DELETE DATABASE CS_VIEWS;
DROP DATABASE CS_VIEWS;

.LABEL CreateVM

CREATE DATABASE CS_VIEWS FROM Teradata_Education AS PERM = 0
	ACCOUNT = ('$M_P0623');
	
GRANT SELECT ON Customer_Service to CS_VIEWS WITH GRANT OPTION;

DATABASE CS_VIEWS;

CREATE VIEW contact
	(contact_number
	,contact_name
	,area_code
	,phone
	,extension
	,last_call_date)
AS
SELECT
	contact_number
	,contact_name
	,area_code
	,phone
	,extension
	,last_call_date
FROM CUSTOMER_SERVICE.contact;

CREATE VIEW customer
	(customer_number
	,customer_name
	,parent_customer_number
	,sales_employee_number)
AS
SELECT
	customer_number
	,customer_name
	,parent_customer_number
	,sales_employee_number
FROM CUSTOMER_SERVICE.customer;

CREATE VIEW department
	(department_number
	,department_name
	,budget_amount
	,manager_employee_number)
AS
SELECT
	department_number
	,department_name
	,budget_amount
	,manager_employee_number
FROM CUSTOMER_SERVICE.department;

CREATE VIEW employee
	(employee_number
	,manager_employee_number
	,department_number
	,job_code
	,last_name
	,first_name
	,hire_date
	,birthdate
	,salary_amount)
AS
SELECT
	employee_number
	,manager_employee_number
	,department_number
	,job_code
	,last_name
	,first_name
	,hire_date
	,birthdate
	,salary_amount
FROM CUSTOMER_SERVICE.employee;

CREATE VIEW employee_phone
	(employee_number
	,area_code
	,phone
	,extension
	,comment_line)
AS
SELECT
	employee_number
	,area_code
	,phone
	,extension
	,comment_line
FROM CUSTOMER_SERVICE.employee_phone;

CREATE VIEW job
	(job_code
	,description
	,hourly_billing_rate
	,hourly_cost_rate)
AS
SELECT
	job_code
	,description
	,hourly_billing_rate
	,hourly_cost_rate
FROM CUSTOMER_SERVICE.job;

CREATE VIEW location
	(location_number
	,customer_number
	,first_address_line
	,city
	,state
	,zip_code
	,second_address_line
	,third_address_line)
AS
SELECT
	location_number
	,customer_number
	,first_address_line
	,city
	,state
	,zip_code
	,second_address_line
	,third_address_line
FROM CUSTOMER_SERVICE.location;

CREATE VIEW location_employee
	(location_number
	,employee_number)
AS
SELECT
	location_number
	,employee_number
FROM CUSTOMER_SERVICE.location_employee;

CREATE VIEW location_phone
	(location_number
	,area_code
	,phone
	,extension
	,description
	,comment_line)
AS
SELECT
	location_number
	,area_code
	,phone
	,extension
	,description
	,comment_line
FROM CUSTOMER_SERVICE.location_phone;

CREATE VIEW emp
	(emp
	,mgr
	,dept
	,job
	,last
	,first
	,hire
	,birth
	,sal)
AS
SELECT
	employee_number
	,manager_employee_number
	,department_number
	,job_code
	,last_name
	,first_name
	,hire_date
	,birthdate
	,salary_amount
	FROM CUSTOMER_SERVICE.employee;
	
	
	
CREATE USER STUDENT FROM Teradata_Education AS
	PASSWORD = STUDENT PERM = 12000000
	SPOOL = 500000 ACCOUNT = ('$M_P0623');
	
GRANT SELECT ON Customer_Service TO ALL STUDENT;
GRANT SELECT ON CS_VIEWS TO ALL STUDENT;

CREATE USER STUDENT00 FROM STUDENT AS PASSWORD = STUDENT00
	PERM = 250000 DEFAULT DATABASE = CS_VIEWS;

.SET QUIET OFF;

.LOGOFF