-- Napisz funkcję masaPudelka wyznaczającą masę pudełka jako sumę masy czekoladek w nim zawartych. 
-- Funkcja jako argument przyjmuje identyfikator pudełka. Przetestuj działanie funkcji na podstawie prostej instrukcji select.

create  or replace function masaPudelka(idPud char(4))
returns int as
$$
declare
w int;

begin
 SELECT sum(masa) into w  from zawartosc natural join czekoladki where idpudelka= idPud;
return w;
end;
$$
language plpgsql;


-- Napisz funkcję liczbaCzekoladek wyznaczającą liczbę czekoladek znajdujących się w pudełku.
-- Funkcja jako argument przyjmuje identyfikator pudełka. Przetestuj działanie funkcji na podstawie prostej instrukcji select.


CREATE OR REPLACE FUNCTION liczbaCzekoladek(idPud CHAR(4))
  RETURNS INT AS $$
DECLARE
  ilosc INT;

BEGIN
  SELECT sum(sztuk)
  INTO ilosc
  FROM zawartosc
  WHERE idpudelka = idPud;

  RETURN ilosc;
END;
$$
LANGUAGE plpgsql;
