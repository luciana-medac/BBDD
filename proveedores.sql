-- Luciana Molina
DROP database if exists proveedores;
create database proveedores;
use proveedores;
create table proveedor (
	codigo int auto_increment primary key,
    ciudad varchar(50) not null, -- Not null es para tener que rellenarlo si o si
    provincia varchar(50) not null,
    direccion varchar(255) null -- null, no es necesario rellenarlo, si no se le especifica, funciona igual
);

create table categoria (
	codigo varchar(20) primary key,
    nombre varchar(100) unique not null-- unique es que aunque nombre no es clave primaria, 
	-- este campo tampoco se puede repetir
);

create table pieza (
	codigo int auto_increment primary key,
    nombre varchar(100) not null,
    color varchar(50) not null,
    precio decimal(4,2), -- 4,2 significa que puede poner cuatro números antes de la coma y dos decimaes (9999,99)
    cod_categoria varchar(20) not null,
    FOREIGN KEY (cod_categoria) references categoria(codigo)
);

create table suministra (
	cod_proveedor int,
    cod_pieza int,
    cantidad int not null,
    fecha date,
    primary key(cod_proveedor, cod_pieza, fecha),
    foreign key (cod_proveedor) references proveedor(codigo),
    foreign key (cod_pieza) references pieza(codigo)
);

insert into proveedor (ciudad, provincia, direccion) values
('Madrid' , 'Madrid' , 'Calle Gran Via, 100'),
('Martos' , 'Jaen' , 'Avenida Ejercito Español, 2' ),
('Linares' , 'Jaen' , NULL);

select * from proveedor; 

insert into categoria (codigo, nombre) values
('COD001' , 'Perifericos'),
('COD002' , 'Almacenamiento'),
('COD003' , 'Discos duros');

insert into pieza (codigo, nombre, color, precio, cod_categoria) values
('Raton' , 'Rojo' , 10.50, 'COD001'),
('HDD 500' , 'Negro' , 45, 'COD003'),
('RAM 4GB' , 'Azul' , 100, 'COD002');











