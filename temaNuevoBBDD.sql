DROP DATABASE IF EXISTS medac_12;
CREATE DATABASE IF NOT EXISTS medac_12;
USE medac_12;

-- Crear la tabla profesores con el motor InnoDB
CREATE TABLE profesores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Crear la tabla asignaturas con el motor InnoDB
CREATE TABLE asignaturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_prof INT,
    CONSTRAINT fk_id_prof FOREIGN KEY (id_prof) REFERENCES profesores(id)
        ON UPDATE CASCADE
        ON DELETE SET NULL -- Si se elimina un profesor, la asignatura se queda sin profesor (NULL)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Crear la tabla alumnos con el motor InnoDB
CREATE TABLE alumnos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Crear la tabla asignatura_alumno con el motor InnoDB
CREATE TABLE asignatura_alumno (
    id_asig INT,
    id_alum INT,
    nota INT NOT NULL,
    PRIMARY KEY (id_asig, id_alum),
    CONSTRAINT fk_id_asig FOREIGN KEY (id_asig) REFERENCES asignaturas(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE, -- Si se elimina una asignatura, se elimina la relación con los alumnos
    CONSTRAINT fk_id_alum FOREIGN KEY (id_alum) REFERENCES alumnos(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE  -- Si se elimina un alumno, se elimina la relación con las asignaturas
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insertar datos en la tabla profesores
INSERT INTO profesores (id, nombre, apellidos) VALUES
(1, 'Dani', 'P.'),
(2, 'Miguel', 'P.'),
(3, 'Celia', 'M.');

-- Insertar datos en la tabla asignaturas
INSERT INTO asignaturas (nombre, id_prof) VALUES
('Bases de Datos', 3),
('Entornos de Desarrollo', 3),
('Programación', 1);

-- Insertar datos en la tabla alumnos
INSERT INTO alumnos (nombre, apellidos) VALUES
('Marcos', 'M.'),
('Laura', 'A.'),
('Juan', 'C.'),
('Inma', 'B.'),
('Lucas', 'B.');

-- Insertar datos en la tabla asignatura_alumno
INSERT INTO asignatura_alumno (id_asig, id_alum, nota) VALUES
(1, 1, 8),
(1, 5, 6),
(2, 1, 7),
(2, 5, 7),
(3, 2, 4),
(3, 1, 4);

-- Añadir a la alumna Marta P., que cursa únicamente la asignatura número 3.
INSERT INTO alumnos (nombre, apellidos) VALUES('Marta', 'P');
INSERT INTO asignatura_alumno (id_alum, id_asig, nota) VALUES(LAST_INSERT_ID(), 3, 10);

-- Inserta a la profesora Lidia M., que da la asignatura de "Francés". 
INSERT INTO profesores (nombre, apellidos) VALUES ("Lidia", "M."); 
INSERT INTO asignaturas (nombre, id_prof) VALUES ("Francés", last_insert_id());

-- Modificar la columna `id_prof` para permitir valores NULL
ALTER TABLE asignaturas
MODIFY COLUMN id_prof INT NULL;

-- Insertar asignatura sin profesor
INSERT INTO asignaturas (nombre, id_prof) VALUES ('asignaturaSinProfesor', NULL);

-- NUEVO TEMA
CREATE TABLE empresas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

INSERT INTO empresas (nombre) VALUES 
('NTER'),
('INNOVASUR'),
('GOOGLE');

CREATE TABLE practicas (
    id_alum INT NOT NULL PRIMARY KEY,
    id_empresa INT, -- Puede ser NULL si no hay empresa
    cursos TINYINT, -- Curso 1 sí, 0 no
    evaluacion_porcentaje DECIMAL(5,2), -- Evaluación por porcentaje para los cursos
    FOREIGN KEY (id_alum) REFERENCES alumnos(id),
    FOREIGN KEY (id_empresa) REFERENCES empresas(id)
);

-- 1. Muestra todos los alumnos que tengan alguna asignatura
SELECT DISTINCT id_alum
FROM asignatura_alumno;

-- Insertar todos los alumnos en la tabla prácticas
INSERT INTO practicas(id_alum)
	(SELECT DISTINCT id_alum
	FROM asignatura_alumno);
    
-- 2. Activa (1) los cursos para todos los alumnos que no tengan empresa asignada y pon el porcentaje a 0
UPDATE practicas SET
cursos = 1, evaluacion_porcentaje = 0;

-- QUITAR EL MODO SEGURO DE SQL PARA PODER MODIFICAR TABLAS
SET SQL_SAFE_UPDATES = 0;

-- 3. Edita el apellido de Celia y que ahora ponga Macias
UPDATE profesores
SET apellidos = 'Macias'
WHERE nombre LIKE 'Celia';

-- 4. Meter al alumno 1, la empresa 1
UPDATE practicas
SET id_empresa = 1
WHERE id_alum = 1;


UPDATE practicas SET
cursos = 1, evaluacion_porcentaje = 0
WHERE id_alum IS NULL;

-- Cambiar el porcentaje de alumno 5 y ponerlo al 12
UPDATE practicas SET evaluacion_porcentaje = 12
WHERE id_alum = 5;

SELECT * FROM practicas;
SELECT * FROM empresas;

-- Añade la empresa NTER a los alumnos que más asignaturas tengan

UPDATE practicas SET 
id_empresa = (SELECT id FROM empresas WHERE nombre LIKE 'NTER') 
WHERE id_alum IN 
	(SELECT id_alum
	FROM asignatura_alumno
	GROUP BY id_alum
	HAVING COUNT(id_alum) >= ALL
		(SELECT COUNT(id_alum) FROM asignatura_alumno GROUP BY id_alum)
        );

SELECT * FROM empresas;
SELECT * FROM practicas;

-- Borrar las asignaturas que no tengan profesor
-- DELETE 
-- FROM asignaturas
-- WHERE id_prof IS NULL;

-- Borrar al profesor Lidia
DELETE FROM profesores
WHERE nombre like 'Lidia';

SELECT * FROM profesores;
SELECT * FROM asignaturas;

-- Borrar alumno 1
DELETE FROM alumnos
WHERE id = 1;

DELETE FROM empresa
WHERE nombre = 'GOOGLE';

-- TEMA NUEVO INDICE Y VISTAS

CREATE VIEW vista_alum_asig AS
SELECT a.id as id_alumnos, a.nombre as nombre_alumno, a.apellidos, asi.id, asi.nombre, id_prof
FROM alumnos AS a
INNER JOIN asignatura_alumno AS aa ON aa.id_alum = a.id
INNER JOIN asignaturas AS asi ON asi.id = aa.id_asig;

SELECT * FROM vista_alum_asig;




















