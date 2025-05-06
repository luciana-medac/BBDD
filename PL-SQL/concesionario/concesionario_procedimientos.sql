/*PROCEDIMIENTOS */

/* Realizar un procedimiento que muestre cuantos modelos de coches hay de la marca 'Citroen' */

-- El declare no hay quue ponerlo 
-- contar_modelos_coche es el nombre del procedimiento
CREATE OR REPLACE PROCEDURE contar_modelos_coche AS 

    v_marca marcas_coche.marca%TYPE := &marca1;
    v_modelo modelo_coche.id_modelo%TYPE;
    v_id_marca marcas_coche.id_marca%TYPE;
    v_cantidad NUMBER;
    
    
BEGIN

    SELECT
        COUNT(m.id_modelo)
        INTO v_cantidad
        FROM modelo_coche m 
        JOIN marcas_coche ma ON m.id_marca = ma.id_marca
        where v_marca = ma.marca;
        
        dbms_output.put_line('Hay un total de: '|| v_cantidad 
                                                || ' '
                                                || v_marca);
        
END; 

/* PARA EJECUTAR AL PROCEDIMIENTO */
EXEC contar_modelos_coche;

/* PARA QUE PREGUNTE SIEMPRE LA MARCA */ 
CREATE OR REPLACE PROCEDURE contar_modelos_coche(v_marca marcas_coche.marca%TYPE) AS 
    v_cantidad NUMBER;
    
BEGIN

    SELECT
        COUNT(m.id_modelo)
        INTO v_cantidad
        FROM modelo_coche m 
        JOIN marcas_coche ma ON m.id_marca = ma.id_marca
        where v_marca = ma.marca;
        
        dbms_output.put_line('Hay un total de: '|| v_cantidad 
                                                || ' '
                                                || v_marca);
        
END; 

/* PARA EJECUTARLO */
DECLARE
    v_marca marcas_coche.marca%TYPE := &vmarca; -- se declara la marca
BEGIN
    contar_modelos_coche(v_marca); -- se llama al procedimiento y se pasa por parámetro la variable
END;

/* Crear un procedimiento que utilice un cursor para listar los empleados que tienen una antigüedad antes del año 2010 */
CREATE OR REPLACE PROCEDURE empleados_con_antiguedad AS 
    v_nombre VARCHAR2(50);
    
    CURSOR c_empleados IS
        SELECT nombre
        FROM empleado
        WHERE anio_incorporacion < 2010-01-01;
BEGIN

    OPEN c_empleados;
    LOOP
        FETCH c_empleados INTO v_nombre;
    EXIT WHEN c_empleados%NOTFOUND;
    dbms_output.put_line( 'Empleado con antiguedad ' || v_nombre);
    END LOOP;
    CLOSE c_empleados;
    
END;

/* PARA EJECUTARLO */
EXEC empleados_con_antiguedad;



/*EJERCICIO 4: Crear un procedimiento ActualizarPrecioCoche que acepte un nuevo_precio y matrícula como parámetro */
CREATE OR REPLACE PROCEDURE actualizarPrecioCoche (
    v_nuevo_precio coche.precio_compra%TYPE,
    v_matricula coche.matricula%TYPE
    ) AS 
    
    v_count NUMBER;
    exception_matricula EXCEPTION;
    exception_precio EXCEPTION;
    
BEGIN
    
    SELECT COUNT(matricula)
        INTO v_count
        FROM coche
        WHERE v_matricula = matricula;
    
    IF v_count = 0 THEN
       RAISE exception_matricula;
    END IF;
    
        
    IF v_nuevo_precio > 0 AND v_nuevo_precio < 10000 THEN
        UPDATE coche SET precio_compra = v_nuevo_precio
        WHERE matricula = v_matricula;
    ELSE 
        RAISE exception_precio;
    END IF;
    
    EXCEPTION 
        WHEN exception_precio THEN
            dbms_output.put_line('No es precio válido');
        WHEN exception_matricula THEN
            dbms_output.put_line('No existe la ' || v_matricula);
        WHEN OTHERS THEN
            dbms_output.put_line('Error: ' || SQLERRM);

END;
    
/ 

DECLARE
    v_nuevo_precio coche.precio_compra%TYPE := &precio;
    v_matricula coche.matricula%TYPE := &matricula;
BEGIN
    actualizarPrecioCoche(v_nuevo_precio, v_matricula);

END;

/

SELECT * FROM coche;

