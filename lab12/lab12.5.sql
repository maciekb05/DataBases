select * from zamowienia;
select * from klienci;

create view nazwaWidoku as
select idzamowienia, datarealizacji, nazwa, ulica, miejscowosc, kod, telefon 
from zamowienia
	natural join klienci;
	
select * from nazwaWidoku;
