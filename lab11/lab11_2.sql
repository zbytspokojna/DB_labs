-- Napisz funkcję zysk obliczającą zysk jaki cukiernia uzyskuje ze sprzedaży
-- jednego pudełka czekoladek, zakładając, że zysk ten jest różnicą między
-- ceną pudełka, a kosztem wytworzenia zawartych w nim czekoladek i kosztem
-- opakowania (0,90 zł dla każdego pudełka). Funkcja jako argument przyjmuje
-- identyfikator pudełka. Przetestuj działanie funkcji na podstawie prostej
-- instrukcji select.


CREATE OR REPLACE FUNCTION zyskSprzedazy(idPud CHAR(4))
  RETURNS NUMERIC(7, 2) AS $$
DECLARE
  cenaPudelka     NUMERIC(7, 2);
  kosztCzekoladek NUMERIC(7, 2);

BEGIN
  SELECT cena
  INTO cenaPudelka
  FROM pudelka
  WHERE idpudelka = idPud;

  SELECT sum(sztuk * koszt)
  INTO kosztCzekoladek
  FROM zawartosc
    NATURAL JOIN czekoladki
  WHERE idpudelka = idPud;

  RETURN cenaPudelka - kosztCzekoladek - 0.90;
END;
$$

LANGUAGE plpgsql;

-- Napisz instrukcję select obliczającą zysk jaki cukiernia uzyska ze sprzedaży pudełek zamówionych w wybranym dniu.


CREATE OR REPLACE FUNCTION zyskDnia(dzien DATE)
  RETURNS NUMERIC(7, 2) AS $$
DECLARE zysk NUMERIC(7, 2);
BEGIN
  SELECT sum(sztuk * zyskSprzedazy(idpudelka))
  INTO zysk
  FROM zamowienia
    NATURAL JOIN artykuly
  WHERE datarealizacji = dzien;
  RETURN zysk;
END;


$$
LANGUAGE plpgsql;


