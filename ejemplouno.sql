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
    (1, 3),
    (2, 3),
    (2, 2);
    
INSERT INTO Asignatura_Alumno(idAsignatura) values
	(3);

    

-- CONSULTAS

-- EJEMPLO: Muestra el nombre de la asignatura que imparte Celia

SELECT a.nombre FROM asignatura as a INNER JOIN profesor as p ON a.idProfesor = p.idProfesor WHERE p.nombre = 'Celia';

-- 1. Muestra el nombre de las asignaturas en las que está matriculado un alumno cuyo nombre sea "Juan".

SELECT asignatura.nombre FROM asignatura
INNER JOIN asignatura_alumno ON asignatura_alumno.idAsignatura = asignatura.idAsignatura 
INNER JOIN alumno ON asignatura_alumno.idAlumno = alumno.idAlumno
WHERE alumno.nombre = 'Juan';



-- 2. Encuentra todos los datos de los profesores que enseñan asignaturas en las que está matriculado el alumno "Juan".

SELECT pro.* from profesor as pro
INNER JOIN asignatura as asig ON asig.idProfesor = pro.idProfesor
INNER JOIN asignatura_alumno as asigAlu ON asigAlu.idAsignatura = asig.idAsignatura
INNER JOIN alumno as alu ON asigAlu.idAlumno = alu.idAlumno
WHERE alu.nombre = 'Juan';

-- 3. Muestra el nombre y apellidos con el título "Nombre completo" de cada alumno junto con el nombre de las asignaturas que cursa.

SELECT concat(alu.nombre, alu.apellidos) as Nombre_Completo, asig.nombre FROM alumno as alu
INNER JOIN asignatura_alumno as asigAlu ON asigAlu.idAlumno = alu.idAlumno
INNER JOIN asignatura as asig ON asigAlu.idAsignatura = asig.idAsignatura;

-- 4. Muestra el nombre de todas las asignaturas, incluyendo aquellas que no tienen alumnos matriculados.

SELECT distinct asig.nombre, asigAlu.*, alu.nombre FROM asignatura as asig
INNER JOIN asignatura_alumno as asigAlu ON asigAlu.idAsignatura = asig.idAsignatura
LEFT JOIN alumno as alu ON asigAlu.idAlumno = alu.idAlumno;



-- 5. Muestra el nombre de todas las asignaturas, incluyendo aquellas que no tienen alumnos matriculados.
-- 6. Muestra los nombres de los alumnos inscritos en las asignaturas impartidas por el/los profesores cuyo apellido empieza por "M".
-- 7. Obtén los profesores que tienen más de dos asignaturas asignadas.
-- 8. Encuentra los alumnos que no están matriculados en ninguna asignatura.
-- 9. Lista todas las asignaturas junto con el nombre del profesor que las imparte, incluyendo las asignaturas sin profesor.
-- 10. Muestra todos los alumnos y sus asignaturas, y los profesores que las imparten.
-- 11. Encuentra los profesores que no tienen asignaturas asignadas.
-- 12. Muestra los nombres de las asignaturas y los nombres de los alumnos que las cursan, incluyendo asignaturas sin alumnos.
-- 13. Encuentra las asignaturas con el mayor número de alumnos matriculados.
-- 14. Muestra los alumnos inscritos en más de una asignatura.
-- 15. Muestra el nombre de las asignaturas, el número de alumnos matriculados y el nombre del profesor que las imparte.












