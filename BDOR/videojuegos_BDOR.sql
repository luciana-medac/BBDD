DROP TYPE Direccion FORCE;
DROP TYPE Persona FORCE;
DROP TYPE Jugador FORCE;
DROP TYPE Moderador FORCE;

-- DEFINICION DE UN TIPO OBJETO DIRECCION
CREATE OR REPLACE TYPE Direccion AS OBJECT(
    calle VARCHAR2(50),
    ciudad VARCHAR2(20),
    codigo_postal NUMBER(5)
);


-- DEFINICION DE UN TIPO OBJETO PERSONA
CREATE OR REPLACE TYPE Persona AS OBJECT(
    nombre VARCHAR2(50),
    email VARCHAR2(100),
    domicilio DIRECCION,
    f_nac DATE,
    
    MEMBER FUNCTION edadActual RETURN NUMBER
    
) not final;

-- DEFINICION DE UN TIPO OBJETO JUGADOR
CREATE OR REPLACE TYPE Jugador UNDER Persona(
    usuario VARCHAR2(50),
    nivel NUMBER(3),
    
    MEMBER PROCEDURE mostrarEstadisticas,
    MEMBER PROCEDURE cambiarNombreUsuario(nuevoNombre VARCHAR2),
    OVERRIDING MEMBER FUNCTION edadActual RETURN NUMBER
    
);

-- DEFINICION DE UN TIPO OBJETO MODERADOR
CREATE OR REPLACE TYPE Moderador UNDER Persona(
    nivelAsignado VARCHAR2(50),
    nivelAutorizacion NUMBER(2),
    
    MEMBER PROCEDURE banearUsuario,
    MEMBER FUNCTION esSenior RETURN VARCHAR2
);

-- BODY DE PERSONA
CREATE OR REPLACE TYPE BODY Persona AS
    MEMBER FUNCTION edadActual RETURN NUMBER IS
    BEGIN
        RETURN MONTHS_BETWEEN(SYSDATE, f_nac) /12;
    END edadActual;
END;

-- BODY DE JUGADOR
CREATE OR REPLACE TYPE BODY Jugador AS
    -- Muestra el usuario y su nivel
    MEMBER PROCEDURE mostrarEstadisticas IS
    BEGIN
        dbms_output.put_line('Jugador: ' || SELF.usuario || ' - Nivel: ' || SELF.nivel);
    END;
    
    -- Usamos el polimorfismo para sobreescribir la funcion de Persona: edadActual
    OVERRIDING MEMBER FUNCTION edadActual RETURN NUMBER IS
    BEGIN
        DECLARE
            edad NUMBER := FLOOR(MONTHS_BETWEEN(SYSDATE, SELF.f_nac) / 12);
        BEGIN
            IF edad >= 18 THEN
                dbms_output.put_line('Puede tener acceso a todos los niveles del juego');
            ELSE
                 dbms_output.put_line('No puede tener acceso a ciertos niveles');
            END IF;
            RETURN edad;
        END;
    END;
    
    -- Actualizamos el nombre del usuario
    MEMBER PROCEDURE cambiarNombreUsuario(nuevoNombre VARCHAR2) IS
    BEGIN
        SELF.usuario := nuevoNombre;
        dbms_output.put_line('Nombre de usuario actualizado: ' || SELF.usuario);
    END;
END;

-- BODY DE MODERADOR
CREATE OR REPLACE TYPE BODY Moderador AS






    
            



