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

SELECT  c.nombre , COUNT(a.id_cliente) AS Cant_alquileres,
		SUM(a.total_pagar) AS Total
FROM rentmasterengine.alquileres AS a 
INNER JOIN rentmasterengine.clientes AS c
	ON c.id_cliente = a.id_cliente
WHERE a.estado_pago = 'NO PAGADO'
GROUP BY c.nombre
ORDER BY total DESC;

call rentmasterengine.sp_registrar_alquiler_por_id(7,3, @res);
SELECT @res;


CALL rentmasterengine.sp_pagar_alquiler_por_id_alquiler_y_monto(19,1100, @res);
SELECT @res;


CALL rentmasterengine.sp_cancelar_alquileres_por_cliente_id_y_monto(7, 3200, @res);
SELECT @res;


SELECT COUNT(*), categoria
FROM rentmasterengine.equipos
WHERE estado = 'DISPONIBLE'
GROUP BY categoria ;


CREATE USER 'Enmanuel'@'localhost' IDENTIFIED BY 'mario12';

SELECT PASSWORD('mario_12');

GRANT SELECT, UPDATE ON rentmasterengine.* TO 'Enmanuel'@'localhost';
	
FLUSH PRIVILEGES;




