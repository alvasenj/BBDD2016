LOAD DATA
INFILE 'restaurantes.txt'
APPEND
INTO TABLE RESTAURANTES
FIELDS TERMINATED BY ';'(codigo,nombre,calle,cp,comision)


