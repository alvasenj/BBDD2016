
LOAD DATA
INFILE 'pedidos.txt'
APPEND
INTO TABLE PEDIDOS
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
codigoPedido "pedSEQ.nextval",
estado,
fecha_pedido "to_date(:fecha_pedido,'DD-MM-YY:HH24:MI')",
fecha_entrega "to_date(:fecha_entrega,'DD-MM-YY:HH24:MI')",
importeT,
DNI
)
