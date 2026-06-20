/*
    ESTA BASE DE DATOS ES UN SISTEMA PARA EL CONTROL DE ATENCION AL CLIENTE.

    LEER LA DESCRIPCION EN EL README

*/

-- CREAMOS LA BASE DE DATOS SI NO EXISTE
CREATE DATABASE IF NOT EXISTS sistema_atencion_clientes;
-- DROP DATABASE sistema_atencion_clientes;

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
-- DROP TABLE sistema_atencion_clientes.auditoria;
CREATE TABLE sistema_atencion_clientes.auditoria(
    id_auditoria INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNSIGNED,
    id_empleado INT UNSIGNED,
    fecha_atencion DATE,
    hora_comienzo TIME NOT NULL,
    hora_final TIME DEFAULT NULL,
    duracion TIME,
    FOREIGN KEY (id_cliente) REFERENCES sistema_atencion_clientes.clientes(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_empleado) REFERENCES sistema_atencion_clientes.empleados(id_empleado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- DROP TABLE sistema_atencion_clientes.en_espera_cliente;
CREATE TABLE sistema_atencion_clientes.en_espera_cliente(
    id_espera_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNSIGNED,
    estado VARCHAR(15) DEFAULT 'EN ESPERA',
    FOREIGN KEY (id_cliente) REFERENCES sistema_atencion_clientes.clientes(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


CREATE TABLE sistema_atencion_clientes.atencion_al_cliente(
    id_atencion_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNSIGNED,
    id_empleado INT UNSIGNED,
    fecha_atencion DATE,
    hora_comienzo TIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES sistema_atencion_clientes.clientes(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_empleado) REFERENCES sistema_atencion_clientes.empleados(id_empleado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

);



-- CREACION DE STORED PROCEDURE

-- STORE PROCEDURE PARA REGISTRAR A LOS CLIENTES
-- DROP PROCEDURE sistema_atencion_clientes.sp_registrar_cliente;
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
            VALUES (UPPER(i_nombre), UPPER(i_apellido), UPPER(i_email));

            -- GUARDAMOS LA RESPUESTA
            SET o_respuesta = 'OPERACION REALIZADA CON EXITO';
        
        -- SI TODO SALE BIEN CONFIRMAMOS LOS CAMBIOS
        COMMIT;

    -- FIN
    END //

DELIMITER ;


-- STORED PROCEDURE PARA REGISTRAR A LOS EMPLEADOS
-- DROP PROCEDURE sistema_atencion_clientes.sp_registrar_empleado;
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
            VALUES (UPPER(i_nombre), UPPER(i_apellido), UPPER(i_email));

            -- GUARDAMOS LA RESPUESTA
            SET o_respuesta = 'OPERACION REALIZADA CON EXITO';
        
        -- SI TODO SALE BIEN CONFIRMAMOS LOS CAMBIOS
        COMMIT;

    -- FIN
    END //

DELIMITER ;

-- STORED PROCEDURE PARA REGISTRAR LA ATENCION DEL CLIENTE
-- DROP PROCEDURE sistema_atencion_clientes.sp_registrar_espera_cliente_por_id;
DELIMITER //
    CREATE PROCEDURE sistema_atencion_clientes.sp_registrar_espera_cliente_por_id(
        IN i_id_cliente INT UNSIGNED,
        OUT o_respuesta VARCHAR(50)
    )

    BEGIN
		
	    -- variable para verificar la existencia del cliente
        DECLARE existencia_cliente INT DEFAULT 0;
	    DECLARE existencia_cliente_en_espera INT DEFAULT 0;

	    -- manejador de errores
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            SET o_respuesta = 'NO SE A PODIDO REALIZAR LA OPERACION';
        END;

	    -- comenzamos la transaccion
        START TRANSACTION;
			
	    	-- Realizamos la consulta del cliente para verificar que existe
            SELECT COUNT(*)
            INTO existencia_cliente
            FROM sistema_atencion_clientes.clientes
            WHERE id_cliente = i_id_cliente;
	    	
	    	-- Realizamos la consulta para ver si el cliente ya esta en la espera
	    	SELECT COUNT(*)
            INTO existencia_cliente_en_espera
            FROM sistema_atencion_clientes.en_espera_cliente
            WHERE id_cliente = i_id_cliente;
	    	
	    	

	    	-- la condicion es que si la variable para verificar la existencia del cliente
	    	-- es distinto de 0 eso signifa que el cliente existe
            IF existencia_cliente <> 0 THEN
            
            	-- verificamos si el cliente esta en la lista de espera
            	-- en caso de estar en la li
            	IF existencia_cliente_en_espera == 0 THEN
            		
            		-- Registramos al cliente en la tabla de espera
	                INSERT INTO sistema_atencion_clientes.en_espera_cliente (id_cliente)
	                VALUES (i_id_cliente);
	
	                SET o_respuesta = 'SE A REGISTRADO LA ESPERA CON EXITO';

                	COMMIT;
            	
            	ELSE
            		
            		ROLLBACK;
            		SET o_respuesta = 'EL CLIENTE YA ESTA EN LA COLA DE ESPERA';
            	
            	END IF;
            
            	

            ELSE

                ROLLBACK;
                SET o_respuesta = 'EL CLIENTE NO EXISTE';

            END IF;

    END //
    
DELIMITER ;




-- STORED PROCEDURE PARA REGISTRAR LA ATENCION AL CLIENTE
-- DROP PROCEDURE sistema_atencion_clientes.sp_registrar_atencion_cliente_por_id;
DELIMITER //
    CREATE PROCEDURE sistema_atencion_clientes.sp_registrar_atencion_cliente_por_id(
        IN i_id_cliente INT UNSIGNED,
        IN i_id_empleado INT UNSIGNED,
        OUT o_respuesta VARCHAR(50)
    )

    BEGIN

        DECLARE existencia_cliente INT DEFAULT 0;
        DECLARE existencia_empleado INT DEFAULT 0;
        DECLARE estado_cliente INT DEFAULT 0;

        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            SET o_respuesta = 'NO SE A PODIDO REALIZAR LA OPERACION';
        END;

        START TRANSACTION;

            SELECT COUNT(*)
            INTO existencia_cliente
            FROM sistema_atencion_clientes.clientes
            WHERE id_cliente = i_id_cliente;

            SELECT COUNT(*)
            INTO existencia_empleado
            FROM sistema_atencion_clientes.empleados
            WHERE id_empleado = i_id_empleado;

            SELECT COUNT(*)
            INTO estado_cliente
            FROM sistema_atencion_clientes.en_espera_cliente
            WHERE id_cliente = i_id_cliente AND estado = 'EN ESPERA';



            IF existencia_cliente <> 0 AND existencia_empleado <> 0 AND estado_cliente <> 0 THEN


                INSERT INTO sistema_atencion_clientes.atencion_al_cliente (id_empleado, id_cliente, fecha_atencion, hora_comienzo)
                VALUES (i_id_empleado, i_id_cliente, CURRENT_DATE(), CURRENT_TIME());

                UPDATE sistema_atencion_clientes.en_espera_cliente 
                SET estado = 'ATENDIENDO'
                WHERE id_cliente = i_id_cliente;

                COMMIT;

            ELSE
                ROLLBACK;
                SET o_respuesta = 'NO CUMPLE LA CONDICION';

            END IF;


    END //

DELIMITER ;