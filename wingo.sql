Create database IF NOT EXISTS wingo;

USE wingo;

CREATE TABLE Aviones (
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(50),
    tipo VARCHAR(50),
    base_mantenimiento VARCHAR(50)
);

CREATE TABLE Pilotos (
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(50),
    nombre VARCHAR(50),
    horas_vuelo INT,
    base_regreso VARCHAR(50)
);

CREATE TABLE MiembrosTripulacion (
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(50),
    nombre VARCHAR(50),
    base_regreso VARCHAR(50)
);

CREATE TABLE Vuelos (
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    numero_vuelo VARCHAR(50),
    origen VARCHAR(50),
    destino VARCHAR(50),
    hora VARCHAR(50),
    avion_id INT,
    piloto_id INT,
    tripulacion_ids VARCHAR(255),
    FOREIGN KEY (avion_id) REFERENCES Aviones(id),
    FOREIGN KEY (piloto_id) REFERENCES Pilotos(id)
);