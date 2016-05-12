create or replace PROCEDURE PEDIDOS_CLIENTE(dni_cliente char)
IS

cursor cPedido is
select * 
from PEDIDOS
where DNI = dni_cliente
order by FECHA_PEDIDO ;

vDNI CLIENTES.DNI%TYPE;
vNombre CLIENTES.nombrecliente%TYPE;
vApellido CLIENTES.apellido%TYPE;
vTotal number := 0;
rPedidos PEDIDOS%ROWTYPE;

NO_PEDIDOS EXCEPTION;

BEGIN

SELECT DNI, NOMBRECLIENTE, APELLIDO INTO vDNI, vNombre, vApellido
FROM CLIENTES
WHERE DNI = dni_cliente;


DBMS_OUTPUT.PUT_LINE('  Cliente: '||vDNI||' '||vNombre||' '||vApellido);
DBMS_OUTPUT.PUT_LINE(' ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');

open cPedido;

LOOP
FETCH cPedido into rPedidos;
EXIT WHEN cPedido%NOTFOUND;

DBMS_OUTPUT.PUT_LINE('  Pedido: '||rPedidos.CODIGOPEDIDO||' Fecha del pedido: '||rPedidos.FECHA_PEDIDO||' Fecha de entrega: '||rPedidos.FECHA_ENTREGA||' Estado: '||rPedidos.ESTADO||' Importe: '||rPedidos.IMPORTET);
DBMS_OUTPUT.PUT_LINE(' ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
vTotal := vTotal + rPedidos.IMPORTET;

END LOOP;

IF cPedido%ROWCOUNT = 0 then raise NO_PEDIDOS;
END IF;

CLOSE cPedido;

DBMS_OUTPUT.PUT_LINE('  Total importe del cliente: '||vTotal);

EXCEPTION

WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No existen clientes con DNI: '||dni_cliente);

WHEN NO_PEDIDOS THEN
DBMS_OUTPUT.PUT_LINE('No existen pedidos para cliente con DNI: '||dni_cliente);


END;
/*Probamos a ejecutar este procedimiento con un DNI conocido*/
exec PEDIDOS_CLIENTE('12345678M');


/*Probamos a ejecutar este procedimiento con un DNI desconocido*/
INSERT INTO Clientes VALUES
('02307334C','Álvaro','Asenjo','Calle',3,'4B','Madrid','12345','12345612','alvaro','Asenjo');
exec PEDIDOS_CLIENTE('02307334C');



 