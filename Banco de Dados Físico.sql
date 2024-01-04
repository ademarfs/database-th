-- Comandos básicos para uso
create database theoprax; -- Criando o Banco de Dados
use theoprax; -- Selecionando o Banco de Dados
show tables; -- Mostra as tabelas
select * from users; -- Seleciona a tabela "users"
drop table users; -- Dropa a tabela "users"
alter table "nome antigo" rename to "nome atual" -- Exemplo de alteração do nome da tabela
alter table "tabela" change "nome antigo" "nome atual" varchar(100) not null; -- Exemplo de alteraração do nome da coluna de uma tabela

-- Criando tabelas
create table users( 
	id int unsigned primary key auto_increment not null,
    cnpjoto int unique key not null,
    firstName varchar(150) not null,
    lastName varchar(150) null,
    mail varchar(150) unique key not null,
    passwordHash varchar(255) unique key not null,
    active tinyint,
    activationKey varchar(30), -- autenticar user
    createdAt timestamp default current_timestamp,
    updateAt timestamp default current_timestamp
);
create table roles(
	id int unsigned primary key auto_increment not null,
    name varchar(100) not null,
    createdAt timestamp default current_timestamp,
    updateAt timestamp default current_timestamp
);
create table usersRoles (
	userId int unsigned, foreign key (userId) references users(id) on delete cascade on update cascade,
    roleId int unsigned, foreign key (roleId) references roles(id) on delete cascade on update cascade
);
create table passwordResets (
    id int unsigned primary key auto_increment not null,
    userId int unsigned, foreign key (userId) references users(id),
    token varchar(32) not null,
    created_at timestamp default current_timestamp
);
create table tickets (
    id int unsigned primary key auto_increment not null,
    ticketType varchar(50) not null,
    ticketStatus varchar(50) not null,
    priority varchar(50) not null,
    createdAt timestamp default current_timestamp,
    updateAt timestamp default current_timestamp
);
create table usersTickets (
	userId int unsigned, foreign key (userId) references users(id) on delete cascade on update cascade,
    ticketId int unsigned, foreign key (ticketId) references tickets(id) on delete cascade on update cascade
);
create table plans (
	id int unsigned primary key auto_increment not null,
    namePlan varchar(100) not null,
    descriptionPlan varchar(255) not null,
    pricePlan decimal(10,2) not null,
    createdAt timestamp default current_timestamp,
    updateAt timestamp default current_timestamp
);
create table usersPlans (
	userId int unsigned, foreign key (userId) references users(id) on delete cascade on update cascade,
    planId int unsigned, foreign key (planId) references plans(id) on delete cascade on update cascade
);
create table companys (
	id int unsigned primary key auto_increment not null,
    cnpj int unique key not null,
    companyName varchar(100) not null,
    country varchar(100),
    state varchar(100),
    city varchar(100),
    adressStreet varchar(100),
    adressNumber int,
    adressZipCode int not null,
    turnover float,
    cnae varchar(50) not null,
    website varchar(100),
    numberEmployees int
);
create table usersCompanys (
	userId int unsigned, foreign key (userId) references users(id) on delete cascade on update cascade,
    companyId int unsigned, foreign key (companyId) references companys(id) on delete cascade on update cascade
 );
create table visits (
	id int unsigned primary key auto_increment not null,
    companyId int unsigned, foreign key (companyId) references companys(id) on delete cascade on update cascade,
    userId int unsigned, foreign key (userId) references users(id) on delete cascade on update cascade,
    visitDate datetime,
    objective varchar(255),
    statusVisit varchar(50),
    createdAt timestamp default current_timestamp,
    updateAt timestamp default current_timestamp
 );
create table contacts (
	id int unsigned primary key auto_increment not null,
    nameContact varchar(100) not null,
    role varchar(100),
    mail varchar(100),
    phone int,
    cellPhone int,
    linkedin varchar(100)
 );
create table contactsCompanys (
	contactId int unsigned, foreign key (contactId) references contacts(id) on delete cascade on update cascade,
    companyId int unsigned, foreign key (companyId) references companys(id) on delete cascade on update cascade
 );
