create or replace procedure DATOS_CLIENTES
IS

rClientes CLIENTES%rowtype;
vTotal number := 0;

--Cursor para clientes
cursor cClientes is
SELECT *
FROM CLIENTES;

BEGIN

for rClientes in cClientes loop

SELECT SUM(IMPORTET) into vTotal
FROM PEDIDOS
WHERE DNI = rClientes.DNI;

if vTotal > 0 then
  DBMS_OUTPUT.PUT_LINE('Cliente: '||rClientes.DNI||' '||rClientes.NOMBRECLIENTE||' Importe total de pedidos: '||vTotal);
  DBMS_OUTPUT.PUT_LINE(' ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
else 
  DBMS_OUTPUT.PUT_LINE('Cliente: '||rClientes.DNI||' '||rClientes.NOMBRECLIENTE||' Importe total de pedidos: '||0);
  DBMS_OUTPUT.PUT_LINE(' ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
end if;
end loop;
END;
  
exec DATOS_CLIENTES;