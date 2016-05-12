LOAD DATA
INFILE 'platos.txt'
APPEND
INTO TABLE PLATOS
FIELDS TERMINATED BY ';'(codigo,nombre,precio,descripcion,categoria)

