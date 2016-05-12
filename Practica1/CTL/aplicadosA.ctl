LOAD DATA
INFILE 'aplicadosA.txt'
APPEND
INTO TABLE AplicadosA
FIELDS TERMINATED BY ';'( codigoD, codigoPedido)