
drop procedure if exists customer_sign_up;
-- creates new customer
delimiter //
create procedure customer_sign_up ( 
email varchar(30),
user_password varchar(224), 
phone_number varchar(11) 
) 
begin
	insert into user (first_name,last_name, user_password, phone_number,email,user_role) 
	values (null, null, SHA2(user_password, 224),phone_number,email,'customer');
	select  first_name, last_name , email, phone_number,user_role from user;
end //

call customer_sign_up("oladele.alade@gmail.com", "password","8169084566");



drop procedure if exists get_users_by_role;
delimiter $$
create procedure get_users_by_role( 
role varchar (10)
)
begin 
	select first_name, last_name, email , phone_number from user where user_role = role;
end $$

call get_users_by_role("customer");



--  create new staff 
drop procedure if exists staff_sign_up;
delimiter //
create procedure staff_sign_up ( 
first_name varchar(10),
last_name varchar(15),
email varchar(30),
user_password varchar(224), 
phone_number varchar(11) 
) 
begin
	insert into user (first_name,last_name, user_password, phone_number,email,user_role) 
	values (first_name,last_name,SHA2(user_password, 224),phone_number,email,'staff');
	select  first_name, last_name , email, phone_number,user_role from user;
end //

call staff_sign_up("summer", "blue","summer@gmail.com", "password","8169084566");


-- reset password
drop procedure if exists reset_password;
delimiter $$
create procedure reset_password(
email varchar(30), new_password  varchar(224)
)
begin 
	update user 
    set user_password = SHA2(new_password,224)
    where email = email;
   select  first_name, last_name , email, phone_number,user_role from user;
end $$

call reset_password("summer@gmail.com","summerbloom")
 


drop procedure if exists add_author;
delimiter $$
create procedure add_author(
	f_name varchar (10),
	l_name varchar (15)
)
-- if author already exists, returns author else creates new author in db 
begin
    declare author_count tinyint;
		select count(*)
		into author_count
		from author
		where first_name = f_name and last_name = l_name;
        
	if author_count = 0 then
		insert into author (first_name, last_name) value( f_name , l_name );
     end if;   
	select * from author where first_name = f_name and last_name = l_name;
end $$
		

call add_author("juli","lof");
call add_author("sam","white");
call add_author("juli","lof");
select * from author



-- UPLOAD A BOOK 
drop procedure if exists upload_book;
delimieter $$
create procedure upload_book( 
sbn13 char(13),
title varchar(225),
publication_date date,
num_of_pages int unsigned,
book_description mediumtext
)
begin 
	insert into book (isbn13, title, publication_date, num_of_pages, book_description)
	values(
		isbn13,
		title,
		str_to_date(publication_date,'%d-%m-%Y'),
		num_of_pages,
		book_description
	);
    select * from book;
end $$



-- ADD AUTHORS
drop procedure if exists add_book_authors;
delimiter $$
create procedure add_book_author(
isbn13 char(13), 
author_id int
)
begin 
	insert into author_books ( book_isbn , author_id )
	values( isbn13, author_id );
    select * from author_books;
end $$

call add_book_author("9781559368421",1);

-- CREATE SESSION FOR USER
drop procedure if exists create_auth_token;
delimiter $$
create procedure create_auth_token(
user varchar(30),
 duration_in_secs int
)
begin 
	declare hrs int;
    declare mins int; 
    declare sec int;
    declare created_at datetime;
    declare access_token char(224);
    declare valid_till datetime;
    
	set hrs = duration_in_secs / 3600;
    set mins = ( duration_in_secs- (3600*hrs) )/ 60;
    set sec = duration_in_secs - (3600*hrs) - (mins * 60 );
    set created_at = current_timestamp;
    set valid_till =  ADDTIME(created_at, CONCAT(hrs,":",mins,":",sec) );
    set access_token = substring(MD5(RAND()),1,224);
    
    insert into auth_token values(user,access_token,valid_till);
  
end $$

call create_auth_token("oladele.alade@gmail.com",3600);

select * from auth_token

