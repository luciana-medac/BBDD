DECLARE
    mensaje VARCHAR2(100);
BEGIN
    mensaje := 'Hola clase DAM!';
    dbms_output.put_line(mensaje);
END;

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


    