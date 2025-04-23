/* Descripción de los modelos de coche correspondientes a una marca específica, por ejemplo marca con id = 3 */
DECLARE
    
    v_id modelo_coche.id_marca%TYPE := &id;
    v_des modelo_coche.descripcion%TYPE;
    CURSOR c_modelos IS -- se declara el cursor
        SELECT descripcion
        FROM modelo_coche
        WHERE id_marca = v_id;
    
BEGIN
    -- recorre cada fila del cursor
    OPEN c_modelos;
    LOOP 
        FETCH c_modelos INTO v_des;
    EXIT WHEN c_modelos%NOTFOUND; -- esto es para que finalice cuando no encuentre nada
    dbms_output.put_line('La descripcion de ' || ' es ' 
                                              || v_des);
    
    END LOOP;
    CLOSE c_modelos; -- cerramos el open
END;

/* Igual que el anterior pero que también nos muestre el número total de modelos con %ROWCOUNT */

DECLARE
    
    v_id modelo_coche.id_marca%TYPE := &id;
    v_des modelo_coche.descripcion%TYPE;
    CURSOR c_modelos IS -- se declara el cursor
        SELECT descripcion
        FROM modelo_coche
        WHERE id_marca = v_id;
    
BEGIN
    -- recorre cada fila del cursor
    OPEN c_modelos;
    LOOP 
        FETCH c_modelos INTO v_des;
    EXIT WHEN c_modelos%NOTFOUND; -- esto es para que finalice cuando no encuentre nada
    dbms_output.put_line('La descripcion de ' || ' es ' 
                                              || v_des);
    
    END LOOP;
    dbms_output.put_line('la cantidad de modelos es: ' || c_modelos%ROWCOUNT); -- con el ROWCOUNT cuenta las filas
    CLOSE c_modelos; -- cerramos el open
END;

/* Listar los empleados que tienen una antigüedad antes del año 2010 */
DECLARE
    v_nombre empleado.nombre;
    CURSOR c_empleados IS
        SELECT nombre
        FROM empleado
        WHERE anio_empleado > '2010-12-31'
BEGIN
    OPEN c_empleados
    LOOP
        FETCH c_empleados INTO v_nombre;
    EXIT WHEN c_empleados%NOTFOUND;
    dbms_output.put_line('Los empleados con antiguedad de antes del 2010 ' || c_empleados)
    END LOOP;
    CLOSE c_empleados;
END;
