-- Napisz funkcję zwracającą informacje o zamówieniach złożonych przez klienta, którego identyfikator podawany jest 
-- jako argument wywołania funkcji. W/w informacje muszą zawierać: idzamowienia, idpudelka, datarealizacji. Przetestuj 
-- działanie funkcji. Uwaga: Funkcja zwraca więcej niż 1 wiersz!


CREATE TEMPORARY TABLE  IF NOT EXISTS cliInfo (
  zamowienie INTEGER,
  pudelka    CHAR(4),
  data       DATE
);
CREATE OR REPLACE FUNCTION clientInfo(id INTEGER)
  RETURNS SETOF cliInfo AS $$

BEGIN
  RETURN QUERY SELECT
                 idzamowienia,
                 idpudelka,
                 datarealizacji
               FROM zamowienia
                 NATURAL JOIN artykuly
               WHERE idklienta = id;
END;
$$

LANGUAGE plpgsql;



-- ★ Napisz funkcję zwracającą listę klientów z miejscowości, której nazwa podawana jest jako argument wywołania funkcji.
-- Lista powinna zawierać: nazwę klienta i adres. Przetestuj działanie funkcji.


CREATE OR REPLACE FUNCTION clientByLocation(miejsce VARCHAR(15))
  RETURNS TABLE(imie_nazw VARCHAR(130), adres VARCHAR(30)) AS $$

BEGIN
  RETURN QUERY SELECT
                 nazwa,
                 ulica
               FROM klienci
               WHERE miejscowosc = miejsce;
END;
$$
  LANGUAGE plpgsql;