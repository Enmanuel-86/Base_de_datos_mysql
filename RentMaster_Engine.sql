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
	fecha_salida DATE NOT NULL,
	fecha_esperada DATE NOT NULL,
	fecha_entrega_real DATE NOT NULL,
	total_pagar DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (id_cliente) REFERENCES rentmasterengine.clientes(id_cliente)
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

# STORED PROCEDURE PARA REGISTRAR EQUIPOS
DROP PROCEDURE rentmasterengine.sp_registrar_equipo;

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


# STORED PROCEDURE PARA ACTUALIZAR LOS PRECIOS DE LOS EQUIPOS
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




