--3.1
--1
select idzamowienia, datarealizacji 
from zamowienia 
where datarealizacji between '2013-11-12' and '2013-11-20';
--2
select idzamowienia, datarealizacji 
from zamowienia 
where (datarealizacji between '2013-12-01' and '2013-12-06') or (datarealizacji between '2013-12-15' and '2013-12-20');
--3
select idzamowienia, datarealizacji 
from zamowienia 
where datarealizacji::text like '2013-12-%';
--4
select idzamowienia, datarealizacji 
from zamowienia 
where extract(month from datarealizacji) = 11;
--5
select idzamowienia, datarealizacji
from zamowienia
where extract(month from datarealizacji) in (11,12) and extract(year from datarealizacji) = 2013;
--or
select idzamowienia, datarealizacji
from zamowienia
where datarealizacji::text similar to '(2013-11|2013-12)%';
--6
select idzamowienia, datarealizacji
from zamowienia
where extract(day from datarealizacji) in (17,18,19);
--7
select idzamowienia, datarealizacji
from zamowienia
where date_part('week', datarealizacji) in (46,47);

--3.2
--1
select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki 
where nazwa like 'S%'
order by 2;
--2
select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki 
where nazwa like 'S%i'
order by 2;
--3
select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki 
where nazwa like 'S% m%'
order by 2;
--4
select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki 
where nazwa similar to '(A|B|C)%'
order by 2;
--5
select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki 
where nazwa similar to '%(Orzech|orzech)%'
order by 2;
--6
select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa  like 'S%m%'
order by 2;
--7
select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa similar to '%(maliny|truskawki)%'
order by 2;
--8
select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa not similar to '([D-K]|S|T)%'
order by 2;
--9
select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki
where nazwa like 'Słod%'
order by 2;

--3.3
--1
select miejscowosc 
from klienci 
where miejscowosc like '_% %_';
--2
select telefon 
from klienci 
where telefon like '% % % %';
--3
select telefon 
from klienci 
where telefon like '___ ___ ___';

--3.4
--1
select idczekoladki, nazwa, masa, koszt 
from czekoladki 
where masa>15 and masa<24 
union 
select idczekoladki, nazwa, masa, koszt 
from czekoladki 
where koszt>0.15 and koszt<0.24;
--2
select idczekoladki, nazwa, masa, koszt 
from czekoladki 
where masa>25 and masa<35 
except 
select idczekoladki, nazwa, masa, koszt 
from czekoladki 
where koszt>0.25 and koszt<0.35;
--3
(
select idczekoladki, nazwa, masa, koszt 
from czekoladki 
where masa>15 and masa<24 
intersect 
select idczekoladki, nazwa, masa, koszt 
from czekoladki 
where koszt>0.15 and koszt<0.24
)
union
(
select idczekoladki, nazwa, masa, koszt 
from czekoladki 
where masa>25 and masa<35 
intersect 
select idczekoladki, nazwa, masa, koszt 
from czekoladki 
where koszt>0.25 and koszt<0.35
);
--4/5 mostly the same

--3.5
--1
select idklienta from klienci 
except
select idklienta from zamowienia;
--2
select idpudelka from pudelka
except
select idpudelka from artykuly;
--3
select nazwa from klienci where nazwa similar to '%(rz|Rz)%'
union
select nazwa from czekoladki where nazwa similar to '%(rz|Rz)%'
union
select nazwa from pudelka where nazwa similar to '%(rz|Rz)%';
--4
select idczekoladki from czekoladki
except
select idczekoladki from zawartosc; 

--3.6
--1
select idmeczu, (gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5], 0)) as Gosp, (goscie[1]+goscie[2]+goscie[3]+coalesce(goscie[4],0)+coalesce(goscie[5], 0)) as Gosc 
from statystyki;
--or
select idmeczu, (select sum(s) from unnest(gospodarze) s) as gospodarze, (select sum(s) from unnest(goscie) s) as goscie from statystyki;
--2
select idmeczu, (gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5], 0)) as Gosp, (goscie[1]+goscie[2]+goscie[3]+coalesce(goscie[4],0)+coalesce(goscie[5], 0)) as Gosc 
from statystyki
where gospodarze[5] + goscie[5] > 29;
--or
select idmeczu, (select sum(s) from unnest(gospodarze) s) as gospodarze, (select sum(s) from unnest(goscie) s) as goscie from statystyki where gospodarze[5]>15 or goscie[5]>15;
--3
select idmeczu,
(case when(gospodarze[1] > goscie[1])then 1 else 0 end+
 case when (gospodarze[2] > goscie[2]) then 1 else 0 end +
 case when (gospodarze[3] > goscie[3]) then 1 else 0 end +
 case when (gospodarze[4] > goscie[4]) then 1 else 0 end +
 case when (gospodarze[5] > goscie[5]) then 1 else 0 end)
|| ':' ||
(case when(gospodarze[1] < goscie[1])then 1 else 0 end+
 case when (gospodarze[2] < goscie[2]) then 1 else 0 end +
 case when (gospodarze[3] < goscie[3]) then 1 else 0 end +
 case when (gospodarze[4] < goscie[4]) then 1 else 0 end +
 case when (gospodarze[5] < goscie[5]) then 1 else 0 end)
as "wynik"
from statystyki;
--4
select idmeczu, (gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5], 0)) as Gosp, (goscie[1]+goscie[2]+goscie[3]+coalesce(goscie[4],0)+coalesce(goscie[5], 0)) as Gosc 
from statystyki
where (gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5], 0)) > 100;
--5 really?!
select idmeczu, gospodarze[1] as gosp1, sqrt(gospodarze[1]) as sqrtgosp1, (gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5], 0)) as gosp, log((gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5], 0)),2) as sqrtgosp
from statystyki
where sqrt(gospodarze[1]+goscie[1]) < log(2, (gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5], 0) + goscie[1]+goscie[2]+goscie[3]+coalesce(goscie[4],0)+coalesce(goscie[5], 0)));

--3.7  make into sql file
\echo <!DOCTYPE html>
\echo <html>
\echo <body>
\echo
\echo <h1>Wynik</h1>
\H
\pset border 2
select idmeczu,
(case when(gospodarze[1] > goscie[1])then 1 else 0 end+
 case when (gospodarze[2] > goscie[2]) then 1 else 0 end +
 case when (gospodarze[3] > goscie[3]) then 1 else 0 end +
 case when (gospodarze[4] > goscie[4]) then 1 else 0 end +
 case when (gospodarze[5] > goscie[5]) then 1 else 0 end)
|| ':' ||
(case when(gospodarze[1] < goscie[1])then 1 else 0 end+
 case when (gospodarze[2] < goscie[2]) then 1 else 0 end +
 case when (gospodarze[3] < goscie[3]) then 1 else 0 end +
 case when (gospodarze[4] < goscie[4]) then 1 else 0 end +
 case when (gospodarze[5] < goscie[5]) then 1 else 0 end)
as "wynik"
from statystyki;
\echo
\echo </body>
\echo </html>

--3.8 make into sql file
\a
\pset fieldsep ','
\t
select idmeczu, (gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5], 0)) as Gosp, (goscie[1]+goscie[2]+goscie[3]+coalesce(goscie[4],0)+coalesce(goscie[5], 0)) as Gosc 
from statystyki;
