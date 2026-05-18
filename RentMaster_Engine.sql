# Proyecto "RentMaster Engine"

# Proyecto para practicar base de datos

# Este Archivo.sql se encargara solamente de la estructura de la base de datos

/*
 * Imagina una empresa que alquila equipos (excavadoras, taladros industriales, generadores). 
 * No puedes alquilar algo que ya está rentado, el precio depende del tiempo y, si el equipo se 
 * devuelve tarde, hay multas automáticas.

 */

# Creamos la base de datos
CREATE DATABASE IF NOT EXISTS rentmasterengine;
#DROP DATABASE rentmasterengine;
USE rentmasterengine;

# Creamos la tabla en donde se almacenan los equipos
CREATE TABLE rentmasterengine.equipos(
	id_equipo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL UNIQUE,
	categoria VARCHAR(100) NOT NULL,
	precio_dia DECIMAL(10,2) NOT NULL ,
	estado VARCHAR(50) NOT NULL DEFAULT 'disponible'
) CHARSET = utf8mb4;

# Creamos la tabla en donde se almacenan lo clientes
CREATE TABLE rentmasterengine.clientes(
	id_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	cedula VARCHAR(10) NOT NULL UNIQUE,
	saldo_deudor DECIMAL(10,2) NOT NULL
	
) CHARSET = utf8mb4;

# Creamos la tabla que contiene los alquileres de los equipos
CREATE TABLE rentmasterengine.alquileres(
	id_alquiler INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	id_cliente INT UNSIGNED NOT NULL,
	id_equipo INT UNSIGNED NOT NULL,
	fecha_salida DATE NOT NULL,
	fecha_esperada DATE NOT NULL,
	fecha_entrega_real DATE NOT NULL,
	total_pagar DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (id_cliente) REFERENCES rentmasterengine.clientes(id_cliente)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
	FOREIGN KEY (id_equipo) REFERENCES rentmasterengine.equipos(id_equipo)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
	
) CHARSET = utf8mb4;


# Creamos una tabla para realizar auditorias para ver los precios viejos
CREATE TABLE rentmasterengine.auditorias(
	id_auditoria INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	id_equipo INT UNSIGNED NOT NULL,
	precio_anterior DECIMAL(10,2) NOT NULL,
	fecha DATE,
	FOREIGN KEY (id_equipo) REFERENCES rentmasterengine.equipos(id_equipo)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);
 


# CREACION DE STORED PROCEDURES

# 1. STORED PROCEDURE PARA REGISTRAR EQUIPOS
#DROP PROCEDURE rentmasterengine.sp_registrar_equipo;


DELIMITER //
# CREAMOS EL STORED PROCEDURE CON LOS PARAMETROS NECESARIOS
CREATE PROCEDURE rentmasterengine.sp_registrar_equipo(
	IN i_nombre_equipo VARCHAR(100),
	IN i_categoria VARCHAR(100),
	IN i_precio_dia DECIMAL(10,2),
	IN i_estado VARCHAR(50)
)

	# COMENZAMOS
	BEGIN
		
		DECLARE existe_equipo INT DEFAULT 0;
		
		SELECT COUNT(*) INTO existe_equipo
		FROM rentmasterengine.equipos
		WHERE nombre = i_nombre_equipo;
		
		IF existe_equipo <> 0 THEN
			
			SELECT 'Este equipo ya esta registrado' AS respuesta;
			
		ELSE
		
			START TRANSACTION;
					
				INSERT INTO rentmasterengine.equipos (nombre, categoria, estado, precio_dia )
				VALUES (i_nombre_equipo, i_categoria, i_estado, i_precio_dia);
				
				SELECT 'Equipo registrado con exito' AS respuesta;
				
			COMMIT;
			
		END IF;
		
		
		
	END //
	

DELIMITER ;


# 2. STORED PROCEDURE PARA ACTUALIZAR LOS PRECIOS DE LOS EQUIPOS
DELIMITER //
CREATE PROCEDURE rentmasterengine.sp_actualizar_precio_equipo(
	IN i_nombre_equipo VARCHAR(100),
	IN i_precio_nuevo DECIMAL(10,2)
)

	BEGIN
		
		DECLARE precio_anterior DECIMAL(10,2);
		DECLARE existe_equipo INT DEFAULT 0;
		
		# BUSCAMOS EL PRECIO DEL PRODUCTO QUE TENGA EL MISMO NOMBRE
		SELECT precio_dia
		INTO precio_anterior
		FROM rentmasterengine.equipos
		WHERE nombre = LOWER(i_nombre_equipo);
		
		# VERIFICAMOS SI EXISTE EL EQUIPO
		SELECT COUNT(*)
		INTO existe_equipo
		FROM rentmasterengine.equipos
		WHERE nombre = LOWER(i_nombre_equipo);
		
		# SI EL EQUIPO EXISTE
		IF existe_equipo <> 0 THEN
			
			# SI EL PRECIO ANTERIOR ES IGUAL AL NUEVO
			IF precio_anterior = i_precio_nuevo THEN
				
					# SI ES IGUAL NO SE ACTUALIZA
					SELECT 'Los precios son iguales';
					
				ELSE
					
					# CASO CONTRARIO ACTUALIZAMOS EL PRECIO DEL EQUIPO
					# BUSCANDOLO POR EL NOMBRE
					UPDATE rentmasterengine.equipos
					SET precio_dia = i_precio_nuevo
					WHERE nombre = LOWER(i_nombre_equipo);
					
					SELECT 'Precio actualizado exitosamente';
				
				END IF;
			
		
		ELSE
			
			# EN CASO CONTRARIO NO HACER NADA
			SELECT 'Este producto no esta registrado en la base de datos';
		
		END IF;
		
	END //

DELIMITER ;

# 3. STORED PROCEDURE PARA REGISTRAR LOS ALQUILERES DE LOS EQUIPOS
DROP PROCEDURE rentmasterengine.sp_registrar_alquiler;
DELIMITER //
CREATE PROCEDURE rentmasterengine.sp_registrar_alquiler(
	IN i_id_cliente INT UNSIGNED,
	IN i_id_equipo INT UNSIGNED,
	OUT o_respuesta VARCHAR(100)
)

	BEGIN
		
		# USAREMOS UNA VARIABLE PARA REALIZAR EL CALCULO DEL PRECIO TOTAL
		DECLARE precio_equipo DECIMAL(10,2);
		DECLARE existencia_equipo INT DEFAULT 0;
		DECLARE total_pagar DECIMAL(10,2);
		
		SELECT COUNT(*)
		INTO existencia_equipo
		FROM rentmasterengine.equipos
		WHERE id_equipo = i_id_equipo;
		
		
		IF existencia_equipo <> 0 THEN 
		
			# BUSCAMOS EL PRECIO DEL EQUIPO QUE SE ESTA ALQUILANDO
			SELECT precio_dia
			INTO precio_equipo
			FROM rentmasterengine.equipos
			WHERE id_equipo = i_id_equipo;
			
			# REALIZAMOS EL CALCULO
			# NO BASAREMOS QUE EL TIEMPO QUE OFRECE LA EMPRESA SON 20 DIAS
			SET total_pagar = precio_equipo * 20;
			
			# REALIZAMOS EL INSERT
			INSERT INTO rentmasterengine.alquileres (id_cliente, id_equipo, 
													fecha_salida, fecha_esperada,
												    fecha_entrega_real, total_pagar)		 
			VALUES (i_id_cliente, 
				i_id_equipo, NOW(),
				DATE_ADD(CURDATE(), INTERVAL 20 DAY),
				DATE_ADD(CURDATE(), INTERVAL 30 DAY),
				total_pagar);
			
			SELECT 'EQUIPO ALQUILADO EXITOSAMENTE'
			INTO o_respuesta;
			
		ELSE
		
			SELECT 'ESTE EQUIPO NO EXITE PARA SER ALQUILADO'
			INTO o_respuesta;

		END IF;
		
		
	END //

DELIMITER ;


# STORE PRODECURE PARA ALQUILAR LOS EQUIPOS PERO CON NOMBRE
DELIMITER //
CREATE PROCEDURE rentmasterengine.sp_registrar_alquiler_con_nombres(
	IN i_nombre_cliente VARCHAR(100),
	IN i_nombre_equipo VARCHAR(100),
	OUT o_respuesta VARCHAR(100)
)

	BEGIN
		
		# USAREMOS UNA VARIABLE PARA REALIZAR EL CALCULO DEL PRECIO TOTAL
		DECLARE precio_equipo DECIMAL(10,2);
		DECLARE existencia_equipo INT DEFAULT 0;
		DECLARE existencia_cliente INT DEFAULT 0;
		DECLARE total_pagar DECIMAL(10,2);
		
		# BUSCAMOS SI EXISTE EL EQUIPO
		SELECT COUNT(*)
		INTO existencia_equipo
		FROM rentmasterengine.equipos
		WHERE nombre = i_nombre_equipo;
		
		# BUSCAMOS SI EXISTE LA PERSONA
		SELECT COUNT(*)
		INTO existencia_cliente
		FROM rentmasterengine.clientes
		WHERE nombre = i_nombre_cliente;
		
		# VERFICAMOS SI EXISTE LA PERSONA/CLIENTE
		IF existencia_cliente <> 0 THEN 
		
			# VERIFICAMOS QUE EXISTA EL EQUIPO
			IF existencia_equipo <> 0 THEN 
		
				# BUSCAMOS EL PRECIO DEL EQUIPO QUE SE ESTA ALQUILANDO
				SELECT precio_dia
				INTO precio_equipo
				FROM rentmasterengine.equipos
				WHERE id_equipo = i_id_equipo;
				
				# REALIZAMOS EL CALCULO
				# NO BASAREMOS QUE EL TIEMPO QUE OFRECE LA EMPRESA SON 20 DIAS
				SET total_pagar = precio_equipo * 20;
				
				# REALIZAMOS EL INSERT
				INSERT INTO rentmasterengine.alquileres (id_cliente, id_equipo, 
														fecha_salida, fecha_esperada,
													    fecha_entrega_real, total_pagar)		 
				VALUES (i_id_cliente, 
					i_id_equipo, NOW(),
					DATE_ADD(CURDATE(), INTERVAL 20 DAY),
					DATE_ADD(CURDATE(), INTERVAL 30 DAY),
					total_pagar);
				
			ELSE
			
				SELECT 'ESTE PRODUCTO NO EXITE PARA SER ALQUILADO'
				INTO o_respuesta;
	
			END IF;
			
		
		ELSE
		
			SELECT 'ESTAS PERSONA NO EXISTE PARA REALIZAR EL REGISTRO'
			INTO o_respuesta;
		
		END IF;
		
		
	END //

DELIMITER ;



# CREACION DE TRIGGER CON BEFORE

# TRIGGER PARA CORREGIR DATOS DEL EQUIPO QUE SE VAYA A REGISTRAR
DELIMITER //
CREATE TRIGGER rentmasterengine.tg_registrar_equipo
	BEFORE INSERT 
	ON rentmasterengine.equipos
	FOR EACH ROW
	
	BEGIN
		
		# OBTENEMOS  LOS CAMPOS Y LOS PASAMOS A MINUSCULAS
		SET NEW.nombre = LOWER(NEW.nombre);
		SET NEW.categoria = LOWER(NEW.categoria);
		SET NEW.estado = UPPER(NEW.estado);
		
		# SI EL PRECIO ES MENOR A 0
		IF NEW.precio_dia < 0 THEN
			
			# COLOCAREMOS EL PRECIO IGUAL A 0 YA QUE NO QUEREMOS VALORES NEGATIVOS
			SET NEW.precio_dia = 0;
		
		END IF;
		
	END //
	
DELIMITER ; 


# 


# TRIGGER PARA REGISTRAR AUDITORIA

USE rentmasterengine;

DELIMITER //
CREATE TRIGGER rentmasterengine.tg_registrar_auditoria
	BEFORE UPDATE
	ON rentmasterengine.equipos
	FOR EACH ROW
	
	BEGIN
		
		# REGISTRAMOS CADA VEZ QUE SE CAMBIE LE PRECIO
		# ESTO SE DISPARA DESPUES DE USAR EL STORED PROCEDURE sp_actualizar_precio_equipo
		# EN CASO DE CUMPLIR LA CONDICION
		INSERT INTO rentmasterengine.auditorias (id_equipo, fecha, precio_anterior)
		VALUES (OLD.id_equipo, NOW(), OLD.precio_dia);
				
	END //
	
DELIMITER ;


/* BEFORE INSERT en Alquileres: Antes de registrar un alquiler, 
 * el trigger debe verificar si el equipo tiene el estado 'Disponible'. 
 * Si está en 'Mantenimiento' o 'Alquilado', debe lanzar un error y bloquear la operación.*/



#sDROP TRIGGER rentmasterengine.tg_registrar_alquiler;
DELIMITER //
CREATE TRIGGER rentmasterengine.tg_registrar_alquiler
	BEFORE INSERT
	ON rentmasterengine.alquileres
	
	FOR EACH ROW
	
	BEGIN
		
		DECLARE estado_equipo VARCHAR(50);
		
		
		# BUSCAMOS EL ESTADO DEL EQUIPO POR EL ID DEL EQUIPO
		SELECT estado INTO estado_equipo
		FROM rentmasterengine.equipos
		WHERE id_equipo = NEW.id_equipo;
		
		
		IF estado_equipo = 'DISPONIBLE' THEN
			
			# ACTUALIZAMOS LA DEUDA DEL CLIENTE DE 0 AL TOTAL A PAGAR NUEVO
			UPDATE rentmasterengine.clientes 
			SET saldo_deudor = NEW.total_pagar
			WHERE id_cliente = NEW.id_cliente;
			
			# ACTUALIZAMOS EL EQUIPO DE DISPONIBLE A ALQUILADO
			UPDATE rentmasterengine.equipos 
			SET estado = 'ALQUILADO'
			WHERE id_equipo = NEW.id_equipo;
			
			
			
		ELSE
		
        	SIGNAL SQLSTATE '45000'
        	SET MESSAGE_TEXT = 'Operación cancelada: El producto no está disponible.';
			
		
		END IF;

	END //
	
DELIMITER ;
        	

