# BASE DE DATOS PARA ATENCIÓN AL CLIENTE 🤖

Esta base de datos cumple con la función de almacenar y controlar la atención del cliente.

## 1. Como funciona ⚙️ :
- Se registran los clientes.
- Se registran los empleados.
- Si un cliente quiere ser atendido por un empleado se registra en la tabla de espera.
- Si el empleado quiere atender a un cliente se registra en la tabla de atención del cliente.
- Al culminar la atención del cliente este se registra en la tabla de auditoria para llevar un control de cuando se atendio a x cliente y por quien fue atendido.
- Luego de registrar la auditoria en las tablas de espera y de atención del cliente se borra esa información ya que es temporal.

## 2. Limitaciones ⚠️
La unica limitación **(por los momentos)** es que al atender un cliente no se puede atender por orden de llegar sino como el usuario quiera colocando el id del cliente y del empleado para que la consulta sea más exacta.

Obviamente esto acompañado de un lenguaje de programción es posible y más comodo.
