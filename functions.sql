-- function checks if input email is valid 
drop function if exists is_email_valid;
delimiter //
create function is_email_valid
( 
email varchar(30)
)
returns int
DETERMINISTIC
begin 
	declare is_valid int;
	select REGEXP_LIKE(email,'^[^@]+@[^@]+\.[^@]{2,}$') into is_valid;
	return is_valid;
end //


select is_email_valid("oladele.alade@gmail.com");



drop function if exists hash_password;
delimiter $$
create function hash_password(
user_password varchar(224)
)
returns varchar(224)
deterministic
begin
	return SHA2(user_password,224);
end $$

select hash_password("password");


-- VALIDATE USER LOGIN
drop function if exists is_login_credentials_valid;
delimiter $$
create function is_login_credentials_valid(
u_email varchar(30),
u_password varchar(224)
) 
returns boolean
deterministic
begin
	declare user_count int;
    declare hashed_password varchar(224);
    
    set hashed_password = hash_password(u_password);

		select count(*) into user_count from user
		where email = u_email and user_password = hashed_password;
        
    if user_count = 1 then  return true;
	end if;
     return false;
end $$

select is_login_credentials_valid("oladele.alade@gmail.com","passwords") as is_valid;