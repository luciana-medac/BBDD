/* EJERCICIO 1: MOSTRAR LA MARCA DADA SU ID DE LA MARCA */
SELECT * FROM marcas_coche;

/

DECLARE
    v_id marcas_coche.id_marca%TYPE := &id_marca1;
    v_marca marcas_coche.marca%TYPE;
BEGIN
    SELECT marca INTO v_marca
    FROM marcas_coche
    WHERE id_marca = v_id;
    dbms_output.put_line('La marca es: ' || v_marca);

END;

/* EJERCICIO 2: IGUAL QUE EL ANTERIOR PERO CAPTURANDO UNA EXCEPCIÓN EN CASO DE QE NO EXISTA EL ID */
SELECT * FROM marcas_coche;

DECLARE
    v_id marcas_coche.id_marca%TYPE := &id_marca1;
    v_marca marcas_coche.marca%TYPE;
    
BEGIN
    SELECT
        marca
    INTO v_marca
    FROM marcas_coche
    WHERE id_marca = v_id;

    dbms_output.put_line('La marca es ' || v_marca);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Marca no encontrada');
    WHEN OTHERS THEN
        dbms_output.put_line('Error desconocido');
END;

/* MOSTRAR EL NOMBRE Y EL TELEFONO DE UN CLIENTE DADO SU DNI
    (AL TRATARSE D UN VARCHAR2 TENEIS QUE PONER EL DNI ENTRE COMILLAS*/
SELECT * FROM cliente; 
DECLARE
    v_dni cliente.dni_cliente%TYPE := &dni_cliente1;
    v_telefono cliente.telef_cliente%TYPE;

BEGIN
    SELECT cliente
    INTO v_dni
    FROM cliente
    WHERE dni_cliente = v_dni;
    
    dbms_output.put_line('El dni es: ' || v_dni || 'y el telefono es' || v_telefono);

END;
    
