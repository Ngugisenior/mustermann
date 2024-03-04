if exists (select name from sys.databases where name = 'HR')
    drop database HR;

create database HR
go

if object_id('dbo.leave_requests','U') is not null
   drop table [HR].[dbo].[leave_requests];

create table [HR].[dbo].[leave_requests](employee_id int, start_date date, end_date date);

insert into [HR].[dbo].[leave_requests] values (1, '2024/03/04','2024/03/10');
insert into [HR].[dbo].[leave_requests] values (2, '2024/03/05','2024/03/12');
insert into [HR].[dbo].[leave_requests] values (3, '2024/03/08','2024/03/15');

if object_id('dbo.employee','U') is not null
    drop table [HR].[dbo].[employee];

create table [HR].[dbo].[employee](employee_id int, start_date date, end_date date);

insert into [HR].[dbo].[employee] values (1, '2024/03/04','2024/03/10');
insert into [HR].[dbo].[employee] values (2, '2024/03/05','2024/03/12');
insert into [HR].[dbo].[employee] values (3, '2024/03/08','2024/03/15');