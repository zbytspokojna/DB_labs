drop schema if exists testy cascade;
create schema if not exists testy;

create table testy.dzialy(
iddzialu CHAR(5) check(length(iddzialu)=5) primary key,
nazwa varchar(32) not null,
lokalizacja varchar(24) not null,
kierownik integer
);

create table testy.pracownicy(
	idpracownika integer primary key,
	nazwisko varchar(32) not null,
	imie varchar(16) not null,
	dataUrodzenia date not null,
	dzial CHAR(5) check(length(dzial)=5),
	stanowisko varchar(24),
	pobory numeric(7,2)
	);

	alter table testy.dzialy add constraint kierownik_fk foreign key (kierownik) references testy.pracownicy(idpracownika) on update cascade;


-- ta relacja powinna wg polecenia, ale przez nią nie da się wykonać insertów w zad 5, bo tworzy się cykliczna zależność
--	alter table testy.pracownicy add constraint dzial_fk foreign key (dzial) references testy.dzialy(iddzialu) on update cascade;
