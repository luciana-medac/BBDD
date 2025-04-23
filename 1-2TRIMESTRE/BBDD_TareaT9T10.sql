use tiendainformatica;

-- Nombre: Luciana Molina Gregoli
-- Consulta 1
SELECT * from producto where precio >= 300 and existencias = 10;

-- Nombre: Luciana Molina Gregoli
-- Consulta 2
SELECT * from pedido where estado = 'Pendiente';

-- Nombre: Luciana Molina Gregoli
-- Consulta 3
SELECT COUNT(precio > 500) as Productos_caros from producto;

-- Nombre: Luciana Molina Grgeoli
-- Consulta 4
SELECT nombre, ciudad from cliente where ciudad = 'Granada';

-- Nombre: Luciana Molina Gregoli
-- Consulta 5
SELECT distinct estado from pedido;

-- Nombre: Luciana Molina Gregoli
-- Consulta 6
SELECT * from pedido where fecha_pedido between "2023-01-01" and "2023-01-31";

-- Nombre: Luciana Molina Gregoli
-- Consulta 7
SELECT nombre, concat(UPPER(direccion), ', ', UPPER(ciudad)) as Ubicacion from cliente;

-- Nombre: Luciana Molina Gregoli
-- Consulta 8
SELECT estado, COUNT(*) as num_estados from pedido group by estado;

-- Nombre: Luciana Molina Gregoli
-- Consulta 9
SELECT descripcion, precio, precio * 0.5 as precio_con_descuento from producto;

-- Nombre: Luciana Molina Gregoli
-- Consulta 10
SELECT replace(direccion, 'Avenida', 'Avda') from cliente;

-- Nombre: Luciana Molina Gregoli
-- Consulta 11
SELECT descripcion, precio from producto where precio >= 200 and precio <= 800;

-- Nombre: Luciana Molina Gregoli
-- Consulta 12
SELECT * from cliente where ciudad like 'B%';

-- Nombre: Luciana Molina Gregoli
-- Consulta 13
SELECT n_pedido, datediff('2024-12-31', fecha_pedido) as dias_pedidos from pedido;

-- Nombre: Luciana Molina Gregoli
-- Consulta 14
SELECT descripcion, ROUND(precio, 0) as Precio_redondeado from producto;

-- Nombre: Luciana Molina Gregoli
-- Consulta 15
SELECT id_fab, AVG(existencias) as Promedio_existencias from producto group by id_fab;

-- Nombre: Luciana Molina Gregoli
-- Consulta 16
INSERT INTO Cliente (Nombre, Direccion, Ciudad, Telefono, Email)
VALUES ('   María López   ', 'Calle Luna 90', 'Cádiz', '612345678', 'maria.lopez@example.com');

SELECT nombre, TRIM(nombre) AS texto_limpio from cliente;

-- Nombre Luciana Molina Gregoli
-- Consulta 17

select descripcion, precio,
	case
	when  precio <= 500 then 'Barato'
    when precio > 500 then 'Caro'
    end as "categoria_precio" from producto;
    
-- Nombre: Luciana Molina Gregoli
-- Consulta 18
SELECT id_fab, sum(existencias) as total_existencias from producto group by id_fab HAVING total_existencias > 50;





