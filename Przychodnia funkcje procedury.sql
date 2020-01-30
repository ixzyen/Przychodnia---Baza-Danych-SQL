CREATE SEQUENCE lekarz_sekwencja minvalue 1 start with 1 cache 99999;
CREATE SEQUENCE recepta_sekwencja minvalue 1 start with 1 cache 99999;
CREATE SEQUENCE wizyta_sekwencja minvalue 1 start with 1 cache 99999;
CREATE SEQUENCE pacjent_sekwencja minvalue 1 start with 1 cache 99999;
CREATE SEQUENCE choroba_sekwencja minvalue 1 start with 1 cache 99999;

---------------------------------------------------------------------------------

CREATE OR REPLACE VIEW widokGrypa AS
SELECT pacjent.id_pacjent, pacjent.imie, pacjent.nazwisko, wizyta.diagnoza
FROM pacjent
LEFT OUTER JOIN wizyta
ON pacjent.id_pacjent = wizyta.id_pacjent
WHERE diagnoza = 'Grypa';

CREATE VIEW widokLekSpec AS
SELECT lekarz.id_lekarz, lekarz.imie, lekarz.nazwisko, specjalizacja.nazwa
FROM lekarz
LEFT OUTER JOIN spcjalizacja
ON lekarz.id_lekarz = specjalizacja.id_lekarz
WHERE specjalizacja = 'Pediatra';

---------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE  DodajWizyte(
    id_wizyta IN NUMBER,
    data_wizyty IN DATE,
    diagnoza IN VARCHAR2,
    id_recepta IN NUMBER,
    id_gabinet IN NUMBER,
    id_pacjent IN NUMBER,
    id_lekarz IN NUMBER,
    szczegoly VARCHAR2
)
IS
BEGIN
    INSERT INTO wizyta
    VALUES (id_wizyta, data_wizyty, diagnoza, id_recepta, id_gabinet, id_pacjent, id_lekarz, szczegoly);
END DodajWizyte;

execute DodajWizyte(wizyta_sekwencja.nextval,'2019-06-20', 'Grypa', 1, 1, 1, 1, NULL);

----------------------------------------------------------------------------------------------------------------------------
drop procedure DodajPacjenta;

CREATE OR REPLACE PROCEDURE DodajPacjenta(
    id_pacjent IN NUMBER,
	imie IN VARCHAR2,
	nazwisko IN VARCHAR2,
    PESEL IN VARCHAR2,
	data_urodzenia IN DATE,
	adres_zamieszkania IN VARCHAR2
)
IS  
BEGIN   
    INSERT INTO pacjent
    VALUES (id_pacjent, imie, nazwisko, PESEL, data_urodzenia, adres_zamieszkania);
END DodajPacjenta;

execute DodajPacjenta(pacjent_sekwencja.nextval, 'Jan', 'Kowalski', '12345678910', '1992-02-02', 'Grunwaldzka_2a');

----------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE DodajLekarza(
    id_lekarz IN NUMBER,
    imie IN VARCHAR2,
	nazwisko IN VARCHAR2,
    data_urodzenia IN DATE,
	adres_zamieszkania IN VARCHAR2,
    PESEL IN VARCHAR2
)
IS
BEGIN
    INSERT INTO lekarz
    VALUES (id_lekarz, imie, nazwisko, data_urodzenia, adres_zamieszkania, PESEL);
END DodajLekarza;

execute DodajLekarza (lekarz_sekwencja.nextval,'Jerzy', 'Mak', '1968-03-12', 'Królewiecka 18', '12312340981');

----------------------------------------------------------------------------------------------------------------------------
drop PROCEDURE DodajRecepte;

CREATE OR REPLACE PROCEDURE DodajRecepte(
    id_recepta IN NUMBER,
    data_wystawienia IN DATE,
    id_pacjent IN NUMBER
)
IS
BEGIN
    INSERT INTO recepta
    VALUES (id_recepta, data_wystawienia, id_pacjent);
END DodajRecepte;

EXECUTE DodajRecepte(RECEPTA_SEKWENCJA.nextval, '2019-06-20', 1);

-------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE DodajChorobe(
    nazwa IN VARCHAR2,
    id_choroba IN NUMBER,
    opis IN VARCHAR2
)
IS
BEGIN
    INSERT INTO choroba     
    VALUES (nazwa, id_choroba, opis);
END DodajChorobe;

execute DodajChorobe('Grypa', CHOROBA_SEKWENCJA.nextval, 'Grypa jaka jest ka¿dy widzi');

---------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION WyswietlLekarza(id_lekarz IN NUMBER)
RETURN VARCHAR2
IS szczegoly VARCHAR2(200);
BEGIN
SELECT imie || ' ' ||
nazwisko INTO szczegoly
FROM lekarz WHERE
lekarz.id_lekarz=id_lekarz;
RETURN(szczegoly);
END WyswietlLekarza;

-------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION WyswietlPacjenta(id_pacjent IN NUMBER)
RETURN VARCHAR2
IS szczegolyp VARCHAR2(200);
BEGIN
SELECT imie || ' ' ||
nazwisko INTO szczegolyp
FROM pacjent WHERE
pacjent.id_pacjent=id_pacjent;
RETURN(szczegolyp);
END WyswietlPacjenta;

-----------------------------------------------------------------------------------------------------------------------------

declare
cursor wizytaRecepta is
select * from wizyta 
where id_recepta is not null;
begin
open wizytaReceota
dbns_output.put_line
