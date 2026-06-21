# BASE DE DATOS PARA ATENCIÓN AL CLIENTE

Esta base de datos cumple con la función de almacenar y controlar la atención del cliente.

## Funciona de la siguiente manera:
    1. Se registran los clientes
    2. Se registran los empleados
    3. Si un cliente quiere ser atendido por un empleado se registra en la tabla de espera
    4. Si el empleado quiere atender a un cliente se registra en la tabla de atención del cliente
    5. Al culminar la atención del cliente este se registra en la tabla de auditoria para llevar un control de cuando se atendio a x cliente y por quien fue atendido.
    6. Luego de registrar la auditoria en las tablas de espera y de atención del cliente se borra esa información ya que es temporal.