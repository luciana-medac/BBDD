/* DISPARADORES O TRIGGERS */
CREATE OR REPLACE TRIGGER checkPrecioCompra 
BEFORE INSERT ON coche -- antes de un insert en la tabla coche
for each row -- por cada fila 

BEGIN
        IF :NEW.precio_compra IS NULL or :NEW.precio_compra <= 0 -- para algo nuevo  (delante de cada new van : )
        THEN
            RAISE_APPLICATION_ERROR(-20001, 'El precio de compra no puede ser nulo o 0');
        END IF;

END;