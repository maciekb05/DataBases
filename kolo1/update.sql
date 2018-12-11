set search_path to siatkowka;

update punktujace set punkty=22
	where
		punktujace.iddruzyny = (select iddruzyny from druzyny where druzyny.miasto like 'Łódź')
	and
		idmeczu=6
	and
		numer=10;
		
select * from punktujace natural join mecze where punkty=22;