/*1. EXCEPCIONES*/
DECLARE
    prueba NUMBER(1) := 5;
    resultado NUMBER(2);
    exception_prueba EXCEPTION;
BEGIN
    resultado := prueba /0;
    dbms_output.put_line('El resultado es ' || resultado);
    
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        dbms_output.put_line('Division por cero ' || SQLERRM);
END;

/ /*LA BARRA ENTRE BLOQUES ES PARA SABER DONDE ACABA UNO Y EMPIEZA OTRO*/

/*2. EXCEPCIONES */
DECLARE
    edad NUMBER := -1;
    excepcion_edad EXCEPTION;
BEGIN
    IF edad < 0 or edad > 99 THEN
        RAISE excepcion_edad;
    END IF;
EXCEPTION 
    WHEN excepcion_edad THEN
    dbms_output.put_line('Error en la variable edad');
END;


/* MOSTRAR LOS NUMEROS DEL 1 AL 10 CON WHILE */

DECLARE
    num NUMBER := 1;
BEGIN
    WHILE (num <= 10)
    loop 
        dbms_output.put_line(num);
        num := num +1;
    end loop;
END;
    
/* MOSTRAR LOS NUMEROS DEL 1 AL 10 CON FOR */
DECLARE
    num NUMBER := 1;
BEGIN
    FOR num in 1..10
    loop
        dbms_output.put_line(num);
    end loop;
END;

/*MOSTRAR LOS NUMEROS DEL 10 AL 1*/
DECLARE
    num NUMBER := 1;
BEGIN
    FOR num in reverse 1..10
    loop
        dbms_output.put_line(num);
    end loop;
END; 

/* MOSTRAR LOS NUMEROS DEL 1 AL 10 CON LOOP */

DECLARE
    num NUMBER := 1;
BEGIN
    loop
        dbms_output.put_line(num);
        exit when num = 10;
        num := num + 1;
    end loop;
END;

/* VIDEO1 1. USO DEL CASE */
DECLARE
    nota NUMBER(3,1); -- 3 digitos y 1 decimal
BEGIN
    nota := 7.8;
    CASE
        WHEN nota < 5 THEN 
            dbms_output.put_line('Reprobaste :( No apto ');
        WHEN nota >= 5 THEN
            dbms_output.put_line('Aprobao: apto');
        ELSE
            dbms_output.put_line('nota erronea');
    END CASE;
END;


    
    
    
    
    
    
    
    
