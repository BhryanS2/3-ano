drop database if exists pomodoro;

create database if not exists pomodoro;

use pomodoro;

create table if not exists credentials (
    id int not null auto_increment,
    email varchar(255) not null,
    password varchar(255) not null,
    primary key (id)
) character set utf8;

create table if not exists userType (
    id int not null auto_increment,
    type varchar(255) not null,
    primary key (id)
) character set utf8;

create table if not exists userLogs (
    id int not null auto_increment,
    login timestamp default current_timestamp,
    logout timestamp default current_timestamp,
    primary key (id)
) character set utf8;

create table if not exists userProfile (
    id int not null auto_increment,
    userId int not null,
    userLevel int not null,
    challengesCompleted int not null,
    experience int not null,
    challengesId int not null,
    primary key (id)
) character set utf8;

create table if not exists users (
    id int not null auto_increment,
    firstName varchar(255) not null,
    lastName varchar(255) not null,
    image varchar(255) not null,
    birthday date not null,
    CPF varchar(255) not null,
    createAt timestamp default current_timestamp,
    updateAt timestamp default current_timestamp on update current_timestamp,
    credentialsId int not null,
    userTypeId int not null,
    userLogsId int not null,
    primary key (id)
) character set utf8;

create table if not exists challenges (
    id int not null auto_increment,
    type varchar(255) not null,
    description Text not null,
    amount int not null,
    primary key (id)
) character set utf8;

create table if not exists challengesCompleted (
    id int not null auto_increment,
    userId int not null,
    challengesId int not null,
    primary key (id)
) character set utf8;

alter table
    users
add
    foreign key (credentialsId) references credentials(id);

alter table
    users
add
    foreign key (userTypeId) references userType(id);

alter table
    users
add
    foreign key (userLogsId) references userLogs(id);

alter table
    userProfile
add
    foreign key (userId) references users(id);

alter table
    userProfile
add
    foreign key (challengesId) references challenges(id);

alter table
    challengesCompleted
add
    foreign key (userId) references users(id);

alter table
    challengesCompleted
add
    foreign key (challengesId) references challenges(id);

insert into
    userType (type)
values
    ('admin'),
    ('user'),
    ('guest');

insert into
    challenges (type, description, amount)
values
    (
        "body",
        "Estique um de seus braços com a palma da mão virada para frente e puxe os dedos para cima por 10 segundos por mão.",
        80
    ),
    (
        "body",
        "Estique seu braço contra o peito e puxe-o utilizando o outro braço por 10 segundos por braço.",
        60
    ),
    (
        "body",
        "Puxe seu pescoço com a ajuda da mão para a direita e para a esquerda, permanecendo na posição por alguns segundos.",
        70
    ),
    (
        "body",
        "Com as duas mãos na parte de trás da cabeça, leve-a para baixo, alongando a parte de trás da região.",
        60
    ),
    (
        "body",
        "Cruze as pernas e desça com as mãos esticadas em direção ao chão. Repita o movimento com a outra perna na frente.",
        100
    ),
    (
        "body",
        "Sentado, abra as pernas e tente encostar as palmas das mãos no chão, repita 3 vezes por 5 segundos.",
        80
    ),
    (
        "body",
        "Puxe o joelho de encontro ao peito e segure, troque de perna após 10 segundos.",
        50
    ),
    (
        "body",
        "Sentado, cruze uma perna e incline seu tronco à frente, troque de perna após 10 segundos.",
        80
    ),
    (
        "eye",
        "Sentado, feche os olhos e cubra-os com as palmas da mão durante 2 minutos, depois abra normalmente.",
        90
    ),
    (
        "eye",
        "Em algum ambiente aberto, olhe o mais longe que puder em quatro direções por 3s, mexa apenas os olhos. Repita 3 vezes.",
        140
    ),
    (
        "eye",
        "Usando os polegares, massage a área abaixo das sobrancelhas em movimentos circulares por 15 segundos.",
        70
    ),
    (
        "body",
        "Em pé, gire a cintura o máximo que puder para a esquerda, segure por cinco segundos. Repita para a direita.",
        90
    );

insert into
    credentials (email, password)
values
    ("joaosilva@teste.com", "123456"),
    ("mariaTeste@teste.com", "123456");

insert into
    userLogs (login, logout)
values
    (current_timestamp, current_timestamp),
    (current_timestamp, current_timestamp),
    (current_timestamp, current_timestamp);

insert into
    userProfile (
        userId,
        userLevel,
        challengesCompleted,
        experience,
        challengesId
    )
values
    (1, 1, 2, 120, 1),
    (2, 2, 5, 280, 2);

insert into
    users (
        firstName,
        lastName,
        image,
        birthday,
        CPF,
        credentialsId,
        userTypeId,
        userLogsId,
    )
values
    (
        "João",
        "Silva",
        "https://avatars3.githubusercontent.com/u/5692389?s=460&v=4",
        "1990-01-01",
        "12345678901",
        1,
        1,
        1
    ),
    (
        "Maria",
        "Teste",
        "https://avatars3.githubusercontent.com/u/5692389?s=460&v=4",
        "1990-01-01",
        "12345678901",
        2,
        2,
        2
    );

insert into
    challengesCompleted (userId, challengesId)
values
    (2, 1),
    (2, 2),
    (2, 3),
    (2, 4),
    (2, 5),
    (1, 8),
    (1, 9);

/*
 
 select * from users;
 select * from userProfile;
 select * from userLogs;
 select * from credentials;
 select * from userType;
 select * from challenges;
 
 */
select
    firstName as "Nome",
    email as "Email",
    userType.type as "Tipo de usuário",
    userLogs.login as "Login",
    challenges.description as "Desafio",
    challenges.amount as "Pontuação",
    userProfile.challengesCompleted as "Desafios concluídos"
from
    users
    inner join credentials on users.credentialsId = credentials.id
    inner join userType on users.userTypeId = userType.id
    inner join userLogs on users.userLogsId = userLogs.userId
    inner join userProfile on users.id = userProfile.userId
    inner join challenges on userProfile.challengesId = challenges.id
    inner join challengesCompleted on challengesCompleted.challengesId = challenges.id
where
    userProfile.challengesCompleted > 0;

-- show challenges completed by user 2
--
select
    firstName,
    challenges.description
from
    challengesCompleted
    inner join challenges on challengesCompleted.challengesId = challenges.id
    inner join users on challengesCompleted.userId = users.id;

update
    users
set
    firstName = "Rafael",
    lastName = "Silva"
where
    id = 1;

insert into
    credentials (email, password)
values
    ("Tomas@Tomas.com", "123456");

insert into
    userLogs (login, logout)
values
    (current_timestamp, current_timestamp);

insert into
    userProfile (
        userId,
        userLevel,
        challengesCompleted,
        experience,
        challengesId
    )
values
    (1, 2, 120, 1);

insert into
    users (
        firstName,
        lastName,
        image,
        birthday,
        CPF,
        credentialsId,
        userTypeId,
        userLogsId,
        userProfileId
    )
values
    (
        "Tomas",
        "Silva",
        "https://avatars3.githubusercontent.com/u/5692389?s=460&v=4",
        "1990-01-01",
        "12345678901",
        3,
        1,
        3,
        3
    );

select
    count(*) as "Total de usuários"
from
    users;

-- Deleter user 3 and data related
--
delete from
    users,
    userProfile,
    userLogs,
    credentials
where
    users.id = 3
    and users.userProfileId = userProfile.id
    and users.userLogsId = userLogs.id
    and users.credentialsId = credentials.id;

select
    count(*) as "Total de usuários"
from
    users;