use tiendainformatica;

-- Convertir los nombres de los clientes a mayúscula
SELECT UPPER(nombre) from Cliente;

-- Convertir descripciones de productos a minúsculas
SELECT LOWER(descripcion) from Producto;

-- Escribir en una línea el nombre y la dirección de cada cliente
-- En mayúscula y en una columna llamada Nombre_Completo

SELECT concat(UPPER(nombre), UPPER(direccion)) as nombre_completo from Cliente;

SELECT concat('Producto: ', descripcion) as producto_descripcion from Producto;

SELECT SUBSTR(pais, 1, 3) FROM Fabricante;

SELECT REPLACE(direccion, 'Calle', 'Avda') from Cliente;