CREATE DATABASE tarea;
USE tarea;

CREATE TABLE cliente (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,  -- Campo para el ID único del cliente
    Nombre VARCHAR(100),                      -- Campo para el nombre del cliente
    Estatura DECIMAL(5,2),                    -- Campo para la estatura del cliente con dos decimales
    FechaNacimiento DATE,                     -- Campo para la fecha de nacimiento del cliente
    Sueldo DECIMAL(10,2)                      -- Campo para el sueldo del cliente con dos decimales
);

-- INSERTAR 2 DATOS SOLO PARA PROBAR
INSERT INTO cliente(Nombre,Estatura,FechaNacimiento,Sueldo)VALUES
	('Diego',1.61,'2002-08-03',2500.00),
    ('Alejandro',1.78,'2003-04-28',1200.00);


-- PROCEDIMIENDO PARA SELECCIONAR TODOS LOS DATOS DE LA TABLA
DELIMITER //
CREATE PROCEDURE verDatos()
BEGIN
    SELECT * FROM cliente;
END //
DELIMITER ;
-- LLAMAR AL PROCEDIMIENTO 
CALL verDatos();

-- PROCEDIMIENTO PARA INSERTAR DATOS
DELIMITER //
CREATE PROCEDURE agregarCliente(
    IN nombre VARCHAR(100),
    IN estatura DECIMAL(5,2),
    IN fechaNacimiento DATE,
    IN sueldo DECIMAL(10,2)
)
BEGIN
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)
    VALUES (nombre, estatura, fechaNacimiento, sueldo);
END //
DELIMITER ;
-- LLAMAR AL PROCEDIMIENTO
CALL agregarCliente('Kevin Flores', 1.75, '2003-05-15', 980.50);

-- CREAR EL PROCEDIMIENTO PARA ACTUALIZAR LA FECHA DE NACIMIENTO
DELIMITER //
CREATE PROCEDURE actualizarEdadCliente(
    IN clienteID INT,
    IN nuevaFechaNacimiento DATE
)
BEGIN
    UPDATE cliente
    SET FechaNacimiento = nuevaFechaNacimiento
    WHERE ClienteID = clienteID;
END //
DELIMITER ;

-- CREAR EL PROCEDIMIENTO PARA ELIMINAR UN CLIENTE POR ID
DELIMITER //
CREATE PROCEDURE EliminarCliente(
    IN clienteID INT
)
BEGIN
    DELETE FROM cliente
    WHERE ClienteID = clienteID;
END //
DELIMITER ;

-- CONDICIONAL IF
DELIMITER //
CREATE PROCEDURE verificarEdadCliente(
    IN clienteID INT,
    OUT esMayor22 BOOLEAN
)
BEGIN
    DECLARE edad INT;

    -- Calcular la edad en años basada en la fecha de nacimiento
    SELECT TIMESTAMPDIFF(YEAR, FechaNacimiento, CURDATE()) INTO edad
    FROM cliente
    WHERE ClienteID = clienteID;

    -- Verificar si la edad es mayor o igual a 22
    IF edad >= 22 THEN
        SET esMayor22 = TRUE;
    ELSE
        SET esMayor22 = FALSE;
    END IF;
END //
DELIMITER ;

-- CREAR LA TABLA ORDENES CON SUS RELACIONEs
CREATE TABLE ordenes (
    OrdenID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,                       
    FechaOrden DATE,                  
    Monto DECIMAL(10,2),                 
    Descripcion VARCHAR(255),            
    FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID) ON DELETE CASCADE
);
-- PROCEDIMIENTO PARA INGRESAR UNA ORDEN 
DELIMITER //
CREATE PROCEDURE ingresartarOrden(
    IN clienteID INT,
    IN fechaOrden DATE,
    IN monto DECIMAL(10,2),
    IN descripcion VARCHAR(255)
)
BEGIN
    INSERT INTO ordenes (ClienteID, FechaOrden, Monto, Descripcion)
    VALUES (clienteID, fechaOrden, monto, descripcion);
END //
DELIMITER ;

-- PROCEDIMIENTO PARA ACTUALIZAR UNA ORDEN 
DELIMITER //
CREATE PROCEDURE ActualizarOrden(
    IN ordenID INT,
    IN nuevoMonto DECIMAL(10,2),
    IN nuevaDescripcion VARCHAR(255)
)
BEGIN
    UPDATE ordenes
    SET Monto = nuevoMonto, Descripcion = nuevaDescripcion
    WHERE OrdenID = ordenID;
END //
DELIMITER ;

-- PROCEDIMIENTO PARA ELIMINAR UNA ORDEN
DELIMITER //
CREATE PROCEDURE eliminarOrden(
    IN ordenID INT
)
BEGIN
    DELETE FROM ordenes
    WHERE OrdenID = ordenID;
END //
DELIMITER ;
