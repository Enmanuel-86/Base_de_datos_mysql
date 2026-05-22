# EN ESTE ARCHIVO .SQL TENDREMOS TODOS LOS INSERTS PARA LA BASE DE DATOS 
# YA SEA CON STORE PROCEDURES O INSERTS INTO:

/*
TRUNCATE rentmasterengine.clientes;
TRUNCATE rentmasterengine.equipos;
TRUNCATE rentmasterengine.alquileres;
TRUNCATE rentmasterengine.auditorias;
*/


USE rentmasterengine;
 
# INSERTAMOS INFORMACION DE CLIENTES PARA LA BD

INSERT INTO rentmasterengine.clientes (nombre, cedula, saldo_deudor)
VALUES 
    -- Clientes existentes
    ('Enmanuel Perez', '30767877', 0),
    ('Juan Garcia', '1928377', 0),
    ('Manolo Garcia', '123455', 0),
    ('Carlos Mendoza', '15342891', 0),
    ('María Alejandra Torres', '18254763', 0),
    ('José Gregorio Rivas', '12984532', 0),
    ('Ana Karina Silva', '20411895', 0),
    ('Luis Eduardo Gómez', '16723419', 0),
    ('Carmen Elena Rondón', '14556238', 0),
    ('Francisco Javier Tobar', '22145789', 0),
    ('Diana Carolina Pérez', '19365412', 0),
    ('Manuel Alejandro Castillo', '11852963', 0),
    ('Patricia Valentina Ortega', '24789451', 0),
    ('Ricardo José Andrade', '13546789', 0),
    ('Gabriela Sofia Colmenares', '21456987', 0),
    ('Miguel Ángel Benítez', '17894562', 0),
    ('Laura Beatriz Marcano', '19852364', 0),
    ('Daniel Enrique Palacios', '15632478', 0),
    ('Vanessa Alexandra Lugo', '23654789', 0),
    ('Pedro Luis Bermúdez', '12457896', 0);



# INSERTS CON STORE PROCEDURE PARA REGISTRAR LOS EQUIPOS
# ESTOS INSERT SON CON IA, ESTO ES PARA REALIZAR PRUEBAS
-- ==========================================
-- 15 EQUIPOS EN ESTADO: disponible
-- ==========================================
CALL rentmasterengine.sp_registrar_equipo('Rotomartillo Industrial Bosch', 'Construcción', 25.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Cámara DSLR Canon EOS R6', 'Fotografía', 45.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Proyector Epson 4K', 'Audiovisual', 35.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Planta Eléctrica 2500W', 'Generadores', 50.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Sierra Circular Makita', 'Construcción', 18.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Monitor de Campo 7" Feelworld', 'Fotografía', 12.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Altavoz Amplificado JBL 15"', 'Audiovisual', 30.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Reflector LED 200W con Trípode', 'Iluminación', 15.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Compresor de Aire 50L Dewalt', 'Herramientas', 22.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Estación Total Topográfica Foif', 'Ingeniería', 90.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Escalera Extensible 24 Peldaños', 'Construcción', 8.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Mezcladora de Pintura Eléctrica', 'Herramientas', 14.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Soldadora Inverter Lincoln', 'Construcción', 32.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Aspiradora Industrial Seco/Húmedo', 'Limpieza', 20.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Caladora de Banco Skil', 'Herramientas', 16.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Andamio Tubular de Aluminio', 'Construcción', 10.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Laptop Dell XPS 15', 'Tecnología', 30.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Consola de Sonido Yamaha 16Ch', 'Audiovisual', 60.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Mezcladora de Concreto 1 Saco', 'Construcción', 40.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Lente Sony FE 24-70mm f/2.8', 'Fotografía', 28.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Micrófono de Solapa Sennheiser', 'Audiovisual', 18.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Planta Eléctrica Diésel 10KVA', 'Generadores', 120.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Martillo Demoledor Dewalt 30Kg', 'Construcción', 55.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Trípode de Carbono Manfrotto', 'Fotografía', 10.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Estructura Truss para Luces 4m', 'Iluminación', 25.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Pulidora de Pisos Industrial', 'Limpieza', 35.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Nivel Láser Autonivelante Bosch', 'Ingeniería', 15.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Hidrolavadora a Gasolina Karcher', 'Limpieza', 45.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Mesa de Mezclas Video Blackmagic', 'Tecnología', 70.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Vibrador de Concreto Shimaha', 'Construcción', 22.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Cortadora de Concreto Honda', 'Construcción', 45.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Dron DJI Mavic 3 Pro', 'Fotografía', 75.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Micrófono Inalámbrico Shure', 'Audiovisual', 15.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Generador Eléctrico Portátil 800W', 'Generadores', 18.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Taladro de Banco Gladiator', 'Herramientas', 12.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Estabilizador Gimbal DJI Ronin RS3', 'Fotografía', 35.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Pantalla LED Gigante Exterior P4', 'Audiovisual', 250.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Esmeril Angular Metabo 9"', 'Herramientas', 14.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Motobomba de Agua 3" Briggs', 'Herramientas', 28.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Cortadora de Azulejos Rubí', 'Construcción', 10.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Gato Hidráulico de Botella 20T', 'Herramientas', 7.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Kit de Luces Fresnel (3 focos)', 'Iluminación', 40.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Compresor de Aire Dental Silencioso', 'Tecnología', 30.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Lijadora de Banda Makita', 'Herramientas', 11.00, 'disponible', @respuesta);
CALL rentmasterengine.sp_registrar_equipo('Pistola de Clavos Neumática Max', 'Construcción', 19.00, 'disponible', @respuesta);


# REGISTRANDO ALQUILERES

-- Declaración de la variable para capturar la respuesta del SP
SET @respuesta = '';

-- ==========================================
-- REGISTRO DE 20 ALQUILERES
-- SP: sp_registrar_alquiler_por_id(id_cliente, id_equipo, @respuesta)
-- ==========================================

-- Cliente 1 alquila Equipo 16 (Andamio Tubular de Aluminio)
CALL rentmasterengine.sp_registrar_alquiler_por_id(1, 16, @respuesta);

-- Cliente 2 alquila Equipo 17 (Laptop Dell XPS 15)
CALL rentmasterengine.sp_registrar_alquiler_por_id(2, 17, @respuesta);

-- Cliente 3 alquila Equipo 18 (Consola de Sonido Yamaha 16Ch)
CALL rentmasterengine.sp_registrar_alquiler_por_id(3, 18, @respuesta);

-- Cliente 4 alquila Equipo 19 (Mezcladora de Concreto 1 Saco)
CALL rentmasterengine.sp_registrar_alquiler_por_id(4, 19, @respuesta);

-- Cliente 5 alquila Equipo 20 (Lente Sony FE 24-70mm f/2.8)
CALL rentmasterengine.sp_registrar_alquiler_por_id(5, 20, @respuesta);

-- Cliente 6 alquila Equipo 21 (Micrófono de Solapa Sennheiser)
CALL rentmasterengine.sp_registrar_alquiler_por_id(6, 21, @respuesta);

-- Cliente 7 alquila Equipo 22 (Planta Eléctrica Diésel 10KVA)
CALL rentmasterengine.sp_registrar_alquiler_por_id(7, 22, @respuesta);

-- Cliente 8 alquila Equipo 23 (Martillo Demoledor Dewalt 30Kg)
CALL rentmasterengine.sp_registrar_alquiler_por_id(8, 23, @respuesta);

-- Cliente 9 alquila Equipo 24 (Trípode de Carbono Manfrotto)
CALL rentmasterengine.sp_registrar_alquiler_por_id(9, 24, @respuesta);

-- Cliente 10 alquila Equipo 25 (Estructura Truss para Luces 4m)
CALL rentmasterengine.sp_registrar_alquiler_por_id(10, 25, @respuesta);

-- Cliente 11 alquila Equipo 26 (Pulidora de Pisos Industrial)
CALL rentmasterengine.sp_registrar_alquiler_por_id(11, 26, @respuesta);

-- Cliente 12 alquila Equipo 27 (Nivel Láser Autonivelante Bosch)
CALL rentmasterengine.sp_registrar_alquiler_por_id(12, 27, @respuesta);

-- Cliente 13 alquila Equipo 28 (Hidrolavadora a Gasolina Karcher)
CALL rentmasterengine.sp_registrar_alquiler_por_id(13, 28, @respuesta);

-- Cliente 14 alquila Equipo 29 (Mesa de Mezclas Video Blackmagic)
CALL rentmasterengine.sp_registrar_alquiler_por_id(14, 29, @respuesta);

-- Cliente 15 alquila Equipo 30 (Vibrador de Concreto Shimaha)
CALL rentmasterengine.sp_registrar_alquiler_por_id(15, 30, @respuesta);



-- Opcional: Verificar el estado de la última respuesta
SELECT @respuesta AS 'Resultado Ultimo Registro';


# INSERT PARA LAS AUDITORIAS

-- Declaración de la variable para capturar la respuesta del SP
SET @respuesta = '';

-- ==========================================
-- REGISTRO DE 10 ACTUALIZACIONES DE PRECIO (AUDITORÍA)
-- SP: sp_actualizar_precio_equipo_por_id(id_equipo, precio_nuevo, @respuesta)
-- ==========================================

-- Actualización del Equipo 1
CALL rentmasterengine.sp_actualizar_precio_equipo_por_id(1, 30.50, @respuesta);

-- Actualización del Equipo 2
CALL rentmasterengine.sp_actualizar_precio_equipo_por_id(2, 55.00, @respuesta);

-- Actualización del Equipo 3
CALL rentmasterengine.sp_actualizar_precio_equipo_por_id(3, 40.00, @respuesta);

-- Actualización del Equipo 4
CALL rentmasterengine.sp_actualizar_precio_equipo_por_id(4, 65.25, @respuesta);

-- Actualización del Equipo 5
CALL rentmasterengine.sp_actualizar_precio_equipo_por_id(5, 22.00, @respuesta);

-- Actualización del Equipo 6
CALL rentmasterengine.sp_actualizar_precio_equipo_por_id(6, 15.75, @respuesta);

-- Actualización del Equipo 7
CALL rentmasterengine.sp_actualizar_precio_equipo_por_id(7, 35.00, @respuesta);

-- Actualización del Equipo 8
CALL rentmasterengine.sp_actualizar_precio_equipo_por_id(8, 18.50, @respuesta);

-- Actualización del Equipo 9
CALL rentmasterengine.sp_actualizar_precio_equipo_por_id(9, 26.00, @respuesta);

-- Actualización del Equipo 10
CALL rentmasterengine.sp_actualizar_precio_equipo_por_id(10, 95.50, @respuesta);

-- Opcional: Verificar el estado de la última actualización
SELECT @respuesta AS 'Resultado Ultima Actualizacion';
