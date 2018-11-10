select count(idczekoladki)
from czekoladki
;

select count(czekoladki)
from czekoladki
where nadzienie is not null
;

select idpudelka, sum(sztuk)
from pudelka 
	natural join zawartosc
group by idpudelka
order by sum(sztuk) desc
limit 1
;

select idpudelka, sum(sztuk)
from pudelka 
	natural join zawartosc
	join czekoladki using(idczekoladki)
where orzechy is null
group by idpudelka
;

select idpudelka, sum(sztuk)
from pudelka 
	natural join zawartosc
	join czekoladki using(idczekoladki)
where czekolada = 'mleczna'
group by idpudelka
order by sum(sztuk)
;

select idpudelka, sum(zawartosc.sztuk * czekoladki.masa)
from pudelka
	natural join zawartosc
	join czekoladki using(idczekoladki)
group by idpudelka
;

select idpudelka, sum(zawartosc.sztuk * czekoladki.masa) as masaP
from pudelka
	natural join zawartosc
	join czekoladki using(idczekoladki)
group by idpudelka
order by masaP desc
;

with masyPudelek as
	(select idpudelka, sum(zawartosc.sztuk * czekoladki.masa) as masaP
	from pudelka
		natural join zawartosc
		join czekoladki using(idczekoladki)
	group by idpudelka
	order by masaP desc)
select round(avg(masaP),2) as srednia
from masyPudelek
;

select idpudelka,  sum( sztuk * masa ) / sum(sztuk) as srednia
from zawartosc
	natural join czekoladki
group by idpudelka
;

select datarealizacji, count(idzamowienia)
from zamowienia
group by datarealizacji
;

select count(idzamowienia)
from zamowienia
;

with kosztzamowien as
	(select idzamowienia, sum(artykuly.sztuk * pudelka.cena) as suma
	from zamowienia
		natural join artykuly
		natural join pudelka
	group by idzamowienia)
select sum(kosztzamowien.suma)
from kosztzamowien
;

with tabela as
	(select idklienta, idzamowienia,
		sum(artykuly.sztuk * pudelka.cena) as suma
	from klienci
		natural join zamowienia
		natural join artykuly
		join pudelka using(idpudelka)
	group by idklienta, idzamowienia)
select idklienta, count(idzamowienia), sum(suma)
from tabela
group by idklienta
order by idklienta
;

select idczekoladki, count(idpudelka) as wilupudelkach
from zawartosc
	natural join czekoladki
group by idczekoladki
order by 2 desc
limit 1
;

select idpudelka, count(idczekoladki)
from zawartosc
	natural join czekoladki
where orzechy is null
group by idpudelka
order by 2 desc
limit 1
;

select idczekoladki, count(idpudelka) as wilupudelkach
from zawartosc
	natural join czekoladki
group by idczekoladki
order by 2 asc
;

select idpudelka, sum(sztuk)
from pudelka
	natural join artykuly
group by idpudelka
order by 2 desc
;

select extract(quarter from datarealizacji), count(idzamowienia)
from zamowienia
group by 1
;

select extract(month from datarealizacji), count(idzamowienia)
from zamowienia
group by 1;

select extract(week from datarealizacji), count(idzamowienia)
from zamowienia
group by 1;

select miejscowosc, count(idzamowienia)
from klienci
	natural join zamowienia
group by 1;

with masyP as
	(select idpudelka, sum(zawartosc.sztuk * czekoladki.masa) as masaP
	from pudelka
		natural join zawartosc
		join czekoladki using(idczekoladki)
	group by idpudelka
	order by masaP desc)
select sum(masap)
from masyP
;

select sum(cena)
from pudelka
;

select idpudelka, cena - sum(koszt * sztuk) as zysk
from pudelka
	natural join zawartosc
	join czekoladki using(idczekoladki)
group by idpudelka, cena
order by zysk desc
;

with zyskZPudelek as
	(select idpudelka, cena - sum(koszt * sztuk) as zysk
	from pudelka
		natural join zawartosc
		join czekoladki using(idczekoladki)
	group by idpudelka, cena)
select sum(sztuk * zysk)
from artykuly natural join zyskZPudelek
;

with zyskZPudelek as 
	(select idpudelka, cena - sum(koszt * sztuk) as zysk
	from pudelka
		natural join zawartosc
		join czekoladki using(idczekoladki)
	group by idpudelka, cena)
select sum(zysk)
from zyskZPudelek
;

select row_number() over(), idpudelka
from pudelka
order by idpudelka
;
