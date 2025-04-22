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
