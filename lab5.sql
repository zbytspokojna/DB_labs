--5.1
--1
select count(*) from czekoladki;
--2
select count(*) from czekoladki where nadzienie is not null;
select count(nadzienie) from czekoladki;
--3
select idpudelka, sum(sztuk)
from zawartosc
group by idpudelka
order by 2 desc
limit 1;
--4
select idpudelka, sum(sztuk) as "Suma czeko"
from zawartosc
group by idpudelka;
--5
select z.idpudelka, sum(sztuk)
from zawartosc z natural join czekoladki c
where c.orzechy is null
group by z.idpudelka;
--6
select z.idpudelka, sum(sztuk)
from zawartosc z natural join czekoladki c
where c.czekolada like 'mleczna'
group by z.idpudelka;

--5.2
--1
select z.idpudelka, sum(z.sztuk * c.masa) as "Masa"
from zawartosc z natural join czekoladki c
group by z.idpudelka;
--2
select z.idpudelka, sum(z.sztuk * c.masa) as "Masa"
from zawartosc z natural join czekoladki c
group by z.idpudelka
order by 2 desc
limit 1;
--or
select pudelka.idpudelka, pudelka.masa
from (select idpudelka, sum(z.sztuk * c.masa) masa
  from zawartosc z natural join czekoladki c
  group by z.idpudelka) pudelka
where pudelka.masa = (select max(pudelko.masa)
                      from (select idpudelka, sum(z.sztuk * c.masa) as masa
                      from zawartosc z natural join czekoladki c
                      group by z.idpudelka) pudelko);
--3
select avg(pudelka.masa) as "Średnia waga pudelka"
from (select sum(z.sztuk * c.masa) as masa
from zawartosc z natural join czekoladki c
group by z.idpudelka) pudelka;
--4
select z.idpudelka, sum(z.sztuk * c.masa)/sum(z.sztuk) as "Średnia masa czekoladki"
from zawartosc z natural join czekoladki c
group by z.idpudelka;

--5.3
--1
select datarealizacji, count(idzamowienia) as "Ilosc"
from zamowienia
group by datarealizacji;
--2
select count(idzamowienia) from zamowienia;
--3
select sum(zamowienia.cena) as "Wartosc zamowien"
from (select sum(a.sztuk*p.cena) as cena
from artykuly a natural join pudelka p
group by idzamowienia) zamowienia;
--4
select klienci.nazwa, klienci.liczba, klienci.cena
from (select k.nazwa as nazwa, count(idzamowienia) as liczba, sum(a.sztuk*p.cena) as cena
from klienci k natural join zamowienia z natural join artykuly a join pudelka p using (idpudelka)
group by k.nazwa) klienci;

--5.4
--1
select idczekoladki, count(idpudelka)
from zawartosc 
group by idczekoladki 
order by 2 desc 
limit 1;
--2
select z.idpudelka, sum(z.sztuk)
from zawartosc z natural join czekoladki c
where c.orzechy is null
group by z.idpudelka
order by 2 desc
limit 4;
--3
select c.idczekoladki, count(idpudelka)
from zawartosc z full join czekoladki c using (idczekoladki)
group by c.idczekoladki 
order by 2 asc
limit 4;
--4
select idpudelka, count(idzamowienia)
from artykuly
group by idpudelka
order by 2 desc
limit by 2;

--5.5
--1
select zamowienia.rok, zamowienia.kwartal, sum(zamowienia.ilosc)
from (select case
	when (extract(month from datarealizacji)<4) then 'pierwszy' 
	when (extract(month from datarealizacji)>3 and extract(month from datarealizacji)<7) then 'drugi'
	when (extract(month from datarealizacji)>6 and extract(month from datarealizacji)<10) then 'trzeci'
	else 'czwarty' end as kwartal,
	extract(year from datarealizacji) as rok, count(idzamowienia) as ilosc
from zamowienia
group by rok, kwartal) zamowienia
group by zamowienia.rok, zamowienia.kwartal;
--or
select date_trunc('quarter', datarealizacji) as kwartal, count(idzamowienia)
from zamowienia
group by 1
order by 1;
--2
select concat(extract(year from datarealizacji),' ',extract(month from datarealizacji)) as data, count(idzamowienia)
from zamowienia
group by extract(year from datarealizacji), extract(month from datarealizacji)
order by 1;
--or
select date_trunc('month', datarealizacji) as kwartal, count(idzamowienia)
from zamowienia
group by 1
order by 1;
--3
select date_trunc('week', datarealizacji) as week, count(idzamowienia)
from zamowienia
group by 1
order by 1;
--4
select miejscowosc, count(idzamowienia)
from	klienci natural join zamowienia
group by 1
order by 1;

--5.6
--1
select sum(pudall.waga)
from (select pudelko.masa*stan as waga
from (select z.idpudelka as idpudelka, sum(z.sztuk * c.masa) as masa
from zawartosc z natural join czekoladki c
group by z.idpudelka) pudelko join pudelka using (idpudelka)) pudall;
--2
select sum(cena*stan)
from pudelka;

--5.7
--1
select zyskPudelko.idpudelka, (zyskPudelko.cena - zyskPudelko.koszt) as "zysk"
from ( select idpudelka, p.cena as cena, sum(z.sztuk*c.koszt) as koszt
from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki)
group by idpudelka) zyskPudelko;
--2
select sum(zamowienia.zysk)
from (select idpudelka, sum(a.sztuk*(zyskPudelko.cena - zyskPudelko.koszt)) as zysk
from ( select idpudelka, p.cena as cena, sum(z.sztuk*c.koszt) as koszt
from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki)
group by idpudelka) zyskPudelko join artykuly a using (idpudelka)
group by idpudelka) zamowienia;
--3
select sum(wyprzedaz.zysk)
from (select idpudelka, sum(stan*(zyskPudelko.cena - zyskPudelko.koszt)) as zysk
from (select idpudelka, p.stan as stan, p.cena as cena, sum(z.sztuk*c.koszt) as koszt
from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki)
group by idpudelka) zyskPudelko
group by idpudelka) wyprzedaz;

--5.8 liczy ile jest przed nim recordow + on sam i to jest jego numer
select (select count(*) from pudelka p2 where p1.idpudelka >= p2.idpudelka) as nr, p1.idpudelka
from pudelka p1
order by p1.idpudelka;
--or easy way
select row_number() over (order by idpudelka) as nr, idpudelka
from pudelka;
