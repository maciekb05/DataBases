select nazwa, ulica, miejscowosc, count(idzamowienia)
from klienci 
	natural join zamowienia 
where idzamowienia is not null
group by nazwa, ulica, miejscowosc
order by nazwa
;

select nazwa, ulica, miejscowosc, idzamowienia
from klienci left join zamowienia 
	on klienci.idklienta = zamowienia.idklienta
;

select idzamowienia from zamowienia;

select nazwa, ulica, miejscowosc, datarealizacji
from klienci natural join zamowienia 
where date_part('month', datarealizacji) = 11;
;

select klienci.nazwa, ulica, miejscowosc, pudelka.nazwa, datarealizacji, sztuk
from klienci
	natural join zamowienia
	natural join artykuly
	join pudelka using(idpudelka)
where pudelka.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna')
	and sztuk >= 2
;

select distinct(klienci.nazwa), ulica, miejscowosc, orzechy
from klienci
	natural join zamowienia
	natural join artykuly
	join pudelka using(idpudelka)
	join zawartosc using(idpudelka)
	join czekoladki using(idczekoladki)
where orzechy = 'migda³y'
;

select pudelka.nazwa, pudelka.opis, czekoladki.nazwa, czekoladki.opis
from pudelka 
	natural join zawartosc
	join czekoladki using(idczekoladki)
where pudelka.idpudelka like 'heav'	
;

select pudelka.nazwa, pudelka.opis, cena, idczekoladki
from pudelka
	natural join zawartosc
	join czekoladki using(idczekoladki)
where idczekoladki = 'd09'
;

select distinct(pudelka.nazwa), pudelka.opis, cena
from pudelka
	natural join zawartosc
	join czekoladki using(idczekoladki)
where czekoladki.nazwa like 'S%'
;

select distinct(pudelka.nazwa), pudelka.opis, cena, sztuk, czekoladki.nazwa
from pudelka
	natural join zawartosc
	join czekoladki using(idczekoladki)
where sztuk > 4
;


select distinct(pudelka.nazwa), pudelka.opis, cena
from pudelka
	natural join zawartosc
	join czekoladki using(idczekoladki)
except
select distinct(pudelka.nazwa), pudelka.opis, cena
from pudelka
	natural join zawartosc
	join czekoladki using(idczekoladki)
where czekoladki.czekolada = 'gorzka'
;

select pudelka.nazwa, pudelka.opis, cena, czekoladki.nazwa, sztuk
from pudelka
	natural join zawartosc
	join czekoladki using(idczekoladki)
where czekoladki.nazwa like 'Gorzka truskawkowa'
	and zawartosc.sztuk >= 4
;

select pudelka.nazwa, pudelka.opis, cena, count(czekoladki.orzechy)
from pudelka
	natural join zawartosc
	join czekoladki using(idczekoladki)
group by (pudelka.nazwa, pudelka.opis, cena)
having count(czekoladki.orzechy) = 0
order by pudelka.nazwa
;

select pudelka.nazwa, pudelka.opis, cena, czekoladki.nazwa
from pudelka
	natural join zawartosc
	join czekoladki using(idczekoladki)
where czekoladki.nazwa like 'Gorzka truskawkowa'
;

select distinct(pudelka.nazwa), pudelka.opis, 
	cena, czekoladki.nadzienie
from pudelka
	natural join zawartosc
	join czekoladki using(idczekoladki)
where czekoladki.nadzienie is null
;

select * from czekoladki;

select c1.idczekoladki, c1.nazwa, c1.koszt, 
	c2.idczekoladki, c2.nazwa, c2.koszt
from czekoladki c1 join czekoladki c2 on c2.idczekoladki = 'd08'
where c1.koszt > c2.koszt
;

with pudelkawszystkich as 
(
	select klienci.nazwa as nazwaKlienta, pudelka.nazwa as nazwaPudelka
	from klienci
		natural join zamowienia
		natural join artykuly
		join pudelka using(idpudelka)
)
, pudelkaalicji as
(
	select klienci.nazwa as nazwaKlienta, pudelka.nazwa as nazwaPudelka
	from klienci
		natural join zamowienia
		natural join artykuly
		join pudelka using(idpudelka)
	where klienci.nazwa = 'Górka Alicja'
)
select distinct(pudelkawszystkich.nazwaKlienta)
from pudelkawszystkich join pudelkaalicji using(nazwapudelka)
order by pudelkawszystkich.nazwaKlienta
;

with klienciwszyscy as
(
	select klienci.nazwa as nazwaKlienta, klienci.miejscowosc as miejscowoscKlienta, pudelka.nazwa as nazwaPudelka
	from klienci
		natural join zamowienia
		natural join artykuly
		join pudelka using(idpudelka)
)
, kliencikatowice as
(
	select klienci.nazwa as nazwaKlienta, klienci.miejscowosc as miejscowoscKlienta, pudelka.nazwa as nazwaPudelka
	from klienci
		natural join zamowienia
		natural join artykuly
		join pudelka using(idpudelka)
	where klienci.miejscowosc = 'Katowice'
)
select distinct(klienciwszyscy.nazwaKlienta), klienciwszyscy.miejscowoscKlienta
from klienciwszyscy join kliencikatowice using(nazwapudelka)
order by klienciwszyscy.nazwaKlienta
;


