USE wingo;

-- Insertar 5 registros en la tabla Aviones
INSERT INTO Aviones (codigo, tipo, base_mantenimiento) VALUES
('AV001', 'AIRBUS A320', 'Panamá'),
('AV002', 'BOEING 737', 'Bogotá'),
('AV003', 'AIRBUS A330', 'Medellín'),
('AV004', 'BOEING 787', 'Cali'),
('AV005', 'EMBRAER E190', 'Cartagena');

-- Insertar 5 registros en la tabla Pilotos
INSERT INTO Pilotos (codigo, nombre, horas_vuelo, base_regreso) VALUES
('P001', 'Carlos Ramirez', 800, 'Panamá'),
('P002', 'Laura Martinez', 600, 'Bogotá'),
('P003', 'Pedro Gonzalez', 700, 'Medellín'),
('P004', 'Ana Lopez', 500, 'Cali'),
('P005', 'Juan Perez', 900, 'Cartagena');

-- Insertar 5 registros en la tabla MiembrosTripulacion
INSERT INTO MiembrosTripulacion (codigo, nombre, base_regreso) VALUES
('M001', 'Maria Rodriguez', 'Panamá'),
('M002', 'Luisa Gomez', 'Bogotá'),
('M003', 'Jorge Hernandez', 'Medellín'),
('M004', 'Andres Silva', 'Cali'),
('M005', 'Carolina Perez', 'Cartagena');

-- Insertar registros en la tabla vuelos

INSERT INTO vuelos(numero_vuelo, origen, destino, hora, avion_id, piloto_id, tripulacion_ids) values
('WI01', 'Cali', 'Cartagena', '12:18', 1, 2, 'CLO-CTG-1218-12'),
('WI02', 'Bogotá', 'Panamá', '13:59', 3, 5, 'BOG-PAN-1359-35'),
('WI03', 'Cartagena', 'Medellín', '09:50', 4, 1, 'CTG-MED-0950-41'),
('WI04', 'Bogotá', 'Cartagena', '08:45', 2, 5, 'BOG-CTG-0845-25'),
('WI05', 'Cali', 'Medellín', '16:30', 3, 1, 'CLO-MED-1630-31')