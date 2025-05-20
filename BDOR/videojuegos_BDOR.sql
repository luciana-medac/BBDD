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
    
    CONSTRUCTOR FUNCTION Jugador(
        nivel NUMBER,
        usuario VARCHAR2) RETURN SELF AS RESULT,
    
    MEMBER PROCEDURE mostrarEstadisticas,
    MEMBER PROCEDURE cambiarNombreUsuario(nuevoNombre VARCHAR2),
    OVERRIDING MEMBER FUNCTION edadActual RETURN NUMBER,
    MEMBER PROCEDURE aumentarNivel(nivel NUMBER)
    
);

-- DEFINICION DE UN TIPO OBJETO MODERADOR
CREATE OR REPLACE TYPE Moderador UNDER Persona(
    nivelAsignado VARCHAR2(50),
    nivelAutorizacion NUMBER(2),
    
    MEMBER PROCEDURE banearUsuario(nombreUsuario VARCHAR2),
    MEMBER FUNCTION esSenior RETURN BOOLEAN
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
    -- Constructor personalizado con orden cambiada
    CONSTRUCTOR FUNCTION Jugador( nivel NUMBER, usuario VARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
        SELF.nivel := nivel;
        SELF.usuario := usuario;
        RETURN;
    END;

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
    
    -- Actualizar el nivel
    MEMBER PROCEDURE aumentarNivel(nivel NUMBER) IS
    BEGIN
        self.nivel := self.nivel + nivel;
    END aumentarNivel;
END;

-- BODY DE MODERADOR
CREATE OR REPLACE TYPE BODY Moderador AS
    MEMBER PROCEDURE banearUsuario(nombreUsuario VARCHAR2) IS
    BEGIN
        dbms_output.put_line('Usuario ' || nombreUsuario || ' ha sido baneado por el moderador ' || SELF.nombre);
    END;
    
    MEMBER FUNCTION esSenior RETURN  BOOLEAN IS
    BEGIN
        RETURN SELF.nivelAutorizacion >= 5;
    END;
END;

-- CREAMOS LAS TABLAS
CREATE TABLE Jugadores OF Jugador;
CREATE TABLE Moderadores OF Moderador;

DROP TABLE Jugadores;
DROP TABLE Moderadores;

-- INSERTAMOS DATOS 
DECLARE
    Jugador1 Jugador;
    Jugador2 Jugador;
BEGIN
    Jugador1 := new Jugador('Sebastian', 'sebas@example.com', Direccion('C/Flores', 'Cordoba', 45001), '08-08-1998', 23, 'sebas123');
    Jugador2 := new Jugador('Sara', 'sara@example.com', Direccion('C/Arcoiris', 'Sevilla', 32003), '04-06-2005', 43, 'sarita8');
    
    INSERT INTO Jugadores VALUES(Jugador1);
    INSERT INTO Jugadores VALUES(Jugador2);
    
    dbms_output.put_line('Jugador 1: ' || jugador1.usuario || ' Jugador 2: ' || jugador2.usuario);
END;

DECLARE
    Moderador1 Moderador;
    Moderador2 Moderador;
BEGIN
    Moderador1 := new Moderador('Martin', 'martin@example.com', Direccion('C/Ajedrez', 'Barcelona', 42001), '16-06-1998', 'Mazmorras', 7);
    Moderador2 := new Moderador('Laura', 'laura@example.com', Direccion('C/Naranja', 'Tenerife', 28007), '12-11-1996', 'Aguas Marinas', 3);
    
    INSERT INTO Moderadores VALUES(Moderador1);
    INSERT INTO Moderadores VALUES(Moderador2);
    
    dbms_output.put_line('El moderador: ' || Moderador1.nombre || ' tiene el nivel de moderacion: ' || Moderador1.nivelAutorizacion || 
    ' El moderador: ' || Moderador2.nombre || ' tiene el nivel de moderacion: ' || Moderador2.nivelAutorizacion);

END;

SELECT * FROM Jugadores;
SELECT * FROM Moderadores;

-- PRUEBAS DE LOS MÉTODOS DE JUGADOR
DECLARE
    jd Jugador;
BEGIN
    SELECT VALUE(jg) INTO jd FROM Jugadores jg WHERE jg.usuario = 'sebas123';
    -- Mostramos las estadisticas del jugador
    jd.mostrarEstadisticas;
    
   -- Mostramos la edad del jugador
    dbms_output.put_line('La edad del jugador ' || jd.nombre || ' es: ' || jd.edadActual);
    
    -- Cambiar nombre de usuario
    jd.cambiarNombreUsuario('sebasputoamo7'); 
    
    -- Mostramos los cambios
    jd.mostrarEstadisticas;
END;

-- PRUEBA DE LOS MÉTODOS DE MODERADOR
DECLARE
    m Moderador;
    senior BOOLEAN;
BEGIN
    SELECT VALUE(mod) INTO m FROM Moderadores mod WHERE mod.nombre = 'Laura';
    
    m.banearUsuario('sarita8');
    
    -- Verificamos si es senior según su nivel de acceso
    senior := m.esSenior;
    IF senior THEN
        dbms_output.put_line('El moderador es senior');
    ELSE
        dbms_output.put_line('El moderador no es senior');
    END IF;
    
    -- Mostrar la edad del moderador 
    dbms_output.put_line('Edad del moderador: ' || m.edadActual); -- No saldrá con la edad redondeada porque no tiene polimorfismo
END;


-- UPDATE
DECLARE
    jg Jugador;
BEGIN
    SELECT VALUE(jd) INTO jg FROM Jugadores jd WHERE jd.usuario = 'sarita8';
    
    -- Para utilizar la funcion, hay que definirla y añadirla al body de Jugador
    jg.aumentarNivel(10); -- le aumentamos 10 niveles más
    -- Actualizamos los datos de la tabla
    UPDATE Jugadores jd SET VALUE(jd) = jg WHERE jd.usuario = 'sarita8';
    -- Mostramos el resultado
    dbms_output.put_line('El nivel de: ' || jg.usuario || ' se ha actualizado a: ' || jg.nivel);
END;
    




    
            



