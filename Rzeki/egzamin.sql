--A.1 modified
Podaj instrukcje wyswietlajaca nazwy rzek, które przepływaja przez Województwo Kujawsko-pomorskie (tj. na terenie tego województwa maja zlokalizowane punkty pomiarowe) i które nie przekroczyły stanu alarmowego w zadnym swoim punkcie pomiarowym na terenie tego województwa w lutym 2016 r.

select r.nazwa, pm.id_pomiaru, pm.poziom_wody, pp.stan_alarmowy
from wojewodztwa w join powiaty p using (identyfikator) join gminy g using (identyfikator) join punkty_pomiarowe pp on g.identyfikator = pp.id_gminy join rzeki r using (id_rzeki) join pomiary pm using (id_punktu)
where w.nazwa like 'kujawsko-pomorskie' and pm.czas_pomiaru::text similar to '2016-02-%' and pm.poziom_wody <= pp.stan_alarmowy
order by 2;

--A.2
create or replace function fn_dodaj_ostrzezenie() returns trigger as
$$
  declare
    ostrzezenie integer;
    alarm integer;
    numer integer;
    stary integer;
    zmiana numeric (3,2);
    
  begin
    select into ostrzezenie stan_ostrzegawczy from punkty_pomiarowe
    where id_punktu = new.id_punktu;
				
    select into alarm stan_alarmowy from punkty_pomiarowe
    where id_punktu = new.id_punktu;
		
    select into numer count(*) + 1 from ostrzezenia;
		
    select into stary max(id_pomiaru) from pomiary
    where id_punktu = new.id_punktu and id_pomiaru < new.id_pomiaru;
		
    select into zmiana ((new.poziom_wody-poziom_wody)/poziom_wody::float) from pomiary
    where id_pomiaru = stary;
		
    if new.poziom_wody > ostrzezenie then
      insert into ostrzezenia
      values(numer, new.id_punktu, new.czas_pomiaru, new.poziom_wody - ostrzezenie, null, zmiana);
    end if;
		
		if new.poziom_wody > alarm then
      update ostrzezenia set przekroczony_stan_alarm = new.poziom_wody - alarm
      where id_ostrzezenia = numer;
    end if;
		
    return null;
  end;
$$
language plpgsql;

create trigger tr_dodaj_ostrzezenie after insert on pomiary
for each row execute procedure fn_dodaj_ostrzezenie();

insert into pomiary values (121,40,TIMESTAMP '2017-02-21 22:01:59',360);

--A.3
create role adam login;
create role ewa login;
create role karol login;
create role dzial_pomiarow;
grant dzial_pomiarow to adam, ewa, karol;
revoke all privileges on pomiary, ostrzezenia from adam;
revoke all privileges on pomiary, ostrzezenia from ewa;
revoke all privileges on pomiary, ostrzezenia from karol;
grant select, update, insert, delete on pomiary, ostrzezenia to dzial_pomiarow;

--B.1
select alarm.ilosc, alarm.data
from (select count(*) ilosc, czas_ostrzezenia::date as data
  from ostrzezenia
  where przekroczony_stan_alarm is not null and czas_ostrzezenia::text similar to '2017-%'
  group by data) alarm
where alarm.ilosc = (select max(alarm.ilosc)
                     from (select count(*) ilosc, czas_ostrzezenia::date as data
                       from ostrzezenia
                       where przekroczony_stan_alarm is not null and czas_ostrzezenia::text similar to '2017-%'
                       group by data) alarm);

--B.2
create or replace function czas_ostrzezenia(idpunktu integer, flaga boolean) returns interval as
$$
  declar
    dlugosc interval;
    ostrzezenie integer;
    last_ostrzezenie record;
    pomiar integer;
    pomiar_before integer;
    
  begin
    --last warning for point
    select into ostrzezenie max(id_ostrzezenia)
    from ostrzezenia
    where id_punktu = idpunktu;
		
		--geting record of last warning
		select * into last_ostrzezenie
		from ostrzezenia
		where id_ostrzezenia = ostrzezenie;
		
		if flaga = true then
		  if last_ostrzezenie.przekroczony_stan_alarm is null then
		    select 0 into dlugosc
		  else
		    
		    
		  end if;
		end if;
		
		if flaga = false then
		  if last_ostrzezenie.przekroczony_stan_alarm is null then
		    select 0 into dlugosc
		  else
		    select into stary max(id_pomiaru) from pomiary
          where id_punktu = punkt and id_pomiaru < pomiar;
		    
		  end if; 
		end if;
		 
    return dlugosc;
  end;
$$
language plpgsql;

--B.2 v2 testowane na tej bazie, która była na wiki

create or replace function czas_ostrzezenia(idpunktu integer, flaga boolean)
returns interval as
$$
declare
  czas timestamp;
begin
  if flaga then
    select czas_ostrzezenia into czas
    from ostrzezenia
    where id_punktu = idpunktu
    order by czas_ostrzezenia desc limit 1;

    if czas = null then return interval '0' ; end if;
    if (select przekreczony_stan_alarm
      from ostrzezenia
      where id_punktu = idpunktu
      order by czas_ostrzezenia desc limit 1) is null
      then return interval '0' ; end if;

    return now() - czas;

  else
    select czas_ostrzezenia into czas
    from ostrzezenia
    where id_punktu = idpunktu
    order by czas_ostrzezenia desc limit 1;

    if czas = null then return interval '0' ; end if;
    if (select przekreczony_stan_alarm
      from ostrzezenia
      where id_punktu = idpunktu
      order by czas_ostrzezenia desc limit 1) is not null
      then return interval '0' ; end if;

    return now() - czas;
  end if;
end;
$$
language plpgsql;

                   
--B.3 modified to Wisła not San
create or replace function dodaj_ostrzezenie(rzeka text) returns void as
$$
  declare
    punkt integer;
    pomiar integer;
    last_pomiar record;    
    ostrzezenie integer;
    alarm integer;
    numer integer;
    stary integer;
    zmiana numeric (3,2);
    
  begin
    --get the point id
    select into punkt max(id_punktu)
    from punkty_pomiarowe natural join rzeki
    where rzeki.nazwa = rzeka;
  
    --get measure id
    select into pomiar max(id_pomiaru)
    from pomiary
    where id_punktu = punkt;
  
    --get record
    select * into last_pomiar
    from pomiary
    where id_pomiaru = pomiar;
  
    --get ostrzez
    select into ostrzezenie stan_ostrzegawczy from punkty_pomiarowe
    where id_punktu = punkt;
				
		--get alarm		
    select into alarm stan_alarmowy from punkty_pomiarowe
    where id_punktu = punkt;
		
		--get next number for otrzezenie
    select into numer count(*) + 1 from ostrzezenia;
		
		--get measure before the last one
    select into stary max(id_pomiaru) from pomiary
    where id_punktu = punkt and id_pomiaru < pomiar;
		
    select into zmiana ((last_pomiar.poziom_wody-poziom_wody)/poziom_wody::float) from pomiary
    where id_pomiaru = stary;
		
    if last_pomiar.poziom_wody > ostrzezenie then
      insert into ostrzezenia
      values(numer, last_pomiar.id_punktu, last_pomiar.czas_pomiaru, last_pomiar.poziom_wody - ostrzezenie, null, zmiana);
    end if;
		
		if last_pomiar.poziom_wody > alarm then
      update ostrzezenia set przekroczony_stan_alarm = last_pomiar.poziom_wody - alarm
      where id_ostrzezenia = numer;
    end if;
  end;
$$
language plpgsql;

select dodaj_ostrzezenie('Wisła');
