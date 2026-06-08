SELECT * FROM sistema_atencion_clientes.clientes;
SELECT * FROM sistema_atencion_clientes.empleados;

SELECT * FROM sistema_atencion_clientes.en_espera_cliente;
SELECT * FROM sistema_atencion_clientes.atencion_al_cliente;

CALL sistema_atencion_clientes.sp_registrar_cliente('Enmanuel', 'Garcia', 'enmanue@gmail.com', @respuesta);
SELECT @respuesta;

CALL sistema_atencion_clientes.sp_registrar_espera_cliente_por_id(1, @respuesta);


TRUNCATE sistema_atencion_clientes.clientes;
TRUNCATE sistema_atencion_clientes.empleados;
TRUNCATE sistema_atencion_clientes.en_espera_cliente;
TRUNCATE sistema_atencion_clientes.atencion_al_cliente;


SELECT TIMEDIFF(CURRENT_TIME(), '05:10:00') as duracion;



CALL sistema_atencion_clientes.sp_registrar_espera_cliente_por_id(1, @respuesta);
CALL sistema_atencion_clientes.sp_registrar_atencion_cliente_por_id(1, 1, @respuesta);
