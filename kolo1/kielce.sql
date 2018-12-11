set search_path to siatkowka;
Select idmeczu from mecze m
	 Join druzyny d on m.gospodarze = d.iddruzyny
	 Join statystyki s Using(idmeczu)	
	 Where
	 	miasto not Like 'Łódź'
	 And
	 	s.goscie is null;
