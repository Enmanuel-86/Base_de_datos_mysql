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

#DROP DATABASE rentmasterengine;

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
	fecha_de_pago DATE,
	total_pagar DECIMAL(10,2) NOT NULL,
	estado_pago VARCHAR(50) NOT NULL DEFAULT 'NO PAGADO',
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
 
# CREACION DE VIEWS 

# 1. VIEW DE ALQUILERES
CREATE VIEW rentmasterengine.vw_alquileres_de_equipos AS
	SELECT a.id_alquiler, c.nombre AS Cliente, e.nombre AS Equipo, e.categoria,
		   e.precio_dia AS Precio_del_equipo, e.estado, a.fecha_salida, a.fecha_esperada,
		   a.fecha_entrega_real, a.total_pagar
	FROM rentmasterengine.alquileres AS a
	INNER JOIN rentmasterengine.equipos AS e 
		ON e.id_equipo = a.id_equipo # COMPARAMOS EL ID DEL EQUIPO DE LA TABLA EQUIPO Y ALQUILES
	INNER JOIN rentmasterengine.clientes AS c
		ON c.id_cliente = a.id_cliente; # COMPARAMOS EL ID DEL CLIENTE DE LA TABLA CLIENTES Y ALQUILES

		
# 2. VIEW DE ALQUILERES DE EQUIPO ALQUILADOS Y NO ALQUILADOS
CREATE VIEW rentmasterengine.vw_equipos_alquilados_y_no_alquilados AS
	SELECT a.id_alquiler, c.nombre AS Cliente, e.nombre AS Equipo, e.categoria,
		   e.precio_dia AS Precio_del_equipo, e.estado, a.fecha_salida, a.fecha_esperada,
		   a.fecha_entrega_real, a.total_pagar
	FROM rentmasterengine.alquileres AS a
	INNER JOIN rentmasterengine.clientes AS c
		ON c.id_cliente = a.id_cliente # COMPARAMOS EL ID DEL CLIENTE DE LA TABLA CLIENTES Y ALQUILES
	RIGHT JOIN rentmasterengine.equipos AS e 
		ON e.id_equipo = a.id_equipo # COMPARAMOS EL ID DEL EQUIPO DE LA TABLA EQUIPO Y ALQUILES
	ORDER BY c.nombre DESC;


# 3. VIEW DE EQUIPOS EN ESTADO DISPONIBLE
CREATE VIEW rentmasterengine.vw_equipos_disponibles AS
	SELECT * FROM rentmasterengine.equipos
	WHERE estado = 'DISPONIBLE';


# 4. VIEW DE EQUIPOS EN ESTADO ALQUILADOS
CREATE VIEW rentmasterengine.vw_equipos_alquilados AS
	SELECT * FROM rentmasterengine.equipos
	WHERE estado = 'ALQUILADO';

# 5. VIEW DE EQUIPOS EN ESTADO DE MANTENIMIENTO
CREATE VIEW rentmasterengine.vw_equipos_en_mantenimiento AS
	SELECT * FROM rentmasterengine.equipos
	WHERE estado = 'MANTENIMIENTO';

# 6. VIEW PARA VER LAS AUDITORIAS
CREATE VIEW rentmasterengine.vw_auditoria_de_equipos AS
	SELECT a.id_auditoria, e.nombre AS Equipo, e.categoria, e.precio_dia,
		   a.precio_anterior, a.fecha
	FROM rentmasterengine.auditorias AS a
	INNER JOIN rentmasterengine.equipos AS e 
		ON e.id_equipo = a.id_equipo;


# 7. VIEW PARA VER EQUIPOS AUDITADOS Y NO AUDITADOS
CREATE VIEW rentmasterengine.vw_equipos_auditados_y_no_auditados AS
	SELECT a.id_auditoria, e.id_equipo, e.nombre AS Equipo, e.categoria, e.precio_dia,
		   a.precio_anterior, a.fecha
	FROM rentmasterengine.auditorias AS a
	RIGHT JOIN rentmasterengine.equipos AS e 
		ON e.id_equipo = a.id_equipo
	ORDER BY e.id_equipo ASC;



		
# /////////////////////////////////////////////////////////////

# CREACION DE STORED PROCEDURES

# 1. STORED PROCEDURE PARA REGISTRAR EQUIPOS
#DROP PROCEDURE rentmasterengine.sp_registrar_equipo;
DELIMITER //
# CREAMOS EL STORED PROCEDURE CON LOS PARAMETROS NECESARIOS
CREATE PROCEDURE rentmasterengine.sp_registrar_equipo(
	IN i_nombre_equipo VARCHAR(100),
	IN i_categoria VARCHAR(100),
	IN i_precio_dia DECIMAL(10,2),
	IN i_estado VARCHAR(50),
	OUT o_respuesta VARCHAR(100)
)

	# COMENZAMOS
	BEGIN
		
		#VARIABLE PARA VER SI EXISTE EL EQUIPO
		DECLARE existe_equipo INT DEFAULT 0;
		
		# VEMOS SI EL QUIPO EXISTE
		SELECT COUNT(*) INTO existe_equipo
		FROM rentmasterengine.equipos
		WHERE nombre = i_nombre_equipo;
		
		IF existe_equipo <> 0 THEN
			
			SELECT 'ESTE EQUIPO YA ESTA REGISTRADO' INTO o_respuesta;
			
		ELSE
		
			START TRANSACTION;
					
				INSERT INTO rentmasterengine.equipos (nombre, categoria, estado, precio_dia )
				VALUES (i_nombre_equipo, i_categoria, i_estado, i_precio_dia);
				
				SELECT 'EQUIPO REGISTRADO EXITOSAMENTE' INTO o_respuesta;
				
			COMMIT;
			
		END IF;
		
		
		
	END //
	

DELIMITER ;


# 2 STORED PROCEDURE PARA ACTUALIZAR LOS PRECIOS DE LOS EQUIPOS
#DROP PROCEDURE rentmasterengine.sp_actualizar_precio_equipo;
DELIMITER //
CREATE PROCEDURE rentmasterengine.sp_actualizar_precio_equipo_por_id(
	IN i_id_equipo VARCHAR(100),
	IN i_precio_nuevo DECIMAL(10,2),
	OUT o_respuesta VARCHAR(100)
)

	BEGIN
		
		# VARIABLES 
		DECLARE precio_anterior DECIMAL(10,2);
		DECLARE existe_equipo INT DEFAULT 0;
		
		# BUSCAMOS EL PRECIO DEL PRODUCTO QUE TENGA EL MISMO NOMBRE
		SELECT precio_dia
		INTO precio_anterior
		FROM rentmasterengine.equipos
		WHERE id_equipo = i_id_equipo;
		
		# VERIFICAMOS SI EXISTE EL EQUIPO
		SELECT COUNT(*)
		INTO existe_equipo
		FROM rentmasterengine.equipos
		WHERE id_equipo = i_id_equipo;
		
		# SI EL EQUIPO EXISTE
		IF existe_equipo <> 0 THEN
			
			# SI EL PRECIO ANTERIOR ES IGUAL AL NUEVO
			IF precio_anterior = i_precio_nuevo THEN
				
					# SI ES IGUAL NO SE ACTUALIZA
					SELECT 'LOS PRECIOS SON IGUALES'
					INTO o_respuesta;
					
				ELSE
					
					# CASO CONTRARIO ACTUALIZAMOS EL PRECIO DEL EQUIPO
					# BUSCANDOLO POR EL NOMBRE
					UPDATE rentmasterengine.equipos
					SET precio_dia = i_precio_nuevo
					WHERE id_equipo = i_id_equipo;
					
					SELECT 'PRECIO ACTUALIZADO EXITOSAMENTE' 
					INTO o_respuesta;
				
				END IF;
			
		
		ELSE
			
			# EN CASO CONTRARIO NO HACER NADA
			SELECT 'ESTE PRODUCTO NO EXISTE EN LA BASE DE DATOS'
			INTO o_respuesta;
		
		END IF;
		
	END //

DELIMITER ;





# 2.1 STORED PROCEDURE PARA ACTUALIZAR LOS PRECIOS DE LOS EQUIPOS
#DROP PROCEDURE rentmasterengine.sp_actualizar_precio_equipo;
DELIMITER //
CREATE PROCEDURE rentmasterengine.sp_actualizar_precio_equipo_por_nombre(
	IN i_nombre_equipo VARCHAR(100),
	IN i_precio_nuevo DECIMAL(10,2),
	OUT o_respuesta VARCHAR(100)
)

	BEGIN
		# VARIABLES
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
					SELECT 'LOS PRECIOS SON IGUALES'
					INTO o_respuesta;
					
				ELSE
					
					# CASO CONTRARIO ACTUALIZAMOS EL PRECIO DEL EQUIPO
					# BUSCANDOLO POR EL NOMBRE
					UPDATE rentmasterengine.equipos
					SET precio_dia = i_precio_nuevo
					WHERE nombre = LOWER(i_nombre_equipo);
					
					SELECT 'PRECIO ACTUALIZADO EXITOSAMENTE' 
					INTO o_respuesta;
				END IF;
			
		
		ELSE
			
			# EN CASO CONTRARIO NO HACER NADA
			SELECT 'ESTE PRODUCTO NO EXISTE EN LA BASE DE DATOS'
			INTO o_respuesta;
			
		END IF;
		
	END //

DELIMITER ;



# 3. STORED PROCEDURE PARA REGISTRAR LOS ALQUILERES DE LOS EQUIPOS
#DROP PROCEDURE rentmasterengine.sp_registrar_alquiler_por_id;
DELIMITER //
CREATE PROCEDURE rentmasterengine.sp_registrar_alquiler_por_id(
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


# 3.1 STORE PRODECURE PARA ALQUILAR LOS EQUIPOS PERO CON NOMBRE
#DROP PROCEDURE rentmasterengine.sp_registrar_alquiler_con_nombres;
DELIMITER //
CREATE PROCEDURE rentmasterengine.sp_registrar_alquiler_por_nombre(
	IN i_nombre_cliente VARCHAR(100),
	IN i_nombre_equipo VARCHAR(100),
	OUT o_respuesta VARCHAR(100)
)

	BEGIN
		
		# VARIABLES
		DECLARE precio_equipo DECIMAL(10,2); # USAREMOS UNA VARIABLE PARA REALIZAR EL CALCULO DEL PRECIO TOTAL
		DECLARE existencia_equipo INT DEFAULT 0; # VARIABLE PARA VERIFICAR SI EXISTE
		DECLARE existencia_cliente INT DEFAULT 0; # VARIABLE PARA VERIFICAR SI EXISTE
		DECLARE var_id_cliente INT DEFAULT 0; # VARIABLE PARA GUARDAR EL ID
		DECLARE var_id_equipo INT DEFAULT 0; # VARIABLE PARA GUARDAR EL ID
		DECLARE total_pagar DECIMAL(10,2); # VARIABLES PARA EL TOTAL A PAGAR
		
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
				WHERE nombre = i_nombre_equipo;
				
				# BUSCAMOS EL ID DEL EQUIPO POR SU NOMBRE
				SELECT id_equipo 
				INTO var_id_equipo
				FROM rentmasterengine.equipos
				WHERE nombre = i_nombre_equipo;
				
				# BUSCAMOS EL ID DEL CLIENTE POR SU NOMBRE
				SELECT id_cliente
				INTO var_id_cliente
				FROM rentmasterengine.clientes
				WHERE nombre = i_nombre_cliente;
								
				
				# REALIZAMOS EL CALCULO
				# NO BASAREMOS QUE EL TIEMPO QUE OFRECE LA EMPRESA SON 20 DIAS
				SET total_pagar = precio_equipo * 20;
				
				# REALIZAMOS EL INSERT
				INSERT INTO rentmasterengine.alquileres (id_cliente, id_equipo, 
														fecha_salida, fecha_esperada,
													    fecha_entrega_real, total_pagar)		 
				VALUES (var_id_cliente, 
					var_id_equipo, 
					NOW(),
					DATE_ADD(CURDATE(), INTERVAL 20 DAY),
					DATE_ADD(CURDATE(), INTERVAL 30 DAY),
					total_pagar);
				
				SELECT 'EQUIPO ALQUILADO EXITOSAMENTE'
				INTO o_respuesta;
				
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


# 4 STORED PROCEDURE PARA PAGAR EL ALQUILER
#DROP PROCEDURE rentmasterengine.sp_pagar_alquiler_por_id_alquiler_y_monto;
DELIMITER //
CREATE PROCEDURE rentmasterengine.sp_pagar_alquiler_por_id_alquiler_y_monto( 
	IN i_id_alquiler INT UNSIGNED,
	IN i_monto_pagar DECIMAL(10,2),
	OUT o_respuesta VARCHAR(60)
)

	BEGIN
		
		# VARIABLES 
		DECLARE existe_alquiler INT DEFAULT 0; # VARIABLE PARA VER SI EL EQUIPO EXISTE EN LA BASE DE DATOS
		DECLARE var_id_cliente INT UNSIGNED;
		DECLARE var_id_equipo INT UNSIGNED;
		DECLARE deuda DECIMAl(10,2); # VARIABLE PARA SABER EL MONTO DE X EQUIPO
		
		
		
		# Manejador de errores
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			
			ROLLBACK;
			SET o_respuesta = 'LA OPERACION SIN EXITO';
		END;
		
		
		
		START TRANSACTION;
		
		# CONSULTA PARA VER SI EL EQUIPO EXISTE
		SELECT COUNT(*)
		INTO existe_alquiler
		FROM rentmasterengine.alquileres
		WHERE id_alquiler = i_id_alquiler;
		
		
		
		IF existe_alquiler <> 0 THEN
		
			# CONSULTA PARA VER LA DEUDA 
			SELECT a.id_equipo, a.id_cliente, c.saldo_deudor
			INTO var_id_equipo, var_id_cliente ,deuda
			FROM rentmasterengine.alquileres AS a
			INNER JOIN rentmasterengine.clientes AS c
			ON c.id_cliente = a.id_cliente
			WHERE id_alquiler = i_id_alquiler;
			
			
			IF i_monto_pagar > deuda THEN 
			
				SELECT CONCAT('SU DEUDA ES DE: ', deuda, ', NO PUEDE PAGAR UNA CANTIDAD SUPERIOR A SU DEUDA')
				INTO o_respuesta;
				
				ROLLBACK ;
				
			ELSEIF i_monto_pagar = deuda THEN
				
				UPDATE rentmasterengine.alquileres
				SET fecha_de_pago = NOW(),
					total_pagar = 0.00,
					estado_pago = 'PAGADO'
				WHERE id_alquiler = i_id_alquiler;
				
				UPDATE rentmasterengine.clientes
				SET saldo_deudor = 0.00
				WHERE id_cliente = var_id_cliente;
				
				SET o_respuesta = 'TRANSACCION EXITOSA';
				
				COMMIT;
					
			ELSEIF i_monto_pagar < deuda THEN
				
				SELECT CONCAT('SU DEUDA ES DE: ', deuda, ', SU PAGO ES MENOR A LA DEUDA ')
				INTO  o_respuesta;
			
				ROLLBACK;
			
			END IF;
		
		ELSE
		
			SELECT 'ESTE ALQUILER NO EXISTE'
			INTO o_respuesta;
			
			ROLLBACK;
			
		END IF;
		
	END //


DELIMITER ; 


# /////////////////////////////////////////////////////////////


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
#DROP TRIGGER rentmasterengine.tg_registrar_auditoria;
DELIMITER //
CREATE TRIGGER rentmasterengine.tg_registrar_auditoria
	BEFORE UPDATE
	ON rentmasterengine.equipos
	FOR EACH ROW
	
	BEGIN
		
		
		IF OLD.precio_dia <> NEW.precio_dia	THEN
		
			# REGISTRAMOS CADA VEZ QUE SE CAMBIE LE PRECIO
			# ESTO SE DISPARA DESPUES DE USAR EL STORED PROCEDURE sp_actualizar_precio_equipo
			# EN CASO DE CUMPLIR LA CONDICION
			INSERT INTO rentmasterengine.auditorias (id_equipo, fecha, precio_anterior)
			VALUES (OLD.id_equipo, NOW(), OLD.precio_dia);
					
			
		END IF;
		
		
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
        	

