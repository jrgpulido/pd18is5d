create database reposystem
	with owner postgres
;

create table author
(
	author_id serial not null
		constraint author_pkey
			primary key,
	lastname varchar(50) not null,
	name varchar(50) default 50 not null
)
;

alter table author owner to postgres
;

create table "user"
(
	user_id serial not null
		constraint users_pkey
			primary key,
	lastname varchar(50) not null,
	email varchar(254) not null,
	password bytea not null,
	user_name varchar not null,
	type smallint not null,
	name varchar(50) not null,
	password_salt varchar
)
;

alter table "user" owner to postgres
;

create unique index users_email_uindex
	on "user" (email)
;

create table action_type
(
	action_type_id integer not null
		constraint action_type_pkey
			primary key,
	description varchar(10) not null
)
;

alter table action_type owner to postgres
;

create unique index action_type_description_uindex
	on action_type (description)
;

create table area
(
	area_id serial not null
		constraint area_pkey
			primary key,
	name varchar(150) not null
)
;

alter table area owner to postgres
;

create table category
(
	category_id serial not null
		constraint category_pkey
			primary key,
	name varchar(30) not null
)
;

alter table category owner to postgres
;

create table resource
(
	resource_id serial not null,
	title varchar(200) not null,
	url varchar(2000),
	file bytea,
	image bytea,
	description varchar(500),
	detailed_info jsonb,
	category_id integer not null
		constraint resource_category_category_id_fk
			references category,
	area_id integer not null
		constraint resource_area_area_id_fk
			references area
)
;

alter table resource owner to postgres
;

create unique index resource_resource_id_uindex
	on resource (resource_id)
;

create table author_resource
(
	resource_id integer not null
		constraint author_resource_resource_resource_id_fk
			references resource (resource_id),
	author_id integer not null
		constraint author_resource_author_author_id_fk
			references author,
	constraint author_resource_pk
		primary key (resource_id, author_id)
)
;

alter table author_resource owner to postgres
;

create table user_resource
(
	user_id integer not null
		constraint user_resource_user_user_id_fk
			references "user",
	resource_id integer not null
		constraint user_resource_resource_resource_id_fk
			references resource (resource_id),
	constraint user_resource_pk
		primary key (user_id, resource_id)
)
;

alter table user_resource owner to postgres
;

create table action
(
	action_id serial not null
		constraint action_pk
			primary key,
	user_id integer
		constraint action_user_user_id_fk
			references "user",
	resource_id integer
		constraint action_resource_resource_id_fk
			references resource (resource_id),
	content varchar(2000) not null,
	type_id integer not null
		constraint action_action_type_action_type_id_fk
			references action_type,
	destiny_action_id integer
		constraint action_action_action_id_fk
			references action,
	created_at timestamp with time zone default CURRENT_TIMESTAMP not null
)
;

alter table action owner to postgres
;

create table keyword
(
	keyword_id serial not null
		constraint keyword_pkey
			primary key,
	name varchar(50) not null
)
;

alter table keyword owner to postgres
;

create table resource_keyword
(
	resource_id integer not null
		constraint resource_keyword_resource_resource_id_fk
			references resource (resource_id),
	keyword_id integer not null
		constraint resource_keyword_keyword_keyword_id_fk
			references keyword,
	constraint resource_keyword_pk
		primary key (resource_id, keyword_id)
)
;

alter table resource_keyword owner to postgres
;

