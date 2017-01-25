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

--10.4
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
