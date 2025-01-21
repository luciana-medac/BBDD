DROP database if exists ejemplouno;
create database ejemplouno;
use ejemplouno;

CREATE TABLE Profesor (
	idProfesor int auto_increment primary key,
    nombre varchar(255),
    apellidos varchar(255)
);

CREATE TABLE Alumno (
	idAlumno int auto_increment primary key,
	nombre varchar(255),
    apellidos varchar(255)
);

CREATE TABLE Asignatura(
	idAsignatura int auto_increment primary key,
    nombre varchar(255),
    idProfesor int not null,
    FOREIGN KEY (idProfesor) references Profesor(idProfesor)
);

CREATE TABLE Asignatura_Alumno(
	idAsignatura int not null,
    idAlumno int null,
    FOREIGN KEY (idAsignatura) references Asignatura(idAsignatura),
	FOREIGN KEY (idAlumno) references Alumno(idAlumno)
);

-- DATOS

INSERT INTO Profesor(nombre, apellidos) values
	('Dani','P'),
    ('Miguel','P'),
    ('Celia', 'M');

INSERT INTO Alumno(nombre, apellidos) values
	('Marcos','M'),
    ('Laura','A'),
    ('Juan','C'),
    ('Inma','B'),
    ('Lucas','B');

INSERT INTO Asignatura(nombre, idProfesor) values
	('Base Datos', 3),
    ('Entornos', 3),
    ('Programacion', 1);

INSERT INTO Asignatura_Alumno(idAsignatura, idAlumno) values
	(1, 1),
    (1, 5),
    (2, 1),
    (2, 5),
    (3, 1),
    (3, 2);
    
-- INSERT INTO Asignatura_Alumno(idAsignatura) values
-- 	(3);

    

-- CONSULTAS

-- EJEMPLO: Muestra el nombre de la asignatura que imparte Celia

SELECT a.nombre FROM asignatura as a INNER JOIN profesor as p ON a.idProfesor = p.idProfesor WHERE p.nombre = 'Celia';

-- Nombre: Luciana Molina Gregoli
-- 1. Muestra el nombre de las asignaturas en las que está matriculado un alumno cuyo nombre sea "Juan".
SELECT asignatura.nombre FROM asignatura
INNER JOIN asignatura_alumno ON asignatura_alumno.idAsignatura = asignatura.idAsignatura 
INNER JOIN alumno ON asignatura_alumno.idAlumno = alumno.idAlumno
WHERE alumno.nombre = 'Juan';

-- Nombre: Luciana Molina Gregoli
-- 2. Muestra el nombre de las asignaturas en las que está matriculado un alumno cuyo nombre sea "Marcos".
SELECT DISTINCT asignatura.nombre FROM asignatura
INNER JOIN asignatura_alumno ON asignatura_alumno.idAsignatura = asignatura.idAsignatura
INNER JOIN alumno ON asignatura_alumno.idAlumno = alumno.idAlumno
WHERE alumno.nombre = 'Marcos';

-- Nombre: Luciana Molina Gregoli
-- 3. Encuentra todos los datos de los profesores que enseñan asignaturas en las que está matriculado el alumno "Juan".
SELECT pro.* from profesor as pro
INNER JOIN asignatura as asig ON asig.idProfesor = pro.idProfesor
INNER JOIN asignatura_alumno as asigAlu ON asigAlu.idAsignatura = asig.idAsignatura
INNER JOIN alumno as alu ON asigAlu.idAlumno = alu.idAlumno
WHERE alu.nombre = 'Juan';

-- Nombre: Luciana Molina Gregoli
-- 4. Encuentra todos los datos de los profesores que enseñan asignaturas en las que está matriculado el alumno "Juan".
SELECT profesor.* FROM profesor
INNER JOIN asignatura as asig ON asig.idProfesor = profesor.idProfesor
INNER JOIN asignatura_alumno as asiAlu ON asiAlu.idAsignatura = asig.idAsignatura
INNER JOIN alumno as alu ON asiAlu.idAlumno = alu.idAlumno
WHERE alu.nombre = 'Marcos';

-- Nombre: Luciana Molina Gregoli
-- 5. Muestra el nombre y apellidos con el título "Nombre completo" de cada alumno junto con el nombre de las asignaturas que cursa.
SELECT concat(alu.nombre, alu.apellidos) as Nombre_Completo, asig.nombre FROM alumno as alu
INNER JOIN asignatura_alumno as asigAlu ON asigAlu.idAlumno = alu.idAlumno
INNER JOIN asignatura as asig ON asigAlu.idAsignatura = asig.idAsignatura;

-- Nombre: Luciana Molina Gregoli
-- 6. Muestra los nombres de los alumnos inscritos en las asignaturas impartidas por el/los profesores cuyo apellido empieza por "M".
SELECT alu.nombre FROM alumno as alu
INNER JOIN asignatura_alumno as asigAlu ON asigAlu.idAlumno = alu.idAlumno
INNER JOIN asignatura as asig ON asigAlu.idAsignatura = asig.idAsignatura
INNER JOIN profesor as pro ON asig.idProfesor = pro.idProfesor
WHERE pro.apellidos LIKE 'M%';

-- Nombre: Luciana Molina Gregoli
-- 7. Obtén los profesores (columnas: nombre y apellido) que tienen dos o más asignaturas asignadas.
SELECT distinct pro.nombre, pro.apellidos FROM profesor as pro
INNER JOIN asignatura as asig ON asig.idProfesor = pro.idProfesor
GROUP BY pro.idProfesor, pro.nombre, pro.apellidos
HAVING count(asig.idAsignatura) >= 2;

-- Nombre: Luciana Molina Gregoli
-- 8.  Muestra todos los alumnos, el nombre de las asignaturas a las que asisten, 
-- y el nombre del profesor que imparte cada asignatura. Si un alumno no da ninguna asignatura no debe aparecer.
SELECT alu.nombre, asig.nombre, pro.nombre FROM alumno as alu
INNER JOIN asignatura_alumno as asiAlu ON asiAlu.idAlumno = alu.idAlumno
INNER JOIN asignatura as asig ON asiAlu.idAsignatura = asig.idAsignatura
INNER JOIN profesor as pro ON asig.idProfesor = pro.idProfesor;

-- Nombre: Luciana Molina Gregoli
-- 9. Muestra el nombre de las asignaturas y el número de alumnos matriculados en cada una.
SELECT asig.idAsignatura, asig.nombre as Asignatura, COUNT(asigAlu.idAsignatura) as num_Alumnos
FROM asignatura as asig
INNER JOIN asignatura_alumno as asigAlu ON asig.idAsignatura = asigAlu.idAsignatura
INNER JOIN alumno as alu ON asigAlu.idAlumno = alu.idAlumno
GROUP BY 1;

-- Nombre: Luciana Molina Gregoli
-- 10. Añade a la alumna Marta P., que cursa únicamente la asignatura número 3. (La última clave insertada es LAST_INSERT_ID())
INSERT INTO alumno (nombre, apellidos) values
	('Marta','P');
INSERT INTO asignatura_alumno (idAsignatura, idAlumno) values
	(3, last_insert_id());

-- Nombre: Luciana Molina Gregoli
-- 11. Estado actual de todas las tablas
SELECT pro.*, asig.*, asigAlu.*, alu.* FROM profesor as pro
INNER JOIN asignatura as asig ON asig.idProfesor = pro.idProfesor
INNER JOIN asignatura_alumno as asigAlu ON asigAlu.idAsignatura = asig.idAsignatura
INNER JOIN alumno as alu ON asigAlu.idAlumno = alu.idAlumno;

-- Nombre: Luciana Molina Gregoli
-- 12. Muestra el nombre y apellidos de los alumnos inscritos en más de una asignatura y el número de asignaturas que cursan.
SELECT alu.nombre, alu.apellidos, COUNT(asigAlu.idAsignatura) FROM alumno as alu
INNER JOIN asignatura_alumno as asigAlu ON alu.idAlumno = asigAlu.idAlumno
GROUP BY alu.idAlumno, alu.nombre, alu.apellidos
HAVING COUNT(asigAlu.idAsignatura) > 1;

-- Nombre: Luciana Molina Gregoli
-- 13. Muestra los apellidos de todos los alumnos que cursan asignaturas de profesores cuyo nombre contiene la letra 'a'.
SELECT alu.apellidos FROM alumno as alu
INNER JOIN asignatura_alumno as asigAlu ON asigAlu.idAlumno = alu.idAlumno
INNER JOIN asignatura as asig ON asig.idAsignatura = asigAlu.idAsignatura
INNER JOIN profesor as pro ON asig.idProfesor = pro.idProfesor
WHERE pro.nombre LIKE '%a%';

-- Nombre: Luciana Molina Gregoli
-- 14. Inserta a la profesora Lidia M., que da la asignatura de "Francés".
INSERT INTO profesor (nombre, apellidos) values
	('Lidia','M');
INSERT INTO asignatura (nombre, idProfesor) values
	('Frances', last_insert_id());

-- Nombre: Luciana Molina Gregoli
-- 15.  Realiza una captura de pantalla del estado actual de todas las tablas.
SELECT alu.*, asig.*, asigAlu.*, pro.* FROM alumno as alu
INNER JOIN asignatura_alumno as asigAlu ON asigAlu.idAlumno = alu.idAlumno
INNER JOIN asignatura as asig ON asig.idAsignatura = asigAlu.idAsignatura
INNER JOIN profesor as pro ON asig.idProfesor = pro.idProfesor;

-- Nombre: Luciana Molina Gregoli
-- 16. Explica la consulta con tus palabras
SELECT a.idAsignatura,a.nombre AS "Asignatura", COUNT(aa.idAsignatura) AS "número de alumnos"
FROM asignatura a
LEFT JOIN asignatura_alumno aa ON a.idAsignatura = aa.idAsignatura
GROUP BY 1;

-- 17. Observa las dos consultas anteriores y describe las similitudes y diferencias con tus palabras
-- Explicado en el pdf

-- 18. Encuentra los alumnos que no están matriculados en ninguna asignatura.
SELECT alu.nombre, COUNT(asigAlu.idAsignatura) as numAsignatura FROM alumno as alu
LEFT JOIN asignatura_alumno as asigAlu ON alu.idAlumno = asigAlu.idAlumno
GROUP BY 1;

-- 19. Edita la tabla asignaturas para que el id profesor que la imparte 
-- pueda ser un campo vacío (imagina que un profesor 
-- tiene que irse y la asignatura permanece una semana sin profesor)









