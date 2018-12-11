SELECT DISTINCT nazwa 
FROM pudelka NATURAL JOIN zawartosc 
WHERE idczekoladki 
  IN (SELECT idczekoladki FROM czekoladki ORDER BY koszt LIMIT 3);
 
SELECT nazwa 
FROM czekoladki 
WHERE koszt = (SELECT MAX(koszt) FROM czekoladki);

SELECT p.nazwa, idpudelka 
FROM (SELECT idczekoladki 
	  FROM czekoladki 
	  ORDER BY koszt 
	  LIMIT 3) 
  AS ulubioneczekoladki 
NATURAL JOIN zawartosc 
NATURAL JOIN pudelka p;
 
SELECT nazwa, koszt, (SELECT MAX(koszt) 
					  FROM czekoladki) AS max 
FROM czekoladki;

select * from klienci;

select datarealizacji, idzamowienia 
from zamowienia
where idklienta in (select idklienta 
				   from klienci 
				   where nazwa like '%Antoni%')
;

select datarealizacji, idzamowienia
from zamowienia
where idklienta in (select idklienta
				   from klienci
				   where ulica like '%/%')
;

select datarealizacji, idzamowienia
from zamowienia
where idklienta in (select idklienta
				   from klienci
				   where miejscowosc like 'Kraków')
	and datarealizacji between '2013-11-01' and '2013-11-30'
;

select nazwa, ulica, miejscowosc
from klienci
where idklienta in (select idklienta
				   from zamowienia
				   where datarealizacji = '2013-11-12')
;

select nazwa, ulica, miejscowosc
from klienci
where idklienta in (select idklienta
				   from zamowienia
				   where datarealizacji
				   		between '2013-11-01'
				   			and '2013-11-30')
;

select nazwa, ulica, miejscowosc
from klienci
where idklienta in (select idklienta
				   from zamowienia
				   		natural join artykuly
				   		natural join pudelka
				   where nazwa like 'Kremowa fantazja'
				   		or nazwa like 'Kolekcja jesienna')
;

select nazwa, ulica, miejscowosc
from klienci
where idklienta in (select idklienta
				   from zamowienia
				   		natural join artykuly
				   		natural join pudelka
				   where (nazwa like 'Kremowa fantazja'
				   		or nazwa like 'Kolekcja jesienna')
						and sztuk >= 2)
;

select nazwa, ulica, miejscowosc
from klienci
where idklienta in (select idklienta
				   from zamowienia
				   		natural join artykuly
				   		natural join pudelka
						join zawartosc using (idpudelka)
						join czekoladki using (idczekoladki)
					where orzechy like 'migdały'
				   )
;

select nazwa, ulica, miejscowosc
from klienci
where idklienta in (select idklienta
				   from zamowienia)
;

select nazwa, ulica, miejscowosc
from klienci
where idklienta not in (select idklienta
					   from zamowienia)
;

select nazwa, opis, cena
from pudelka
where idpudelka in (select idpudelka
				   from zawartosc
				   where idczekoladki ilike 'D09')
;

select nazwa, opis, cena
from pudelka
where idpudelka in (select idpudelka
				   from zawartosc
				   		natural join czekoladki
				   where nazwa like 'Gorzka truskawkowa')
;

select nazwa, opis, cena
from pudelka
where idpudelka in (select idpudelka
				   from zawartosc
				   		natural join czekoladki
				   where nazwa like 'S%')
;

select nazwa, opis, cena
from pudelka
where idpudelka in (select idpudelka
				   from zawartosc
				   where sztuk >= 4)
;

select nazwa, opis, cena
from pudelka
where idpudelka in (select idpudelka
				   from zawartosc
						natural join czekoladki
				   where sztuk >= 3
				   		and nazwa like 'Gorzka truskawkowa')
;

select * from czekoladki;

select nazwa, opis, cena
from pudelka
where idpudelka in (select idpudelka
				   from zawartosc
				   		natural join czekoladki
				   where nadzienie like 'truskawki')
;

select nazwa, opis, cena
from pudelka
where idpudelka not in (select idpudelka
				   		from zawartosc
				   			natural join czekoladki
				   		where czekolada like 'gorzka')
;

select nazwa, opis, cena
from pudelka
where idpudelka not in (select idpudelka
						from zawartosc
							natural join czekoladki
						where orzechy is not null)
;

select nazwa, opis, cena
from pudelka
where idpudelka in (select idpudelka
				   from zawartosc
				   		natural join czekoladki
				   where nadzienie is null)
;

select idczekoladki, nazwa
from czekoladki
where koszt > (select koszt
			  from czekoladki
			  where idczekoladki = 'd08')
;

select distinct nazwa
from klienci
	natural join zamowienia
	natural join artykuly
where idpudelka in (select idpudelka
				   from artykuly
						natural join zamowienia
				   		natural join klienci
				   where nazwa like 'Górka Alicja')
;

select distinct nazwa, ulica, miejscowosc, kod
from klienci
	natural join zamowienia
	natural join zawartosc
where idpudelka in (select idpudelka
				   from zawartosc
				   		natural join zamowienia
				   		natural join klienci
				   where miejscowosc like 'Katowice')
;

select *
from pudelka
	natural join zawartosc
order by sztuk desc;

select *
from pudelka
	natural join zawartosc
where sztuk in (select idpudelka
				from (select idpudelka, sum(sztuk) 
						from pudelka 
						natural join zawartosc
					  	group by idpudelka)
				where sum(sztuk) = (select max(sum)
								   from )
;




