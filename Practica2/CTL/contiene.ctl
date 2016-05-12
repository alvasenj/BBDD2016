
LOAD DATA
INFILE 'contiene.txt'
APPEND
INTO TABLE CONTIENE
FIELDS TERMINATED BY ';'(codigo,nombre,codigoPedido,precioT,uds)
