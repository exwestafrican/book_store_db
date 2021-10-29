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




    