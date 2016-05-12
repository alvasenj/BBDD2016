create or replace procedure REVISA_PEDIDOS
IS

igual boolean := true;
rPedidos PEDIDOS%rowtype;
rContiene CONTIENE%rowtype;
vPrecioPedido number := 0;
vPrecio PLATOS.PRECIO%type;
vComision RESTAURANTES.COMISION%type;
vPrecioT CONTIENE.PRECIOT%type;


--Cursor para pedidos
cursor cPedidos is
SELECT * 
FROM PEDIDOS;

--Cursor para contiene
cursor cContiene is
SELECT *
FROM CONTIENE;

BEGIN
--Comprobamos la consistencia del precio en contiene con el del plato multiplicado por sus unidades.
for rContiene in cContiene loop

SELECT PRECIO into vPrecio
FROM PLATOS
WHERE NOMBRE = rContiene.NOMBRE;

SELECT COMISION into vComision
FROM RESTAURANTES
WHERE CODIGO = rContiene.CODIGO;

vPrecioT := vPrecio * vComision*0.01 + vPrecio;

if rContiene.PRECIOT != vPrecioT then
  igual := false;
  DBMS_OUTPUT.PUT_LINE('Datos modificados en el plato: '||rContiene.NOMBRE||rContiene.CODIGOPEDIDO);
  --Actualizamos en contiene el precio de los platos respecto a su nombre y multiplicándolos por sus uds.
  --En el caso de que no haya consistencia
  UPDATE CONTIENE 
  SET PRECIOT = vPrecio * vComision*0.01 + vPrecio
  WHERE CONTIENE.NOMBRE = rContiene.NOMBRE;
end if;

end loop;

--Comprobamos la consistencia del importe de los pedidos respecto de la tabla contiene
for rPedidos in cPedidos loop

SELECT SUM(PRECIOT*UDS) into vPrecioPedido
FROM CONTIENE 
WHERE CODIGOPEDIDO = rPedidos.CODIGOPEDIDO;

if vPrecioPedido != rPedidos.IMPORTET then
  igual := false; 
  DBMS_OUTPUT.PUT_LINE('Datos modificados en el pedido: '||rPedidos.CODIGOPEDIDO||' Nuevo importe: '||vPrecioPedido);
  --Actualizamos en caso de que no haya consistencia
  UPDATE PEDIDOS 
  SET IMPORTET = vPrecioPedido
  WHERE PEDIDOS.CODIGOPEDIDO = rPedidos.CODIGOPEDIDO;
end if;
end loop;


if igual then 
  DBMS_OUTPUT.PUT_LINE('Los datos son iguales');
end if;

END;

show errors;

/*Probamos a actualizar el precio de un plato y comprobamos la consistencia de los datos*/
UPDATE PLATOS 
SET PRECIO = '17,5'
WHERE PLATOS.NOMBRE = 'pizza arrabiata';
  
exec REVISA_PEDIDOS;