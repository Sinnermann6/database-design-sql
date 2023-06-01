REM creating SECURITY DBM
CREATE DATABASE IF NOT EXISTS SECURITY;
USE SECURITY;

REM creating employee table
CREATE TABLE EMPLOYEE
(
EMP_ID VARCHAR(6) NOT NULL PRIMARY KEY,
EMP_SNAME VARCHAR(20) NOT NULL,
EMP_ONAME VARCHAR(40) NOT NULL,
EMP_TEL_NO CHAR(11),
EMP_ADD VARCHAR(60),
EMP_POSTCODE VARCHAR(8)
);

REM creating client table
CREATE TABLE CLIENT
(
CLIENT_ID VARCHAR(6) NOT NULL PRIMARY KEY,
CLIENT_SNAME VARCHAR(20) NOT NULL,
CLIENT_ONAME VARCHAR(40) NOT NULL,
CLIENT_TEL_NO CHAR(11),
CLIENT_ADD VARCHAR(60),
CLIENT_POSTCODE VARCHAR(8)
);

REM creating staff table
CREATE TABLE STAFF
(
STAFF_ID VARCHAR(6) NOT NULL PRIMARY KEY,
STAFF_SNAME VARCHAR(20) NOT NULL,
STAFF_ONAME VARCHAR(40) NOT NULL,
STAFF_TEL_NO CHAR(11),
STAFF_ADD VARCHAR(60),
STAFF_POSTCODE VARCHAR(8),
POSIT CHAR(1) CHECK (POSIT IN ('M', 'S')) DEFAULT 'S'
);

Rem creating client_site table
CREATE TABLE CLIENT_SITE
(
SITE_ID VARCHAR(6) NOT NULL PRIMARY KEY,
CLIENT_ID VARCHAR(6),
FOREIGN KEY (CLIENT_ID) REFERENCES CLIENT (CLIENT_ID)
);

REM creating site_address table
CREATE TABLE SITE_ADDRESS
(
SITE_ID VARCHAR(6) NOT NULL PRIMARY KEY,
SITE_ADD VARCHAR(60) NOT NULL
);

REM creating security_arrangement Table
CREATE TABLE SECURITY_ARRANGEMENT
(
SEC_FORM_ID VARCHAR(6) NOT NULL PRIMARY KEY,
SITE_ID VARCHAR(6),
T_HOURS SMALLINT(2) CHECK (T_HOURS >= 10 AND T_HOURS <= 16) DEFAULT '10',
RATE_P_HOUR DECIMAL(3,1) DEFAULT '10.5',
FOREIGN KEY (SITE_ID) REFERENCES SITE_ADDRESS(SITE_ID)
);

REM creating availability table
CREATE TABLE AVAILABILITY
(
EMP_ID VARCHAR(6) PRIMARY KEY NOT NULL,
SEC_FORM_ID VARCHAR(6),
AV_DATE DATE,
STAT CHAR(1) CHECK (STAT IN ('T', 'F')) DEFAULT 'T',
COM_BY CHAR(1) CHECK (COM_BY IN ('M', 'S')) DEFAULT 'S',

FOREIGN KEY (SEC_FORM_ID) REFERENCES SECURITY_ARRANGEMENT (SEC_FORM_ID)
);

REM creating emp_av_date table
CREATE TABLE EMP_AV_DATE 
(
EMP_ID VARCHAR(6) NOT NULL PRIMARY KEY,
ONSET_DATE DATE,
OFFSET_DATE DATE
);

REM creating sec_need table
CREATE TABLE SEC_NEED 
(
CLIENT_ID VARCHAR(6) NOT NULL PRIMARY KEY,
SEC_TYPE CHAR(1) DEFAULT 'L' CHECK (SEC_TYPE IN ('H', 'L')),
SITE_LOC INTEGER CHECK (SITE_LOC IS NULL OR SITE_LOC <= 20),
START_DATE DATE NOT NULL,
END_DATE DATE NOT NULL,
NO_DAYS INTEGER,
NO_WEEKS INTEGER
);
ALTER TABLE SEC_NEED DROP COLUMN NO_DAYS;
ALTER TABLE SEC_NEED DROP COLUMN NO_WEEKS;

REM creating client_payment_details table
CREATE TABLE CLIENT_PAYMENT_DETAILS 
(
PAY_ID VARCHAR(6) NOT NULL PRIMARY KEY,
CLIENT_ID VARCHAR(6),
PAY_METH VARCHAR(6) DEFAULT NULL CHECK (PAY_METH IN ('CARD', 'CHEQUE', 'CASH')),
SEC_FEE DECIMAL(10,2),
CON_FEE DECIMAL(10,2),
TAX DECIMAL(10,2),
EST_AMT DECIMAL(10,2),
AMT_PAID DECIMAL(10,2),
BAL DECIMAL(10,2),
FOREIGN KEY (CLIENT_ID) REFERENCES CLIENT (CLIENT_ID) 
);

Rem creating site_supervised
CREATE TABLE SITE_SUPERVISED
(
SITE_ID VARCHAR(6) NOT NULL PRIMARY KEY,
EMP_ID VARCHAR(6) NOT NULL,
CHECK_BY VARCHAR(6),
TIME_CHECK TIMESTAMP,
RESULT CHAR(1) CHECK (RESULT IN ('G', 'B')),
FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE (EMP_ID)
);


ALTER TABLE SITE_SUPERVISED
ADD CONSTRAINT SITE_ID FOREIGN KEY(SITE_ID) REFERNCES SITE_ADDRESS;


ALTER TABLE SITE_SUPERVISED
ADD CONSTRAINT CHECK_BY CHECK (CHECK_BY IN ('S01', 'S03', 'S03'));

REM creating add_fee_loc
CREATE TABLE ADD_FEE_LOC
(
SITE_LOC INTEGER PRIMARY KEY,
ADD_FEE DECIMAL(10,2) DEFAULT NULL,
CONSTRAINT C_SITE_LOC CHECK (SITE_LOC IS NULL OR SITE_LOC >= 20),
CONSTRAINT C_ADD_FEE CHECK (ADD_FEE IS NOT NULL OR SITE_LOC IS NULL)
);

REM populating employee
INSERT INTO EMPLOYEE
VALUES ('E01', 'MARK', 'FISHE', '07455789542', '39 GREY ST', 'NE1 2S6');
INSERT INTO EMPLOYEE
VALUES ('E02', 'BEAN', 'TOM', '07443388995', '55 BEDLING ST', 'NE2 E56');
INSERT INTO EMPLOYEE
VALUES ('E03', 'BENSON', 'KONG', '07664499235', '67 BITCH ST', 'NE3 5FT');
INSERT INTO EMPLOYEE
VALUES ('E04', 'KULE', 'MUITY', '07559933445', '78 YAM ST', 'NE3 5TG');
INSERT INTO EMPLOYEE
VALUES ('E05', 'TUNDE', 'BAKARE', '07885599324', '90 HOWARD ST', 'NE4 55S');
INSERT INTO EMPLOYEE
VALUES ('E06', 'CHIKA', 'UMEH', '07448822124', '91 SMITH ST', 'NE32 SRT');
INSERT INTO EMPLOYEE
VALUES ('E07', 'ELOPI', 'AKAI', '07883322883', '82 FARM ST', 'NE12 5DT');
INSERT INTO EMPLOYEE
VALUES ('E08', 'AMARI', 'SHUMA', '07224466992', '76 NUHU ST', 'NE1 D5T');

REM populating client
INSERT INTO CLIENT
VALUES ('C01', 'BOLA', 'AHMED', '07443399442', '51 CLART ST', 'NE4 D53');
INSERT INTO CLIENT
VALUES ('C02', 'NULU', 'AKAJI', '07448833998', '89 GUKUS ST', 'NE4 J89');
INSERT INTO CLIENT
VALUES ('C03', 'BULU', 'TOMI', '07883366228', '93 JAKA ST', 'NE5 H94');
INSERT INTO CLIENT
VALUES ('C04', 'UMORU', 'KERRY', '07448899782', '09 WATCH ST', 'NE3 9DT');
INSERT INTO CLIENT
VALUES ('C05', 'KUNLE', 'BAKARE', '07449922103', '72 SMITH ST', 'NE2 B3T');
INSERT INTO CLIENT
VALUES ('C06', 'ADARA', 'PATRICK', '07445577332', '98 BENSON ST', 'NE4 8RT');
INSERT INTO CLIENT
VALUES ('C07', 'GULUKA', 'PETERS', '07553300889', '89 UJUKA ST', 'NE5 T6Y');
INSERT INTO CLIENT
VALUES ('C08', 'JUKAPU', 'JOHNSON', '07448899220', '76 RATU ST', 'NE9 K2V');

REM populating staff
INSERT INTO STAFF
VALUES ('S01', 'MATTHEW', 'MUSAN', '07228899333', '34 BUTCHER ST', 'NE3 4SR', 'M');
INSERT INTO STAFF
VALUES ('S02', 'BESIN', 'MASJIB', '07449922815', '39 BENDLING ST', 'NE5 Y5S', 'M');
INSERT INTO STAFF
VALUES ('S03', 'BOLU', 'MARTINS', '07883355660', '73 BUTEF ST', 'NE6 H4R', 'M');
INSERT INTO STAFF
VALUES ('S04', 'INEH', 'JOHNSON', '07449922081', '94 YAMUL ST', 'NE7 4FT', 'S');
INSERT INTO STAFF
VALUES ('S05', 'RICK', 'TOMMY', '07339944220', '85 TOMMI ST', 'NE5 6YT', 'S');
INSERT INTO STAFF
VALUES ('S06', 'ROCK', 'SIMON', '07553399882', '55 BUTER ST', 'NE7 T5Y', 'S');
INSERT INTO STAFF
VALUES ('S07', 'JIM', 'IYKE', '07442299335', '57 NULLI ST', 'NE2 T9S', 'S');
INSERT INTO STAFF
VALUES ('S08', 'TOMMI', 'SHELBY', '07225599667', '44 KANU ST', 'NE5 R5S', 'S');
INSERT INTO STAFF
VALUES ('S09', 'FICHER', 'FLETCHER', '07335500883', '14 DUTU ST', 'NE32 RT5', 'S');
INSERT INTO STAFF
VALUES ('S10', 'MEANIY', 'JOHNY', '07442212456', '32 FITSU ST', 'NE5 T5D', 'S');

REM populating site_address
INSERT INTO SITE_ADDRESS
VALUES ('SIT01', '23 BEDWIN ST NE3 B5T');
INSERT INTO SITE_ADDRESS
VALUES ('SIT02', '45 BUTCHER ST NE4 6TY');
INSERT INTO SITE_ADDRESS
VALUES ('SIT03', '66 BUNK ST NE5 IT8');
INSERT INTO SITE_ADDRESS
VALUES ('SIT04', '99 GUNK ST NE4 TY8');
INSERT INTO SITE_ADDRESS
VALUES ('SIT05', '89 HUMMER ST NE4 TU7');
INSERT INTO SITE_ADDRESS
VALUES ('SIT06', '84 GUMER ST NE4 TR5');
INSERT INTO SITE_ADDRESS
VALUES ('SIT07', '90 HURTUK ST NE5 TY9');
INSERT INTO SITE_ADDRESS
VALUES ('SIT08', '87 TUKER ST NE3 T9I');

REM populating client_site
INSERT INTO CLIENT_SITE
VALUES ('SIT01', 'C01');
INSERT INTO CLIENT_SITE
VALUES ('SIT02', 'C02');
INSERT INTO CLIENT_SITE
VALUES ('SIT03', 'C03');
INSERT INTO CLIENT_SITE
VALUES ('SIT04', 'C04');
INSERT INTO CLIENT_SITE
VALUES ('SIT05', 'C05');
INSERT INTO CLIENT_SITE
VALUES ('SIT06', 'C06');
INSERT INTO CLIENT_SITE
VALUES ('SIT07', 'C07');
INSERT INTO CLIENT_SITE
VALUES ('SIT08', 'C08');

REM populating security_arrangement
INSERT INTO SECURITY_ARRANGEMENT (SEC_FORM_ID, SITE_ID)
VALUES ('SEC01', 'SIT01');
INSERT INTO SECURITY_ARRANGEMENT (SEC_FORM_ID, SITE_ID)
VALUES ('SEC02', 'SIT02');
INSERT INTO SECURITY_ARRANGEMENT (SEC_FORM_ID, SITE_ID)
VALUES ('SEC03', 'SIT03');
INSERT INTO SECURITY_ARRANGEMENT (SEC_FORM_ID, SITE_ID)
VALUES ('SEC04', 'SIT04');
INSERT INTO SECURITY_ARRANGEMENT (SEC_FORM_ID, SITE_ID)
VALUES ('SEC05', 'SIT05');
INSERT INTO SECURITY_ARRANGEMENT (SEC_FORM_ID, SITE_ID)
VALUES ('SEC06', 'SIT06');
INSERT INTO SECURITY_ARRANGEMENT (SEC_FORM_ID, SITE_ID)
VALUES ('SEC07', 'SIT07');
INSERT INTO SECURITY_ARRANGEMENT (SEC_FORM_ID, SITE_ID)
VALUES ('SEC08', 'SIT08');

REM populating sec_need
INSERT INTO SEC_NEED
VALUES ('C01', 'L', '20', '12-JAN-2023', '15-JAN-2023');
INSERT INTO SEC_NEED
VALUES ('C02', 'H', '20', '13-JAN-2023', '17-JAN-2023');
INSERT INTO SEC_NEED
VALUES ('C03', 'L', '20', '22-JAN-2023', '28-JAN-2023');
INSERT INTO SEC_NEED
VALUES ('C04', 'H', '20', '02-FEB-2023', '15-FEB-2023');
INSERT INTO SEC_NEED
VALUES ('C05', 'L', '20', '08-FEB-2023', '12-FEB-2023');
INSERT INTO SEC_NEED
VALUES ('C06', 'H', '20', '15-FEB-2023', '20-FEB-2023');
INSERT INTO SEC_NEED
VALUES ('C07', 'L', '20', '01-MAR-2023', '05-MAR-2023');
INSERT INTO SEC_NEED
VALUES ('C08', 'H', '20', '04-MAR-2023', '09-MAR-2023');

REM populating site_supervised
INSERT INTO SITE_SUPERVISED
VALUES ('SIT01', 'E01', 'S01', '11-FEB-2023 01:25:30', 'G');
INSERT INTO SITE_SUPERVISED
VALUES ('SIT02', 'E02', 'S02', '25-FEB-2023 10:30:30', 'G');
INSERT INTO SITE_SUPERVISED
VALUES ('SIT03', 'E03', 'S03', '27-FEB-2023 01:25:30', 'G');
INSERT INTO SITE_SUPERVISED
VALUES ('SIT04', 'E04', 'S01', '10-MAR-2023 01:29:30', 'G');
INSERT INTO SITE_SUPERVISED
VALUES ('SIT06', 'E06', 'S02','12-FEB-2023 12:40:30', 'G');

REM populating client_payment_details
INSERT INTO CLIENT_PAYMENT_DETAILS
VALUES ('P01', 'C01', 'CARD', '200', '20', '40', '260', '100', '160');
INSERT INTO CLIENT_PAYMENT_DETAILS
VALUES ('P02', 'C02', 'CASH', '400', '40', '80', '520', '450', '70');
INSERT INTO CLIENT_PAYMENT_DETAILS
VALUES ('P03', 'C03', 'CHEQUE', '750', '75', '150', '975', '500', '475');
INSERT INTO CLIENT_PAYMENT_DETAILS
VALUES ('P04', 'C04', 'CASH', '800', '80', '160', '1040', '800', '240');
INSERT INTO CLIENT_PAYMENT_DETAILS
VALUES ('P05', 'C05', 'CASH', '1200', '120', '240', '1560', '1250', '310');
INSERT INTO CLIENT_PAYMENT_DETAILS
VALUES ('P06', 'C05', 'CASH', '750', '75', '150', '975', '750', '225');

REM populating emp_av_date
INSERT INTO EMP_AV_DATE VALUES ('E01', '11-JAN-2023', '11-MAR-2023');
INSERT INTO EMP_AV_DATE VALUES ('E02', '12-JAN-2023', '12-MAR-2023');
INSERT INTO EMP_AV_DATE VALUES ('E03', '13-JAN-2023', '13-MAR-2023');
INSERT INTO EMP_AV_DATE VALUES ('E04', '14-JAN-2023', '14-MAR-2023');
INSERT INTO EMP_AV_DATE VALUES ('E05', '15-JAN-2023', '15-MAR-2023');
INSERT INTO EMP_AV_DATE VALUES ('E06', '16-JAN-2023', '16-MAR-2023');
INSERT INTO EMP_AV_DATE VALUES ('E07', '17-JAN-2023', '17-MAR-2023');
INSERT INTO EMP_AV_DATE VALUES ('E08', '18-JAN-2023', '18-MAR-2023');

REM populating availability
INSER INTO AVAILABILITY
VALUES ('E01', 'SEC01', '02-JAN-2023', 'F', 'M');
INSERT INTO AVAILABILITY
VALUES ('E02', 'SEC02', '20-JAN-2023', 'F', 'M');
INSERT INTO AVAILABILITY
VALUES ('E03', 'SEC03', '30-JAN-2023', 'F', 'M');
INSERT INTO AVAILABILITY
VALUES ('E04', 'SEC04', '03¬-FEB-2023', 'F', 'M');
INSERT INTO AVAILABILITY
VALUES ('E05', 'SEC05', '10-FEB-2023', 'F', 'M');
