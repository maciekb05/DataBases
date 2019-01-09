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

create or replace function rabatuj() returns trigger as
$$
declare
	s integer;															
begin
	update kwiaciarnia.zamowienia set cena = cena - rabat2(NEW.idklienta)*cena
	where idzamowienia = NEW.idzamowienia;
	
	update kwiaciarnia.kompozycje
	set stan = stan - 1
	where idkompozycji = NEW.idkompozycji;
														
	select into s stan from kwiaciarnia.kompozycje
	where idkompozycji = new.idkompozycji;
															
	if s = 1 then
	insert into kwiaciarnia.zapotrzebowanie
		values(new.idkompozycji, current_date);
	end if;															
															
	return null;
end;														
$$
language plpgsql;															
															
create trigger rabatuj 
after insert on kwiaciarnia.zamowienia
for each row execute procedure rabatuj();			

select * from kwiaciarnia.zamowienia;
															
insert into kwiaciarnia.zamowienia values
(4223414,'mbabik',1,'buk2',now(),100.00,true,'to moje');															
											
select * from kwiaciarnia.kompozycje;

select * from kwiaciarnia.zapotrzebowanie;															
															
create or replace function dostarcz() returns trigger as
$$
declare
	s integer;															
begin												
	select into s stan from kwiaciarnia.kompozycje
	where idkompozycji = new.idkompozycji;
															
	if s > 1 then
		delete from kwiaciarnia.zapotrzebowanie
		where idkompozycji = new.idkompozycji;															
	end if;															
															
	return null;
end;														
$$
language plpgsql;																
															
create trigger dostawa
after update on kwiaciarnia.kompozycje
for each row execute procedure dostarcz();	
															
update kwiaciarnia.kompozycje
set stan = 3
where idkompozycji = 'buk2';															
				