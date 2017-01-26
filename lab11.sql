--11.1
--1
create or replace function masaPudelka (pudelko text)
returns numeric(7,2) as
$$
declare
suma numeric(7,2);

begin
  select sum(z.sztuk * c.masa) into suma
    from zawartosc z natural join czekoladki c
    where idpudelka = pudelko;
  return suma;
end;
$$
language plpgsql;

--11.2
--1
create or replace function zysk (pudelko text)
returns numeric(7,2) as
$$
declare
suma numeric(7,2);

begin
  select (zyskPudelko.cena - zyskPudelko.koszt - 0.9) into suma
    from ( select idpudelka, p.cena as cena, sum(z.sztuk*c.koszt) as koszt
      from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki)
      where idpudelka = pudelko
      group by idpudelka) zyskPudelko;
  return suma;
end;
$$
language plpgsql;

--2
create or replace function zysk2 (data date)
returns numeric(7,2) as
$$
declare
suma numeric(7,2);

begin
  select sum(zamowienia.zysk) into suma
    from (select idpudelka, sum(a.sztuk*(zyskPudelko.cena - zyskPudelko.koszt)) as zysk
    from ( select idpudelka, p.cena as cena, sum(z.sztuk*c.koszt) as koszt
    from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki)
    group by idpudelka) zyskPudelko join artykuly a using (idpudelka) natural join zamowienia
    where datarealizacji = data
    group by idpudelka) zamowienia;
  return suma;
end;
$$
language plpgsql;

--11.3
--1
create or replace function sumaZamowien (klient integer)
returns numeric(7,2) as
$$
declare
suma numeric(7,2);

begin
  select sum(zamowienia.wartosc) into suma
  from (select idpudelka, sum(a.sztuk*p.cena) as wartosc
    from pudelka p natural join artykuly a natural join zamowienia z
    where idklienta = klient
    group by idpudelka) zamowienia;
  return suma;
end;
$$
language plpgsql;

--2
create or replace function rabat (klient integer)
returns integer as
$$
declare
rabat integer;

begin
select rabat.rabat into rabat
from(select case
  when zamowienia.suma >= 101 and zamowienia.suma < 201 then 4
  when zamowienia.suma >= 201 and zamowienia.suma < 401 then 7
  when zamowienia.suma >= 401 then 8
  else 0 end as rabat
  from (select sum(zamowienia.wartosc) as suma
  from (select idpudelka, sum(a.sztuk*p.cena) as wartosc
    from pudelka p natural join artykuly a natural join zamowienia z
    where idklienta = klient
    group by idpudelka) zamowienia) zamowienia) rabat;
  return rabat;
end;
$$
language plpgsql;

--11.4
create or replace function podwyzka () returns void as
$$
declare
   chocolate czekoladki%rowTYPE;

begin
   for chocolate in select * from czekoladki
   loop
      if chocolate.koszt < 0.2 then
         update czekoladki set koszt = chocolate.koszt + 0.03
         where idczekoladki = chocolate.idczekoladki;
      elseif chocolate.koszt >= 0.2 and chocolate.koszt <= 0.29 then
         update czekoladki set koszt = chocolate.koszt + 0.04
         where idczekoladki = chocolate.idczekoladki;
      else
         update czekoladki set koszt = chocolate.koszt + 0.05
         where idczekoladki = chocolate.idczekoladki;
      end if;
   end loop;
end;
$$
language plpgsql;


--11.6
--1
create or replace function podsumowanie(nr int, druzyna varchar , out mecze int , out srednia numeric ) as
$$
begin
select count (idmeczu), avg (punkty) into mecze, srednia
from siatkarki natural join punktujace
where numer = nr
and
iddruzyny = druzyna
group by
numer, iddruzyny;
end
$$
language
plpgsql;

