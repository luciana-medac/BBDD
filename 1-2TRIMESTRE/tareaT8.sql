DROP database if exists tareat8; -- se elimina la base de datos si exist
CREATE database tareat8; -- creamos la base de datos
USE tareat8; -- usamos la base de datos

-- Crear la tabla BANK --

CREATE TABLE Bank (
	idBank INT auto_increment primary key, -- clave primaria autoincremental (va asignando el número de forma automática e incrementandose conforme haya más datos)
	name VARCHAR(200) not null, -- not null es para que no se pueda dejar vacío el registro
    address VARCHAR (200) not null
);

-- Crear la tabla Banch --
CREATE TABLE Branch (
	idBranch INT auto_increment primary key,
    address VARCHAR (200) not null,
    idBank INT not null,
	FOREIGN KEY (idBank) REFERENCES Bank(idBank) -- Branch tiene una clave foránea que hace refencia a la tabla Bank al registro idBank
);
-- Crear la tabla Customer --
CREATE TABLE Customer (
	idCustomer INT primary key auto_increment,
    first_name VARCHAR(200) not null,
    last_name VARCHAR(200) not null,
    telephone VARCHAR(20) not null, 
    address VARCHAR(200) null -- Null para que si no se rellena el registro, no pasaría nada
);

-- Crear la tabla Account, se cambia el nombre porque account lo reconoce SQL como comando --
CREATE TABLE Cuenta (
	idCuenta INT auto_increment primary key,
    acct_type VARCHAR (200) not null,
    balance DECIMAL(10,2) not null,
    idBranch INT not null,
    idCustomer INT not null,
    FOREIGN KEY (idBranch) REFERENCES Branch(idBranch),
    FOREIGN KEY (idCustomer) REFERENCES Customer(idCustomer)
);

-- Crear la tabla Loan --
CREATE TABLE Loan (
	idLoan INT primary key auto_increment,
    loan_type VARCHAR(200) not null,
    amount DECIMAL(10,2)not null,
    idBranch INT not null,
    FOREIGN KEY (idBranch) REFERENCES Branch(idBranch)
);

-- Añadimos registros a las tablas creadas 

INSERT INTO Bank (name, address) VALUES -- No añadimos idBank porque es autoincremental, por lo que no es necesario
('Banco Central', 'Calle Santo Domingo'),
('Banco Suroeste', 'Calle Arrayán'),
('Banco Noreste', 'Calle Ebro'),
('Banco Oeste', 'Calle Guerra Fría');

INSERT INTO Branch (address, idBank) VALUES
('Sucursal Central', 1),
('Sucursal Suroeste', 2),
('Sucursal Noreste', 3),
('Sucursal Oeste', 4);

INSERT INTO Customer (first_name, last_name, telephone, address) VALUES
('Ramona', 'Lendinez', '675 421 785', 'Calle Rosales'),
('Ramon', 'Jaen', '742 531 951', 'Calle Via Verde'),
('Martina', 'Gonzalez', '784 152 956', 'Calle Pasta'),
('Alejandro', 'Martinez', '688 586 785', 'Calle Doctor');

INSERT INTO Cuenta (acct_type, balance, idBranch, idCustomer) VALUES
('Ahorros', 1700.00, 1, 2), -- Aquí tenemos que especificar que id de Branch y de Customer es, pero por ejemplo el idCuenta no lo ponemos por lo mismo que idBank
('Nómina', 1030.00, 2, 1),
('Jóven', 177.00, 3, 4),
('Corriente', 1200.00, 4, 3);

INSERT INTO Loan (loan_type, amount, idBranch) VALUES
('Hipotecaria',  50000.00, 4),
('Personal', 3500.00, 2);

-- Consultamos las tablas
SELECT * FROM Bank;
SELECT * FROM Branch;
SELECT * FROM Cuenta;
SELECT * FROM Loan;

-- AÑADIR UNA COLUMNA

ALTER TABLE Customer ADD COLUMN fnac date; -- Alteramos la tabla Customer, añadimos la columna de fecha de cumpleaños y ponemos el tipo de dato que es

-- Comprobamos que se ha añadido la columna a la tabla Customer

SELECT * FROM Customer;

-- RESTRICCIONES

ALTER TABLE Loan ADD CONSTRAINT chk_amount_pos CHECK (amount > 1000.00); -- Alteramos la tabla y añadimos una restricción a la columna amount para que tenga que ser más de 1000
ALTER TABLE Cuenta ADD CONSTRAINT chk_balance_pos CHECK (balance > 0); -- Aquí la restricción sería en la columna balance para que no pueda ser menos de 0











