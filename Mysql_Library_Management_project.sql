# Create a Database 'library'

create database library;

use library;

# Create Table 'Branch'

create table Branch
(
Branch_No int primary key,
Manager_Id int,
Branch_Address varchar(50),
Contact_No int
);

# Create Table 'Employee'

create table Employee
(
Emp_Id int primary key,
Emp_Name varchar(30),
Position varchar(30),
Salary decimal(10,2)
);

# Create Table 'Customer'

create table Customer
(
Customer_Id int primary key,
Customer_Name varchar(30),
Customer_Address varchar(30),
Reg_Date date
);

# Create Table 'Books'

create table Books
(
ISBN int primary key,
Book_Title varchar(50),
Category varchar(30),
Rental_Price float,
Status varchar(10),
Author varchar(30),
Publisher varchar(30)
);

# Create Table 'IssueStatus'

create table IssueStatus
(
Issue_Id int primary key,
Issued_Cust int,
Issued_Book_Name varchar(50),
Issue_Date date,
Isbn_Book int,
foreign key(Issued_Cust)references Customer(Customer_Id) on delete cascade, 
foreign key(Isbn_Book) references Books(ISBN)on delete cascade
);

# Create Table 'ReturnStatus'

create table ReturnStatus
(
Return_Id int primary key,
Return_Cust int,
Return_Book_Name varchar(50),
Return_Date date,
Isbn_Book2 int,
 foreign key(Isbn_Book2) references Books(ISBN)on delete cascade
 );
 
 # Insert values into each table

insert into Branch values
(1,100,'National Library of India, Kolkata',90563423),
(2,101,'City Central Library, Hyderabad',78562223),
(3,102,'State Central Library, Trivandrum',83456342),
(4,103,'Ernakulam Public Library, Kochi',88563423),
(5,104,'Delhi Public Library, Delhi',77563423);

insert into Employee values
(100,'Aleena','Library Assistant',60000.00),
(101,'Bincy','Librarian',40000.00),
(102,'Aneeta','Library Manager',70000.00),
(103,'Preethi','Librarian',48000.00),
(104,'Dhwani','Librarian',28000.00),
(105,'Deepa','Library Assistant',65000.00),
(106,'Divya','Library Manager',75000.00),
(107,'Aparna','Librarian',20000.00),
(108,'Malavika','Library Assistant',55000.00),
(109,'Remya','Library Assistant',50000.00),
(110,'Albert','Library Manager',65000.00);


insert into Customer values
(100,'Beena','Delhi','2020-01-10'),
(101,'Arun','Chennai','2021-05-12'),
(102,'Gauri','Kerala','2020-06-15'),
(103,'Megha','Bangaluru','2021-10-01'),
(104,'Saurav','Kolkata','2020-04-23'),
(105,'Sandra','Patna','2021-06-13'),
(106,'Aishwarya','Gujrat','2019-04-02'),
(107,'Niti','UP','2020-12-20'),
(108,'Anu','Haryana','2023-04-05'),
(109,'Dany','Chennai','2021-04-15'),
(110,'Siva','Hyderabad','2022-04-25');

insert into Books values
(978-0-9767736-6-5,'The Lord of the Rings','Classic Novel',50,'yes','J.R.R. Tolkien','Harper Collins Publishers'),
(978-0-9767726-7-5,'Think and Grow Rich','Business and Money',30,'no','Napoleon Hill','Simon & Schuster'),
(978-0-9767733-4-3,'A Brief History of Time','Science and Technology',35,'yes','Stephen Hawking','Bantam Dell Publishing Group'),
(978-0-9768733-2-3,'On the Road','Travel and Adventure',35,'yes','Jack Kerouac','Viking Press'),
(978-0-9778543-5-9,' Sapiens:A Brief History of Humankind','History',25,'yes','Yuval Noah Harari','Dvir Publishing House Ltd'),
(978-0-9775555-7-9,' Long Walk to Freedom','History',25,'no','Nelson Mandela','Back Bay Books');
 
insert into IssueStatus values
(1,100,'The Lord of the Rings','2023-06-15',978-0-9767736-6-5),
(2,101,'Think and Grow Rich','2023-06-12',978-0-9767726-7-5),
(3,102,'A Brief History of Time','2010-02-25',978-0-9767733-4-3),
(4,103,'On the Road','2021-04-01',978-0-9768733-2-3),
(5,104,'Sapiens: A Brief History of Humankind','2020-10-13',978-0-9778543-5-9);

insert into ReturnStatus values
(1,101,'The Lord of the Rings','2023-08-16',978-0-9767736-6-5),
(2,102,'Think and Grow Rich','2019-08-13',978-0-9767726-7-5),
(3,104,'A Brief History of Time','2011-03-26',978-0-9767733-4-3),
(4,105,'On the Road','2022-05-02',978-0-9768733-2-3),
(5,107,'Sapiens: A Brief History of Humankind','2021-11-14',978-0-9778543-5-9);

select * from Branch;
select * from Employee;
select * from Customer;
select * from Books;
select * from IssueStatus;
select * from ReturnStatus;


-- Queries --

-- Retrieve the book title, category, and rental price of all available books --

select Book_Title,Category,Rental_Price 
from Books 
where Status='yes';

-- List the employee names and their respective salaries in descending order of salary --

select Emp_Name,Salary 
from Employee 
order by Salary desc;

-- Retrieve the book titles and the corresponding customers who have issued those books --

select IssueStatus.Issued_Book_Name,Customer.Customer_Name 
from IssueStatus join Customer 
on IssueStatus.Issued_Cust=Customer.Customer_Id;

-- Display the total count of books in each category --

select Category,count(Book_Title) 
from Books 
group by Category;

-- Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000 --

select Emp_Name,Position,Salary 
from Employee 
where Salary>50000;

-- List the customer names who registered before 2022-01-01 and have not issued any books yet. --

select Customer_Name from Customer where Reg_date < '2022-01-01' and
 Customer_Id not in(select Issued_Cust from IssueStatus);
 
-- Display the branch numbers and the total count of employees in each branch --

select Branch.Branch_No, count(Employee.Emp_Name) 
from Branch join Employee
on Branch.Manager_Id = Employee.Emp_Id group by Branch.Branch_No;
 
 -- Display the names of customers who have issued books in the month of June 2023 --
 
 select Customer.Customer_Name 
 from Customer join IssueStatus 
 on Customer.Customer_Id=IssueStatus.Issued_Cust
 where IssueStatus.Issue_Date >= '2023-06-01' and IssueStatus.Issue_Date <='2023-06-30';
 
 --  Retrieve book_title from book table containing history. --
 
 select Book_Title 
 from Books 
 where Category = 'History';
 
 -- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees --
 
 select Branch.Branch_No,count(*) as employee_count
 from Branch join Employee
 on Branch.Manager_Id=Employee.Emp_Id
 group by Branch.Branch_No
 having employee_count>5;
 

 
