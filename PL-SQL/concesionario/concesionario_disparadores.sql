/* DISPARADORES O TRIGGERS */
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




