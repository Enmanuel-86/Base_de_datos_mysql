/*
    ESTA BASE DE DATOS ES UN SISTEMA PARA EL CONTROL DE ATENCION AL CLIENTE.

    LEER LA DESCRIPCION EN EL README

*/

-- CREAMOS LA BASE DE DATOS SI NO EXISTE
CREATE DATABASE IF NOT EXISTS sistema_atencion_clientes;

-- UTILIZAMOS LA BASE DE DATOS
USE sistema_atencion_clientes;

-- CREAMOS UNA TABLA PARA LOS CLIENTES
CREATE TABLE sistema_atencion_clientes.clientes(
    id_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);

-- CREAMOS UNA TABLA DE LOS EMPLEADOS QUE ATENDERAN A LOS CLIENTES
CREATE TABLE sistema_atencion_clientes.empleados(
    id_empleado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);

-- CREAMOS UNA TABLA PARA REGISTRAR LAS AUDITORIAS DEL SISTEMA (LA BASE DE DATOS)
CREATE TABLE sistema_atencion_clientes.auditoria(
    id_auditoria INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNSIGNED,
    id_empleado INT UNSIGNED,
    duracion TIME
);

CREATE TABLE sistema_atencion_clientes.atencion_cliente(
    id_atencion_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNSIGNED,
    estado VARCHAR(15) DEFAULT 'EN ESPERA',
    fecha_atencion DATE,
    hora_comienzo TIME NOT NULL,
    hora_final TIME DEFAULT NULL
);

