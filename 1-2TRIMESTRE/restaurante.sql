DROP DATABASE IF EXISTS restaurante;
CREATE DATABASE IF NOT EXISTS restaurante;
USE restaurante;

CREATE TABLE plato (
	idPlato INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(100) NOT NULL
);

CREATE TABLE mesero (
	idMesero INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
	turno VARCHAR(50) NOT NULL,
    telefono INT(9) NOT NULL
);

CREATE TABLE pedido(
	idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idMesero INT NOT NULL,
    idPlato INT NOT NULL,
    mesa INT null,
    fecha DATE,
    tipoPedido VARCHAR(20) NOT NULL,
    telefono INT(9) null,
    direccion VARCHAR(100) null,
    FOREIGN KEY(idMesero) references mesero(idMesero),
    FOREIGN KEY(idPlato) references plato(idPlato)
);


INSERT INTO plato(nombre, precio, categoria) VALUES
	('chimichanga_de_la_casa', 2.50, 'chimichanga'),
    ('chimichanga_argentina', 2.50, 'chimichanga'),
    ('chimichanga_especial', 3.00, 'chimichanga'),
    ('empanada_de_carne', 2.00, 'empanada'),
    ('empanada_choclo', 2.10, 'empanada'),
    ('quesadilla_al_gusto', 1.50, 'quesadilla');

INSERT INTO mesero(nombre, turno, telefono) VALUES
	('Ana', 'manana', 111111111),
    ('Luis', 'tarde', 222222222),
    ('Marta','manana', 333333333),
    ('Pedro', 'manana', 444444444),
    ('Sofia', 'tarde', 555555555);
    
INSERT INTO pedido(idMesero, idPlato, mesa, fecha, tipoPedido) VALUES
	(1, 3, 5, '2025-04-01', 'restaurante'),
    (3, 3, 8, '2025-04-01', 'restaurante'),
    (4, 5, 17, '2025-04-01', 'restaurante');
   
INSERT INTO pedido(idMesero, idPlato, mesa, fecha, tipoPedido, telefono, direccion) VALUES
    (2, 2, 0, '2025-04-01', 'domicilio', 777777777, 'calle 123'),
    (5, 4, 0, '2025-04-01', 'domicilio', 888888888, 'calle 321');

SELECT 
	CONCAT(
		'<?xml version = "1.0" encoding="UTEF-8"?>',
        '\n <platos>',
			GROUP_CONCAT(
				CONCAT(
					'\n <plato>',
						'\n <id>', idPlato, '</id>',
						'\n <nombre>', nombre, '</nombre>',
                        '\n <precio>', precio, '</precio>',
                        '\n <categoria>', categoria, '</categoria>',
					'\n </plato>'
                    ) SEPARATOR ''
				),
                '\n <platos>'
			) AS xml_result
FROM plato;

SELECT 
	CONCAT(
		'<?xml version = "1.0" encoding="UTF-8"?>',
        '\n<meseros>',
			GROUP_CONCAT(
				CONCAT(
					'\n  <mesero>',
						'\n    <id>', idMesero, '</id>',
						'\n    <nombre>', nombre, '</nombre>',
                        '\n    <turno>', turno, '</turno>',
                        '\n    <telefono>', telefono, '</telefono>',
					'\n  </mesero>'
                    ) SEPARATOR ''
				),
        '\n</meseros>'
	) AS xml_result
FROM mesero;

SELECT 
	CONCAT(
		'<?xml version = "1.0" encoding="UTF-8"?>',
        '\n<pedidos>',
			GROUP_CONCAT(
				CONCAT(
					'\n  <pedido>',
						'\n    <id>', p.idPedido, '</id>',
						'\n    <fecha>', p.fecha, '</fecha>',
						'\n    <tipo>', p.tipoPedido, '</tipo>',
                        -- IFNULL sirve para reemplazar un dato nulo por un valor alternativo, de esta forma
						-- evitamos que en el xml salga: <mesa>null</mesa>
						'\n    <mesa>', IFNULL(p.mesa, ''), '</mesa>',
						'\n    <telefono>', IFNULL(p.telefono, ''), '</telefono>',
						'\n    <direccion>', IFNULL(p.direccion, ''), '</direccion>',
						'\n    <plato>',
							'\n      <id>', pl.idPlato, '</id>',
							'\n      <nombre>', pl.nombre, '</nombre>',
							'\n      <precio>', pl.precio, '</precio>',
						'\n    </plato>',
						'\n    <mesero>',
							'\n      <id>', m.idMesero, '</id>',
							'\n      <nombre>', m.nombre, '</nombre>',
						'\n    </mesero>',
					'\n  </pedido>'
                    ) SEPARATOR ''
				),
        '\n</pedidos>'
	) AS xml_result
FROM pedido p
JOIN plato pl ON p.idPlato = pl.idPlato
JOIN mesero m ON p.idMesero = m.idMesero;
