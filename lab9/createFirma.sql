create table firma.dzialy (
	iddzialu char(5) primary key,
	nazwa varchar(32) not null,
	lokalizacja varchar(24) not null,
	kierownik integer
);

create table firma.pracownicy (
	idpracownika integer primary key,
	nazwisko varchar(32) not null,
	imie varchar(16) not null,
	dataUrodzenia date not null,
	dzial char(5) not null,
	stanowisko varchar(24),
	pobory numeric(12,2)
);

alter table firma.dzialy add constraint dzial_fk foreign key(kierownik) 
  references firma.pracownicy(idpracownika) on update cascade deferrable;
  
alter table firma.pracownicy add constraint pracownik_fk foreign key(dzial) 
  references firma.dzialy(iddzialu) on update cascade deferrable;