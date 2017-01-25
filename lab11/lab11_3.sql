-- Napisz funkcję rabat obliczającą rabat jaki otrzymuje klient składający zamówienie.
-- Funkcja jako argument przyjmuje identyfikator klienta. Rabat wyliczany jest na podstawie
-- wcześniej złożonych zamówień w sposób następujący:
-- 4 % jeśli wartość zamówień jest z przedziału 101-200 zł;
-- 7 % jeśli wartość zamówień jest z przedziału 201-400 zł;
-- 8 % jeśli wartość zamówień jest większa od 400 zł.

-- Napisz funkcję sumaZamowien obliczającą łączną wartość zamówień złożonych przez klienta,
-- które czekają na realizację (są w tabeli Zamowienia). Funkcja jako argument przyjmuje
-- identyfikator klienta. Przetestuj działanie funkcji.


CREATE OR REPLACE FUNCTION sumaZamowien(idKli INT)
  RETURNS NUMERIC(7, 2) AS $$
DECLARE
  hajsy NUMERIC(7, 2);

BEGIN
  SELECT sum(sztuk * cena)
  INTO hajsy
  FROM zamowienia
    NATURAL JOIN artykuly
    NATURAL JOIN pudelka
  WHERE idklienta = idKli;
  RETURN hajsy;
END;

$$

LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION rabat(idKli INT)
  RETURNS NUMERIC(7, 2) AS $$

DECLARE
  suma NUMERIC(7, 2);

BEGIN
  suma := sumaZamowien(idKli);
  IF suma >= 101.00 AND suma < 201.00
  THEN RETURN 0.04 * suma;
  ELSEIF suma >= 201.00 AND suma < 400.00
    THEN RETURN 0.07 * suma;
  ELSEIF suma >= 401.00
    THEN RETURN 0.08 * suma;
  ELSE RETURN 0.00;
  END IF;

END;
$$


LANGUAGE plpgsql;