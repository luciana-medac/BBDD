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

/* EJERCICIO 2: IGUAL QUE EL ANTERIOR PERO CAPTURANDO UNA EXCEPCIÃ“N EN CASO DE QE NO EXISTA EL ID */
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

/* EJERCICIO 3: MOSTRAR EL NOMBRE Y EL TELEFONO DE UN CLIENTE DADO SU DNI
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

/* EJERCICIO 4: MOSTRAR EL NOMBRE Y EL TELEFONO DE UN LIENTE DADO SU DNI (IGUAL AL ANTERIOR PERO USANDO %ROWTYPE */
-- %ROWTYPE --> sirve para almacenar una fila completa de una tabla sin tener que declarar cada columna como variable indivisual

DECLARE
	
    v_dni cliente.nombre%TYPE := &dni1;
    v_cliente cliente%ROWTYPE;
    
BEGIN
	SELECT
		nombre, telef
        INTO v_cliente
		FROM cliente
        WHERE v_dni = dni;
        
        dbms_output.put_line('El nombre es: ' || v_nombre || ' y su telefono ' || v_telef);
END;

/* EJERCICIO 5: MOSTRAR TODA LA INFORMACIÃ“N DE UN COCHE DADA LA MATRICULA (MATRICULA, ID_MODELO, PRECIO_COMPRA) */
SELECT * FROM coche;
DECLARE
	
    v_matricula coche.matricula%TYPE := &matricula1
    v_coche coche%ROWTYPE;
    
BEGIN

	SELECT *
    INTO v_coche
    FROM coche
    WHERE v_matricula = matricula;
	
    dbms_output.put_line('Matricula: ' 
						|| 'id del modelo: ' 
						|| v_coche.id_modelo 
                        || ' precio compra: ' 
                        || v_coche.precio_compra);
END;

/*EJERCICIO 6: MOSTRAR TODA LA INFORMACION DEL MODELO DE UN COCHE DADO UN ID INCLUIDO EL NOMBRE DE LA MARCA */
SELECT * FROM modelo_coche;
DECLARE
    v_id_modelo modelo_coche.id_modelo%TYPE := &id_modelo1;
    v_modelo_coche modelo_coche%ROWTYPE;
    v_marcas marcas_coche.marca%TYPE;
BEGIN
	SELECT 
		m.id_modelo, m.descripcion, m.id_marca, ma.marca
	INTO
		v_modelo_coche.id_modelo,
        v_modelo_coche.descripcion,
        v_modelo_coche.id_marca,
        v_marcas
	FROM
		modelo_coche m
        JOIN marcas_coche ma ON m.id_marca = ma.id_marca
	WHERE m.id_modelo = v_id_modelo;
    
     dbms_output.put_line('id_modelo: '
                         || v_id_modelo
                         || ' descripcion: '
                         || v_modelo_coche.descripcion
                         || '  id_marca: '
                         || v_modelo_coche.id_marca
                         || ' marca: '
                         || v_marcas);
	
	END;

/* EJERCICIO 7: MOSTRAR LA SUMA DE VENTAS PASANDO EL DNI POR PARÁMETRO */
SELECT * FROM vende;
DECLARE
    
    v_dni_cliente vende.dni_cliente%TYPE := &dni_cliente;
    v_precio vende.precio%TYPE;
    
BEGIN

    SELECT 
        SUM(precio) 
        INTO v_precio
        FROM vende
        WHERE v_dni_cliente = dni_cliente;
    
    dbms_output.put_line('las ventas totales son: ' || v_precio);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line(v_dni_cliente || 'no se ha encontrado ');
END;


/*EJERCICIO 8: MOSTRAR CUÁNTOS MODELOS DE COCHES HAY DE LA MARCA: 'CITROEN' */
SELECT * FROM marcas_coche;
DECLARE
    
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

/* EJERCICIO 9: MOSTRAR LA SUMA DE VENTAS. PASA EL DNI DEL EMPLEADO POR PARAMETRO. SI EL PRECIO DE LAS VENTAS ESTÁ EN NULL
    DEBE MOSTRARSE SU MENSAJE INDICADO QUE NO HAY VENTAS REGISTRADAS. EN CASO CONTRARIO,
    DEBE MOSTRARSE EL TOTAL DE VENTAS MEDIANTE DBMS */
SELECT * FROM vende;
/
DECLARE
    v_dni_empleado vende.dni_empleado%TYPE := &dni;
    v_ventas vende.precio%TYPE;
  
BEGIN
    SELECT 
    SUM(precio)
    INTO v_ventas FROM vende
    WHERE v_dni_empleado = dni_empleado;
    
    IF v_ventas IS NULL
    THEN dbms_output.put_line('no hay ventas');
    ELSE dbms_output.put_line('las ventas son: ' || v_ventas);
    END IF;
END;


























    
