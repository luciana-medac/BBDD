/*EJERCICIO 1*/
/* LUCIANA MOLINA GREGOLI */

CREATE OR REPLACE PROCEDURE puesto_empleado(v_dni empleado.dni%TYPE) 
AS 
    v_empleado empleado.nombre%TYPE;
    v_tipo_puesto tipos_puesto.id_puesto%TYPE;
    v_puesto tipos_puesto.puesto%TYPE;
    
BEGIN

    SELECT em.nombre, tp.id_puesto, tp.puesto
    INTO v_empleado,
         v_tipo_puesto,
         v_puesto
    FROM empleado em
    JOIN tipos_puesto tp ON em.id_puesto = tp.id_puesto
    WHERE em.dni = v_dni;
    
    dbms_output.put_line('El empleado con DNI: ' || v_dni 
                        || ' nombre: ' || v_empleado 
                        || ' trabaja en el puesto ' || v_puesto);

    EXCEPTION
        WHEN no_data_found THEN
            dbms_output.put_line('No se ha encontrado el DNI: ' || v_dni);
        WHEN OTHERS THEN
            dbms_output.put_line('Error: ' || SQLERRM);
    
END;

/

/* EJECUTAR EL PROCEDIMIENTO DEL EJERCICIO 1 */
DECLARE
    v_dni empleado.dni%TYPE := &dni;
BEGIN
    puesto_empleado(v_dni);
END;


/* EJERCICIO 2 */
/* LUCIANA MOLINA GREGOLI */
CREATE OR REPLACE FUNCTION contarCoches (v_precio_minimo coche.precio_compra%TYPE)
RETURN NUMBER
AS
    v_cantidad NUMBER;
    
BEGIN
    
    SELECT COUNT(*)
    INTO v_cantidad
    FROM coche
    WHERE precio_compra >= v_precio_minimo;
    
    RETURN v_cantidad;

END;

/

/*EJECUTAR LA FUNCIÓN DEL EJERCICIO 2 */
DECLARE
    v_precio_minimo coche.precio_compra%TYPE := &precio;
    v_cantidad NUMBER;
BEGIN
    v_cantidad := contarCoches(v_precio_minimo);
    dbms_output.put_line('La cantidad de coches con precio ' || v_precio_minimo 
                                                             || ' son ' 
                                                             ||v_cantidad);
END;


/*EJERCICIO 3*/
/*LUCIANA MOLINA GREGOLI */
CREATE OR REPLACE TRIGGER asignar_telefono_empresa
BEFORE INSERT ON empleado
for each row
    BEGIN
        IF :OLD.telef IS NULL
        THEN :NEW.telef := '953941822';
        END IF;
        
        IF :NEW.id_puesto = :OLD.id_puesto 
        THEN 
            RAISE_APPLICATION_ERROR(-20020, 'Error: El puesto con ese ID ya está asignado');
        END IF;
END;

/*PRUEBA DEL TRIGGER EJERCICIO 3*/
INSERT INTO empleado(dni,nombre,id_puesto,anio_incorporacion) VALUES
('7777777T', 'Ramon Ortega', 2, 2013);
/*COMPROBAR QUE SE HA INSERTADO CORRECTAMENTE*/
SELECT * FROM empleado;

/*EJERCICIO 4*/
/*LUCIANA MOLINA GREGOLI*/
CREATE OR REPLACE PROCEDURE listarVentasAltas AS
    v_total_ventas VARCHAR2(255);
    
    v_matricula vende.matricula%TYPE;
    v_dni_cliente vende.dni_cliente%TYPE;
    v_precio vende.precio%TYPE;
    
    CURSOR c_ventas IS
        SELECT matricula, dni_cliente, precio
        FROM vende
        WHERE precio >= 10000;
    
BEGIN
    OPEN c_ventas;
    LOOP
        FETCH c_ventas INTO v_matricula, v_dni_cliente, v_precio;
    EXIT WHEN c_ventas%NOTFOUND;
        dbms_output.put_line('Linea: ' || c_ventas%ROWCOUNT 
                                       || ' Matricula: ' 
                                       || v_matricula
                                       || ' DNI Cliente: '
                                       || v_dni_cliente
                                       || ' Precio '
                                       || v_precio);
    END LOOP;
    CLOSE c_ventas;
    
END;

/*PARA EJECUTAR EL EJERCICIO 4*/
EXEC listarVentasAltas;



