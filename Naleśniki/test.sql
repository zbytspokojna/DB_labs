select distinct k.nazwa, z.id_zamowienia, s.nazwa
from klienci k natural join zamowienia z natural join kompozycje o join bazowe_nalesniki b on id_bazowego_nalesnika = id_nalesnika natural join zawartosc_nalesnika n join skladniki s using(id_skladnika)
where s.nazwa like 'banan';


select k.id_klienta, k.nazwa, count(o.id_zamowienia)
from klienci k full join zamowienia z using (id_klienta) full join kompozycje o using (id_zamowienia)
group by k.nazwa, k.id_klienta
order by 1;

select suma.nazwa, sum(suma.sum)
from (select nazwa, sum(masa.waga)
from (select z.id_zamowienia as id_zamowienia, sum(s.masa) as waga
from zamowienia z natural join kompozycje o natural join dodatkowe_skladniki d natural join skladniki s group by id_zamowienia) masa full join zamowienia using(id_zamowienia) full join klienci using(id_klienta) 
group by nazwa
union
select nazwa, sum(masa.waga)
from (select z.id_zamowienia as id_zamowienia, sum(s.masa) as waga
from zamowienia z natural join kompozycje o join bazowe_nalesniki b on id_bazowego_nalesnika = id_nalesnika natural join zawartosc_nalesnika w join skladniki s using(id_skladnika) group by id_zamowienia) masa full join zamowienia using(id_zamowienia) full join klienci using(id_klienta) 
group by nazwa) suma
group by nazwa
having sum(suma.sum) > 200;


