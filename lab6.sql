--6.1
--1
insert into czekoladki values ('W98','Biały kieł','biała','laskowe','marcepan','Rozpływające się w rękach i kieszeniach','0.45','20');
--2
insert into klienci values
('90','Matusiak Edward','Kropiwnickiego 6/3','Leningrad','31-471','031 423 45 38'),
('91','Matusiak Alina','Kropiwnickiego 6/3','Leningrad','31-471','031 423 45 38'),
('92','Kimono Franek','Karateków 8','Mistrz','30-029','501 498 324');
--3
insert into klienci (select '93', 'Matusiak Iza', ulica, miejscowosc, kod, telefon from klienci where nazwa = 'Matusiak Edward');

--6.2
--1
insert into czekoladki values
('X91','Nieznana Nieznajoma', null , null , null ,'Niewidzialna czekoladka wspomagajaca odchudzanie.','0.26','0'),
('M98','Mleczny Raj','mleczna', null , null ,'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.','0.26','36');

--6.3
--1
delete from czekoladki where idczekoladki in ('X91', 'M98');
--3
insert into czekoladki(idczekoladki, nazwa, czekolada, opis, koszt, masa) values
('X91','Nieznana Nieznajoma', null ,'Niewidzialna czekoladka wspomagajaca odchudzanie.','0.26','0'),
('M98','Mleczny Raj','mleczna','Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.','0.26','36');

--6.4
--1
update klienci set nazwa = 'Nowak Iza' where nazwa = 'Matusiak Iza';
--2
update czekoladki set koszt = koszt - (0.1*koszt) where idczekoladki in ('W98','M98','X91');
--3
update czekoladki set koszt = (select koszt from czekoladki where idczekoladki = 'W98') where nazwa = 'Nieznana Nieznajoma';
--4 to samo
--5
update czekoladki set koszt = koszt + 0.15 where idczekoladki like '%9%';

--6.5
--1
delete from klienci
where nazwa like 'Matusiak %';
--2
delete from klienci
where idklienta > 91 and idklienta < 100;
--3
delete from czekoladki
where koszt >= 0.45 or masa >= 36 or masa = 0;

--6.6
insert into pudelka values
('evio','Everything in one','Niczego w tym pudełku nie brakuje.','30.00','100'),
('nieb','Niebiańskie','Niebiańskie czekoladki z dostawą nawet do nieba','77.77','777');
insert into zawartosc select
'evio', idczekoladki, 1 from czekoladki;
insert into zawartosc select
'nieb', idczekoladki, 7 from czekoladki where opis like '%nie%';

--6.7
boreanna=> COPY pudelka from stdin;
Enter data to be copied followed by a newline.
End with a backslash and a period on a line by itself.
>> nice         Najmilej mleczne	Najmilsze czekoladki na świecie.        10.00	200
>> game 	Marzenie gracza         Każdy gracz pragnie je mieć na swoim biurku.	13.13   255
>> \.

boreanna=> copy zawartosc from stdin (delimiter('|'));
Enter data to be copied followed by a newline.
End with a backslash and a period on a line by itself.
>> nice|b01|4
>> nice|b02|4
>> nice|b03|4
>> nice|b04|4
>> nice|b05|4
>> game|w01|3
>> game|w02|3
>> game|w03|3
>> game|w06|3
>> \.

--6.8
--1
update zawartosc set sztuk = sztuk + 1
where idpudelka in ('evio','nieb','nice','game');
--2
update czekoladki set czekolada = 'brak'
where czekolada is null;
update czekoladki set orzechy = 'brak'
where orzechy is null;
update czekoladki set nadzienie = 'brak'
where nadzienie is null;
--3
update czekoladki set czekolada = null
where czekolada = 'brak';
update czekoladki set orzechy = null
where orzechy = 'brak';
update czekoladki set nadzienie = null
where nadzienie = 'brak';
