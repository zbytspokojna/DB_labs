DROP SCHEMA IF EXISTS kwiaciarnia CASCADE;
CREATE SCHEMA IF NOT EXISTS kwiaciarnia;

CREATE TABLE kwiaciarnia.klienci (
  idklienta VARCHAR(10) PRIMARY KEY,
  haslo     VARCHAR(10) CHECK (length(haslo) >= 4), /* PLAIN TEXT */
  nazwa     VARCHAR(40) NOT NULL,
  miasto    VARCHAR(40) NOT NULL,
  kod       VARCHAR(6)  NOT NULL,
  adres     VARCHAR(40) NOT NULL,
  email     VARCHAR(40) NOT NULL,
  telefon   VARCHAR(16) NOT NULL,
  fax       VARCHAR(16),
  nip       VARCHAR(13) CHECK (length(nip) = 13),
  regon     VARCHAR(9) CHECK (length(regon) = 9)
);

CREATE TABLE kwiaciarnia.kompozycje (
  idkompozycji CHAR(5) CHECK (length(idkompozycji) = 5) PRIMARY KEY,
  nazwa        VARCHAR(40) NOT NULL,
  opis         VARCHAR(100),
  cena         NUMERIC(7, 2) CHECK (cena >= 40.00),
  minimum      INTEGER,
  stan         INTEGER
);

CREATE TABLE kwiaciarnia.odbiorcy (
  idodbiorcy SERIAL PRIMARY KEY,
  nazwa      VARCHAR(40)                        NOT NULL,
  miasto     VARCHAR(40)                        NOT NULL,
  kod        VARCHAR(6) CHECK (length(kod) = 6) NOT NULL,
  adres      VARCHAR(40)                        NOT NULL
);

CREATE TABLE kwiaciarnia.zamowienia (
  idzamowienia INTEGER PRIMARY KEY,
  idklienta    VARCHAR(10) REFERENCES kwiaciarnia.klienci,
  idodbiorcy   INTEGER REFERENCES kwiaciarnia.odbiorcy,
  idkompozycji CHAR(5) CHECK (length(idkompozycji) = 5) REFERENCES kwiaciarnia.kompozycje,
  termin       DATE NOT NULL,
  cena         NUMERIC(7, 2),
  zaplacone    BOOLEAN,
  uwagi        VARCHAR(200)
);

CREATE TABLE kwiaciarnia.historia (
  idzamowienia INTEGER PRIMARY KEY,
  idklienta    VARCHAR(10),
  idkompozycji CHAR(5) CHECK (length(idkompozycji) = 5),
  cena         NUMERIC(7, 2),
  termin       DATE
);
CREATE TABLE kwiaciarnia.zapotrzebowanie (
  idkompozycji CHAR(5) CHECK (length(idkompozycji) = 5) PRIMARY KEY REFERENCES kwiaciarnia.kompozycje,
  data         DATE
);