select idczekoladki, masa, koszt
from czekoladki
where masa between 25 and 35 
	and koszt not between 0.15 and 0.24
	and koszt not between 0.25 and 0.35
;