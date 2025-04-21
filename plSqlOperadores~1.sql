/**1. SUMA DOS NUMEROS Y MUESTRA EL RESULTADO**/
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

/**2. MULTIPLICA 6 POR 7 Y MUESTRA EL RESULTADO **/
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

/**3. VERIFICA SI UNA PERSONA TIENE 18 Y MUESTRA UN MENSAJE**/
DECLARE
    numero1 NUMBER(2);
    mensaje1 VARCHAR2(100);
BEGIN
    numero1:=18;
    mensaje1:= 'es mayor que 18';
    IF numero1 > 17
        THEN dbms_output.put_line(mensaje1);
    ELSIF numero1 < 17
        THEN dbms_output.put_line('es menor');
    ELSE dbms_output.put_line('no es meyor a 18');
    END IF;
END;

/**4. COMPRUEBA SI 10 ES MAYOR QUE 5 **/
DECLARE
    numero1 NUMBER(2);
    numero2 NUMBER(1);
BEGIN
    numero1:=10;
    numero2:=5;
    IF numero1 > numero2 THEN
    dbms_output.put_line('no es mayor');
    END IF;
END;

/** 5. MUESTRA LA FECHA ACTUAL CON FORMATO DE TEXTO **/
DECLARE
   fecha DATE := SYSDATE;
BEGIN
    dbms_output.put_line(fecha);
END;
    
/**6. CREA UNA VARIABLE CON EL MISMO TIPO QUE EL NOMBRE DE UN EMPLEADO**/
DECLARE
    nombre1 VARCHAR2(50);
    nombre2 nombre1%TYPE;
BEGIN
    nombre2 :='Canelita';
    dbms_output.put_line('Nombre del empleado: ' || nombre2);
END;

/**7. USA UNA VARIABLE DENTRO DE UN BLOQUE PL/SQL Y ACCEDE SU VALOR**/
DECLARE
    nombre1 VARCHAR2;
BEGIN 
    nombre1 := 'Alejandro';
    dbms_output.put_line(nombre1);
END;

/**8. COMPRUEBA SI UN NÚMERO ES MENOR QUE OTRO**/
DECLARE
    numero1 NUMBER(1);
    numero2 NUMBER(1);
BEGIN
    numero1 := 3;
    numero2 := 5;
    IF numero1 < numero2 THEN
    dbms_output.put_line('el numero: ' || numero1 || ' es menor que ' || numero2);
    ELSE dbms_output.put_line('el numero: ' || numero1 || ' NO es menor que ' || numero2);
    END IF;
END;

/**9. COMPRUEBA SI DOS NUMEROS SON DISTINTOS**/
DECLARE
    numero1 NUMBER(1);
    numero2 NUMBER(1);
BEGIN
    numero1 := 3;
    numero2 := 8;
    IF numero1 != numero2 THEN
    dbms_output.put_line('el numero: ' || numero1 || ' es diferente que ' || numero2);
    ELSE dbms_output.put_line('son iguales');
    END IF;
END;

/**10. COMPRUEBA SI UN NUMERO ES MENOR O IGUAL QUE OTRO**/
DECLARE
    numero1 NUMBER(1);
    numero2 NUMBER(1);
BEGIN
    numero1 := 9;
    numero2 := 7;
    IF numero1 <= numero2 THEN
    dbms_output.put_line(numero1 || ' es menor o igual que ' || numero2);
    ELSE dbms_output.put_line(numero1 || ' NO es menor o igual que ' || numero2);
    END IF;
END;

/**11. ASIGNA UN VALOR A UNA VARIABLE Y MUESTRÁLO**/
DECLARE
    frase VARCHAR2(50);
BEGIN
    frase := 'frasecilla chikitita';
    dbms_output.put_line(frase);
END;

/**12. MUESTRA UN SALUDO CONCATENANDO TEXTO**/
DECLARE
    saludo VARCHAR(50);
BEGIN
    saludo := 'hola holita';
    dbms_output.put_line(saludo || 'buenas mañanitas');
END;

/**13. CREA UNA ETIQUETA PARA UN BLOQUE**/
DECLARE
    nombre1 VARCHAR2(50);
BEGIN
    <<Etiqueton>>
    nombre1 := 'Manolita';
    dbms_output.put_line(nombre1);
END;

/**14. AÑADE UN COMENTARIO MULTILINEA ANTES DE UN BLOQUE DE CÓDIGO**/
/** la siguiente declaracion
es sobre mostrar una frase**/
DECLARE
    frase VARCHAR2(50);
BEGIN
    frase := 'frasecilla chikitita';
    dbms_output.put_line(frase);
END;

/**15. AÑADE UN COMENTARIO SIMPLE ANTES DE UN BLOQUE DE CÓDIGO**/
DECLARE
-- Declaramos la variable
    frase VARCHAR2(50);
BEGIN
-- Asignamos la frase a la variable antes creada
    frase := 'frasecilla chikitita';
    dbms_output.put_line(frase);
END;

/**16. RESTA DIS NUMEROS Y MUESTRA EL RESULTADO**/
DECLARE
    num1 NUMBER(1);
    num2 NUMBER(2);
    resultado NUMBER(2);
BEGIN
    num1 := 3;
    num2 := 8;
    resultado := num2 - num1;
    dbms_output.put_line('el resultado es: ' || resultado);
END;

/**17. DIVIDE 20 ENTRE 4 Y MUESTRA EL RESULTADO**/
DECLARE
    num1 NUMBER(2);
    num2 NUMBER(1);
    resultado NUMBER(2);
BEGIN
    num1 := 20;
    num2 := 4;
    resultado := num1 / num2;
    dbms_output.put_line('el resultado es: ' || resultado);
END;

/**18. CALCULA UNA POTENCIA**/
DECLARE
    num1 NUMBER(2);
    num2 NUMBER(2);
    resultado NUMBER(2);
BEGIN
    num1 := 2;
    num2 := 3;
    resultado := 2**3;
    dbms_output.put_line('2 elevado a 3 es ' || resultado);
END;

/**19. COMPRUEBA SI UN NUMERO ES MAYOR O IGUAL QUE OTRO**/
DECLARE
    num1 NUMBER(2);
    num2 NUMBER(2);
BEGIN
    num1 := 4;
    num2 := 8;
    IF num1 >= num2 THEN dbms_output.put_line(num1 || ' es mayor o igual que ' || num2);
    ELSE dbms_output.put_line(num1 || ' NO es mayor o igual que ' || num2);
    END IF;
END;

/**20. USA UN PARÁMETRO NOMBRADO DE UNA FUNCIÓN**/
DECLARE
    nombre1 VARCHAR2(50);
    FUNCTION marica (
        nombre2 in VARCHAR2
        ) RETURN VARCHAR2 IS
    BEGIN
     RETURN 'ay, ' || nombre1;
    END marica;
BEGIN
    nombre1 := 'marieta';
    dbms_output.put_line(marica(nombre2 => nombre1));
END;

/**FORMA DE HACERLO DE LA PROFESORA**/
BEGIN
    dbms_output.put_line(TO_CHAR(SYSDATE, format => 'YYYY');
END;

/**21. MUESTRA UNA CADENA DE TEXTO ENTRE COMILLAS SIMPLES**/
BEGIN
    dbms_output.put_line('cadena de texto entre comilas simples');
END;

/**22. EXPLICA CÓMO SE USARÍA PARA EJECUTAR SCRIPTS EXTERNOS EN SQL*Plus **/
-- se usaría de la siguiente forma: @:\ruta\del\archivo\script.sql

/**23. ESCRIBE UN BLOQUE BIEN INDENTADO CON ESPACIOS Y TABULACIONES**/
DECLARE
    mensaje1 VARCHAR2(20);
    mensaje2 VARCHAR2(20);
BEGIN
    mensaje1 := 'este es el mensaje 1';
    mensaje2 := 'este es el mensaje 2';
    dbms_output.put_line(mensaje1 || mensaje2);
END;


