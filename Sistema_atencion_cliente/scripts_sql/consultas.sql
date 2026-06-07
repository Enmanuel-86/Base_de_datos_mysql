SELECT * FROM sistema_atencion_clientes.clientes;

CALL sistema_atencion_clientes.sp_registrar_cliente('Enmanuel', 'Garcia', 'enmanue@gmail.com', @respuesta);
SELECT @respuesta;
