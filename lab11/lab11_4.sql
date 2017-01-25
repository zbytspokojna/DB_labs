-- Napisz bezargumentową funkcję podwyzka, która dokonuje podwyżki kosztów produkcji czekoladek o:
--
-- 3 gr dla czekoladek, których koszt produkcji jest mniejszy od 20 gr;
-- 4 gr dla czekoladek, których koszt produkcji jest z przedziału 20-29 gr;
-- 5 gr dla pozostałych.
-- Funkcja powinna ponadto podnieść cenę pudełek o tyle o ile zmienił się koszt produkcji zawartych w nich czekoladek.
--
-- Przed testowaniem działania funkcji wykonaj zapytania, które umieszczą w plikach dane na temat kosztów czekoladek
-- i cen pudełek tak, aby można było później sprawdzić poprawność działania funkcji podwyzka. Przetestuj działanie funkcji.


CREATE OR REPLACE FUNCTION kwota_podwyzki(kosztCurr NUMERIC(7, 2))
  RETURNS NUMERIC(7, 2) AS $$
BEGIN
  IF kosztCurr < 0.20
  THEN RETURN 0.03;
  ELSEIF kosztCurr BETWEEN 0.20 AND 0.29
    THEN RETURN 0.04;
  ELSE RETURN 0.05;
  END IF;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION updater(czekoladka czekoladki, podwyzka NUMERIC(7, 2))
  RETURNS VOID AS $$
DECLARE
  zaw zawartosc%ROWTYPE;
BEGIN
  FOR zaw IN SELECT *
             FROM zawartosc
             WHERE idczekoladki = czekoladka.idczekoladki
  LOOP
    UPDATE pudelka
    SET cena = cena + podwyzka * zaw.sztuk
    WHERE idpudelka = zaw.idpudelka;
  END LOOP;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION podwyzka()
  RETURNS VOID AS
$$
DECLARE
  czekoladka czekoladki%ROWTYPE;
BEGIN
  FOR czekoladka IN SELECT *
                    FROM czekoladki
                    ORDER BY koszt DESC
  LOOP
    UPDATE czekoladki
    SET koszt = koszt + kwota_podwyzki(czekoladka.koszt)
    WHERE idczekoladki = czekoladka.idczekoladki;
    PERFORM updater(czekoladka, kwota_podwyzki(czekoladka.koszt));
  END LOOP;
END
$$
LANGUAGE plpgsql;