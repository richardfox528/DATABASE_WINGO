/**
NOTA:###
Todas las consultas, tanto del punto 1 como del punto 2, estarán en este mismo documento SQL.
Se enumerarán cada una de ellas. 👌
**/

/**
#######################################################################################
#	1 Realiza consultas mediante la construcción de sentencias de algebra relacional. #
#######################################################################################
**/

-- A. Consultas utilizando operaciones relacionales:
	-- 1: Obtener los pilotos con más de 700 horas de vuelo
	SELECT * FROM Pilotos WHERE horas_vuelo > 700;

	-- 2: Obtener los miembros de tripulación que regresan a Bogotá
	SELECT * FROM MiembrosTripulacion WHERE base_regreso = 'Bogotá';

-- B. Consultas utilizando operaciones de la teoría de conjuntos:
	-- 1: Obtener la lista de aviones y pilotos en una sola consulta
	SELECT Aviones.codigo, Pilotos.* FROM Aviones INNER JOIN Pilotos ON Aviones.id = Pilotos.id;

	-- 2: Obtener la intersección de pilotos y miembros de tripulación
	SELECT * FROM Pilotos WHERE id IN (SELECT id FROM MiembrosTripulacion);
    
-- C. Consultas con operadores derivados:
	-- 1: Obtener el total de horas de vuelo de todos los pilotos
	SELECT SUM(horas_vuelo) AS total_horas_vuelo FROM Pilotos;

	-- 2: Obtener el promedio de horas de vuelo de los pilotos
	SELECT AVG(horas_vuelo) AS promedio_horas_vuelo FROM Pilotos;
    
-- D. Consultas con operadores relacionales adicionales:
	-- 1: Ordenar los pilotos por horas de vuelo de forma descendente
	SELECT * FROM Pilotos ORDER BY horas_vuelo DESC;

	-- 2: Filtrar los miembros de tripulación que no regresan a Medellín
	SELECT * FROM MiembrosTripulacion WHERE base_regreso <> 'Medellín';

/**
#####################################################################################
#	2 Realiza consultas y operaciones SQL                                           #
#####################################################################################
**/

-- A. Consultas aplicando condicionales:
	-- 1: Obtener los vuelos que tienen como destino Panamá
	SELECT vuelos.id, vuelos.numero_vuelo, vuelos.origen, vuelos.destino FROM Vuelos WHERE destino = 'Panamá';

	-- 2: Obtener los pilotos que regresan a la misma base después de los vuelos
	SELECT * FROM Pilotos WHERE base_regreso = (SELECT base_mantenimiento FROM Aviones WHERE Aviones.id = Pilotos.id);
    
-- B. Vistas a la base de datos:
	-- 1: Crear una vista con la información de los vuelos
	CREATE VIEW InformacionVuelos AS SELECT * FROM Vuelos;
    select * FROM InformacionVuelos;

	-- 2: Crear una vista con los pilotos y sus horas de vuelo
	CREATE VIEW PilotosHorasVuelo AS SELECT nombre, horas_vuelo FROM Pilotos;
    SELECT * FROM PilotosHorasVuelo;
    
-- C. Triggers en la base de datos:
	-- 1: Actualizar las horas de vuelo de un piloto al insertar un nuevo vuelo
    DELIMITER //
	CREATE TRIGGER ActualizarHorasVuelo BEFORE INSERT ON Vuelos
	FOR EACH ROW
	BEGIN
		UPDATE Pilotos SET horas_vuelo = horas_vuelo + 1 WHERE id = NEW.piloto_id;
	END //
    DELIMITER ;
    
    -- Eliminar trigger
	DROP TRIGGER wingo.ActualizarHorasVuelo;
	-- Mostrar trigger
	SHOW CREATE TRIGGER wingo.ActualizarHorasVuelo;

	-- 2: Registrar la fecha y hora de la última modificación en la tabla Aviones
    DELIMITER //
	CREATE TRIGGER RegistroUltimaModificacion AFTER UPDATE ON Aviones
	FOR EACH ROW
	BEGIN
		UPDATE Aviones SET ultima_modificacion = NOW() WHERE id = NEW.id;
	END //
    DELIMITER ;
    
    -- Eliminar trigger
	DROP TRIGGER wingo.RegistroUltimaModificacion;
	-- Mostrar trigger
	SHOW CREATE TRIGGER wingo.RegistroUltimaModificacion;
    
    SHOW TRIGGERS;
    
-- D. Procedimientos en la base de datos:
	-- 1: Calcular el total de horas de vuelo de un piloto
    DELIMITER //
	CREATE PROCEDURE CalcularTotalHorasVuelo (IN piloto_id INT)
	BEGIN
		SELECT SUM(horas_vuelo) AS total_horas_vuelo FROM Pilotos WHERE id = piloto_id;
	END //
    DELIMITER ;
    
    -- Eliminar lista de procedimientos
	DROP PROCEDURE IF EXISTS CalcularTotalHorasVuelo;
	-- Consultar lista
	CALL CalcularTotalHorasVuelo(4);

	-- 2: Actualizar la base de regreso de un miembro de tripulación
    DELIMITER //
	CREATE PROCEDURE ActualizarBaseRegreso (IN miembro_id INT, IN nueva_base VARCHAR(50))
	BEGIN
		UPDATE MiembrosTripulacion SET base_regreso = nueva_base WHERE id = miembro_id;
	END //
    DELIMITER ;
    
    -- Eliminar lista de procedimientos
	DROP PROCEDURE IF EXISTS ActualizarBaseRegreso;
	-- Consultar lista
	CALL ActualizarBaseRegreso(4, 'Cali');
    
    SHOW procedure status; -- LISTA DE PROCEDIMIENTOS (Buscar de la BD, wingo)
    
-- F. Transacciones en la base de datos:
-- 1
	-- Iniciar la transacción
	START TRANSACTION;

	-- Realizar operaciones dentro de la transacción
	UPDATE Aviones SET base_mantenimiento = 'Panamá' WHERE id = 6;
	INSERT INTO Pilotos (codigo, nombre, horas_vuelo, base_regreso) 
    VALUES ('P006', 'Maria Garcia', 600, 'Bogotá');

	-- Confirmar la transacción
	COMMIT;

	-- Revertir la transacción en caso de error
	ROLLBACK;


-- 2
	-- Inicia la transacción
    START TRANSACTION;
	-- Seleccionar los pilotos involucrados para la transacción
	SELECT p1.nombre AS piloto1, p1.horas_vuelo AS horas1, 
		   p2.nombre AS piloto2, p2.horas_vuelo AS horas2
	FROM Pilotos p1, Pilotos p2
	WHERE p1.codigo = 'P001' AND p2.codigo = 'P002';

	-- Transferir 100 horas de vuelo del piloto 1 al piloto 2
	UPDATE Pilotos 
	SET horas_vuelo = horas_vuelo - 100
	WHERE codigo = 'P001';

	UPDATE Pilotos
	SET horas_vuelo = horas_vuelo + 100 
	WHERE codigo = 'P002';

	-- Verificar los cambios
	SELECT p1.nombre AS piloto1, p1.horas_vuelo AS horas1, 
		   p2.nombre AS piloto2, p2.horas_vuelo AS horas2
	FROM Pilotos p1, Pilotos p2
	WHERE p1.codigo = 'P001' AND p2.codigo = 'P002';

	-- Confirmar la transacción
	COMMIT;
    
-- 3
	-- Inicia la transacción
	START TRANSACTION;

	-- Insertar un nuevo vuelo
	INSERT INTO Vuelos (id, numero_vuelo, origen, destino, hora, avion_id, piloto_id, tripulacion_ids)
	VALUES (1, 'VU001', 'Bogotá', 'Cartagena', '08:00', 1, 1, '1,2,3');

	-- Verificar la inserción
	SELECT * FROM Vuelos WHERE id = 1;

	-- Confirmar la transacción
	COMMIT;
