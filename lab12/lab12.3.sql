begin

select * from zawartosc;

update zawartosc
set sztuk = 5
where idpudelka = 'alls' and idczekoladki = 'b02';

rollback
commit