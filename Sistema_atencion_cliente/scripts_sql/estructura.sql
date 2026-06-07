/*
    ESTA BASE DE DATOS ES UN SISTEMA PARA EL CONTROL DE ATENCION AL CLIENTE.

    LEER LA DESCRIPCION EN EL README

*/

-- CREAMOS LA BASE DE DATOS SI NO EXISTE
CREATE DATABASE IF NOT EXISTS sistema_atencion_clientes;

-- UTILIZAMOS LA BASE DE DATOS
USE sistema_atencion_clientes;

-- CREAMOS UNA TABLA PARA LOS CLIENTES
CREATE TABLE sistema_atencion_clientes.clientes(
    id_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);

-- CREAMOS UNA TABLA DE LOS EMPLEADOS QUE ATENDERAN A LOS CLIENTES
CREATE TABLE sistema_atencion_clientes.empleados(
    id_empleado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);

-- CREAMOS UNA TABLA PARA REGISTRAR LAS AUDITORIAS DEL SISTEMA (LA BASE DE DATOS)
CREATE TABLE sistema_atencion_clientes.auditoria(
    id_auditoria INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNSIGNED,
    id_empleado INT UNSIGNED,
    duracion TIME
);

CREATE TABLE sistema_atencion_clientes.atencion_cliente(
    id_atencion_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNSIGNED,
    estado VARCHAR(15) DEFAULT 'EN ESPERA',
    fecha_atencion DATE,
    hora_comienzo TIME NOT NULL,
    hora_final TIME DEFAULT NULL
);



-- CREACION DE STORED PROCEDURE

-- STORE PROCEDURE PARA REGISTRAR A LOS CLIENTES
DELIMITER //
CREATE PROCEDURE sistema_atencion_clientes.sp_registrar_cliente(
    IN i_nombre VARCHAR(20),
    IN i_apellido VARCHAR(20),
    IN i_email VARCHAR(50),
    OUT o_respuesta VARCHAR(40)
)

BEGIN

    -- DECLARAMOS EL MANEJADOR DE ERRORES
    DECLARE EXIT HANDLER FOR SQLEXCEPTION

    -- EN CASO DE FALLAR SE MOSTRAR EL MENSAJE DE ERROR
    BEGIN
        ROLLBACK;
        SET o_respuesta = 'NO SE A PODIDO REALIZAR LA OPERACION';
    END;

    -- COMIENZA LA TRANSACCION
    START TRANSACTION;

        -- SE REALIZA LA INSERCION 
        INSERT INTO sistema_atencion_clientes.clientes (nombre, apellido, email)
        VALUES (i_nombre, i_apellido, i_email);

        -- GUARDAMOS LA RESPUESTA
        SET o_respuesta = 'OPERACION REALIZADA CON EXITO';
    
    -- SI TODO SALE BIEN CONFIRMAMOS LOS CAMBIOS
    COMMIT;

-- FIN
END //

DELIMITER ;


-- STORED PROCEDURE PARA REGISTRAR A LOS EMPLEADOS
DELIMITER //
CREATE PROCEDURE sistema_atencion_clientes.sp_registrar_empleado(
    IN i_nombre VARCHAR(20),
    IN i_apellido VARCHAR(20),
    IN i_email VARCHAR(50),
    OUT o_respuesta VARCHAR(40)
)

BEGIN

    -- DECLARAMOS EL MANEJADOR DE ERRORES
    DECLARE EXIT HANDLER FOR SQLEXCEPTION

    -- EN CASO DE FALLAR SE MOSTRAR EL MENSAJE DE ERROR
    BEGIN
        ROLLBACK;
        SET o_respuesta = 'NO SE A PODIDO REALIZAR LA OPERACION';
    END;

    -- COMIENZA LA TRANSACCION
    START TRANSACTION;

        -- SE REALIZA LA INSERCION 
        INSERT INTO sistema_atencion_clientes.empleados (nombre, apellido, email)
        VALUES (i_nombre, i_apellido, i_email);

        -- GUARDAMOS LA RESPUESTA
        SET o_respuesta = 'OPERACION REALIZADA CON EXITO';
    
    -- SI TODO SALE BIEN CONFIRMAMOS LOS CAMBIOS
    COMMIT;

-- FIN
END //

DELIMITER ;