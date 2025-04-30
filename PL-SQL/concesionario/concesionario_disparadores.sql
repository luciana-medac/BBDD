/* DISPARADORES O TRIGGERS */

/* EJERCICIO 1: TRIGGER QUE IMPIDE REGISTRAR UNA VENTA SI EL PRECIO ES MENOR QUE 1000  */
CREATE OR REPLACE TRIGGER checkVenta
BEFORE INSERT ON vende
for each row
    BEGIN
        IF :NEW.precio < 1000
        THEN 
            RAISE_APPLICATION_ERROR(-20001, 'No se puede registrar un precio menor a 1000');
        END IF;
END;

/*EJERCICIO 2: Crear un trigger que verifique el precio de compra de un coche antes de insertarlo en la tabla coche. 
Si el precio es nulo o cero, el trigger debe evitar la inserción y lanzar una excepción. */
CREATE OR REPLACE TRIGGER checkPrecioCompra 
BEFORE INSERT ON coche -- antes de un insert en la tabla coche
for each row -- por cada fila 

BEGIN
        IF :NEW.precio_compra IS NULL or :NEW.precio_compra <= 0 -- para algo nuevo  (delante de cada new van : )
        THEN
            RAISE_APPLICATION_ERROR(-20001, 'El precio de compra no puede ser nulo o 0');
        END IF;

END;

ALTER TABLE coche ADD fecha_insercion DATE;

/* EJERCICIO 3: Crear un trigger que automáticamente inserte la fecha actual en la columna fecha_insercion cada 
vez que se añade un nuevo registro en la tabla coche.
Hay que añadir antes un campo fecha_insercion en la tabla coche */
CREATE OR REPLACE TRIGGER checkFechaActual
BEFORE INSERT ON coche
for each row

BEGIN
    :NEW.fecha_insercion := SYSDATE;
END;

/*EJERCICIO 4: CREAR UN TRIGGER QUE, ANTES DE ACTUALIZAR UN COCHE, REVISE SI EL CAMPO PRECIO_COMPRA HA CAMBIADO
Y SI ES ASÍ, LE APLIQUE UN 21% DE IVA AUTOMÁTICAMENTE, SIEMPRE QUE EL NUEVO VALOR NO SEA NULL*/

CREATE OR REPLACE TRIGGER checkIva
BEFORE UPDATE OF precio_compra ON coche
for each row
    BEGIN
        IF :OLD.precio_compra != :NEW.precio_compra AND :NEW.precio_compra IS NOT NULL 
        THEN :NEW.precio_compra:= :NEW.precio_compra*1.21;
        END IF;
END;


UPDATE coche SET precio_compra = 12000 WHERE matricula = '4446GCN';

SELECT * FROM coche;
