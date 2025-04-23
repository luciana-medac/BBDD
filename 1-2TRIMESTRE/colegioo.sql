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

-- TAREA DE CONSULTAS DEL TEMA 11

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
SELECT asig.idAsignatura, asig.nombre, COUNT(asigAlu.idAsignatura) as num_Alumnos
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

-- Nombre: Luciana Molina Gregoli
-- 18. Encuentra los alumnos que no están matriculados en ninguna asignatura.
SELECT alu.nombre, COUNT(asigAlu.idAsignatura) as numAsignatura FROM alumno as alu
LEFT JOIN asignatura_alumno as asigAlu ON alu.idAlumno = asigAlu.idAlumno
GROUP BY 1;
-- Consulta modificada
SELECT alu.*, asigAlu.idAsignatura
FROM alumno as alu
LEFT JOIN asignatura_alumno as asigAlu ON alu.idAlumno = asigAlu.idAlumno
WHERE asigAlu.idAlumno is null;

-- Nombre: Luciana Molina Gregoli
-- 19. Edita la tabla asignaturas para que el id profesor que la imparte 
-- pueda ser un campo vacío (imagina que un profesor tiene que irse y la asignatura permanece una semana sin profesor)
ALTER TABLE asignatura
MODIFY COLUMN idProfesor int null;

-- Nombre: Luciana Molina Gregoli
-- 20. Inserta la asignatura ‘asignaturaSinProfesor’ y muestra una captura de pantalla de la tabla asignaturas.
INSERT INTO asignatura(nombre) values
	('asignaturaSinProfesor');
    
SELECT * FROM asignatura;

-- Nombre: Luciana Molina Gregoli
-- 21. Lista todas las asignaturas junto con el nombre del profesor que las imparte, incluyendo las asignaturas sin profesor.
SELECT asig.*, pro.nombre FROM asignatura as asig
LEFT JOIN profesor as pro ON asig.idProfesor = pro.idProfesor;

-- Nombre: Luciana Molina Gregoli
-- 22. Muestra los nombres de las asignaturas y los nombres de los alumnos que las 
-- cursan, incluyendo asignaturas sin alumnos.
SELECT asig.*, alu.nombre FROM asignatura as asig
LEFT JOIN asignatura_alumno as asigAlu ON asigAlu.idAsignatura = asig.idAsignatura
LEFT JOIN alumno as alu ON asigAlu.idAlumno = alu.idAlumno;

-- Nombre: Luciana Molina Gregoli
-- 23. Muestra el nombre de las asignaturas, el número de alumnos matriculados y el nombre del profesor que las imparte.
SELECT asig.nombre as Asignatura, COUNT(asigAlu.idAsignatura) as num_Alumnos, pro.nombre, pro.apellidos
FROM asignatura as asig
LEFT JOIN asignatura_alumno as asigAlu ON asig.idAsignatura = asigAlu.idAsignatura
LEFT JOIN alumno as alu ON asigAlu.idAlumno = alu.idAlumno
LEFT JOIN profesor as pro ON asig.idProfesor = pro.idProfesor
GROUP BY asig.nombre, pro.nombre, pro.apellidos;  -- Se agrupa por las columnas que se van a seleccionar

-- Nombre: Luciana Molina Gregoli
-- 24. Muestra el nombre de las asignaturas que tienen profesor asignado, el número de alumnos matriculados y el nombre del profesor que las imparte.
SELECT asig.nombre as Asignatura, COUNT(asigAlu.idAsignatura) as num_Alumnos, pro.nombre, pro.apellidos
FROM asignatura as asig
INNER JOIN profesor as pro ON asig.idProfesor = pro.idProfesor
LEFT JOIN asignatura_alumno as asigAlu ON asig.idAsignatura = asigAlu.idAsignatura
LEFT JOIN alumno as alu ON asigAlu.idAlumno = alu.idAlumno
GROUP BY asig.nombre, pro.nombre, pro.apellidos;

-- Nombre: Luciana Molina Gregoli
-- 25. Muestra el nombre de las asignaturas que tienen profesor asignado
-- y alumnos matriculados. Muestra el número de alumnos matriculados y el nombre del profesor que las imparte.
SELECT asig.nombre as Asignatura, COUNT(asigAlu.idAsignatura) as num_Alumnos, pro.nombre, pro.apellidos
FROM asignatura as asig
INNER JOIN profesor as pro ON asig.idProfesor = pro.idProfesor
INNER JOIN asignatura_alumno as asigAlu ON asig.idAsignatura = asigAlu.idAsignatura
INNER JOIN alumno as alu ON asigAlu.idAlumno = alu.idAlumno
GROUP BY asig.nombre, pro.nombre, pro.apellidos;


-- TAREA 2 SUBCONSULTAS

-- 1. Muestra todos los datos de las asignatras que no tienen alumnos inscritos
SELECT * 
FROM asignatura as asig
WHERE idAsignatura NOT IN (SELECT idAsignatura FROM asignatura_alumno);

-- 2. Muestra el nombre de los profesores que imparten alguna asignatura
-- a. OPCION JOIN
SELECT pro.nombre FROM profesor as pro
INNER JOIN asignatura as asig ON pro.idProfesor = asig.idProfesor;
-- b. OPCION SUBCONSULTA
SELECT pro.nombre 
FROM profesor as pro
WHERE idProfesor = ANY (SELECT idProfesor FROM asignatura);

-- 3.Muestra el nombre de los profesores que NO imparten ninguna asignatura
-- a. OPCION JOIN
SELECT pro.nombre FROM profesor as pro
LEFT JOIN asignatura as asig ON pro.idProfesor = asig.idProfesor
WHERE asig.idProfesor is null;
-- b. OPCION SUBCONSULTA
SELECT nombre FROM profesor
WHERE idProfesor NOT IN 
		(SELECT idProfesor FROM asignatura 
			WHERE idProfesor is not null);

-- 4. Edita la tabla asignatura_alumno y añade el campo nota, un valor entero no nulo
ALTER TABLE asignatura_alumno
ADD COLUMN nota int;

UPDATE asignatura_alumno SET nota = 8 WHERE idAlumno = 1 AND idAsignatura = 1;
UPDATE asignatura_alumno SET nota = 6 WHERE idAlumno = 5 AND idAsignatura = 1;
UPDATE asignatura_alumno SET nota = 7 WHERE idAlumno = 1 AND idAsignatura = 2;
UPDATE asignatura_alumno SET nota = 7 WHERE idAlumno = 5 AND idAsignatura = 2;
UPDATE asignatura_alumno SET nota = 4 WHERE idAlumno = 2 AND idAsignatura = 3;
UPDATE asignatura_alumno SET nota = 4 WHERE idAlumno = 1 AND idAsignatura = 3;
UPDATE asignatura_alumno SET nota = 10 WHERE idAlumno = 6 AND idAsignatura = 3;

SELECT * FROM asignatura_alumno;

-- 5. Selecciona las tuplas de la tabla asignatura_alumno que tengan la nota más baja que el resto
SELECT * FROM asignatura_alumno
WHERE nota <= ALL (SELECT nota FROM asignatura_alumno);

-- 6. Selecciona las tuplas de la tabla asignatura_alumno que tengan la nota más baja
SELECT * FROM asignatura_alumno
WHERE nota < ANY (SELECT nota FROM asignatura_alumno);

-- 7. ¿Cuántas tuplas tienen una nota mayor que la nota más baja?
SELECT * FROM asignatura_alumno
WHERE nota > ANY (SELECT nota FROM asignatura_alumno);
-- Respuesta: 5 tuplas son las que tienen mayor nota que la más baja

-- 8.Muestra en una sola columna el nombre y apellidos de los alumnos de Bases de Datos
-- que tienen la nota superior a la media de esa asignatura. 
-- (La media se representa con AVG)

SELECT CONCAT(nombre, apellidos) as Alumnos_BBDD FROM alumno as alu
INNER JOIN asignatura_alumno as asigAlu ON asigAlu.idAlumno = alu.idAlumno
WHERE idAsignatura = 1 AND asigAlu.nota > (SELECT AVG(nota) FROM asignatura_alumno WHERE idAsignatura = 1);

-- Pruebas ejercicio 8
SELECT AVG(nota) FROM asignatura_alumno WHERE idAsignatura = 1;
SELECT * FROM asignatura_alumno;
SELECT * FROM alumno;
SELECT * FROM asignatura;


-- TAREAS Y CONSULTAS EXTRA
-- 9. Realiza una consulta con IN o NOT IN.
-- Muestra todos los datos de las asignaturas que no tienen profesor
SELECT * FROM asignatura
WHERE idAsignatura IN (SELECT idAsignatura FROM asignatura WHERE idProfesor is null);

-- 10.Realiza una consulta con ANY o ALL.
-- Selecciona las notas de la tabla asignatura_alumno que tengan la nota más alta
-- que el resto en la asignatura de programacion
SELECT nota FROM asignatura_alumno
WHERE nota >= ALL (SELECT nota FROM asignatura_alumno WHERE idAsignatura = 3);

-- 11.Realiza una consulta con AVG, MAX o MIN.
-- Muestra los alumnos que tengan media más alta de todas las asignaturas
SELECT nombre FROM alumno as alu
INNER JOIN asignatura_alumno as asigAlu ON asigAlu.idAlumno = alu.idAlumno
WHERE AVG(nota) > (SELECT AVG(nota) FROM asignatura_alumno);

-- 12.Realiza una consulta con COUNT o SUM.
-- Cuantos alumnos tienen una nota mayor a la media de todas las asignaturas
SELECT COUNT(asigAlu.idAlumno) as AlumDestacados 
FROM asignatura_alumno as asigAlu
WHERE asigAlu.nota > (SELECT AVG(nota) FROM asignatura_alumno);

-- 13.Realiza una consulta con HAVING.
-- Muestra los alumnos tienen una media mayor a 6 en todas las asignaturas
SELECT alu.nombre, alu.apellidos, AVG(nota) as media FROM alumno as alu
INNER JOIN asignatura_alumno as asigAlu ON asigAlu.idAlumno = alu.idAlumno
GROUP BY asigAlu.idAlumno
HAVING AVG(nota) > 6;

-- TEMA NUEVO INDICE Y VISTAS

CREATE VIEW vista_alum_asig
