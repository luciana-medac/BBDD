DROP DATABASE IF EXISTS TiendaInformatica;
CREATE DATABASE TiendaInformatica;
USE TiendaInformatica;

CREATE TABLE Cliente (
	
    id_Cliente int auto_increment primary key,
	Nombre varchar(255),
    Direccion varchar(255),
    Ciudad varchar(255),
    Telefono varchar(25),
    Email varchar(255)
);

CREATE TABLE Fabricante (
	
    id_fab int auto_increment primary key,
	Nombre varchar(255),
    Pais varchar(255)
    
);

CREATE TABLE Producto (
	
    id_Producto int auto_increment primary key,
	id_fab int not null,
    Descripcion varchar(255),
    Precio decimal(10,2),
    Existencias int,
    
    FOREIGN KEY(id_fab) references Fabricante(id_fab)
);

CREATE TABLE Pedido(

	N_pedido int auto_increment primary key,
	Fecha_pedido date,
	Estado varchar(20),
	id_Cliente int,
	constraint fk_pedido_cliente foreign key (id_Cliente) references Cliente(id_Cliente)

);

CREATE TABLE Detalles_pedido(
	
    N_pedido int,
    id_Producto int,
    primary key (N_pedido, id_Producto),
    Cantidad int,
    foreign key (N_pedido) references Pedido(N_pedido),
    foreign key (id_Producto) references Producto (id_Producto)
    
);
    

-- Inserción de datos
-- Datos para CLIENTES
INSERT INTO Cliente (Nombre, Direccion, Ciudad, Telefono, Email)
VALUES
('Juan Pérez', 'Calle Falsa 123', 'Madrid', '600123456', 'juan.perez@example.com'),
('Ana López', 'Avenida Real 45', 'Barcelona', '650987654', 'ana.lopez@example.com'),
('Carlos García', 'Plaza Mayor 2', 'Valencia', '610555444', 'carlos.garcia@example.com'),
('Laura Martínez', 'Calle Sol 33', 'Sevilla', '620334556', 'laura.martinez@example.com'),
('Miguel Fernández', 'Avenida Luna 89', 'Bilbao', '630445667', 'miguel.fernandez@example.com'),
('Lucía Torres', 'Calle Luna 77', 'Granada', '600998776', 'lucia.torres@example.com'),
('Pedro Ruiz', 'Calle Estrella 55', 'Zaragoza', '650334998', 'pedro.ruiz@example.com'),
('Isabel Gómez', 'Calle Mayor 15', 'Toledo', '620443321', 'isabel.gomez@example.com'),
('José Morales', 'Avenida del Sol 78', 'Málaga', '640556778', 'jose.morales@example.com'),
('Elena Martín', 'Calle Mar 89', 'Alicante', '611223344', 'elena.martin@example.com'),
('Luis Sánchez', 'Calle Río 12', 'Córdoba', '650556677', 'luis.sanchez@example.com'),
('Carmen Díaz', 'Calle Rosa 5', 'Santander', '600667788', 'carmen.diaz@example.com'),
('Raúl Ramírez', 'Avenida Flor 90', 'La Coruña', '621223344', 'raul.ramirez@example.com'),
('Álvaro Vega', 'Calle Maravilla 56', 'Tarragona', '630778899', 'alvaro.vega@example.com'),
('Sofía López', 'Calle Estrella 77', 'Murcia', '601334556', 'sofia.lopez@example.com'),
('Daniel Ortega', 'Calle Paz 99', 'Almería', '620998776', 'daniel.ortega@example.com'),
('Marta Sánchez', 'Calle Jazmín 23', 'Jaén', '630889977', 'marta.sanchez@example.com'),
('Javier López', 'Avenida Campo 12', 'Pamplona', '611334455', 'javier.lopez@example.com'),
('Clara Torres', 'Calle Luna 89', 'Oviedo', '620443322', 'clara.torres@example.com'),
('Hugo Díaz', 'Calle Rayo 43', 'Huelva', '600112233', 'hugo.diaz@example.com');

-- Datos para FABRICANTES
INSERT INTO Fabricante (Nombre, Pais)
VALUES
('HP', 'Estados Unidos'),
('Dell', 'Estados Unidos'),
('Lenovo', 'China'),
('Asus', 'Taiwán'),
('Acer', 'Taiwán'),
('Samsung', 'Corea del Sur'),
('Sony', 'Japón'),
('Toshiba', 'Japón'),
('MSI', 'Taiwán'),
('Apple', 'Estados Unidos');

-- Datos para PRODUCTOS
INSERT INTO Producto (id_fab, Descripcion, Precio, Existencias)
VALUES
(1, 'Portátil HP Envy 13', 999.99, 10),
(2, 'Monitor Dell UltraSharp 27', 499.99, 5),
(3, 'Teclado mecánico Lenovo Legion', 89.99, 20),
(4, 'Placa base Asus ROG', 299.99, 8),
(5, 'Ordenador Acer Aspire 5', 599.99, 15),
(6, 'Disco duro Samsung EVO 1TB', 120.00, 50),
(7, 'Auriculares Sony WH-1000XM4', 350.00, 30),
(8, 'Portátil Toshiba Satellite', 700.00, 12),
(9, 'Tarjeta gráfica MSI RTX 3080', 899.99, 6),
(10, 'iPhone 14 Pro', 1199.99, 25),
(1, 'Impresora HP LaserJet', 199.99, 20),
(2, 'Docking Station Dell', 149.99, 10),
(3, 'Cargador Lenovo USB-C', 49.99, 40),
(4, 'Router Asus RT-AC86U', 189.99, 18),
(5, 'Chromebook Acer Spin', 450.00, 22),
(6, 'SSD Samsung 980 Pro 2TB', 220.00, 30),
(7, 'Cámara Sony Alpha A7 III', 2000.00, 8),
(8, 'Disco duro Toshiba Canvio', 99.99, 60),
(9, 'Placa base MSI MPG Z490', 250.00, 15),
(10, 'MacBook Pro 14"', 2199.99, 10);

-- Datos para PEDIDOS
INSERT INTO Pedido (Fecha_pedido, id_Cliente, Estado)
VALUES
('2024-01-01', 1, 'En proceso'),
('2023-01-01', 1, 'Completado'),
('2024-02-03', 2, 'Completado'),
('2023-02-03', 2, 'Cancelado'),
('2024-02-05', 3, 'Pendiente'),
('2023-02-05', 3, 'Pendiente');

-- Datos para DETALLES_PEDIDO
INSERT INTO Detalles_Pedido (N_pedido, id_Producto, Cantidad)
VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 4, 1),
(4, 5, 2),
(5, 1, 1),
(5, 6, 1),
(6, 2, 2);

-- Listado de todos los productos

-- SELECT * from Producto;

-- SELECT * from Detalles_Pedido where id_Cliente = 2;

-- SELECT * from Producto where precio > 100;

-- SELECT COUNT(*) AS cuenta_pedidos FROM Detalles_Pedido where importe > 1000;


select distinct (pais) from fabricante;
-- muestra los países sin que se repitan (eso lo hace el distinct)

truncate table detalles_pedido; 
-- elimina las filas de la tabla

select max(precio) as preciomax from producto;
-- muestra en una nueva tabla el precio mayor de la tabla productos

select * from producto order by precio desc;
-- muestra todo de la tabla en orden descendente del precio

select descripcion,existencias from producto where precio>=2000;
-- muestra las dos columnas de productos donde el precio sea mayor o igual que 2000

select * from Cliente where ciudad='Madrid' or ciudad='barcelona';
-- select * from Cliente where ciudad in('Madrid','Barcelona');

select * from Cliente where ciudad LIKE 'M%'; -- Filtra la ciudad que empiece por M

select AVG(precio) as precio_medio from Producto where id_fab=1;

select MIN(fecha_pedido) as f_min from Pedido;

select distinct pais from fabricante;

select fecha_pedido from pedido where fecha_pedido between '2024-01-01' AND '2024-02-05';

select nombre, concat(direccion, ' ',ciudad) as direc_completa from cliente;

select pais, COUNT(*) as num_total from fabricante group by pais;

-- where condiciona y filtra y having hace lo mismo solo que es necesario que haya un group by
-- de esta forma si quiero filtrar en la siguiente consulta, usaría HAVING

select pais, COUNT(*) as num_total from fabricante group by pais having num_total > 2;

SELECT * from pedido where id_cliente = 2;

SELECT id_producto, precio * 1.21 as precio_con_IVA from producto;

select count(*) as suma from producto where precio >= 1000;

select nombre, concat(direccion, ' ',ciudad) as direc_completa from cliente;
-- clientes con su nombre completo (direccion + ciudad) concatenados en un solo campo.

select pais, COUNT(*) as num_total from fabricante group by pais;
select pais, COUNT(*) as num_total from fabricante group by pais having num_total > 2;
-- fabricantes que hay en cada país

SELECT id_producto, precio * 1.21 as precio_con_IVA from producto;
-- Muestra en otra columna llamada precio_con_iva todos los datos de los productos.

SELECT UPPER(nombre) from Cliente;
-- Convertir nombres de clientes a mayúsculas

SELECT LOWER(descripcion) from Producto;
-- Convertir descripciones de productos a minúsculas

SELECT concat(UPPER(nombre), UPPER(direccion)) as nombre_completo from Cliente;
-- Escribir en una línea el nombre y la dirección de cada cliente en mayúsculas, en una columna llamada Nombre_Completo

SELECT concat('Producto: ', descripcion) as producto_descripcion from Producto;
-- Haz que la tabla productos empiece por producto: 

SELECT SUBSTR(pais, 1, 3) FROM Fabricante;
-- tres primeras letras del nombre de cada país  de fabricantes

SELECT REPLACE(direccion, 'Calle', 'Avda') from Cliente;
-- Reemplazar "Calle" por "Avda." en las direcciones de cliente

select datediff(sysdate(), fecha_pedido) as "Dias_Pasados" from pedido; 
-- dice cuantos dias han pasado desde la fecha que se indica hasta el dia de hoy

select last_day(fecha_pedido) from pedido; 
-- Obtener la última fecha del mes en que se realizó cada pedido (función LAST_DAY):

select estado, 
-- Asignar un estado personalizado a los pedidos dependiendo de su estado actual, 'Finalizado', 'Anulado'
	case
	when 'Completado' then 'finalizado'
    when 'Cancelado' then 'Anulado'
    end as "estado" from pedido;
    
select * from pedido where fecha_pedido between "2023-01-01" and "2023-12-31"; 
-- Obtener los pedidos realizados en 2023.

select power(precio,2) from producto; 
-- Elevar el precio de cada producto al cuadrado

select round(precio,1) from producto; 
-- redondea a un decimal 

select extract(year from fecha_pedido) from pedido; 
-- extrae el año de la fecha seleccionada mediante extract

select count( extract(year from fecha_pedido))from pedido ; 
-- cuenta cuantos pedidos se han realizado en cada año

select reverse(nombre) from cliente; 
-- da la vuelta a los nombres, los pone a la inversa

-- SELECT TRIM('   ejemplo de texto   ') AS Texto_Limpio  FROM DUAL;

select 
nombre, 
pais, 
row_number() over (
partition by pais ) as rango
from fabricante;
-- asignar un rango a los fabricantes de un pais



