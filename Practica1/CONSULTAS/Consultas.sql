
/*1--------------------------------------------------------------*/
SELECT *
FROM CLIENTES
ORDER BY apellido;
/*2--------------------------------------------------------------*/
SELECT DISTINCT NOMBRE, DIA_SEMANA, to_char(HORA_APERTURA, 'HH24:MI'), to_char(HORA_CIERRE, 'HH24:MI')
FROM RESTAURANTES NATURAL JOIN HORARIOS
ORDER BY NOMBRE;
/*3--------------------------------------------------------------*/
SELECT DISTINCT DNI, NOMBRECLIENTE, APELLIDO
FROM CLIENTES NATURAL JOIN PEDIDOS NATURAL JOIN CONTIENE NATURAL JOIN PLATOS
WHERE PLATOS.CATEGORIA = 'picante';
/*4--------------------------------------------------------------*/
SELECT  NOMBRECLIENTE, COUNT(CODIGO) AS PEDIDOS
FROM CLIENTES NATURAL JOIN PEDIDOS NATURAL JOIN CONTIENE 
group by NOMBRECLIENTE
HAVING COUNT(CODIGO) >= (SELECT COUNT(*) FROM RESTAURANTES);
/*5--------------------------------------------------------------*/
SELECT DISTINCT DNI, NOMBRECLIENTE, APELLIDO
FROM CLIENTES NATURAL JOIN PEDIDOS
WHERE ESTADO != 'ENTREGADO';
/*6--------------------------------------------------------------*/
SELECT *
FROM PEDIDOS
WHERE IMPORTET = (SELECT MAX(IMPORTET) FROM PEDIDOS);
/*7--------------------------------------------------------------*/
SELECT DISTINCT DNI,NOMBRECLIENTE, APELLIDO, to_char(AVG(IMPORTET), '99999999.99') AS MEDIA
FROM CLIENTES NATURAL JOIN PEDIDOS
GROUP BY DNI, NOMBRECLIENTE, APELLIDO;
/*8--------------------------------------------------------------*/
SELECT RESTAURANTES.CODIGO, RESTAURANTES.NOMBRE, COUNT(PLATOS.NOMBRE) AS PLATOS, SUM(PLATOS.PRECIO) AS TOTAL
FROM RESTAURANTES,CONTIENE,PLATOS
WHERE RESTAURANTES.CODIGO = CONTIENE.CODIGO AND CONTIENE.NOMBRE = PLATOS.NOMBRE
GROUP BY RESTAURANTES.CODIGO, RESTAURANTES.NOMBRE
ORDER BY RESTAURANTES.CODIGO;
/*9--------------------------------------------------------------*/
SELECT DISTINCT NOMBRECLIENTE, APELLIDO
FROM CLIENTES NATURAL JOIN PEDIDOS NATURAL JOIN CONTIENE NATURAL JOIN PLATOS
WHERE PRECIO > 15;
/*10--------------------------------------------------------------*/
SELECT CLIENTES.DNI, CLIENTES.NOMBRECLIENTE, CLIENTES.APELLIDO, COUNT(CP_AREAS_COBERTURA.CP) AS NUMERO
FROM CLIENTES,CP_AREAS_COBERTURA, RESTAURANTES
WHERE CLIENTES.CP = CP_AREAS_COBERTURA.CP AND CP_AREAS_COBERTURA.CODIGO = RESTAURANTES.CODIGO
group by  CLIENTES.DNI, CLIENTES.NOMBRECLIENTE, CLIENTES.APELLIDO
UNION( 
SELECT DNI, NOMBRECLIENTE, APELLIDO, 0 
FROM CLIENTES
WHERE CP NOT IN(SELECT CP FROM CP_AREAS_COBERTURA));

