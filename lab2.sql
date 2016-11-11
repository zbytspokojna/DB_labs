--2.1
--1
select nazwa, ulica, miejscowosc
from klienci
order by 1;
--2
select nazwa, ulica, miejscowosc
from klienci
order by 3 desc, 1 asc;
--3
select nazwa, miejscowosc 
from klienci
where miejscowosc = 'Kraków' or miejscowosc = 'Warszawa'
--where miejscowosc in ('Kraków','Warszawa')
order by 2 desc, 1 asc;
--4
select nazwa
from klienci
order by miejscowosc;
--5
select nazwa
from klienci
where miejscowosc = 'Kraków'
--where miejscowosc in ('Kraków','Warszawa')
order by 1;

--2.2
--1
select nazwa, masa
from czekoladki
where masa > 20;
--2
select nazwa, masa, koszt
from czekoladki
where masa > 20 and koszt > 0.25;
--3
select nazwa, masa, koszt*100 as koszt
from czekoladki
where masa > 20 and koszt*100 > 25;
--4
select nazwa, czekolada, nadzienie, orzechy
from czekoladki
where (czekolada = 'mleczna' and nadzienie in ('maliny','truskawki')) or orzechy = 'laskowe' and czekolada != 'gorzka';
--5/6 mostly the same

--2.3
--1/2 just select before equation
--3
select sqrt(3);
--4
select pi();

--2.4
--1
select idczekoladki, nazwa, masa, koszt
from czekoladki
where masa between 15 and 24;
--2
select idczekoladki, nazwa, masa, koszt
from czekoladki
where koszt between 0.25 and 0.35;
--3
select idczekoladki, nazwa, masa, koszt
from czekoladki
where (koszt between 0.25 and 0.35) or (masa between 15 and 24);

--2.5
--1
select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where orzechy is not null;
--2
select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where orzechy is null;
--3/6
select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where orzechy is not null or nadzienie is not null;
--4/9
select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where czekolada in ('mleczna','biała') and orzechy is null;
--5
select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki 
where (czekolada not in ('mleczna','biała')) and (orzechy is not null or nadzienie is not null);
--7/8
select idczekoladki, nazwa, czekolada, orzechy, nadzienie
from czekoladki
where orzechy is null and nadzienie is null;

--2.6
--1/2/3/4/5 no sense making them all
select idczekoladki, masa, koszt 
from czekoladki
where (masa between 25 and 35) and (koszt not between 0.15 and 0.24) and (koszt not between 0.25 and 0.35);

--2.7
--\a format unaligned\aligned
--\f '*' field separator *-anything you want
--\H format html\aligned
--\o [file.format] przekierowanie do pliku

--2.8
--1 In script \o [file.txt] and select. To use script -> psql <file.sql> <- in it's directory
--2 Add \H for html format
