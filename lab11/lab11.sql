create or replace function masaPudelka(idp char(4)) returns integer as 
$$
declare
	m integer;
begin 
	select sum(sztuk*masa) into m
	from zawartosc
		join czekoladki using(idczekoladki)
	where idpudelka = idp;
	return m;
end 
$$ 
language plpgsql;
													  
select masaPudelka('alpi');
												
create or replace function liczbaCzekoladek(idp char(4)) returns integer as 
$$
declare
	m integer;
begin 
	select sum(sztuk) into m
	from zawartosc
		join czekoladki using(idczekoladki)
	where idpudelka = idp;
	return m;
end 
$$ 
language plpgsql;
													 
select liczbaCzekoladek('alpi');
							
create or replace function zysk(idp char(4)) returns numeric(7,2) as 
$$
declare
	cenaPudelka numeric(7,2);
	cenaWytworzenia numeric(7,2);
begin
	select cena into cenaPudelka
	from pudelka
	where idpudelka = idp;
										 
	select sum(sztuk*koszt) into cenaWytworzenia
	from zawartosc
		join czekoladki using(idczekoladki)
	where idpudelka = idp;
										 
	return cenaPudelka - cenaWytworzenia - 0.9;
end 
$$ 
language plpgsql;

select zysk('alpi');										 
										 
select * from zamowienia;
										 
select sum(zysk(idpudelka))
from zamowienia
	natural join artykuly
where datarealizacji = '2013-10-30'
;


				
create or replace function sumaZamowien(idk integer) returns numeric(7,2) as
$$
declare
	wynik = numeric(7,2);	
begin
	with
		cenaArtykulow as
			(select idzamowienia, sum(sztuk*cena)
			from artykuly
				natural join pudelka
			group by  idzamowienia),
		cenaZamowien as
			(select idklienta, idzamowienia, sum())
end
$$
language plpgsql;