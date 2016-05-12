LOAD DATA
INFILE 'descuentos.txt'
APPEND
INTO TABLE DESCUENTOS
FIELDS TERMINATED BY ';'(codigoD,fecha_caducidad "to_date(:fecha_caducidad,'DD-MM-YY:HH24:MI')",porcentaje_des)
