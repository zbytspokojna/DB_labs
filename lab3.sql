select idzamowienia, datarealizacji 
from zamowienia 
where datarealizacji between '2013-11-12' and '2013-11-20';

select idzamowienia, datarealizacji 
from zamowienia 
where (datarealizacji between '2013-12-01' and '2013-12-06') or (datarealizacji between '2013-12-15' and '2013-12-20');

select idzamowienia, datarealizacji 
from zamowienia 
where datarealizacji::text like '2013-12-%';

select idzamowienia, datarealizacji 
from zamowienia 
where extract(month from datarealizacji) = 11;

select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki 
where nazwa like 'S%';

select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki 
where nazwa like 'S%i';

select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki 
where nazwa like 'S% m%';

select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki 
where nazwa similar to '(A|B|C)%';

select idczekoladki, nazwa, czekolada, orzechy, nadzienie 
from czekoladki 
where nazwa similar to '%(Orzech|orzech)%';

select miejscowosc 
from klienci 
where miejscowosc like '_% %_';

select telefon 
from klienci 
where telefon like '% % % %';

select idczekoladki, nazwa, masa, koszt 
from czekoladki 
where masa>15 and masa<24 
union 
select idczekoladki, nazwa, masa, koszt 
from czekoladki 
where koszt>0.15 and koszt<0.24;

select idczekoladki, nazwa, masa, koszt 
from czekoladki 
where masa>25 and masa<35 
except 
select idczekoladki, nazwa, masa, koszt 
from czekoladki 
where koszt>0.25 and koszt<0.35;

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

select idklienta from klienci 
except
select idklienta from zamowienia;

select idpudelka from pudelka
except
select idpudelka from artykuly;


select idmeczu, (gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5], 0)) as Gosp, (goscie[1]+goscie[2]+goscie[3]+coalesce(goscie[4],0)+coalesce(goscie[5], 0)) as Gosc 
from statystyki;

select idmeczu, (gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5], 0)) as Gosp, (goscie[1]+goscie[2]+goscie[3]+coalesce(goscie[4],0)+coalesce(goscie[5], 0)) as Gosc 
from statystyki
where gospodarze[5] + goscie[5] > 29;

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
