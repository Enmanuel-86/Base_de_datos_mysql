USE rentmasterengine;


SELECT * FROM rentmasterengine.equipos ;
SELECT * FROM rentmasterengine.clientes ;
SELECT * FROM rentmasterengine.alquileres;
SELECT * FROM rentmasterengine.auditorias;
 

/*
# UPDATE PARA PROBRAR EL TRIGGER DE REGISTRAR AUDITORIA
UPDATE rentmasterengine.equipos
SET precio_dia = 500.50
WHERE id_equipo = 1;
*/

# INSERT PARA REALIZAR CONSULTAS

# USANDO EL STORED PROCEDURE: sp_registrar_equipo(nombre, categoria, precio_dia, estado)
/*
CALL rentmasterengine.sp_registrar_equipo('Excavadora Caterpillar 320', 'Maquinaria Pesada', 450.00, 'Disponible');
CALL rentmasterengine.sp_registrar_equipo('Mini Cargador Bobcat S450', 'Compactos', 180.340, 'DiSpOniBLE');
CALL rentmasterengine.sp_registrar_equipo('Generador Eléctrico 100kVA', 'Energía', -95.00, 'Alquilado');
CALL rentmasterengine.sp_registrar_equipo('Plataforma de Tijera JLG', 'Elevación', 120.00, 'Mantenimiento');
CALL rentmasterengine.sp_registrar_equipo('Retroexcavadora John Deere 310L', 'Maquinaria Pesada', 320.00, 'Disponible');
CALL rentmasterengine.sp_registrar_equipo('Compresor de Aire Industrial', 'Herramientas Neumáticas', 65.00, 'Disponible');
CALL rentmasterengine.sp_registrar_equipo('Rodillo Compactador Dynapac', 'Pavimentación', 210.00, 'Alquilado');
CALL rentmasterengine.sp_registrar_equipo('Torre de Iluminación LED', 'Iluminación', 45.00, 'Disponible');
CALL rentmasterengine.sp_registrar_equipo('Martillo Hidráulico para Mini', 'Accesorios', 85.00, 'Mantenimiento');
CALL rentmasterengine.sp_registrar_equipo('Montacargas Toyota 2.5 Ton', 'Carga', 110.00, 'Disponible');
*/

# UPDATE DE LOS PRECIOS DE LOS EQUIPOS CON STORE PROCEDURE
# rentmasterengine.sp_actualizar_precio_equipo( nombre_equipo, precio_nuevo)

# Con el nombre exactamente igual
CALL rentmasterengine.sp_actualizar_precio_equipo('excavadora caterpillar 320', 200.10);
CALL rentmasterengine.sp_actualizar_precio_equipo('generador eléctrico 100kva', 202.10);

# Sin el nombre exactamente igual
CALL rentmasterengine.sp_actualizar_precio_equipo('excasssvadora caterpillar 320', 200.10);

# INSERTAMOS INFORMACION DE CLIENTES PARA LA BD

/*
INSERT INTO rentmasterengine.clientes (nombre, cedula, saldo_deudor)
VALUES ('Enmanuel Perez', '30767877', 0),
   		('Juan Garcia', '1928377', 0),
   		('Manolo Garcia', '123455', 0),
   		('Carlos Mendoza', '15342891', 0),
		('María Alejandra Torres', '18254763', 0),
		('José Gregorio Rivas', '12984532', 0),
		('Ana Karina Silva', '20411895', 0),
		('Luis Eduardo Gómez', '16723419', 0),
		('Carmen Elena Rondón', '14556238', 0),
		('Francisco Javier Tobar', '22145789', 0),
		('Diana Carolina Pérez', '19365412', 0),
		('Manuel Alejandro Castillo', '11852963', 0),
		('Patricia Valentina Ortega', '24789451', 0);
	   
*/

SELECT * FROM rentmasterengine.clientes;
SELECT * FROM rentmasterengine.equipos;
SELECT * FROM rentmasterengine.auditorias;
SELECT * FROM rentmasterengine.alquileres;


START TRANSACTION;
	INSERT INTO rentmasterengine.alquileres (id_cliente, id_equipo, fecha_salida, fecha_esperada,
											 fecha_entrega_real, total_pagar)		 
	VALUES (1, 2, NOW(), DATE_ADD(CURDATE(), INTERVAL 30 DAY), DATE_ADD(CURDATE(), INTERVAL 40 DAY), 200.00);
ROLLBACK;
COMMIT;




# RECORDATORIO: COMENTAR LOS INSERTS LUEGO DE ESTRUCTURARLOS



