SELECT * FROM rentmasterengine.clientes;
SELECT * FROM rentmasterengine.equipos;
SELECT * FROM rentmasterengine.alquileres;
SELECT * FROM rentmasterengine.auditorias;


SELECT * FROM rentmasterengine.vw_alquileres_de_equipos;
SELECT * FROM rentmasterengine.vw_auditoria_de_equipos;
SELECT * FROM rentmasterengine.vw_equipos_alquilados_y_no_alquilados;
SELECT * FROM rentmasterengine.vw_equipos_auditados_y_no_auditados;

# Equipos segun su estado
SELECT * FROM rentmasterengine.vw_equipos_alquilados;
SELECT * FROM rentmasterengine.vw_equipos_disponibles;
SELECT * FROM rentmasterengine.vw_equipos_en_mantenimiento;


START TRANSACTION;

CALL rentmasterengine.sp_pagar_alquiler_por_id_alquiler_y_monto(16, 620.00, @respuesta);
SELECT @respuesta;

ROLLBACK;
COMMIT;


