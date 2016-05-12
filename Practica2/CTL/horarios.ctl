LOAD DATA
INFILE 'horarios.txt'
APPEND
INTO TABLE HORARIOS
FIELDS TERMINATED BY ';'(codigo,
						dia_semana,
						hora_apertura "to_date(:hora_apertura,'HH24:MI')",
						hora_cierre "to_date(:hora_cierre,'HH24:MI')")