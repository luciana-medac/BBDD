/*EJERCICIO 3*/
/*LUCIANA MOLINA GREGOLI */
CREATE OR REPLACE TRIGGER asignar_telefono_empresa
BEFORE INSERT ON empleado
for each row
DECLARE
    v_count number;
    BEGIN
        
        SELECT (id_puesto)
        INTO v_count 
        FROM empleado
        WHERE v_count = :new.id_puesto;
        
        IF :OLD.telef IS NULL
        THEN :NEW.telef := '953941822';
        END IF;
        
        IF v_count > 0
        THEN 
            RAISE_APPLICATION_ERROR(-20020, 'Error: El puesto con ese ID ya está asignado'); 
        END IF;
                
END;

/*PRUEBA DEL TRIGGER EJERCICIO 3*/
INSERT INTO empleado(dni,nombre,id_puesto,anio_incorporacion) VALUES
('7777774T', 'Carla', 5, 2011);
/
/*COMPROBAR QUE SE HA INSERTADO CORRECTAMENTE*/
SELECT * FROM empleado;


