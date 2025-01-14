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
    idAlumno int not null,
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
    (2, 5);
    

    

-- CONSULTAS

SELECT a.nombre FROM asignatura as a INNER JOIN profesor as p ON a.idProfesor = p.idProfesor WHERE p.nombre = 'Dani';
