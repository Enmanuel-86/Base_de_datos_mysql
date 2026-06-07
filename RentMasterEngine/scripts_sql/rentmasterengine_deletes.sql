# ESTE ARCHIVO CONTIENE TODAS LAS MANERAS DE ELIMINAR LA BASE DE DATOS

# PARA ELIMINAR TODO DE UN SOLO GOLPE
DROP DATABASE rentmasterengine;

# PARA BORRAR LAS TABLAS
DROP TABLE rentmasterengine.alquileres;
DROP TABLE rentmasterengine.auditorias;
DROP TABLE rentmasterengine.clientes;
DROP TABLE rentmasterengine.equipos;

# PARA ELIMINAR LOS REGISTROS DE LAS TABLAS SIN WHERE 
# (SIN ESPECIFICAR, ESTO ES UNA MALA PRACTICA)
DELETE FROM rentmasterengine.alquileres;
DELETE FROM rentmasterengine.auditorias;
DELETE FROM rentmasterengine.clientes;
DELETE FROM rentmasterengine.equipos;

# PARA ELIMINAR LOS REGISTROS DE LAS TABLAS CON WHERE
DELETE FROM rentmasterengine.alquileres WHERE id_alquiler = 1;
DELETE FROM rentmasterengine.auditorias WHERE id_auditoria = 1;
DELETE FROM rentmasterengine.clientes WHERE id_cliente = 1;
DELETE FROM rentmasterengine.equipos WHERE id_equipo = 1;


# PARA BORRAR Y RESETEAR LAS TABLAS
TRUNCATE rentmasterengine.alquileres;
TRUNCATE rentmasterengine.auditorias;
TRUNCATE rentmasterengine.clientes;
TRUNCATE rentmasterengine.equipos;


