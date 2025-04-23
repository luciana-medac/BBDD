/** SUMA LAS CANTIDADES 4 Y 7
Y DEVUELVE EL RESULTADO POR CONSOLA **/
DECLARE
    numero1 NUMBER(1);
    numero2 NUMBER(1);
    resultado NUMBER(2);
BEGIN
    numero1:=4;
    numero2:=7;
    resultado:=numero1+numero2;
    dbms_output.put_line('el resultado es ' || resultado);
END;

/** MULTIPLICA 6 POR 7 Y MUESTRA EL RESULTADO **/
DECLARE
    numero1 NUMBER(1);
    numero2 NUMBER(1);
    resultado NUMBER(2);
BEGIN
    numero1:=6;
    numero2:=7;
    resultado:=numero1*numero2;
    dbms_output.put_line('el resltado es' || resultado);
END;

/**VERIFICA SI UNA PERSONA TIENE 18 Y MUESTRA UN MENSAJE**/
DECLARE
    numero1 NUMBER(2);
    mensaje1 VARCHAR2(100);
BEGIN
    numero1:=17;
    mensaje1:= 'es mayor que 18';
    IF numero1 > 17
        THEN dbms_output.put_line(mensaje1);
    ELSE dms_output.put_line('no es meyor a 18');
    END IF;
END;








