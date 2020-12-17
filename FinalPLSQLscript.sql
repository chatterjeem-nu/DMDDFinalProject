---------------------ALL TABLES CREATED-----------------------------------

declare
nCount NUMBER;
begin
-- table Mutliplex
SELECT count(*) into nCount FROM user_tables where table_name = 'MULTIPLEX';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('Table MULTIPLEX already exists');
Else
    execute immediate 'create table Multiplex (
    multiplex_id varchar(10) primary key,
    multiplex_name varchar2(50) not null,
    address_street varchar2(500) not null,
    create_date date default sysdate,
    modify_date date default sysdate,
    Address_pincode varchar(5) not null)';
end if;
    
-- table Auditoriums
SELECT count(*) into nCount FROM user_tables where table_name = 'AUDITORIUMS';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('AUDITORIUMS Table already exists');
Else
    execute immediate 'create table Auditoriums (
    audi_id varchar(10) primary key,
    multiplex_id varchar(10) not null,
    audi_name varchar2(100) not null,
    no_of_seats number,
    create_date date default sysdate,
    modify_date date default sysdate,
    constraint fk_multiplex foreign key (multiplex_id) references Multiplex(multiplex_id),
    constraint ckAudiName check (audi_name in (''Standard'', ''IMAX'', ''Dolby'')))';
end if;

-- table Movies
SELECT count(*) into nCount FROM user_tables where table_name = 'MOVIES';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('MOVIES Table already exists');
Else
    execute immediate 'CREATE TABLE MOVIES (
      MOVIE_ID VARCHAR2(10) primary key, 
      MOVIE_NAME VARCHAR2(200) NOT NULL, 
      RUNTIME NUMBER NOT NULL,
      MOVIE_DESCRIPTION VARCHAR2(1000) NOT NULL, 
      IMDB_RATING NUMBER NOT NULL, 
      MODIFY_DATE DATE DEFAULT sysdate NOT NULL, 
      CREATE_DATE DATE DEFAULT sysdate NOT NULL, 
      RELEASE_YEAR NUMBER(4, 0) NOT NULL)';
end if;

-- table Movie Schedule
SELECT count(*) into nCount FROM user_tables where table_name = 'MOVIE_SCHEDULE';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('MOVIE_SCHEDULE Table already exists');
Else
    execute immediate 'create table Movie_Schedule (
    movie_schedule_id varchar(10) primary key,
    movie_id varchar(10) not null,
    audi_id varchar(10) not null,
    show_datetime timestamp not null,
    ticket_cost number not null,
    seats_remaining number not null,
    create_date date default sysdate not null,
    modify_date date default sysdate not null,
    constraint fk_movie foreign key (movie_id) references Movies(movie_id),
    constraint fk_audi foreign key (audi_id) references Auditoriums(audi_id),
    constraint ck_seats check (seats_remaining >= 0))';
end if;

-- table Director

SELECT count(*) into nCount FROM user_tables where table_name = 'DIRECTOR';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('DIRECTOR Table already exists');
Else
    execute immediate 'CREATE TABLE DIRECTOR(
    DIRECTOR_ID VARCHAR2(10) primary key, 
	DIRECTOR_NAME VARCHAR2(100)
    ) ';
end if;

-- table MovieDirector

SELECT count(*) into nCount FROM user_tables where table_name = 'MOVIE_DIRECTOR';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('MOVIE_DIRECTOR Table already exists');
Else
    execute immediate 'CREATE TABLE MOVIE_DIRECTOR (
    DIRECTOR_ID VARCHAR2(10), 
	MOVIE_ID VARCHAR2(10),
    primary key (DIRECTOR_ID,MOVIE_ID), 
    constraint fk_dir foreign key (DIRECTOR_ID) references DIRECTOR(DIRECTOR_ID),
    constraint fk_mov foreign key (MOVIE_ID) references MOVIES(MOVIE_ID))';
end if; 

-- table Actor
SELECT count(*) into nCount FROM user_tables where table_name = 'ACTOR';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('ACTOR Table already exists');
Else
    execute immediate 'CREATE TABLE ACTOR (	
    ACTOR_ID VARCHAR2(10) primary key, 
	ACTOR_NAME VARCHAR2(100))';

end if;

-- table MovieActor
SELECT count(*) into nCount FROM user_tables where table_name = 'MOVIE_ACTOR';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('MOVIE_ACTOR Table already exists');
Else
    execute immediate 'CREATE TABLE MOVIE_ACTOR 
    (ACTOR_ID VARCHAR2(10), 
	MOVIE_ID VARCHAR2(10),
    primary key (ACTOR_ID, MOVIE_ID),
    constraint fk_act foreign key (ACTOR_ID) references ACTOR(ACTOR_ID),
    constraint fk_mov1 foreign key (MOVIE_ID) references MOVIES(MOVIE_ID)
    )' ;
 
end if;

-- table Genre
SELECT count(*) into nCount FROM user_tables where table_name = 'GENRE';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('GENRE Table already exists');
Else
    execute immediate 'CREATE TABLE GENRE 
   (GENRE_ID VARCHAR2(10) primary key, 
	GENRE_CATEGORY VARCHAR2(100))';
end if;


-- table MovieGenre
SELECT count(*) into nCount FROM user_tables where table_name = 'MOVIE_GENRE';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('MOVIE_GENRE Table already exists');
Else
    execute immediate 'CREATE TABLE MOVIE_GENRE(	
    GENRE_ID VARCHAR2(10), 
	MOVIE_ID VARCHAR2(10),
    primary key(GENRE_ID, MOVIE_ID),
    constraint fk_act1 foreign key (GENRE_ID) references GENRE(GENRE_ID),
    constraint fk_mov2 foreign key (MOVIE_ID) references MOVIES(MOVIE_ID))' ;
end if;


-- table UserCredentials
SELECT count(*) into nCount FROM user_tables where table_name = 'USERCREDENTIAL'; 
IF(nCount > 0) 
THEN 
    DBMS_OUTPUT.PUT_LINE('USERCREDENTIAL Table already exists'); 
Else 
    execute immediate 'CREATE TABLE USERCREDENTIAL(
    USER_ID VARCHAR2(10) primary key, 
    EMAIL VARCHAR2(100) UNIQUE not null,  
    PASSWORD VARCHAR2(32) not null, 
    CREATE_DATE DATE default sysdate, 
    MODIFY_DATE DATE default sysdate)'; 
end if;

-- table Employees
SELECT count(*) into nCount FROM user_tables where table_name = 'EMPLOYEES'; 
IF(nCount > 0) 
THEN 
    DBMS_OUTPUT.PUT_LINE('Table EMPLOYEES already exists'); 
Else 
    execute immediate 'CREATE TABLE EMPLOYEES ( 
    EMPLOYEE_ID VARCHAR2(10) primary key,
    USER_ID VARCHAR2(10) not null,  
    MULTIPLEX_ID VARCHAR2(10) not null,  
    EMP_FNAME VARCHAR2(100) not null,  
    EMP_LNAME VARCHAR2(100) not null,
    EMPLOYEE_CONTACT NUMBER(9,0) not null,  
    MANAGER_ID NUMBER(9,0),  
    ADDRESS_HOUSENO VARCHAR2(400) not null,  
    ADDRESS_STREET VARCHAR2(400) not null,  
    ADDRESS_CITY VARCHAR2(400) not null,  
    ADDRESS_STATE VARCHAR2(400) not null,  
    EMPLOYEE_SNN VARCHAR2(400) not null,  
    EMPLOYEE_DOB DATE not null,
    CREATE_DATE DATE default sysdate,  
    MODIFY_DATE DATE default sysdate,
    CONSTRAINT FK_USERID FOREIGN KEY (USER_ID) REFERENCES USERCREDENTIAL(USER_ID),
    CONSTRAINT FK_MULTIPLEXID FOREIGN KEY (MULTIPLEX_ID) REFERENCES  MULTIPLEX(MULTIPLEX_ID))';

end if;

-- table Customer
SELECT count(*) into nCount FROM user_tables where table_name = 'CUSTOMER'; 
IF(nCount > 0) 
THEN 
    DBMS_OUTPUT.PUT_LINE('Table CUSTOMER already exists'); 
Else 
    execute immediate'CREATE TABLE CUSTOMER ( 
    CUSTOMER_ID VARCHAR2(10) primary key, 
    USER_ID VARCHAR2(10) not null, 
    CUSTOMER_FNAME VARCHAR2(50) not null, 
    CUSTOMER_LNAME VARCHAR2(50) not null, 
    ADDRESS_HOUSENO VARCHAR2(400) not null, 
    ADDRESS_STREET VARCHAR2(400) not null, 
    ADDRESS_CITY VARCHAR2(400) not null, 
    CUSTOMER_CONTACT NUMBER(10,0) not null,  
    CREATE_DATE DATE default sysdate, 
    MODIFY_DATE DATE default sysdate,
    CONSTRAINT FK_USERCREID FOREIGN KEY (USER_ID) REFERENCES USERCREDENTIAL (USER_ID))';
end if;

-- table Payment
SELECT count(*) into nCount FROM user_tables where table_name = 'PAYMENT';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('PAYMENT Table already exists');
Else
    execute immediate 'CREATE TABLE "PAYMENT" 
   ("PAYMENT_ID" VARCHAR2(10 BYTE) NOT NULL, 
	"PAYMENT_METHOD" VARCHAR2(100 BYTE), 
	"CARD_NUMBER" VARCHAR2(40 BYTE), 
	"CARD_TYPE" VARCHAR2(20 BYTE), 
	 PRIMARY KEY ("PAYMENT_ID"))';
end if;

-- table Bookings
SELECT count(*) into nCount FROM user_tables where table_name = 'BOOKING';
IF(nCount > 0)
THEN
    DBMS_OUTPUT.PUT_LINE('Table BOOKING already exists');
Else
    execute immediate 'CREATE TABLE BOOKING 
   (BOOKING_ID VARCHAR2(10) primary key, 
    CUSTOMER_ID VARCHAR2(10), 
    EMPLOYEE_ID VARCHAR2(10), 
    PAYMENT_ID VARCHAR2(10), 
    MOVIE_SCHEDULE_ID VARCHAR2(10), 
    RESERVATION_STATUS VARCHAR2(10), 
    TICKET_PRICE NUMBER, 
    NO_OF_SEATS NUMBER, 
    BOOKING_CREATE_DATE DATE DEFAULT SYSDATE, 
    BOOKING_MODIFY_DATE DATE DEFAULT SYSDATE, 
     CONSTRAINT NO_OF_TICKETS CHECK (no_of_seats >= 1), 
     CONSTRAINT FK_CUSTOMERID FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID), 
     CONSTRAINT FK_MOVIE_SCHEDULE FOREIGN KEY (MOVIE_SCHEDULE_ID) REFERENCES MOVIE_SCHEDULE(MOVIE_SCHEDULE_ID), 
     CONSTRAINT FK_EMPLOYEE_ID FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID), 
     CONSTRAINT FK_PAYMENT_ID FOREIGN KEY (PAYMENT_ID) REFERENCES PAYMENT(PAYMENT_ID))';
end if;
end;
-- view on movie schedule start and end date (required for trigger trig_no_overlap_sch)

create or replace view audi_schedules as
select ms.audi_id, ms.show_datetime, mov.runtime, ms.show_datetime + NUMTODSINTERVAL(mov.runtime, 'MINUTE') as Show_enddatetime
from movie_schedule ms 
inner join movies mov on ms.movie_id = mov.movie_id order by ms.audi_id;


---------------------TRIGGERS-----------------------------------
-- trigger - update last modified date    
create or replace trigger multiplex_mod_date
before update on multiplex
for each row
begin
 :new.modify_date := sysdate;
end;
/    
-- trigger - prevent update on create date    
create or replace trigger no_create_mod_multiplex
before update of create_date on multiplex
for each row
begin
raise_application_error(-20000, 'Cannot change create date!');
end;
/
-- trigger - update last modified date      
create or replace trigger auditoriums_mod_date
before update on auditoriums
for each row
begin
 :new.modify_date := sysdate;
end;
/    
-- trigger - prevent update on create date  
create or replace trigger no_create_mod_auditoriums
before update of create_date on auditoriums
for each row
begin
raise_application_error(-20000, 'Cannot change create date!');
end;
/
-- trigger - allot seats by audi name
create or replace TRIGGER audi_seats
    before insert on auditoriums
    FOR EACH ROW
    BEGIN
       IF :new.audi_name = 'Standard'
       THEN 
          :new.no_of_seats := 300;
       ELSIF :new.audi_name = 'IMAX'
       THEN 
          :new.no_of_seats := 250;       
       ELSIF :new.audi_name = 'Dolby'
       THEN 
          :new.no_of_seats := 200;
        END IF;  
    END;
/    
-- trigger update last modified date
create or replace trigger movie_schedule_mod_date
before update on movie_schedule
for each row
begin
 :new.modify_date := sysdate;
end;
/
-- trigger - prevent update on create date 
create or replace trigger no_create_mod_mov_sch
before update of create_date on movie_schedule
for each row
begin
raise_application_error(-20000, 'Cannot change create date!');
end;
/
-- trigger - allot seats to movie schedule as per audi
create or replace TRIGGER movieSch_audi_seats
before insert on movie_schedule
FOR EACH ROW
BEGIN
     select no_of_seats into :new.seats_remaining from auditoriums where audi_id = :new.audi_id;
END;
/
--trigger - avoid overlap of movie schedule in same audi
create or replace trigger trig_no_overlap_sch
before insert or update of show_datetime on movie_schedule
for each row
begin
  for x in ( select count(*) cnt
               from dual 
              where exists (
                select * from audi_schedules where audi_id = :new.audi_id and :new.show_datetime between show_datetime and show_enddatetime) )
  loop
        if ( x.cnt = 1 ) 
        then
           raise_application_error(-20000, 'Movie schedules cannot overlap for same auditorium');
        end if;
  end loop;
end;
/
--trigger - update last modified date
create or replace trigger CUSTOMER_mod_date
before update on CUSTOMER
for each row
begin
 :new.modify_date := sysdate;
end;
/
--trigger - update last modified date
create or replace trigger EMPLOYEES_mod_date
before update on EMPLOYEES
for each row
begin
 :new.modify_date := sysdate;
end;
/
--trigger - update last modified date
create or replace trigger movies_mod_date
before update on Movies
for each row
begin
 :new.modify_date := sysdate;
end;
/
-- trigger - prevent update on create date 
create or replace trigger no_create_customer_date
before update of create_date on CUSTOMER
for each row
begin
raise_application_error(-20000, 'Cannot change create date!');
end;
/
-- trigger - prevent update on create date 
create or replace trigger no_create_employee_date
before update of create_date on EMPLOYEES
for each row
begin
raise_application_error(-20000, 'Cannot change create date!');
end;
/
-- trigger - prevent update on create date 
create or replace trigger no_create_movie_date
before update of create_date on MOVIES
for each row
begin
raise_application_error(-20000, 'Cannot change create date!');
end;
/
-- trigger - prevent update on create date 
create or replace trigger no_create_user_date
before update of create_date on USERCREDENTIAL
for each row
begin
raise_application_error(-20000, 'Cannot change create date!');
end;
/
-- trigger - employee can book for the same multiplex they work in
create or replace trigger trig_check_emp
before insert or update on booking
for each row
declare emp_multiplex varchar(10); movie_multiplex varchar(10);
begin
    select multiplex_id into emp_multiplex from employees where employee_id = :new.employee_id;
    select multiplex_id into movie_multiplex from movie_schedule ms inner join auditoriums a on ms.audi_id = a.audi_id where movie_schedule_id = :new.movie_schedule_id;
    if (emp_multiplex != movie_multiplex)
    then
    raise_application_error(-20000, 'Employee can only make booking for their own multiplex!');
    end if;
end;
/
-- trigger - update last modified date
create or replace trigger USER_mod_date
before update on USERCREDENTIAL
for each row
begin
 :new.modify_date := sysdate;
end;
/

-- trigger - number of seats in movie schedule is reduced based on seats in a booking
create or replace TRIGGER seats_remaining
AFTER INSERT ON booking
FOR EACH ROW
DECLARE MOVIE_ID VARCHAR2(10); SEATS NUMBER;
BEGIN
  UPDATE movie_schedule
  SET seats_remaining = seats_remaining - :new.no_of_SEATS
  WHERE movie_schedule.movie_schedule_id = :new.movie_schedule_id;
END seats_remaining;
/

-- trigger - to calculate the total price per create or replace TRIGGER ticket_cost
create or replace TRIGGER ticket_cost
BEFORE INSERT ON booking
FOR EACH ROW
DECLARE PRICE NUMBER;
BEGIN
  select movie_schedule.ticket_cost into PRICE from Movie_Schedule WHERE movie_schedule.movie_schedule_id = :new.movie_schedule_id;
  :new.ticket_price := PRICE * :new.no_of_seats;
END ticket_cost;
/

-- trigger - to check the card type and number
create or replace TRIGGER card_check
BEFORE INSERT ON PAYMENT 
FOR EACH ROW
BEGIN
  IF :new.payment_METHOD NOT IN ('CASH', 'DEBIT', 'CREDIT') THEN 
      RAISE_APPLICATION_ERROR(-20001, 'Invalid payment method');
  END IF;
  IF :new.payment_METHOD IN ('DEBIT', 'CREDIT') THEN 
    IF :new.card_number IS NULL or :new.card_type IS NULL THEN
    RAISE_APPLICATION_ERROR(-20001, 'Card number and type cannot be empty');
    END IF;
  END IF;
END card_check;
/

---------------------INSERT STATEMENTS-----------------------------------
-- table Multiplex

Insert into MULTIPLEX (MULTIPLEX_ID,MULTIPLEX_NAME,ADDRESS_STREET,ADDRESS_PINCODE) values ('TR2002','ArcLight Cinemas','60 Causeway St','02114');
Insert into MULTIPLEX (MULTIPLEX_ID,MULTIPLEX_NAME,ADDRESS_STREET,ADDRESS_PINCODE) values ('TR2001','AMC Boston Common 19','175 Tremont St','02114');
Insert into MULTIPLEX (MULTIPLEX_ID,MULTIPLEX_NAME,ADDRESS_STREET,ADDRESS_PINCODE) values ('TR2003','ShowPlace ICON Boston','60 Seaport Blvd #315','02210');
Insert into MULTIPLEX (MULTIPLEX_ID,MULTIPLEX_NAME,ADDRESS_STREET,ADDRESS_PINCODE) values ('TR2004','Regal Fenway','201 Brookline Ave','02215');
Insert into MULTIPLEX (MULTIPLEX_ID,MULTIPLEX_NAME,ADDRESS_STREET,ADDRESS_PINCODE) values ('TR2005','Simons Theatre','1 Central Wharf','02110');
Insert into MULTIPLEX (MULTIPLEX_ID,MULTIPLEX_NAME,ADDRESS_STREET,ADDRESS_PINCODE) values ('TR2006','Nova','Newbury St','02116');
Insert into MULTIPLEX (MULTIPLEX_ID,MULTIPLEX_NAME,ADDRESS_STREET,ADDRESS_PINCODE) values ('TR2007','Cyclorama','539 Tremont St','02116');

-- table Auditorium
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3001','TR2001','Standard');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3002','TR2001','IMAX');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3003','TR2001','Dolby');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3004','TR2002','Standard');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3005','TR2002','IMAX');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3006','TR2002','Dolby');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3007','TR2003','Standard');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3008','TR2003','IMAX');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3009','TR2003','Dolby');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3010','TR2004','Standard');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3011','TR2004','IMAX');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3012','TR2004','Dolby');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3013','TR2005','Standard');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3014','TR2005','IMAX');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3015','TR2005','Dolby');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3016','TR2006','Standard');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3017','TR2006','IMAX');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3018','TR2006','Dolby');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3019','TR2007','Standard');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3020','TR2007','IMAX');
Insert into AUDITORIUMS (AUDI_ID,MULTIPLEX_ID,AUDI_NAME) values ('AUD3021','TR2007','Dolby');

--table Movies
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1001','Hopeful Notes',94,'A young violinist with leukemia brings hope and life into a desolate Russian hospital for children.',9.7,2010);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1002','The Moving on Phase',85,'Piper is a young adult female that is forced into a life change after long time boyfriend breaks it off and evicts her from their home.',9.5,2020);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1003','The Shawshank Redemption',142,'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',9.3,1994);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1004','Love in Kilnerry',100,'The elderly resident of a small remote town panic after the EPA announces that government mandated changes to their chemical plant could create a bi-product that would dramatically increase...',9.3,2019);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1005','As I Am',62,'A story of a young man running from the truth about his childhood returns in order to correct his past but ends up discovering a side of himself that he suppressed.',9.3,2019);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1006','The Godfather',175,'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',9.2,1972);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1007','The Transcendents',96,'Roger, a Rasputin-like drifter, is in search of the ultimate indie-rock band, The Transcendents. What he finds is less than transcendent: a band who has all but abandoned society, a host of...',9.2,2018);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1008','Delaware Shore',98,'A Holocaust survivor who escapes the concentration camps finds refuge on a secluded Delaware Beach and raises her abandoned twin grandchildren.',9.1,2018);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1009','The Godfather: Part II',202,'The early life and career of Vito Corleone in 1920s New York City is portrayed, while his son, Michael, expands and tightens his grip on the family crime syndicate.',9,1974);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1010','The Dark Knight',152,'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',9,2008);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1011','The Lord of the Rings: The Return of the King',201,'Gandalf and Aragorn lead the World of Men against Sauron''s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.',8.9,2003);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1012','Schindler''s List',195,'In German-occupied Poland during World War II, industrialist',8.9,1993);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1013','Pulp Fiction',154,'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',8.9,1994);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1014','12 Angry Men',96,'A jury holdout attempts to prevent a miscarriage of justice by forcing his colleagues to reconsider the evidence.',8.9,1957);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1015','The Lord of the Rings: The Fellowship of the Ring',178,'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.',8.8,2001);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1016','Metallica and San Francisco Symphony - SandM2',150,'Metallica and the San Francisco Symphony perform a live concert together at Chase Center in San Francisco.',8.8,2019);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1017','Inception',148,'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',8.8,2010);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1018','Forrest Gump',142,'The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate and other historical events unfold through the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.',8.8,1994);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1019','Fight Club',139,'An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.',8.8,1999);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1020','Wheels',115,'Two suicidal paraplegic junkies hustle their way through the city streets trying to find a reason to live.',8.8,2014);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1021','Graves End',90,'When society turns their back on reformed felons, the town of Graves End welcomes them but when the ex-cons disappear, FBI agent Paul Rickman comes looking for them and discovers more than he expected.',8.8,2005);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1022','All You Can Dream',79,'A young girl with some extra weight is helped by her guardian angel / favorite singer Anastacia to change her perspective on life. She will progressively acquire self-confidence, modify her...',8.8,2012);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1023','Se7en',127,'Two detectives, a rookie and a veteran, hunt a serial killer who uses the seven deadly sins as his motives.',8.6,1995);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1024','Interstellar',169,'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.',8.6,2014);
Insert into MOVIES (MOVIE_ID,MOVIE_NAME,RUNTIME,MOVIE_DESCRIPTION,IMDB_RATING,RELEASE_YEAR) values ('movie1025','The Prestige',130,'After a tragic accident, two stage magicians engage in a battle to create the ultimate illusion while sacrificing everything they have to outwit each other.',8.5,2006);

-- table Movie Schedule
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4001', 'movie1001', 'AUD3001', '19-12-2020 10:00:00', 14);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4002', 'movie1001', 'AUD3005', '19-12-2020 03:30:00 PM', 13);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4003', 'movie1001', 'AUD3009', '19-12-2020 04:00:00 PM', 12);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4004', 'movie1002', 'AUD3002', '19-12-2020 01:40:00 PM', 12);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4005', 'movie1002', 'AUD3006', '19-12-2020 05:30:00 PM', 13);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4006', 'movie1002', 'AUD3010', '20-12-2020 06:30:00 PM', 14);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4007', 'movie1003', 'AUD3003', '20-12-2020 11:00:00', 13);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4008', 'movie1003', 'AUD3007', '20-12-2020 12:00:00', 12);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4009', 'movie1003', 'AUD3011', '20-12-2020 08:00:00 PM', 12);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4010', 'movie1004', 'AUD3012', '20-12-2020 09:30:00 PM', 13);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4011', 'movie1005', 'AUD3004', '20-12-2020 10:00:00', 14);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4012', 'movie1005', 'AUD3008', '20-12-2020 03:30:00 PM', 13);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4013', 'movie1005', 'AUD3012', '20-12-2020 04:00:00 PM', 12);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4014', 'movie1006', 'AUD3016', '20-12-2020 01:40:00 PM', 12);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4015', 'movie1006', 'AUD3020', '20-12-2020 05:30:00 PM', 13);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4016', 'movie1006', 'AUD3012', '21-12-2020 06:30:00 PM', 14);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4017', 'movie1007', 'AUD3007', '21-12-2020 11:00:00', 13);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4018', 'movie1007', 'AUD3003', '21-12-2020 12:00:00', 12);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4019', 'movie1007', 'AUD3010', '21-12-2020 08:00:00 PM', 12);
insert into movie_schedule (movie_schedule_id, movie_id, audi_id, show_datetime, ticket_cost) values ('MS4020', 'movie1008', 'AUD3002', '21-12-2020 09:30:00 PM', 13);

-- table Director
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1001','Valerio Zanoli');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1002','Don Tjernagel');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1003','Frank Darabont');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1004','Daniel Keith');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1005','Snorri Sturluson');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1006','Anthony Bawn');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1007','Francis Ford Coppola');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1008','Derek Ahonen');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1009','Raghav Peri');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1010','Christopher Nolan');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1011','Peter Jackson');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1012','Steven Spielberg');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1013','Quentin Tarantino');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1014','Sidney Lumet');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1015','Wayne Isham');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1016','Robert Zemeckis');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1017','David Fincher');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1018','Tim Gagliardo');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1019','Donavon Warren');
Insert into DIRECTOR (DIRECTOR_ID,DIRECTOR_NAME) values ('D1020','James Marlowe');


-- table MovieDirector
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1001','movie1001');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1002','movie1002');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1003','movie1003');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1004','movie1004');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1005','movie1004');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1006','movie1005');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1007','movie1006');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1008','movie1007');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1009','movie1008');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1007','movie1009');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1010','movie1010');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1011','movie1011');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1012','movie1012');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1013','movie1013');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1014','movie1014');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1011','movie1015');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1015','movie1016');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1010','movie1017');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1016','movie1018');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1017','movie1019');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1018','movie1020');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1019','movie1020');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1020','movie1021');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1001','movie1022');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1017','movie1023');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1010','movie1024');
Insert into MOVIE_DIRECTOR (DIRECTOR_ID,MOVIE_ID) values ('D1010','movie1025');


-- table Actor

Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act101','Walter Nudo');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act102',' Colin Ross');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act103',' Ian Poland');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act104',' Laural Merlington');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act105','Matt Anderson');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act106',' Clint Boevers');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act107',' Jillian Brown');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act108',' Cody Croskrey');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act109','Tim Robbins');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act110',' Morgan Freeman');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act111',' Bob Gunton');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act112',' William Sadler');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act113','Daniel Keith');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act114',' Kathy Searle');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act115',' Tony Triano');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act116',' James Patrick Nelson');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act117','Andre Myers');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act118',' Jerimiyah Dunbar');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act119',' Rodney Chester');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act120',' Tom McLaren');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act121','Marlon Brando');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act122',' Al Pacino');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act123',' James Caan');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act124',' Richard S. Castellano');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act125','Rob Franco');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act126',' Savannah Welch');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act127',' Kathy Valentine');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act128',' William Leroy');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act129','James Robinson Jr.');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act130',' Kevin D. Benton');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act131',' Bella Dontine');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act132',' Ed Aristone');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act133','Al Pacino');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act134',' Robert Duvall');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act135',' Diane Keaton');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act136',' Robert De Niro');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act137','Christian Bale');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act138',' Heath Ledger');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act139',' Aaron Eckhart');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act140',' Michael Caine');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act141','Noel Appleby');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act142',' Ali Astin');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act143',' Sean Astin');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act144',' David Aston');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act145','Liam Neeson');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act146',' Ben Kingsley');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act147',' Ralph Fiennes');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act148',' Caroline Goodall');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act149','Tim Roth');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act150',' Amanda Plummer');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act151',' Laura Lovelace');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act152',' John Travolta');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act153','Martin Balsam');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act154',' John Fiedler');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act155',' Lee J. Cobb');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act156',' E.G. Marshall');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act157','Alan Howard');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act158',' Noel Appleby');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act159',' Sala Baker');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act160','Edgar Barradas');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act161',' Kirk Hammett');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act162',' James Hetfield');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act163',' Metallica');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act164','Leonardo DiCaprio');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act165',' Joseph Gordon-Levitt');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act166',' Ellen Page');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act167',' Tom Hardy');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act168','Tom Hanks');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act169',' Rebecca Williams');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act170',' Sally Field');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act171',' Michael Conner Humphreys');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act172','Edward Norton');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act173',' Brad Pitt');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act174',' Meat Loaf');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act175',' Zach Grenier');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act176','Donavon Warren');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act177',' Patrick Hume');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act178',' Diana Gettinger');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act179',' Kevin McCorkle');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act180','Eric Roberts');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act181',' Steven Williams');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act182',' Daniel Roebuck');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act183',' Valerie Mikita');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act184','Anastacia');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act185',' Hali Mason');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act186',' Lynn Shackelford');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act187','Morgan Freeman');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act188',' Andrew Kevin Walker');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act189',' Daniel Zacapa');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act190','Ellen Burstyn');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act191',' Matthew McConaughey');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act192',' Mackenzie Foy');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act193',' John Lithgow');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act194','Hugh Jackman');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act195',' Christian Bale');
Insert into ACTOR (ACTOR_ID,ACTOR_NAME) values ('act196',' Piper Perabo');

-- table MovieActor

Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act101','movie1001');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act102','movie1001');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act103','movie1001');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act104','movie1001');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act105','movie1002');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act106','movie1002');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act107','movie1002');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act108','movie1002');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act109','movie1003');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act110','movie1003');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act111','movie1003');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act112','movie1003');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act113','movie1003');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act114','movie1003');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act115','movie1004');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act116','movie1004');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act117','movie1004');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act118','movie1004');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act119','movie1005');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act120','movie1005');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act121','movie1006');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act122','movie1006');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act123','movie1006');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act124','movie1006');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act125','movie1007');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act126','movie1007');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act127','movie1007');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act128','movie1007');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act129','movie1007');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act130','movie1007');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act131','movie1008');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act132','movie1008');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act133','movie1008');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act134','movie1008');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act135','movie1009');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act136','movie1009');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act137','movie1009');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act138','movie1009');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act139','movie1010');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act140','movie1010');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act141','movie1010');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act142','movie1010');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act143','movie1011');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act144','movie1011');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act145','movie1011');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act146','movie1011');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act147','movie1012');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act148','movie1012');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act149','movie1012');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act150','movie1012');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act151','movie1013');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act152','movie1013');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act153','movie1013');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act154','movie1013');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act155','movie1014');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act156','movie1014');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act157','movie1014');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act158','movie1014');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act143','movie1015');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act159','movie1015');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act160','movie1015');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act161','movie1015');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act162','movie1016');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act163','movie1016');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act164','movie1016');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act165','movie1016');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act166','movie1017');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act167','movie1017');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act168','movie1017');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act169','movie1017');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act170','movie1018');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act171','movie1018');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act172','movie1018');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act173','movie1018');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act174','movie1019');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act175','movie1019');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act176','movie1019');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act177','movie1019');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act178','movie1020');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act179','movie1020');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act180','movie1020');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act181','movie1020');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act182','movie1021');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act183','movie1021');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act184','movie1021');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act185','movie1021');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act104','movie1022');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act186','movie1022');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act187','movie1022');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act188','movie1022');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act189','movie1023');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act173','movie1023');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act190','movie1023');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act191','movie1023');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act192','movie1024');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act193','movie1024');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act194','movie1024');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act195','movie1024');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act140','movie1025');
Insert into MOVIE_ACTOR (ACTOR_ID,MOVIE_ID) values ('act196','movie1025');


-- table Genre

Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre101','Drama');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre102','Comedy');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre103','Fantasy');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre104','Romance');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre105','Crime');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre106','Music');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre107','Mystery');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre108',' Thriller');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre109','Action');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre110','Adventure');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre111','Biography');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre112','History');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre113','Sci-Fi');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre114','Thriller');
Insert into GENRE (GENRE_ID,GENRE_CATEGORY) values ('genre115','Family');

-- table MovieGenre
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1001');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre102','movie1002');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1003');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre102','movie1004');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1005');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre103','movie1005');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre104','movie1005');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre105','movie1006');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre106','movie1007');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre107','movie1007');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre108','movie1007');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1008');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre105','movie1009');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1009');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre109','movie1010');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre105','movie1010');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1010');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre109','movie1011');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre110','movie1011');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1011');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre111','movie1012');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1012');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre112','movie1012');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre105','movie1013');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1013');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre105','movie1014');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1014');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre109','movie1015');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre110','movie1015');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1015');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre106','movie1016');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre109','movie1017');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre110','movie1017');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre113','movie1017');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1018');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre104','movie1018');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1019');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1020');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre114','movie1021');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre107','movie1021');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre102','movie1022');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1022');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre115','movie1022');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre105','movie1023');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1023');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre107','movie1023');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre110','movie1024');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1024');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre113','movie1024');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre101','movie1025');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre107','movie1025');
Insert into MOVIE_GENRE (GENRE_ID,MOVIE_ID) values ('genre113','movie1025');





-- table UserCredentials
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US60021','nickiled@gmail.com','nicki@123'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US23456','caqawofam-9045@yopmail.com','Gmail@123'); 
Insert intO USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US12356','cipobop253@tdcryo.com','US1233fg'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US23556','cipobop255@tdcryo.com','naruto'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US23656','cipobop277@tdcryo.com','danny'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US23756','cipobop298@tdcryo.com','cold123'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US23856','fall23@gmail.com','hot123'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US23956','oasis.45@gmail.com','blue23'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US27756','lagos@gmail.com','red567'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US27856','google@gmail.com','mark34'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US29956','mike234@gmail.com','rose34'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US56565','danyseth@gmail.com','gunswe'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US56789','DUSTIN@GMAIL.COM','gunsandroses'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US56409','kamla345@gmail.com','gitam123'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US56708','jimred34@gmail.com','null234'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US56777','chris45@gmail.com','killer45'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US34934','koalar54e@yahoo.com','dank43'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US23454','tedboris@gmail.com','bulletein43'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US45612','donald43@gmail.com','taylor670'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US90083','jimmyfalon56@gmail.com','twilight45'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US50043','tonystank789@gmail.com','toodles2'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US50044','KAMLA49@GMAIL.COM','Kamla@231'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US50014','harish@gmail.com','hari342@990'); 
Insert into USERCREDENTIAL (USER_ID,EMAIL,PASSWORD) values ('US50003','domaincycle@gmail.com','domain@873'); 
INSERT INTO USERCREDENTIAL (USER_ID, EMAIL, PASSWORD) VALUES ('US50021', 'MIKETYSON@GMAIL.COM', standard_hash('2122','MD5'));

-- table Employees
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323111','US60021','TR2001','JAKE','BLACK',617888111,null,'43','New england st.','Boston','Massachusets','902020345','17/10/1981'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323456','US56565','TR2002','MARK','TWAIN',617816875,2323498,'23','Hanover St','Weston','Massachusetts','234567890', '26/05/1983'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323453','US56789','TR2001','TIM','BLAKE',617816874,2323111,'34','Great Rd','Bedford','Massachusetts','897234567', '19/09/1984'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323444','US56409','TR2003','JACK','SHAE',617816222,2323602,'456','Avalon Dr','Wilmington','Rhode ISLAND','456123782', '07/05/1988'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323441','US56708','TR2004','JIMMY','NEUTRON',617816121,2323609,'123','Hathaway Rd','Wilmington','Maine','789342142', '26/01/1989'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323490','US56777','TR2005','NEIL','FALCON',617816222,2323901,'234','Heath St','Tewksbury','Newyork','672342908', '02/07/1990'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323460','US34934','TR2006','PICOLO','DAS',617816902,2323909,'345','Dell Dr','Wilmington','Massachusetts','890387933', '30/12/1990'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323345','US23454','TR2007','CASSANDRA','JERKY',617816502,2323500,'123','Osgood St #R506','Cambridge','Massachusetts','897405624', '07/05/1991'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323498','US45612','TR2002','CHRIS','HAMSWORTH',617816232,null,'78','Greenbriar Dr','Metheuen','Massachusetts','783903674', '28/08/1997'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323602','US90083','TR2003','KAMLA','HARI',617232123,null,'345','PARKDRIVE ST.','Boston','Massachusetts','890466234', '01/06/1998'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323609','US50043','TR2004','KAMLA','GABBAD',617323451,null,'556','QUEENSBERRY ST.','Boston','Massachusetts','738474926', '29/10/1998'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323901','US50044','TR2005','NELSON','MANDELA',617515515,null,'45','PARK DRIVE','Boston','Massachusetts','900123456', '21/07/1999'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323909','US50014','TR2006','PETER','PARKER',617516516,null,'67','Columbus Avenue','Boston','Massachusetts','800456788', '18/12/2000'); 
Insert into EMPLOYEES (EMPLOYEE_ID,USER_ID,MULTIPLEX_ID,EMP_FNAME,EMP_LNAME,EMPLOYEE_CONTACT,MANAGER_ID,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,ADDRESS_STATE,EMPLOYEE_SNN,EMPLOYEE_DOB) values ('2323500','US50003','TR2007','HARRY','JAMES',617501201,null,'292','Charles street','Boston','Massachusetts','901234561', '26/12/2000'); 

-- table Customer
Insert into CUSTOMER (CUSTOMER_ID,USER_ID,CUSTOMER_FNAME,CUSTOMER_LNAME,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,CUSTOMER_CONTACT) values ('C89012','US23456','Jodi','Plummer','23','Boylston St','Springfield',7856334004); 
Insert into CUSTOMER (CUSTOMER_ID,USER_ID,CUSTOMER_FNAME,CUSTOMER_LNAME,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,CUSTOMER_CONTACT) values ('C89023','US12356','Fahim','Gamble','34','Ames St','West Springfield',7757660059); 
Insert into CUSTOMER (CUSTOMER_ID,USER_ID,CUSTOMER_FNAME,CUSTOMER_LNAME,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,CUSTOMER_CONTACT) values ('C89056','US23556','Keelan','Norris','45','Cabot St','Springfield',2312753164); 
Insert into CUSTOMER (CUSTOMER_ID,USER_ID,CUSTOMER_FNAME,CUSTOMER_LNAME,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,CUSTOMER_CONTACT) values ('C56789','US23656','Dustin','Beattie','54','Cherry St','Springfield',7659848734); 
Insert into CUSTOMER (CUSTOMER_ID,USER_ID,CUSTOMER_FNAME,CUSTOMER_LNAME,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,CUSTOMER_CONTACT) values ('C45098','US23756','Raihan','Dixon','55','Clearwater Rd','West Springfield',7578931388); 
Insert into CUSTOMER (CUSTOMER_ID,USER_ID,CUSTOMER_FNAME,CUSTOMER_LNAME,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,CUSTOMER_CONTACT) values ('C37689','US23856','Vijay','Everett','656','Hawthorne St','West Springfield',3183054957); 
Insert into CUSTOMER (CUSTOMER_ID,USER_ID,CUSTOMER_FNAME,CUSTOMER_LNAME,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,CUSTOMER_CONTACT) values ('C90008','US23956','Dora','Wall','654','Clearwater Rd','Wilbraham',7187044782); 
Insert into CUSTOMER (CUSTOMER_ID,USER_ID,CUSTOMER_FNAME,CUSTOMER_LNAME,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,CUSTOMER_CONTACT) values ('C78903','US27756','Pranav','NOIR','232','Valleyview Dr','Boston',5123302277); 
Insert into CUSTOMER (CUSTOMER_ID,USER_ID,CUSTOMER_FNAME,CUSTOMER_LNAME,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,CUSTOMER_CONTACT) values ('C56009','US27856','Isla-Rae','WILSON','122','Jasmin Dr','Cambridge',6208923495); 
Insert into CUSTOMER (CUSTOMER_ID,USER_ID,CUSTOMER_FNAME,CUSTOMER_LNAME,ADDRESS_HOUSENO,ADDRESS_STREET,ADDRESS_CITY,CUSTOMER_CONTACT) values ('V79008','US29956','Isla-Rae','WILSON','342',' Cardinal Ln','Columbus',8106784295); 

-- table Bookings
INSERT into BOOKING (BOOKING_ID, CUSTOMER_ID, EMPLOYEE_ID, 
PAYMENT_ID, MOVIE_SCHEDULE_ID, 
RESERVATION_STATUS, NO_OF_SEATS) 
VALUES ('18', 'C89023', '2323456', '9', 'MS4011', 'ONLINE', 4);

INSERT into BOOKING (BOOKING_ID, CUSTOMER_ID, EMPLOYEE_ID, 
PAYMENT_ID, MOVIE_SCHEDULE_ID, 
RESERVATION_STATUS, NO_OF_SEATS) 
VALUES ('19', 'C89056', '2323456', '10', 'MS4011', 'ONLINE', 2);

INSERT into BOOKING (BOOKING_ID, CUSTOMER_ID, EMPLOYEE_ID, 
PAYMENT_ID, MOVIE_SCHEDULE_ID, 
RESERVATION_STATUS, NO_OF_SEATS) 
VALUES ('20', 'C56789', '2323456', '1', 'MS4011', 'ONLINE', 5);

INSERT into BOOKING (BOOKING_ID, CUSTOMER_ID, EMPLOYEE_ID, 
PAYMENT_ID, MOVIE_SCHEDULE_ID, 
RESERVATION_STATUS, NO_OF_SEATS) 
VALUES ('21', 'C45098', '2323456', '2', 'MS4011', 'ONLINE', 4);

INSERT into BOOKING (BOOKING_ID, CUSTOMER_ID, EMPLOYEE_ID, 
PAYMENT_ID, MOVIE_SCHEDULE_ID, 
RESERVATION_STATUS, NO_OF_SEATS) 
VALUES ('22', 'C37689', '2323456', '3', 'MS4011', 'ONLINE', 2);

-- table Payment
INSERT INTO PAYMENT (PAYMENT_ID, PAYMENT_METHOD, CARD_NUMBER, Card_type) VALUES ('6', 'CREDIT', standard_hash('888555588884444', 'MD5'), 'VISA');
INSERT INTO PAYMENT (PAYMENT_ID, PAYMENT_METHOD, CARD_NUMBER, Card_type) VALUES ('1', 'CREDIT', standard_hash('8455567583239974', 'MD5'), 'Master');
INSERT INTO PAYMENT (PAYMENT_ID, PAYMENT_METHOD, CARD_NUMBER, Card_type) VALUES ('2', 'CREDIT', standard_hash('7654234888846784', 'MD5'), 'VISA');
INSERT INTO PAYMENT (PAYMENT_ID, PAYMENT_METHOD, CARD_NUMBER, Card_type) VALUES ('3', 'CREDIT', standard_hash('2345567678888654', 'MD5'), 'VISA');
INSERT INTO PAYMENT (PAYMENT_ID, PAYMENT_METHOD, CARD_NUMBER, Card_type) VALUES ('4', 'DEBIT', standard_hash('123456678899335', 'MD5'), 'VISA');
INSERT INTO PAYMENT (PAYMENT_ID, PAYMENT_METHOD, CARD_NUMBER, Card_type) VALUES ('7', 'DEBIT', standard_hash('345678885533356', 'MD5'), 'VISA');
INSERT INTO PAYMENT (PAYMENT_ID, PAYMENT_METHOD, CARD_NUMBER, Card_type) VALUES ('8', 'CREDIT', standard_hash('888555588884444', 'MD5'), 'VISA');
INSERT INTO PAYMENT (PAYMENT_ID, PAYMENT_METHOD) VALUES ('9', 'CASH');
INSERT INTO PAYMENT (PAYMENT_ID, PAYMENT_METHOD) VALUES ('10', 'CASH');

--------------------------------------VIEWS-------------------------------------
-- shows collection made by each movie
CREATE VIEW MOVIE_COLLECTION
AS select movie_name, sum(ticket_price) total_collection
from booking b inner join movie_schedule ms on b.movie_schedule_id = ms.movie_schedule_id
inner join movies mv on mv.movie_id = ms.movie_id group by movie_name;

select * from movie_collection;

-- shows collection made by each multiplex
CREATE VIEW MULTIPLEX_COLLECTION
AS select multiplex_name, sum(ticket_price) total_collection
from booking b inner join movie_schedule ms on b.movie_schedule_id = ms.movie_schedule_id
inner join auditoriums a on a.audi_id = ms.audi_id
inner join multiplex mx on mx.multiplex_id = a.multiplex_id group by multiplex_name;

select * from multiplex_collection;

-- shows all movies released in all multiplexes
CREATE VIEW SHOW_MOVIES
AS select movie_schedule_id, movie_name, ticket_cost, seats_remaining, show_datetime, runtime, multiplex_name, address_street 
from movie_schedule ms inner join movies mv on ms.movie_id = mv.movie_id
inner join auditoriums a on ms.audi_id = a.audi_id
inner join multiplex mx on a.multiplex_id = mx.multiplex_id
order by show_datetime;

select * from show_movies where show_datetime between '19-12-2020' and '21-12-2020';

--------- SQL Reports---------

---Which Genre has maximum number of movies---
Select genre_category, count(*) as no_of_movies
From movie_genre m
Left join genre g on m.genre_id=g.genre_id
Group by g.genre_category
order by no_of_movies desc, genre_category asc

--- Directors and Genre of movies they make----
Select director_name, genre_category, count(*) no_of_movies
From movies
Left join movie_director on movies.movie_id=movie_director.movie_id
Left join director on movie_director.director_id= director.director_id
Left join movie_genre on movie_genre.movie_id=movies.movie_id
Left join genre g on movie_genre.genre_id=g.genre_id
Group by director_name,genre_category
order by director_name asc, no_of_movies desc
---

--Actors and their number of movies----
select actor_name, count(*) as no_of_movies  
from movie_actor m
Left join actor a on m.actor_id=a.actor_id
group by actor_name
order by no_of_movies desc, actor_name asc
FETCH FIRST 5 ROWS ONLY;

---Director and their number of movies---
select director_name, count(*) as no_of_movies  
from movie_director m
Left join director d on m.director_id=d.director_id
group by director_name
order by no_of_movies desc, director_name asc
FETCH FIRST 5 ROWS ONLY;

----------Employees and managers they report to----------
SELECT
    (e.EMP_FNAME|| '  ' || e.emp_lname) employee,
    (m.EMP_FNAME || '  ' || m.emp_lname) manager,
    e.multiplex_id
FROM
    employees e
LEFT JOIN employees m ON
    m.EMPLOYEE_ID = e.manager_id;