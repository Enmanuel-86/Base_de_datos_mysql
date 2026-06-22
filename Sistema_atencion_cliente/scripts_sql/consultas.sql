-- Consulta de las tablas
SELECT * FROM sistema_atencion_clientes.clientes;
SELECT * FROM sistema_atencion_clientes.empleados;
SELECT * FROM sistema_atencion_clientes.en_espera_cliente;
SELECT * FROM sistema_atencion_clientes.atencion_al_cliente;
SELECT * FROM sistema_atencion_clientes.auditoria;

-- Consultas con vistas
SELECT * FROM sistema_atencion_clientes.vw_atencion_al_cliente;
SELECT * FROM sistema_atencion_clientes.vw_atencion_al_cliente_resumen;
SELECT * FROM sistema_atencion_clientes.vw_clientes_en_espera;
SELECT * FROM sistema_atencion_clientes.vw_auditoria;

-- Reiniciar tablas
TRUNCATE sistema_atencion_clientes.clientes;
TRUNCATE sistema_atencion_clientes.empleados;
TRUNCATE sistema_atencion_clientes.en_espera_cliente;
TRUNCATE sistema_atencion_clientes.atencion_al_cliente;
TRUNCATE sistema_atencion_clientes.auditoria;

-- Operaciones del sistema

-- 1. Registrar el cliente en la lista de espera o en cola (id_cliente)
CALL sistema_atencion_clientes.sp_registrar_espera_con_cliente_id(1, @res);
CALL sistema_atencion_clientes.sp_registrar_espera_con_cliente_id(2, @res);
CALL sistema_atencion_clientes.sp_registrar_espera_con_cliente_id(3, @res);
CALL sistema_atencion_clientes.sp_registrar_espera_con_cliente_id(4, @res);
CALL sistema_atencion_clientes.sp_registrar_espera_con_cliente_id(5, @res);
SELECT @res;

-- 2. Atender al cliente (id_cliente, id_empleado)
CALL sistema_atencion_clientes.sp_registrar_atencion_con_cliente_y_empleado_id(1, 2, @res);
CALL sistema_atencion_clientes.sp_registrar_atencion_con_cliente_y_empleado_id(2, 1, @res);
SELECT @res;

-- 3. Finalizar la atencion al cliente y registrar la auditoria (id_cliente)
CALL sistema_atencion_clientes.sp_finalizar_atencion_con_cliente_id(1, @res);
CALL sistema_atencion_clientes.sp_finalizar_atencion_con_cliente_id(2, @res);
SELECT @res;
