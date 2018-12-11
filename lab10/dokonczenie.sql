select idpudelka, sum(sztuk)
	from pudelka
		natural join zawartosc
group by idpudelka
having sum(sztuk) = (select max(sum)
					from (select idpudelka, sum(sztuk) 
							from pudelka
								natural join zawartosc
							group by idpudelka) as max)
;

select idpudelka, sum(sztuk)
	from pudelka
		natural join zawartosc
group by idpudelka
having sum(sztuk) = (select min(sum)
					from (select idpudelka, sum(sztuk) 
							from pudelka
								natural join zawartosc
							group by idpudelka) as max)
;


select idpudelka, sum(sztuk)
	from pudelka
		natural join zawartosc
group by idpudelka
having sum(sztuk) > (select avg(sum)
					from (select idpudelka, sum(sztuk) 
							from pudelka
								natural join zawartosc
							group by idpudelka) as max)
;

select idpudelka, sum(sztuk)
	from pudelka
		natural join zawartosc
group by idpudelka
having sum(sztuk) = (select max(sum)
					from (select idpudelka, sum(sztuk) 
							from pudelka
								natural join zawartosc
							group by idpudelka) as max)
	or sum(sztuk) = (select min(sum)
					from (select idpudelka, sum(sztuk) 
							from pudelka
								natural join zawartosc
							group by idpudelka) as max)
;


select (select count(idpudelka)
	   from pudelka
	   where idpudelka <= p2.idpudelka), idpudelka
from pudelka p2
order by p2.idpudelka
;



