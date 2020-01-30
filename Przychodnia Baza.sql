DROP TABLE pacjent;
Drop Table lekarz;
Drop TABLE choroba;
drop table recepta; 
drop table wizyta;
drop table gabinet;
drop table specjalizacja;

SELECT * FROM wizyta;
SELECT * FROM lekarz;
SELECT * FROM pacjent;
SELECT * FROM gabinet;
SELECT * FROM recepta;
SELECT * FROM choroba;
SELECT * FROM specjalizacja;


DELETE FROM wizyta where id_wizyta < 9999999;
DELETE FROM lekarz  where id_lekarz < 9999999;
DELETE FROM pacjent where id_pacjent < 9999999;
DELETE FROM gabinet where id_gabinet < 9999999;
DELETE FROM recepta where id_recepta < 9999999;
DELETE FROM choroba where id_choroba < 9999999;
DELETE FROM specjalizacja where id_specjalizacja < 9999999;


CREATE TABLE pacjent(
	id_pacjent NUMBER  NOT NULL PRIMARY KEY,
	imie VARCHAR2(255) NOT NULL,
	nazwisko VARCHAR2(255) NOT NULL,
    PESEL VARCHAR2(11) NOT NULL,
	data_urodzenia DATE,
	adres_zamieszkania VARCHAR2(255)
);

CREATE TABLE lekarz(
    id_lekarz NUMBER NOT NULL PRIMARY KEY,
    imie VARCHAR2(255) NOT NULL,
	nazwisko VARCHAR2(255) NOT NULL,
    data_urodzenia DATE,
	adres_zamieszkania VARCHAR2(255),
    PESEL VARCHAR2(11)
);

CREATE TABLE wizyta(
    id_wizyta NUMBER NOT NULL PRIMARY KEY,
    data_wizyty DATE,
    diagnoza VARCHAR2(255),
    id_recepta NUMBER,
    id_gabinet NUMBER NOT NULL,
    id_pacjent NUMBER NOT NULL,
    id_lekarz NUMBER NOT NULL,
    szczegoly VARCHAR2(255),
    FOREIGN KEY (id_gabinet) REFERENCES gabinet(id_gabinet),
    FOREIGN KEY (id_pacjent) REFERENCES pacjent(id_pacjent),
    FOREIGN KEY (id_lekarz) REFERENCES lekarz(id_lekarz),
    FOREIGN KEY (diagnoza) REFERENCES choroba(nazwa),
    FOREIGN KEY (id_recepta) REFERENCES recepta(id_recepta)
    );

CREATE TABLE gabinet(
    id_gabinet NUMBER NOT NULL PRIMARY KEY,
    numer_pokoju NUMBER
);

CREATE TABLE  choroba(
nazwa VARCHAR (255) PRIMARY KEY NOT NULL,
id_choroba NUMBER NOT NULL,
opis VARCHAR (255) NOT NULL
);

CREATE TABLE specjalizacja(
id_specjalizacja NUMBER  not null primary key,
nazwa VARCHAR(60)NOT NULL,
id_gabinet NUMBER not null,
id_lekarz NUMBER,
FOREIGN KEY(id_gabinet) REFERENCES gabinet(id_gabinet),
FOREIGN KEY(id_lekarz) REFERENCES lekarz(id_lekarz)
);


CREATE TABLE recepta(
id_recepta NUMBER not null primary key,
data_wystawienia DATE not null,
id_pacjent NUMBER not null,
FOREIGN KEY(id_pacjent) REFERENCES pacjent(id_pacjent)
); 
