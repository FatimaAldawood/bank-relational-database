
-- Designing a bank relational database based on an entity-relationship diagram I created prior to starting the coding process
/*
The tables in this databse are : (branch, employee, department, project, 
customers, account, login, users, transaction, dependents)
*/


-- Building the tables and adding sample values.

--1
--Creating Branch Table

CREATE TABLE branch (
    branch_id NUMBER(3),
    branch_name VARCHAR2(20),
    address VARCHAR2(50),
    Constraint branch_PK Primary key (branch_id)
    ) ;  

-- inserting data to the branch table  

INSERT INTO branch (branch_id, branch_name, address) VALUES 
(1,'Riyadh Main Branch', 'King Fahad 7768 Road'); 
(2, 'Dammam Main Branch', 'King Saud 4469 Suq');
(3, 'Jeddah Main Branch','Al Baghdadiyah Al Gharbiyah District 7340');
(4, 'Makkah Main Branch', 'An Nuzhah 24227'); 



--2
-- Creating Employees Table
CREATE TABLE employee (
    employee_id NUMBER(4),
    employee_fname VARCHAR2(10),
    date_of_birth DATE,
    employee_sex VARCHAR2(10), 
    employee_address VARCHAR2(15), 
    employee_salary NUMBER(7,2), 
    branch_id NUMBER(3), 
    deptNo NUMBER (3),
    Constraint employee_FK Foreign Key (branch_id) references branch(branch_id),
    Constraint employee_Fk2 Foreign Key (deptNo) references department(deptNo),
    Constraint employee_PK Primary Key (employee_id)
    );
  
-- inserting data to the employees table
INSERT INTO employee ( employee_id, employee_fname, date_of_birth, employee_sex, employee_address, employee_salary, branch_id, deptNo) VALUES 
(1123, 'Ahmed', '12-DEC-91', 'Male', 'Dammam 2267', 30000, 2, 4);
(1543, 'Noor', '30-Jan-95', 'Female', 'Riyadh 7682', 22500, 1, 6);
(1622, 'Sarah', '2-Aug-89', 'Female', 'Jeddah 5799', 15000, 3, 2);
(1821, 'Abdullah', '20-May-85', 'Male', 'Makkah 2408', 20000, 4, 5); 



--3
-- Creating Department Table
CREATE TABLE department (
     deptNo NUMBER(3), 
     deptName VARCHAR2(100), 
     number_of_employees NUMBER(5),  
     manager_id NUMBER(4), 
     manager_sDate DATE,  
     CONSTRAINT department_PK PRIMARY KEY (deptNo)
     ); 

-- inserting data to the department table
INSERT INTO department(deptNo, deptName, number_of_employees, manager_id, manager_sDate) VALUES 
(1, 'MANAGEMENT', 7, 1443, '1-jan-20');   
(2, 'HR', 5, 1972, '4-Jul-15'); 
(3, 'ACCOUNTS', 8, 1366, '30-Dec-22'); 
(4, 'CUSTOMER SERVICES', 7, 1502, '1-Oct-20'); 
(5, 'IT', 9, 1338, '1-Sep-16'); 
(6, 'FINANCE', 11, 1052, '15-Apr-19'); 



--4
-- Creating Projects Table
CREATE TABLE projects (
    project_No NUMBER(5),
    project_name VARCHAR2(20),
    project_location VARCHAR2(30),
    deptNo NUMBER(3),
    employee_id NUMBER(4),
    Constraint projects_FK Foreign Key (deptNo) references department(deptNo),
    Constraint projects_Fk2 Foreign Key (employee_id) references employee(employee_id),
    Constraint projects_PK Primary Key (project_No)
    ); 
 
-- inserting data to the projects table
INSERT INTO projects (project_No, project_name, project_location, deptNo, employee_id) VALUES 
(12, 'Mobile banking','Khobar',4,1123);  
(65, 'Internet Banking','Riyadh',6,1543);
(47, 'Assets Liability MS','Jeddah',2,1622);
(08, 'Corporate E-banking','Makkah',5,1821);



--5
-- Creating Customers Table
CREATE TABLE customers (
    customer_id number NOT NULL,
    name VARCHAR2(50) NOT NULL,
    phone_number VARCHAR2(10) NOT NULL,
    address VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    primary KEY (customer_id)
    );

-- inserting data to the customers table
INSERT INTO customers (customer_id, name, phone_number, address, email) VALUES
(1001, 'Norah', '0505938432', 'khobar','norah@gmail.com');  
(1002, 'Muneera', '0505589372', 'Dammam','muneera@gmail.com');
(1003, 'Ali', '050513579', 'Dhahran','Ali@gmail.com');
(1004, 'lulwah', '050582579', 'khobar','lulwah@gmail.com');



--6
-- Creating Account Table
CREATE TABLE Account (
    Account_No INT NOT NULL,
    Account_Customer_ID INT,
    Account_Balance NUMBER(20),
    Account_Type VARCHAR(30),
    PRIMARY KEY(Account_No),
    FOREIGN KEY(Account_Customer_ID); References Customer(Customer_ID)
    );

-- inserting data to the account table  
INSERT INTO Account (Account_No, Account_Customer_ID, Account_Balance, Account_Type) VALUES
(1,1001,20000,'Saving Account');
(2,1002,30000,'Saving Account');
(3,1003,60000,'Salary Account');
(4,1004,50000,'Salary Account');



--7
-- Creating Login Table
CREATE TABLE login (
    login_id INT PRIMARY KEY,
    customer_id INT,
    login_role_id INT,
    login_username VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    );

-- inserting data to the login table  
INSERT INTO login (login_id, customer_id, login_role_id, login_username) VALUES
(1, 1001, 1, 'ahm647'),   
(2, 1002, 2, 'dana777m'), 
(3, 1003, 3, 'fay999'),   
(4, 1004, 4, 'moha5455'); 



--8
-- Creating Transaction Table
CREATE TABLE Transaction(
    Transaction_ID INT NOT NULL,
    Account_No INT,
    Transaction_Type VARCHAR(30),
    Amount NUMBER(20),
    PRIMARY KEY (Transaction_ID),
    FOREIGN KEY (Account_No) References Account(Account_No)
    );

-- inserting data to the transaction table
INSERT INTO Transaction(Transaction_ID, Account_No, Transaction_Type, Amount) VALUES  
(10,1,'Payment',200);
(11,2,'Transfer',1000);
(12,3,'Payment',50); 
(14,4,'Deposit',2000);



--9
-- Creating Dependents Table
CREATE TABLE dependents (
    dependent_id number(4) NOT NULL,
    name VARCHAR2(50) NOT NULL,
    relationship  VARCHAR2(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR2(50) NOT NULL,  
    employee_id number(4) NOT NULL,
    constraint dependents_fk foreign key(employee_id) references employee (employee_id),
    primary KEY (dependent_id)
    );

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD'; 

-- inserting data to the dependents table
INSERT INTO dependents (dependent_id, name,  relationship, date_of_birth, gender, employee_id) VALUES   
(2001, 'Ahmad', 'single', '1991-12-12', 'Male',1123);
(2002, 'Noor', 'single', '1995-01-30', 'Female',1543); 
(2003, 'Sarah', 'married', '1989-08-02', 'Female',1622); 
(2004, 'Abdullah', 'married', '1985-05-20', 'Male',1821);



-- 10
-- Creating the Work table (a junction table to manage the many-to-many relationship between the Employee and Project tables)
CREATE TABLE work (
    work_id INT PRIMARY KEY AUTO_INCREMENT, 
    employee_id INT NOT NULL,              
    project_id INT NOT NULL,               
    start_date DATE,                        
    end_date DATE,                          
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_No)
);

-- inserting data to the work table
INSERT INTO work (work_id, employee_id, project_id) VALUES
(1, 1123, 12, '2024-01-01', '2024-06-30'), 
(2, 1543, 65, '2024-03-01', NULL), -- Null indicates that the work is still in progress, so there is no end date
(3, 1622, 47, '2024-02-01', '2024-08-31'), 
(4, 1821, 8, '2024-04-01', NULL);          

