DROP TABLE typ_skladnika;
DROP TABLE zawartosc_nalesnika;
DROP TABLE skladniki;
DROP TABLE dodatkowe_skladniki;
DROP TABLE kompozycje;
DROP TABLE bazowe_nalesniki;
DROP TABLE klienci;
DROP TABLE zamowienia;
DROP TABLE adresy;

BEGIN;

CREATE TABLE typ_skladnika (
    id_typ                 integer PRIMARY KEY,
    nazwa                  varchar(20),
    wegetarianski          boolean
);

CREATE TABLE bazowe_nalesniki (
    id_nalesnika           integer PRIMARY KEY,
    nazwa                  varchar(40),
    opis                   text,
    koszt                  numeric(7,2)
);

CREATE TABLE klienci (
    id_klienta             integer PRIMARY KEY,
    nazwa                  varchar(70),
    telefon                varchar(10)
);

CREATE TABLE skladniki (
    id_skladnika           integer PRIMARY KEY,
    nazwa                  varchar(40),
    koszt                  numeric(7,2),
    masa                   integer,
    id_typ                 integer references typ_skladnika
);

CREATE TABLE zawartosc_nalesnika (
    id_nalesnika           integer references bazowe_nalesniki,
    id_skladnika           integer references skladniki,
    PRIMARY KEY (id_nalesnika, id_skladnika)
);

CREATE TABLE adresy (
    id_adresu              char(4) PRIMARY KEY,
    id_klienta             integer references klienci,
    ulica                  varchar(50),
    numer_domu             integer,
    numer_mieszkania       integer
);

CREATE TABLE zamowienia (
    id_zamowienia          integer PRIMARY KEY,
    id_klienta             integer references klienci,
    data_realizacji        date,
    adres_realizacji       char(4) references adresy
);

CREATE TABLE kompozycje (
    id_kompozycji          integer PRIMARY KEY,
    id_bazowego_nalesnika  integer references bazowe_nalesniki,
    id_zamowienia          integer references zamowienia
);

CREATE TABLE dodatkowe_skladniki (
    id_kompozycji          integer references kompozycje,
    id_skladnika           integer references skladniki,
    PRIMARY KEY (id_kompozycji, id_skladnika)
);

copy klienci from stdin with (null '', delimiter '|');
1|Hłasko Regina|111222111
2|Pikowski Stefan|0121111111
3|Wandziak Wojciech|111222001
4|Wolski Wojciech|111222002
5|Wojak Mirosław|333000103
6|Górka Alicja|333000104
7|Moński Andrzej|0121111155
8|Sokół Antoni|232777900
9|Heroński Robert|232777907
10|Hłasko Regina|232777908
\.

copy adresy from stdin with (null '', delimiter '|');
1|1|Edwarda Bera|5|1
2|2|Wolna|3|1
3|3|Wolska|89|2
4|4|Gregorowa|3|1
5|5|Beringa|8|2
6|6|Stefanowska|35|1
7|7|Młyńska|3|
8|8|Akacjowa|3|
9|9|asztanowa|23|
10|10|Krucza|12|12
11|1|Rzeczna|44|22
12|2|Boczna|23|91
13|3|Krucza|12|43
\.

copy zamowienia from stdin with(null '', delimiter '|');
1|1|2015-10-01|11
2|3|2015-02-05|3
3|6|2015-02-12|6
4|9|2015-03-05|9
5|10|2015-12-19|10
6|2|2016-01-09|2
7|5|2016-01-12|5
8|1|2016-01-30|11
9|2|2016-02-28|2
10|3|2016-03-10|13
11|5|2016-05-22|5
12|6|2016-05-11|6
13|7|2016-05-01|7
14|8|2016-06-12|8
15|7|2016-06-17|7
16|5|2016-07-23|5
17|5|2016-07-29|5
18|1|2016-07-28|1
19|3|2016-07-21|3
20|8|2016-09-28|8
21|9|2016-10-29|9
22|5|2016-11-30|5
23|3|2013-12-31|3
\.

copy typ_skladnika from stdin with(null '', delimiter '|');
1|ważywa|true
2|owoce|true
3|mięso|false
4|ryba|false
5|inne|false
\.

copy skladniki from stdin with(null '', delimiter '|');
1|banan|0.5|20|2
2|szpinak|0.3|12|1
3|wołowina|2.1|77|3
4|kurczak|1.5|82|3
5|papryka|0.8|12|1
6|boczek|1.2|50|3
7|cyjanek|7.0|1|5
8|dorsz|3.3|80|4
9|dynamite|1.5|5|5
10|smalec|0.5|30|3
11|ołów|10.0|200|5
12|alkohol|17.0|50|5
13|truskawki|1.0|10|2
\.

copy bazowe_nalesniki from stdin with(null '', delimiter '|');
1|Bombowy naleśnik|Naleśnik z wybuchową mieszanką|10.5
2|Owocowy|Naleśnik z owocami|12.99
3|Wegański|Naleśnik dla frutarian|0.5
4|Z rybą|Naleśnik dla miłośników ryb|15.0
5|Dla prawdziwych mężczyzn|Samo mięso|20.0
6|Zabij się|Naleśnik dla ludzi którym życie nie miłe|90.01
7|Dla alkoholików|Alkohol pasuje do wszystkiego|17.0
8|Dla odchudzających się|Naleśnik z powietrzem|1.0
\.

copy zawartosc_nalesnika from stdin with(null '', delimiter '|');
1|7
1|9
1|11
2|1
3|2
3|5
4|8
4|10
5|3
5|4
5|6
5|10
6|7
6|11
6|12
7|12
\.

copy kompozycje from stdin with(null '', delimiter '|');
1|2|1
2|2|1
3|1|2
4|3|3
5|4|4
6|5|5
7|6|6
8|7|7
9|8|8
10|3|9
11|4|9
12|5|9
13|6|10
14|7|11
15|8|12
16|1|13
17|2|14
18|3|15
19|4|16
20|5|16
21|6|17
22|7|18
23|8|19
24|2|20
25|3|21
26|4|22
27|4|23
\.

copy dodatkowe_skladniki from stdin with(null '', delimiter '|');
1|1
1|2
1|3
1|4
2|13
3|2
4|12
5|3
6|11
7|4
8|10
9|5
10|9
11|6
12|8
13|7
14|12
15|1
16|3
17|11
18|7
19|8
20|3
21|6
22|12
23|1
24|5
25|9
26|11
27|3
\.

COMMIT;
