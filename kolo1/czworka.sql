set search_path to siatkowka;
with czworka as (
	select idmeczu
	from siatkarki s
		join punktujace p using(numer, iddruzyny)
		natural join druzyny d
		natural join mecze m
	where
		extract(year from termin) = 2009
		and
		extract(month from termin) = 10
		and
		miasto like 'Łódź'
		and
		numer = 10
)
select imie, nazwisko, miasto, termin, punkty, idmeczu
from siatkarki s
	join punktujace p using(numer, iddruzyny)
	natural join druzyny d
	natural join mecze m
	natural join czworka
;

select * from punktujace order by numer;