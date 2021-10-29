
create database if not exists book_store;
use  book_store;

-- ROLES 
create table role(
	role_name varchar(10) not null unique primary key,
	created_at datetime not null default current_timestamp
);


-- USERS 
create table user(
	first_name varchar(10),
	last_name varchar(15),
	user_password varchar(224) not null,
	phone_number varchar(11) not null,
	email varchar(30) not null primary key unique,
	date_created datetime not null default CURRENT_TIMESTAMP ,
	user_role varchar(10),
	FOREIGN KEY (user_role)
	REFERENCES role(role_name)
	on delete set null
);

-- USER LOGIN HISTORY
create table login_history(
	user varchar(30) not null,
    date_created datetime not null default current_timestamp
);

-- USER SESSION
create table auth_token(
user varchar(30) not null,
access_token varchar(224),
valid_till datetime not null default current_timestamp,
foreign key (user)
references user (email)
on delete cascade 
);



-- BOOK 
create table book(
	isbn13 char(13) not null unique primary key,
	title varchar(225) not null,
	publication_date date not null,
	num_of_pages int unsigned not null,
	book_description mediumtext,
	date_created datetime not null default current_timestamp
);

-- AUTHOR 
create table author(
	first_name varchar(10),
	last_name varchar(15),
	author_id int auto_increment primary key,
	date_created datetime not null default current_timestamp
);

-- upload book
-- update inventory 

-- AUTHORS BOOKS
create table author_books(
	book_isbn char(13) ,
    author_id  int ,
    foreign key (author_id) references author (author_id) on delete cascade,
    foreign key ( book_isbn) references book(isbn13) on delete cascade ,
    primary key(author_id, book_isbn)
);

-- PUBLISHER 
create table publisher(
	pub_name varchar(220),
	pub_id int auto_increment primary key
);

-- PUBLISHERS BOOK
create table publishers_book(
	book_isbn char(13),
    pub_id int,
    foreign key (book_isbn) references book(isbn13) on delete cascade,
    foreign key (pub_id) references publisher(pub_id) on delete cascade,
    primary key (book_isbn, pub_id )
);



select * from user;
select * from role;
select * from book;

insert into role (role_name)
values (
"customer"
);

insert into role (role_name)
values (
"staff"
);

insert into role (role_name)
values (
"manager"
);

insert into book (isbn13, title, publication_date, num_of_pages, book_description)
values(
"9781633539327",
"Tears of the Silenced: An Amish True Crime Memoir of Childhood Sexual Abuse, Brutal Betrayal, and Ultimate Survival",
str_to_date("15-9-2018",'%d-%m-%Y'),
429,
"When Misty Griffin was six years old, her family started to live and dress like the Amish. Misty and her sister were kept as slaves on a mountain ranch and subjected to almost complete isolation, sexual abuse, and extreme physical violence. Their stepfather kept a loaded rifle by the door to make sure the young girls were too terrified to try to escape. No rescue would ever come since the few people who knew they existed did not care."
);

insert into book (isbn13, title, publication_date, num_of_pages, book_description)
values(
"9781559368421",
"Between Riverside and Crazy (TCG Edition)",
str_to_date("19-10-2015",'%d-%m-%Y'),
309,
"Expected to be revived in a high-profile NYC production (possibly on Broadway), and likely to be produced at major theaters around the country"
);

insert into book (isbn13, title, publication_date, num_of_pages, book_description)
values(
"9781559368421",
"Between Riverside and Crazy (TCG Edition)",
str_to_date("19-10-2015",'%d-%m-%Y'),
500,
"Expected to be revived in a high-profile NYC production (possibly on Broadway), and likely to be produced at major theaters around the country"
);

drop database book_store;


