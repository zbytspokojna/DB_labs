Wyświetla nazwisko, wiek oraz roczne pobory pracownika posortowane wg poborów
 oraz nazwiska (pole pobory w tabeli pracownicy określa pobory miesięczne).

SELECT nazwisko,12*pobory as roczne FROM pracownicy ORDER BY pobory desc, nazwisko ASC;


Wyświetla nazwisko, imię, datę urodzenia, stanowisko, dział i pobory pracownika, który pracuje na stanowisku
 robotnik lub analityk i zarabia więcej niż 2000 miesięcznie.


SELECT * FROM pracownicy WHERE stanowisko in ('robotnik','analityk') and pobory >2000;


Wyświetla nazwiska i imiona pracowników, którzy zarabiają więcej niż zarabia Adam Kowalik.

SELECT * FROM pracownicy WHERE pobory > (select pobory from pracownicy where imie='Adam' and nazwisko = 'Kowalik');


Podnosi zarobki o 10% na stanowisku robotnik.


UPDATE testy.pracownicy SET pobory = 1.1*pobory WHERE stanowisko ='robotnik';

Oblicza średnie zarobki oraz ilość pracowników na poszczególnych stanowiskach z wyłączeniem stanowisk kierownik.


SELECT stanowisko, sum(pobory)/count(*) as avg, count(*) as ilosc  from pracownicy where stanowisko<>'kierownik' GROUP BY stanowisko;
