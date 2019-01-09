create or replace function sprawdzOplacalnosc() returns trigger as
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
		return (new.idpudelka, new.nazwa, new.opis, cast(1.05 * kosztPudelka as numeric(7,2)), new.stan);
	end if;

	return null;
end;
$$
language plpgsql;

drop trigger oplacalnosc on pudelka;

create trigger oplacalnosc
before update on pudelka
for each row execute procedure sprawdzOplacalnosc();

update pudelka
set cena = 5.0
where idpudelka = 'nort';

select * from pudelka;														 