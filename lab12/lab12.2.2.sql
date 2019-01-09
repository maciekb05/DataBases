create or replace function nazwa() returns trigger as
$$
declare
	cenaPudelka integer;
	kosztPudelka integer;
begin
	select into cenaPudelka cena
	from pudelka
	where idpudelka = new.idpudelka;

	select into kosztPudelka sum(koszt*sztuk) + 0.9
	from zawartosc
	join czekoladki using(idczekoladki)
	where idpudelka = new.idpudelka
	group by(idpudelka);
	
	if cenaPudelka < 1.05 * kosztPudelka then
		update pudelka
		set cena = cast(1.05 * kosztPudelka as numeric(7,2))
		where idpudelka = new.idpudelka;
	end if;

	return null;
end;
$$
language plpgsql;

drop trigger oplacalnosc on zawartosc;													   
													   
create trigger oplacalnosc
after insert or update on zawartosc
for each row execute procedure nazwa();

select * from zawartosc;
select * from pudelka;
													   
update zawartosc 
set sztuk = 11
where idpudelka = 'nort' and idczekoladki = 'm05';