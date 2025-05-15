DROP TYPE Direccion FORCE;
DROP TYPE Persona FORCE;
DROP TYPE Profesor FORCE;
DROP TYPE Alumno FORCE;
DROP TYPE Administrativo FORCE;
DROP TYPE Becario FORCE;

-- DEFINICIÓN DE UN TIPO PARA DIRECCIÓN
CREATE OR REPLACE TYPE Direccion AS OBJECT(
    calle VARCHAR2(50),
    ciudad VARCHAR2(20),
    codigo_postal NUMBER(5)
);


-- DEFINICIÓN DE UN TIPO DE OBJETO 'PERSONA'
CREATE OR REPLACE TYPE Persona AS OBJECT(
    nombre VARCHAR2(50),
    apellidos VARCHAR2(100),
    domicilio DIRECCION, -- EL TIPO DE DATO DE UN ATRIBUTO PUEDE SER DE OTRO TIPO DE DATO OBJETO
    f_nac DATE,
    
    MEMBER FUNCTION calcularEdad RETURN NUMBER
    
) not final; -- PARA QUE LOS DEMÁS OBJETOS PUEDAN HEREDAR DE ESTE (final --> sería si no queremos que herede)


-- PARA DECIR QUE ALUMNO HEREDA DE PERSONA USAMOS UNDER
CREATE OR REPLACE TYPE Alumno UNDER Persona (
    matricula VARCHAR2(20),
    calificacion NUMBER
);

-- PARA ALTERAR UN OBJETO, USAMOS CASCADE PARA ELIMINARLO TAMBIÉN DE LOS OBJETOS QUE HAYAN HEREDADO ESE ATRIBUTO
ALTER TYPE Persona DROP ATTRIBUTE f_nac CASCADE;
-- PARA AÑADIRLO DE NUEVO
ALTER TYPE Persona ADD ATTRIBUTE f_nac DATE CASCADE;

CREATE OR REPLACE TYPE Profesor UNDER Persona (
    asignatura VARCHAR2(50),
    salario NUMBER,
    -- VA A TENER UN PROCEDIMIENTO DONDE LE PASEMOS POR PARÁMETRO EL SALARIO PARA AUMENTARLO (se puede poner cualquier nombre en salario)
    MEMBER PROCEDURE aumentoSalario (salario NUMBER)
);

-- DEFINIMOS EL CUERPO DE PERSONA (LOS MÉTODOS)
CREATE OR REPLACE TYPE BODY Persona AS 
    MEMBER FUNCTION calcularEdad RETURN NUMBER IS
    BEGIN
    -- Calcula los meses que hay entre la fecha actual y la fecha nacimiento, dividido entre 12, da los años
        RETURN MONTHS_BETWEEN(SYSDATE, f_nac) / 12;
    END calcularEdad;
    -- SI TUVIERA MÁS FUNCIONES Y PROCEDIMIENTOS SEGUIRÍAMOS AÑANDIENDO AQUÍ
    -- MEMBER PROCEDURE etc, etc,
END;

-- DEFINCIÓN DEL CUERPO DE PROFESOR (LOS MÉTODOS
CREATE OR REPLACE TYPE BODY Profesor AS
    MEMBER PROCEDURE aumentoSalario(salario NUMBER) IS
    BEGIN
    -- SE USA EL SELF PARA DIFERENCIAR EL ATRIBUTO DE LA VARIABLE
        self.salario := self.salario + salario;
    END aumentoSalario;
END;

-- CREACIÓN DE TABLAS PARA ALMACENAR OBJETOS DE ALUMNO Y PROFESOR
CREATE TABLE Alumnos OF Alumno;
CREATE TABLE Profesores OF Profesor;

-- CREAR/MODIFICAR OBJETO ALUMNO EN MEMORIA Y HACERLO PERSISTENTE(QUE SE ALMACENE)
DECLARE
    alumno1 Alumno;
BEGIN
    -- CREAMOS EL OBJETO ALUMNO1
    alumno1 := new Alumno('Ana', 'Garcia', 
                            Direccion ('C/Madrid', 'Jaen', 23600), '07-11-1985', '123456','9');
    -- PODEMOS MODIFICAR EL ATRIBUTO NOMBRE (si ejecutamos, se guardará con este nombre)
    alumno1.nombre := 'Marta';
    
    -- PARA GUARDARLO
    INSERT INTO Alumnos VALUES(alumno1);
    dbms_output.put_line('Alumno: ' || alumno1.nombre || ' - Calificacion: ' || alumno1.calificacion);
    dbms_output.put_line('La edad es: ' || alumno1.calcularEdad());
END;

-- CONSULTAR ALUMNO DE LA TABLA
DECLARE
    
    a Alumno; -- ASEGURATE DE QUE ALUMNO ES EL TIPO CORRECTO Y calcularEdad ESTÉ DEFINIDO (cuerpo)
    
BEGIN
    -- el value va la variable que yo le dé
    SELECT VALUE(al) INTO a FROM Alumnos al WHERE al.nombre = 'Marta';
    dbms_output.put_line('La edad es: ' || a.calcularEdad());
END;

/*
DECLARE
    profesor1 Profesor;
BEGIN
    profesor1 := new Profesor('Santiago', 'Lopez', Direccion ('C/Huelma', 'Sevilla', 23400), '09-12-1974', 'Literatura', 100);
    
    INSERT INTO Profesores VALUES(profesor1);
    dbms_output.put_line('Profesor: ' || profesor1.nombre || ' imparte la asignatura: ' 
                                      || profesor1.asignatura || ' y tiene un salario de: ' || profesor1.aumentoSalario(profesor1.salario));
END;
*/

-- INSERTAR DATOS PROFESORES UTILIZANDO UN CONSTRUCTOR (POR DEFECTO)
INSERT INTO Profesores VALUES(
    Profesor('Carlos', 'Fernandez', Direccion ('C/Andalucia' , 'Jaen', 23401), '07-04-1990', 'Informatica', 1000)    
);

DECLARE
    -- CREAMOS UNA VARIABLE DE TIPO PROFESOR
    p Profesor;
BEGIN
    -- SACAMOS LOS DATOS DEL PROFESOR DONDE SU ASIGNATURA SEA INFORMATICA
    SELECT value(pro)INTO p FROM Profesores pro WHERE pro.asignatura = 'Informatica';
    -- LE AUMENTAMOS EL SALARIO SUMANDOLE 100 CON LA FUNCIÓN
    p.aumentoSalario(100);
    -- ACTUALIZAMOS LOS DATOS EN LA TABLA
    UPDATE Profesores pro SET VALUE(pro) = p WHERE pro.asignatura = 'Informatica';
    -- MOSTRAMOS EL RESULTADO
    dbms_output.put_line('El salario es de: ' || p.salario);
END;

-- Diferencia entre una tabla anidada y un v.array --> La tabla anidada no tiene limite en comparación con el Varray 
-- CREAR UN ARRAY
CREATE OR REPLACE TYPE telefonoVArray as varray(3) of varchar2(9);

CREATE OR REPLACE TYPE Administrativo UNDER Persona (
    categoria VARCHAR2(50),
    telefonos telefonoVArray,
    MEMBER FUNCTION bonus(base NUMBER) RETURN NUMBER,
    -- MEMBER FUCTION bonus(base NUMBER) RETURN NUMBER  esta sobrecarga no sería válida, porque tiene el mismo nombre, mismo parámetro que recibe y retorna el mismo tipo de dato
    -- MEMBER FUCTION bonus(hola NUMBER) RETURN NUMBER tampoco sería válido
    -- MEMBER FUCTION bonus(hola NUMBER, base NUMBER) RETURN NUMBER
    -- MEMBER FUCTION bonus(base NUMBER, hola NUMBER) RETURN NUMBER estas dos tampoco serían válidas
    MEMBER FUNCTION bonus(base NUMBER, base1 NUMBER) RETURN NUMBER -- esto sería válido
    
);

CREATE OR REPLACE TYPE Becario UNDER Persona (
    universidad VARCHAR(50),
    telefonos telefonoVArray,
    -- POLIMORFISMO CON OVERRIDING
    OVERRIDING MEMBER FUNCTION calcularEdad RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY Becario AS
    OVERRIDING MEMBER FUNCTION calcularEdad RETURN NUMBER IS
    BEGIN
    -- el FLOOR redondea
        RETURN FLOOR(MONTHS_BETWEEN(SYSDATE, f_nac) / 12);
        END calcularEdad;
END;

CREATE OR REPLACE TYPE BODY Administrativo AS
    MEMBER FUNCTION bonus(base NUMBER) RETURN NUMBER IS
    BEGIN
    -- SE USA EL SELF PARA DIFERENCIAR EL ATRIBUTO DE LA VARIABLE
        RETURN base*1.1;
    END;
    
    MEMBER FUNCTION bonus(base NUMBER, base1 NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN (base + base1);
    END;
END;

-- CREATE TABLE Becarios OF Becario
-- CREATE TABLE Administrativos OF Administrativos

-- BLOQUE ANÓNIMO DE PRUEBA, CREAR OBJETOS Y COMPROBAR FUNCIONES
DECLARE
    a Administrativo;
    b Becario;

BEGIN
    a := new Administrativo('Manuel', 'Lopez Gutierrez', Direccion('C/123', 'Cordoba', 25003),
                            '05-05-1995', 'ugr', telefonoVArray('123456789','666666666','777747775'));
    b := new Becario('Fifiru', 'Salvatore Silvestre', Direccion('C/Falsilla', 'Almeria', 44598), '02-04-1996',
                    'UJA',telefonoVArray('953350000'));
    dbms_output.put_line('Sueldo base del administrativo ' || a.bonus(1000));
    dbms_output.put_line('Sueldo base del administrativo ' || a.bonus(1000, 200));
    dbms_output.put_line('La edad del becario es ' || b.calcularEdad);
END;














