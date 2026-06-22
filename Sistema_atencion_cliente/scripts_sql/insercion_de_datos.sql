-- REALIZANDO INSERCION DE DATOS

/*

	PARA LOS EMPLEADOS Y CLIENTES SIMPLEMENTE ES:
	- NOMBRE
	- APELLIDO
	- CORREO/EMAIL

*/

-- REGISTRANDO CLIENTES
CALL sistema_atencion_clientes.sp_registrar_cliente('Juan', 'Pérez', 'juan.perez@email.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_cliente('María', 'Gómez', 'maria.gomez@email.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_cliente('Carlos', 'Rodríguez', 'carlos.rod@email.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_cliente('Ana', 'Martínez', 'ana.martinez@email.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_cliente('Luis', 'Sánchez', 'luis.sanchez@email.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_cliente('Laura', 'Fernández', 'laura.fer@email.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_cliente('Diego', 'López', 'diego.lopez@email.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_cliente('Sofía', 'Díaz', 'sofia.diaz@email.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_cliente('Andrés', 'Torres', 'andres.torres@email.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_cliente('Elena', 'Ruiz', 'elena.ruiz@email.com', @respuesta);

-- REGISTRANDO EMPLEADOS

CALL sistema_atencion_clientes.sp_registrar_empleado('Alejandro', 'Morales', 'alejandro.morales@empresa.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_empleado('Gabriela', 'Herrera', 'gabriela.herrera@empresa.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_empleado('Ricardo', 'Castro', 'ricardo.castro@empresa.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_empleado('Valeria', 'Mendoza', 'valeria.mendoza@empresa.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_empleado('Fernando', 'Aguilar', 'fernando.aguilar@empresa.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_empleado('Patricia', 'Ortiz', 'patricia.ortiz@empresa.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_empleado('Manuel', 'Silva', 'manuel.silva@empresa.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_empleado('Natalia', 'Ramos', 'natalia.ramos@empresa.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_empleado('Javier', 'Vargas', 'javier.vargas@empresa.com', @respuesta);
CALL sistema_atencion_clientes.sp_registrar_empleado('Beatriz', 'Ríos', 'beatriz.rios@empresa.com', @respuesta);
