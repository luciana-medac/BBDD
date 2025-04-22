/* Realizar una función que devuelva la suma de ventas. Pasa el dni del empleado por parámetro */
CREATE OR REPLACE FUNCTION precio_ventas (v_dni vende.dni_empleado%TYPE)
RETURN NUMBER
AS
    v_suma vende.precio%TYPE;
    
BEGIN
    SELECT 
        SUM(precio) 
        INTO v_suma
        FROM vende
        WHERE dni_empleado = v_dni;
        
    RETURN v_suma;
    
END;

/* PARA LLAMAR A LA FUNCION */
SELECT * FROM vende;
DECLARE
    v_dni vende.dni_empleado%TYPE := &dni;
    v_suma_precio vende.precio%TYPE; -- para guardar la variable que nos retorna la funcion
BEGIN
    v_suma_precio := precio_ventas(v_dni);
    dbms_output.put_line('la suma de ventas es: ' || v_suma_precio);
END;