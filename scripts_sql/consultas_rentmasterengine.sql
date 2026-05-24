SELECT * FROM rentmasterengine.clientes;
SELECT * FROM rentmasterengine.equipos;
SELECT * FROM rentmasterengine.alquileres;
SELECT * FROM rentmasterengine.auditorias;

SELECT * FROM rentmasterengine.alquileres
WHERE id_cliente = 1;
CALL rentmasterengine.sp_cancelar_alquileres_por_cliente_id_y_monto(1, 2710, @res );
SELECT @res;

CALL rentmasterengine.sp_registrar_alquiler_por_id(1,3, @respuesta);
SELECT @respuesta;

SELECT * FROM rentmasterengine.vw_alquileres_de_equipos;
SELECT * FROM rentmasterengine.vw_auditoria_de_equipos;
SELECT * FROM rentmasterengine.vw_equipos_alquilados_y_no_alquilados;
SELECT * FROM rentmasterengine.vw_equipos_auditados_y_no_auditados;

# Equipos segun su estado
SELECT * FROM rentmasterengine.vw_equipos_alquilados;
SELECT * FROM rentmasterengine.vw_equipos_disponibles;
SELECT * FROM rentmasterengine.vw_equipos_en_mantenimiento;




START TRANSACTION;

CALL rentmasterengine.sp_pagar_alquiler_por_id_alquiler_y_monto(4, 800, @respuesta);
SELECT @respuesta;

ROLLBACK;
COMMIT;


