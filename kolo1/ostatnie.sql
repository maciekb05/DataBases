with ilosc as (
	select idklienta, nazwa, count(*) as ile
	from klienci 
		natural join zamowienia
		natural join kompozycje
	group by (idklienta, nazwa)
)
select idklienta, nazwa
from ilosc
where ile > (select ile from ilosc where idklienta =2)