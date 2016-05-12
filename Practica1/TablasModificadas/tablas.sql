
drop table RESTAURANTES cascade constraints;
drop table CP_AREAS_COBERTURA cascade constraints;
drop table PLATOS cascade constraints;
drop table HORARIOS cascade constraints;
drop table DESCUENTOS cascade constraints;
drop table CLIENTES cascade constraints;
drop table CONTIENE cascade constraints;
drop table PEDIDOS cascade constraints;
drop table AplicadosA cascade constraints;
drop SEQUENCE pedSEQ;

create sequence pedSEQ   INCREMENT BY 1 START WITH 1
NOMAXVALUE;

/*  TABLAS  */


CREATE TABLE Restaurantes(
  codigo NUMBER(8) NOT NULL,
  nombre CHAR(20) NOT NULL,
  calle CHAR(30) NOT NULL,
  cod_postal CHAR(5) NOT NULL,
  comision NUMBER(8,2),
  PRIMARY KEY(codigo)
);

CREATE TABLE CP_AREAS_COBERTURA(
  codigo_R NUMBER(8) NOT NULL, 
  cp_areas CHAR(5) NOT NULL,
  CONSTRAINT areas_FK FOREIGN KEY(codigo_R) REFERENCES Restaurantes ON DELETE CASCADE
);


CREATE TABLE Platos(
  codigo_Re NUMBER(8) NOT NULL,
  nombre CHAR(20) NOT NULL,
  precio NUMBER(8,2),
  descripcion CHAR(30),
  categoria char(20),
  PRIMARY KEY(codigo_Re, nombre),
  CONSTRAINT Platos_FK FOREIGN KEY (codigo_Re) REFERENCES Restaurantes(codigo) ON DELETE CASCADE
);

CREATE INDEX I_CatPlatos ON Platos(categoria);



CREATE TABLE Horarios(
  codigo_Res NUMBER(8),
  dia_semana  char(1) NOT NULL,
  hora_apertura DATE NOT NULL,
  hora_cierre DATE NOT NULL,
  PRIMARY KEY(codigo_Res, dia_semana),
  CONSTRAINT Horarios_FK FOREIGN KEY (codigo_Res) REFERENCES Restaurantes(codigo) ON DELETE CASCADE
);



CREATE TABLE Descuentos(
  codigoD NUMBER(8) NOT NULL,
  fecha_caducidad DATE,
  porcentaje_des NUMBER(3) CHECK (porcentaje_des >0 AND porcentaje_des <=100),
  PRIMARY KEY(codigoD)
);



CREATE TABLE Clientes(
  DNI CHAR(9) NOT NULL,
  nombreCliente CHAR(20) NOT NULL,
  apellido CHAR(20) NOT NULL,
  calle CHAR(20),
  numero NUMBER(4),
  piso CHAR(5),
  localidad CHAR(15),
  cp CHAR(5),
  telefono CHAR(9),
  usuario CHAR(8),
  contrase CHAR(8) DEFAULT 'Nopass',
  PRIMARY KEY(DNI)
);


CREATE TABLE Pedidos(
  codigoPedido NUMBER(8) NOT NULL,
  estado CHAR(9) DEFAULT 'REST' NOT NULL,
  fecha_pedido DATE NOT NULL,
  fecha_entrega DATE,
  importeT NUMBER(8,2),
  DNI_Cliente CHAR(9) NOT NULL REFERENCES Clientes(DNI),
  codigoDescuento Number(8),
  PRIMARY KEY(codigoPedido),
  CONSTRAINT Pedidos_FK FOREIGN KEY (codigoDescuento) REFERENCES Descuentos(codigoD) ON DELETE SET NULL,
  CHECK (estado IN ('REST', 'CANCEL', 'RUTA', 'ENTREGADO','RECHAZADO'))
);


CREATE TABLE Contiene(
  restaurante NUMBER(8),
  plato CHAR(20),
  pedido NUMBER(8),
  precioT NUMBER(8,2),
  uds NUMBER(4)NOT NULL,
  PRIMARY KEY(restaurante, plato, pedido),
  CONSTRAINT Contiene_FK FOREIGN KEY(restaurante, plato) REFERENCES Platos(codigo_Re, nombre),
  CONSTRAINT Contiene_FK2 FOREIGN KEY(pedido) REFERENCES Pedidos(codigoPedido) ON DELETE CASCADE
  );


CREATE TABLE AplicadosA(
  codigoDescuento NUMBER(8) NOT NULL,
  codigoPedido NUMBER(8) NOT NULL,
  CONSTRAINT AplicadosA_FK FOREIGN KEY(codigoDescuento) REFERENCES Descuentos(codigoD),
  CONSTRAINT AplicadosA_FK2 FOREIGN KEY(codigoPedido) REFERENCES Pedidos(codigoPedido) ON DELETE CASCADE
  );



INSERT INTO Restaurantes VALUES (1234,'pizzahud','abascal 45','12345',2.0);
INSERT INTO CP_AREAS_COBERTURA VALUES (1234,'12345');
INSERT INTO Platos VALUES (1234,'pizza arrabiata',17.50,'pizza de carne y guindilla','picante');
INSERT INTO Horarios VALUES (1234,'X',to_date('12:00','HH24:MI'),to_date('23:00','HH24:MI'));
INSERT INTO Descuentos VALUES (1100,to_date('20-04-09', 'DD-MM-YY'),50);
INSERT INTO Clientes VALUES
('12345678M','Pedro','Pérez','Torralba',29,'4B','Madrid','12345','12345612','pedro','pedro');
INSERT INTO Pedidos VALUES 
(1,'REST',to_date('17-0209:19:50','DD-MMYY:HH24:MI'),to_date('17-0209:20:50','DD-MM-YY:HH24:MI'), 34.25,'12345678N',1100);
INSERT INTO Contiene VALUES (1234,'pizza arrabiata',1,NULL,2);

DELETE FROM Contiene;
DELETE FROM Pedidos;
DELETE FROM Clientes;
DELETE FROM Descuentos;
DELETE FROM Horarios;
DELETE FROM Platos;
DELETE FROM CP_AREAS_COBERTURA;
DELETE FROM Restaurantes;

/*CARGAMOS LOS DATOS CON LA INSTRUCCION LOAD*/

/*sqlldr userid= SYSTEM@localhost/SYS CONTROL=control.ctl LOG=log.txt*/

