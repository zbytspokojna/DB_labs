DROP TABLE kwiaciarnia.klienci cascade;
DROP TABLE kwiaciarnia.zamowienia cascade;
DROP TABLE kwiaciarnia.odbiorcy cascade;
DROP TABLE kwiaciarnia.zapotrzebowanie cascade;
DROP TABLE kwiaciarnia.kompozycje cascade;
DROP TABLE kwiaciarnia.historia cascade;


--Data of clients
CREATE TABLE kwiaciarnia.klienci (
      id_klienta                  varchar(10) PRIMARY KEY,
      haslo                       varchar(10) not null check(haslo LIKE '____%'),
      nazwa                       varchar(40) not null,
      miasto                      varchar(40) not null,
      kod                         char(6) not null,
      adres                       varchar(40) not null,
      email                       varchar(40),
      telefon                     varchar(16) not null,
      fax                         varchar(16),
      nip                         char(13),
      regon                       char(9)
);


--Data of recipients
CREATE TABLE kwiaciarnia.odbiorcy (
      idodbiorcy                  serial PRIMARY KEY,
      nazwa                       varchar(40) not null,
      miasto                      varchar(40) not null,
      kod                         char(6) not null,
      adres                       varchar(40) not null
);

--Data of compositions
CREATE TABLE kwiaciarnia.kompozycje (
      idkompozycji                char(5) PRIMARY KEY,
      nazwa                       varchar(40) not null,
      opis                        varchar(100),
      cena                        numeric(7,2) check(cena >=40),
      minimum                     integer,
      stan                        integer
);

--Data of history
CREATE TABLE kwiaciarnia.historia (
      idzamowienia                integer PRIMARY KEY,
      idklienta                   varchar(10),
      idkompozycji                char(5),
      cena                        numeric(7,2),
      termin                      date
);

--Data of orders
CREATE TABLE kwiaciarnia.zamowienia (
      idzamowienia                integer PRIMARY KEY,
      idklienta                   varchar(10) not null references kwiaciarnia.klienci,
      idodbiorcy                  integer not null references kwiaciarnia.odbiorcy,
      idkompozycji                char(5) not null references kwiaciarnia.kompozycje,
      termin                      date not null,
      cena                        numeric(7,2),
      zapłacone                   boolean,
      uwagi                       varchar(200)
);

--Data of needs?
CREATE TABLE kwiaciarnia.zapotrzebowanie (
      idkompozycji                char(5) PRIMARY KEY references kwiaciarnia.kompozycje,
      data                        date
);
