LOAD DATA
INFILE 'clientes.txt'
APPEND
INTO TABLE CLIENTES
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS(DNI,nombreCliente,apellido,calle,numero,piso,localidad,cp,telefono,usuario,contrase)
