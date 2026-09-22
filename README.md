Evento Programado - Mantenimiento de Cuentas Inactivas

Para mantener la base de datos limpia y cumplir con las políticas de retención de datos, la empresa ha decidido desactivar automáticamente las cuentas de clientes que no han realizado ninguna compra en los últimos dos años.



Tarea: Crea un evento programado llamado evt_desactivar_cuentas_inactivas.



El evento debe ejecutarse una vez al mes.
Debe buscar en la tabla Clientes aquellos usuarios cuya última compra (fecha_ultima_compra, un campo que deberías añadir a la tabla Clientes y mantener actualizado con un trigger) sea de hace más de dos años.
Para los clientes que cumplan esta condición, el evento debe actualizar un campo activo (booleano, que también debes añadir) en la tabla Clientes a FALSO.
Asegúrate de que el planificador de eventos de MySQL (event_scheduler) esté activado.
