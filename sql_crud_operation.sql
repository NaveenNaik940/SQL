---"""

---@Author: Naveen Madev Naik
---@Date: 2024-08-22
---@Last Modified by: Naveen Madev Naik
---@Last Modified time: 2024-08-22
---@Title: Crude operations on Mssql

---"""



---creating database
create database crudeDB;
use crudeDB;

---creating Department Table
create table Department (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100) NOT NULL
); 


---creating Employee Table
create table Employee(
	EmployeeID int primary key identity(1,1),
    FirstName nvarchar(50) NOT NULL,
    LastName nvarchar(50) NOT NULL,
    Age int,
    DepartmentID INT,
    foreign key (DepartmentID) references Department(DepartmentID)
);

select * from employee ; 

select * from department;


---Inserting Data
---inserting data in department table
insert into department(departmentName)
values ('HR'),('IT'),('Finance');

---inserting data in employee table
insert into Employee (FirstName, LastName, Age, DepartmentID)
values ('Nagashree', 'CR', 30, 1);

insert into Employee (FirstName, LastName, Age, DepartmentID)
values ('Girish', 'Nekar', 22, 2);

insert into Employee (FirstName, LastName, Age, DepartmentID)
values ('Sanjay', 'Kumar', 22, 3);

--Reading Data
select * from employee;

select * from department;

---Updating data
update employee
set DepartmentID = 2
where FirstName = 'Sanjay' AND LastName = 'Kumar';

---Joining Table
select e.EmployeeID, e.FirstName, e.LastName, e.Age, d.DepartmentName
from Employee e
JOIN Department d on e.DepartmentID = d.DepartmentID;

---Deleting data
delete from Employee
where FirstName = 'Sanjay' AND LastName = 'Kumar';

---Creating index
create index index1
on Employee(employeeid);

---Deleting index from table
drop index employee.index1;

