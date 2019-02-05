--10.2
--1
select datarealizacji, idzamowienia
from zamowienia z natural join klienci k
where k. nazwa in (select nazwa from klienci where nazwa like '%Antoni%');
--2
select datarealizacji, idzamowienia
from zamowienia z natural join klienci k
where k.ulica in (select ulica from klienci where ulica like '%/%');
--3
select datarealizacji,idzamowienia 
from zamowienia 
where idklienta in (select idklienta from klienci where miejscowosc='Kraków') 
and extract(year from datarealizacji)=2013 
and extract(month from datarealizacji)=11;

--10.3
--1
select nazwa, ulica, miejscowosc from klienci where idklienta in (select idklienta from zamowienia where datarealizacji='2013-11-12');
--2
select nazwa, ulica, miejscowosc from klienci 
where idklienta in 
(select idklienta from zamowienia where  
extract(year from datarealizacji)=2013 and 
extract(month from datarealizacji)=11);
--3,4,5
--Jak wyzej tylko w drugim seleccie join i wiecej warunków

--6
select nazwa, ulica, miejscowosc from klienci 
where idklienta  in  
(select idklienta from zamowienia);

--7
select nazwa, ulica, miejscowosc from klienci 
where idklienta  not in  
(select idklienta from zamowienia);

--10.4
--1
select nazwa,opis,cena from pudelka where idpudelka in (select idpudelka from zawartosc where idczekoladki='D09');
--2
select nazwa,opis,cena from pudelka where idpudelka in (select idpudelka from zawartosc natural join czekoladki  where nazwa='Gorzka truskawkowa');
--3- Jak 2 inne where
--4 jak 1. tylko warunek na sztuk
--5 Jak 2 wyżej tylko warunek na sztuk
--6
select nazwa,opis,cena from pudelka where idpudelka in (select idpudelka from zawartosc natural join czekoladki  where nadzienie='truskawki');

--7
select p.nazwa, p.opis, p.cena
from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki)
where p.nazwa not in (select p.nazwa
                      from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki)
                      where c.czekolada = 'gorzka');
--8
select distinct p.nazwa, p.opis, p.cena
from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki)
where p.nazwa not in (select p.nazwa
                      from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki)
                      where c.orzechy is not null);
--9
select distinct p.nazwa, p.opis, p.cena
from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki)
where p.nazwa in (select p.nazwa
                  from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki)
                  where c.nadzienie is null);
--10.5
--1
select idczekoladki, nazwa from czekoladki where koszt>all(select koszt from czekoladki where idczekoladki='D08');
--2,3 analogiczne uzycie all tylko juz nie bedie tam jeden rekord w all

--10.6
--1
 select idpudelka, sum(sztuk) ss from zawartosc group by idpudelka having sum(sztuk)>=all(select sum(sztuk) ss from zawartosc group by idpudelka);
 --jak 1 tylko odwrotnie xD
 -- jak wyzej tylkodrugi select avg z select sum
 -- polaczenie 1 i 2

 --10.7
 select one.idpudelka, (select count(idpudelka) from pudelka  where idpudelka<one.idpudelka)  from pudelka one order by 1 asc;