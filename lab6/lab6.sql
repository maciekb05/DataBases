insert into czekoladki(idczekoladki, nazwa, czekolada, orzechy, nadzienie, opis, koszt, masa) values 
('W98', 'Biały kieł', 'biała', 'laskowe', 'marcepan', 'Rozpływające się w rękach i kieszeniach', 0.45, 20);

insert into klienci(idklienta, nazwa, ulica, miejscowosc, kod, telefon) values
(90, 'Matusiak Edward', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'),
(91, 'Matusiak Alina', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'),
(92, 'Kimono Franek', 'Karateków 8', 'Mistrz', '30-029', '501 498 324')
;

insert into klienci values(
93,
'Matusiak Iza',
(select ulica from klienci where nazwa = 'Matusiak Edward'),
(select miejscowosc from klienci where nazwa = 'Matusiak Edward'),
(select kod from klienci where nazwa = 'Matusiak Edward'),
(select telefon from klienci where nazwa = 'Matusiak Edward')
);

select * from klienci;
select * from czekoladki;

insert into czekoladki values
('X91', 'Nieznana Nieznajoma', null, null, null, 'Niewidzialna czekoladka wspomagająca odchudzanie.', 0.26, 0),
('M98', 'Mleczny Raj', 'mleczna', null, null, 'Aksamitna mleczna czekolada w kształcie butelki z mlekiem.', 0.26, 36);

delete from czekoladki where idczekoladki in ('X91', 'M98');

insert into czekoladki(idczekoladki, nazwa, czekolada, opis, koszt, masa) values
('X91', 'Nieznana Nieznajoma', null, 'Niewidzialna czekoladka wspomagająca odchudzanie.', 0.26, 0),
('M98', 'Mleczny Raj', 'mleczna', 'Aksamitna mleczna czekolada w kształcie butelki z mlekiem.', 0.26, 36);

update klienci
set nazwa = 'Nowak Iza'
where nazwa = 'Matusiak Iza'
;

update czekoladki
set koszt = koszt * 0.9
where idczekoladki in ('W98', 'M98', 'X91');

update czekoladki
set koszt = (select koszt from czekoladki where idczekoladki = 'W98')
where nazwa = 'Nieznana Nieznajoma';

update klienci
set miejscowosc = 'Piotrograd'
where miejscowosc = 'Leningrad';

update czekoladki
set koszt = koszt + 0.15
where idczekoladki similar to '%9(1|2|3|4|5|6|7|8|9)';

delete from klienci
where nazwa like 'Matusiak %';

delete from klienci
where idklienta > 91;

delete from czekoladki
where koszt >= 0.45 or masa = 36 or masa = 0;

select * from pudelka;
select * from zawartosc;

insert into pudelka values
('moje', 'Nowa odsłona', 'Czekoladki czekoladowe', 50.00, 900),
('twoj', 'Stare czekoladki', 'Czekoladki przeterminowane', 10.00, 200);

insert into zawartosc values
('moje', 'b02', 5),
('moje', 'm16', 2),
('moje', 'w03', 1),
('moje', 'd06', 4),
('twoj', 'b03', 3),
('twoj', 'm17', 3),
('twoj', 'w06', 3),
('twoj', 'd07', 3);

update zawartosc
set sztuk = sztuk + 1
where idpudelka in ('moje', 'twoj');

update czekoladki
set czekolada = 'brak'
where czekolada is null;

update czekoladki
set orzechy = 'brak'
where orzechy is null;

update czekoladki
set nadzienie = 'brak'
where nadzienie is null;

update czekoladki
set czekolada = null
where czekolada = 'brak';

update czekoladki
set orzechy = null
where orzechy = 'brak';

update czekoladki
set nadzienie = null
where nadzienie = 'brak';