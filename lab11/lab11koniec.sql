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
				
create or replace function obnizka() returns boolean as
$$
begin
	update czekoladki
	set koszt = koszt - 0.03
	where koszt < 0.23;
	
	update czekoladki
	set koszt = koszt - 0.04
	where koszt >= 0.24 and koszt <= 0.33;
				
	update czekoladki
	set koszt = koszt - 0.05
	where koszt > 0.33;
	
	return true;
end
$$
language plpgsql;
				
select obnizka();
				
				
create or replace function infoZamowienia(idk integer)
returns table (f_idzamowienia integer, f_idpudelka char(4), f_datarealizacji date) as
$$
begin
	return query
	select idzamowienia, idpudelka, datarealizacji
	from zamowienia natural join artykuly
	where idklienta = idk;
end
$$
language plpgsql;
				
select *
from infoZamowienia(1);
				
				
				
create or replace function klienciMiejscowosc(nazwaMiejscowosci varchar(130))
returns table (f_nazwa varchar(130), f_ulica varchar(30), f_miejscowosc varchar(15), f_kod char(6)) as
$$
begin
	return query
	select nazwa, ulica, miejscowosc, kod
	from klienci
	where miejscowosc = nazwaMiejscowosci;
end
$$
language plpgsql;
				
select *
from klienciMiejscowosc('Kraków');
																								
																								
																								
create or replace function rabat2(idk varchar(10)) returns numeric(7,2) as
$$
declare
	wartoscZamowien numeric(7,2);
begin
	with
		zamowieniaBiezace as
			(select idklienta, sum(cena)
			from kwiaciarnia.zamowienia
			group by idklienta),
		zamowieniaHistoria as
			(select idklienta, sum(cena)
			from kwiaciarnia.historia
			where now() - termin < interval '12 years 7 days'
			group by idklienta)
	select sum(coalesce(zamowieniaBiezace.sum,0) + coalesce(zamowieniaHistoria.sum,0)) into wartoscZamowien
	from zamowieniaBiezace left join zamowieniaHistoria using(idklienta)
	where idklienta = idk
	group by idklienta
	;
																								
	if wartoscZamowien >= 0 and wartoscZamowien <= 100 then
		return 0.05;
	elseif wartoscZamowien >= 101 and wartoscZamowien <= 400 then
		return 0.1;
	elseif wartoscZamowien >= 401 and wartoscZamowien <= 700 then
		return 0.15;
	else
		return 0.2;
	end if;
end
$$
language plpgsql;
				
select rabat2('dniemcz');
											  
select * from kwiaciarnia.klienci;											  