-- Examen Evento Programado - Mantenimiento de Cuentas Inactivas

-- Se agrega la columna que registrará la fecha de la última compra de cada cliente 

ALTER TABLE Clientes
ADD COLUMN fecha_ultima_compra DATETIME DEFAULT NULL;


-- Se agrega la columna que registrará el estado del cliente en este caso aparecera por defecto como activo, a menos de que su estado se cambie con dicho evento

ALTER TABLE Clientes
ADD COLUMN activo BOOLEAN DEFAULT TRUE;


-- Trigger que permite la actualización de la fecha de la última compra en la tabla clientes  despues de insertada una nueva venta viculada a ese cliente

DELIMITER //


CREATE TRIGGER trg_actualizar_fecha_ultima_compra
AFTER INSERT ON Ventas
FOR EACH ROW
BEGIN
	
    UPDATE Clientes
    SET fecha_ultima_compra = NOW()
    WHERE id_cliente = NEW.id_cliente; 

END //

DELIMITER ;


-- Creacion de evento que se ejecuta el primer dia de cada mes, actualizando la tabla clientes de estado activo a estado inactivo pasandolo a false
-- don de la condición cumpla que el cliente primero sea un cliente activo y además la fecha registrada de la última compra sea menor a dos años 

DELIMITER //

CREATE EVENT  evt_desactivar_cuentas_inactivas
ON SCHEDULE EVERY 1 MONTH
STARTS DATE_ADD(DATE_FORMAT(NOW(), '%Y-%m-01 00:00:00'), INTERVAL 1 MONTH)
DO
BEGIN

	UPDATE Clientes 
	SET activo = FALSE
	WHERE (activo = TRUE) AND
	(fecha_ultima_compra < NOW() - INTERVAL 2 YEAR) ;

END //

DELIMITER ;


-- Se habilita el planificador de eventos de MySQL (necesario para que el evento se ejecute)

SET GLOBAL event_scheduler = ON;