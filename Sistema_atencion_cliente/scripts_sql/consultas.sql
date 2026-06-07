SELECT * FROM sistema_atencion_clientes.clientes;
SELECT * FROM sistema_atencion_clientes.empleados;

SELECT * FROM sistema_atencion_clientes.en_espera_cliente;
SELECT * FROM sistema_atencion_clientes.atencion_al_cliente;

CALL sistema_atencion_clientes.sp_registrar_cliente('Enmanuel', 'Garcia', 'enmanue@gmail.com', @respuesta);
SELECT @respuesta;

CALL sistema_atencion_clientes.sp_registrar_espera_cliente_por_id(1, @respuesta);


TRUNCATE sistema_atencion_clientes.clientes;
TRUNCATE sistema_atencion_clientes.empleados;

INSERT INTO sistema_atencion_clientes.atencion_al_cliente (id_empleado, id_cliente, hora_comienzo, fecha_atencion)
VALUES (1, 1,CURRENT_TIME(), CURRENT_DATE());