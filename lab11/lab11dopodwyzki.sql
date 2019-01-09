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
				
select * from klienci;
			
create or replace function sumaZamowien(idk integer) returns numeric(7,2) as
$$
declare
	wynik numeric(7,2);	
begin
	with
		cenaArtykulow as
			(select idzamowienia, sum(sztuk*cena) as cena
			from artykuly
				natural join pudelka
			group by  idzamowienia),
		cenaZamowien as
			(select idklienta, sum(cena) as wartosc
			from cenaArtykulow
				natural join zamowienia
			group by idklienta)
	select wartosc into wynik
	from cenaZamowien
	where idklienta = idk;
	
	return wynik;
end
$$
language plpgsql;
				
select sumaZamowien(2);
				
create or replace function rabat(idk integer) returns numeric(7,2) as
$$
declare
	wartoscZamowien numeric(7,2);
begin
	wartoscZamowien = sumaZamowien(idk);
	if wartoscZamowien >= 101 and wartoscZamowien <= 200 then
		return 0.04;
	elseif wartoscZamowien >= 201 and wartoscZamowien <= 400 then
		return 0.07;
	else
		return 0.08;
	end if;
end
$$
language plpgsql;
				
select rabat(3);

select * from czekoladki where idczekoladki like 'b01';
				
create or replace function podwyzka() returns boolean as
$$
begin
	update czekoladki
	set koszt = koszt + 0.03
	where koszt < 0.20;
	
	update czekoladki
	set koszt = koszt + 0.04
	where koszt >= 0.20 and koszt <= 0.29;
				
	update czekoladki
	set koszt = koszt + 0.05
	where koszt > 0.29;
	
	return true;
end
$$
language plpgsql;
				
select podwyzka();
