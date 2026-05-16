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
INSERT INTO rentmasterengine.clientes (nombre, cedula, saldo_deudor)
VALUES 

SELECT * FROM rentmasterengine.equipos;
SELECT * FROM rentmasterengine.auditorias;

# RECORDATORIO: COMENTAR LOS INSERTS LUEGO DE ESTRUCTURARLOS



