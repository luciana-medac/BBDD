/* EJERCICIO 1: MOSTRAR LA MARCA DADA SU ID DE LA MARCA */
SELECT * FROM marcas_coche;

/

DECLARE
    v_id marcas_coche.id_marca&TYPE := &id_marca1;
    v_marca marcas_coche.marca&TYPE;
BEGIN
    SELECT marca INTO v_marca
    FROM marcas_coche
    WHERE id_marca = v_id;
    dbms_output.put_line('La marca es: ' || v_marca);

END;