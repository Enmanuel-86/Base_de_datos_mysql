SELECT * FROM rentmasterengine.clientes;
SELECT * FROM rentmasterengine.equipos;
SELECT * FROM rentmasterengine.alquileres;

CALL rentmasterengine.sp_registrar_alquiler_por_id(1)

SELECT * FROM rentmasterengine.vw_alquileres_de_equipos;