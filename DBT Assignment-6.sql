use whitewalker5;
Create table EMP ( 
			EMPNO numeric(4) not null, 
            ENAME varchar(30) not null, 
            JOB varchar(10), 
            MGR numeric(4), 
            HIREDATE date, 
            SAL numeric(7,2), 
            DEPTNO numeric(2) 
            ); 

Insert into EMP (EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO ) values(1000,  'Manish' , 'SALESMAN', 1003,  '2020-02-18', 600,  30) ;
Insert into EMP (EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO ) values(1001,  'Manoj' , 'SALESMAN', 1003,  '2018-02-18', 600,  30) ;
Insert into EMP (EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO ) values(1002 , 'Ashish', 'SALESMAN',1003 , '2013-02-18',  750,  30 );
Insert into EMP (EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO ) values(1004,  'Rekha', 'ANALYST', 1006 , '2001-02-18', 3000,  10);
Insert into EMP (EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO ) values(1005 , 'Sachin', 'ANALYST', 1006 ,  '2019-02-18', 3000, 10 );
Insert into EMP (EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO ) values(1006,  'Pooja',  'MANAGER' , null    , '2000-02-18' ,6000, 10 );

-- ================================================================================================================

-- 1.	Write function that accepts a positive number from a user and displays its factorial on the screen.
delimiter $$
create function factorial(val int) returns int
begin
declare iterator int default 1;
	lable1 : loop
    if(val<=0) then
    leave lable1;
    end if;
    set iterator=iterator*val;
    set val=val-1;
    iterate lable1;
    end loop;
    return iterator;
    end $$
  
	select factorial(3);
    select factorial(5);
	select factorial(7);


-- ===========================================================================================================
-- 2.	Write a function that accepts a positive number ‘n’ and displays whether that number is a Prime number or not.
delimiter $$
create function fun2( val int) returns varchar(40)
begin
	declare M , I int;
    set  I = 2 ;
    set M = val / 2;

  if  val = 0 || val = 1 then
  return 'not prime';
  else
		L1: LOOP
		WHILE I<=M DO
			IF val % 2 = 0 THEN 
				RETURN 'NOT PRIME';
				LEAVE L1;
				ELSE
				SET I=I+1;
				ITERATE L1;
			END IF;
	   END WHILE;
       RETURN 'PRIME';
	END LOOP L1;
  end if ;
end $$
select fun2(3)$$
select fun2(11)$$

-- ===============================================================================================================
-- 3.	Write a function to Convert an inputed number of inches into yards, feet, and inches. For example, 124 
-- inches equals 3 yards, 1 foot, and 4 inches.
delimiter $$                                                    
create function fun3(inch int(10)) returns varchar(40)           
begin
	declare yard , feet ,  inches  int(10);
    set yard = round(inch / 36);
    set feet = round(inch / 12);
    set inches = inch;
    return concat( 'yard' , yard , 'feet' , feet , 'inches' , inches);
end $$

select fun3(124)$$
-- ===========================================================================================================
-- 4.	Write a function to update salary of the employees of specified dept by 10%. Take dept no as parameter.
delimiter $$
create function fun4(dpt int) returns varchar(10)
begin
	update emp set sal = ( sal + sal*(10/100) ) where deptno = dpt;
    return 'updated';
end $$

select fun4(30)$$
select * from emp$$
-- =============================================================================================================
-- 5.	Create a function named USER_ANNUAL_COMP that has a parameter p_eno for passing on the values of  an employee 
-- number of the employee and p_comp for passing the compansation. In the function calculates and returns the annual 
-- compensation of the employee by using the following formula. annual_compensation =  (p_sal+p_comm)*12
-- If the salary or commission value is NULL then zero should be substituted for it.  Give a call to USER_ANNUAL_COMP.
delimiter $$
create function fun5( p_eno int , p_comp int) returns int(100)
begin
		declare p_sal int ;
	if (p_comp = isnull(p_comp) || ' ') then
			return 0;
    else
		set p_sal = (select sal from emp where empno = p_eno );
		return (p_sal + p_comm ) *12;
   end if;
end $$
drop function fun5$$
select fun5( 1002 , 123 )$$

-- ==============================================================================================================
-- 6.	Create a procedure called USER_QUERY_EMP that accepts three parameters. Parameter p_myeno is of IN parameter
-- mode which provides the empno value. The other two parameters p_myjob and p_mysal are of OUT mode. 
-- The procedure retrieves the salary and job of an employee with the provided employee number and assigns those to
--  the two OUT parameters respectively. The procedure should raise the error if the empno does not exist in the EMP 
-- table by displaying an appropriate message
delimiter $$
create procedure proc6(in p_myeno numeric(4) , out p_myjob varchar(10) , out p_mysal numeric(7,2) ) 
begin
	declare a1 int;
     set a1 = (select count(*) from emp where empno = p_myeno);
	if   a1 = 0   then
	select ' emp number is not in table';
    else
	select  job  , sal into  p_myjob ,p_mysal from emp where empno = p_myeno;
    end if;
end $$

call proc6( 1002 , @job , @sal )$$
select  @job , @sal  $$

call proc6( 100 , @job , @sal )$$

-- ==============================================================================================================
-- 7.	Create a procedure to print the inputted string in reverse order. If  inputted string is null display an
-- appropriate message
delimiter $$
create procedure proc7(inout str varchar(20))
begin
	if (str = ' ' || isnull(str) ) then
    select 'String is null';
    else
    select reverse(str) into str;
    end if;
end $$

set @x = 'Namanp'$$   -- if string is pass then
call proc7(@x)$$
select @x $$

set @str1 = null $$  -- if string is null
call proc7(@str1)$$

-- ============================================================================================================
-- 8.	Create a procedure named ‘tabledetails’ which gives all the details of a particular table stored in database.
delimiter $$
create procedure proc8()
begin
		desc edac_assignment2.titles;
end $$

call proc8$$
-- ===========================================================================================================


    