create or replace function innaNazwa() returns trigger as
$$
declare
	pudelko char(4);
	cenaPudelka integer;
	kosztPudelka integer;
	i smallint;
begin

	for pudelko in 
		select idpudelka
		from zawartosc
		where idczekoladki = new.idczekoladki 
	loop
		select into cenaPudelka cena
		from pudelka
		where idpudelka = pudelko;

		select into kosztPudelka sum(koszt*sztuk) + 0.9
		from zawartosc
		join czekoladki using(idczekoladki)
		where idpudelka = pudelko
		group by(idpudelka);

		if cenaPudelka < 1.05 * kosztPudelka then
			update pudelka
			set cena = cast(1.05 * kosztPudelka as numeric(7,2))
			where idpudelka = pudelko;
		end if;	
	end loop;
														   
	return null;
end;
$$
language plpgsql;

drop trigger oplacalnosc on czekoladki;													   
													   
create trigger oplacalnosc
after update on czekoladki
for each row execute procedure innaNazwa();

select * from czekoladki;
select * from pudelka;
select * from zawartosc;														   
													   
update czekoladki
set koszt = 0.48
where idczekoladki = 'd09';													   