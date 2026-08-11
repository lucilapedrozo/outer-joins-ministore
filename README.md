# MiniStore — LEFT, RIGHT y FULL OUTER JOIN

## Descripción

Este proyecto analiza el catálogo de productos y el historial de ventas de MiniStore mediante uniones externas de SQL.

El objetivo es detectar situaciones que un INNER JOIN no mostraría, como productos que nunca tuvieron ventas o ventas asociadas a un producto que no existe en el catálogo.

El repositorio contiene:

- `schema.sql`: crea las tablas `productos` y `ventas` y carga los datos de prueba.
- `soluciones.sql`: contiene las consultas con `LEFT JOIN`, `RIGHT JOIN` y `FULL OUTER JOIN` simulado.

## 1. ¿Por qué usé LEFT JOIN para la Consulta 1 y no INNER JOIN?

Usé `LEFT JOIN` porque necesito conservar todos los productos del catálogo, incluso aquellos que nunca tuvieron una venta.

En esta consulta, `productos` es la tabla ubicada a la izquierda. Por eso SQL devuelve todos sus registros. Cuando un producto no tiene una venta relacionada, las columnas provenientes de `ventas` aparecen como `NULL`.

En los datos de MiniStore ocurre con:

- Producto 108: Hub USB-C 7p.
- Producto 109: Parlante Bluetooth.

Si utilizara `INNER JOIN`, esos dos productos desaparecerían del resultado porque `INNER JOIN` solamente devuelve filas que tienen coincidencia en ambas tablas.

Por lo tanto, no podría detectar los productos que nunca se vendieron.

## 2. ¿Por qué usé RIGHT JOIN para la Consulta 2?

Usé `RIGHT JOIN` porque necesito conservar todas las ventas, aunque alguna tenga un `producto_id` que no exista en el catálogo.

En mi consulta, la tabla `productos` está a la izquierda y la tabla `ventas` está a la derecha.

Como `ventas` está del lado derecho, `RIGHT JOIN` mantiene todas sus filas.

Esto permite detectar la venta número 10, cuyo `producto_id` es 999. Ese producto no existe en la tabla `productos`, por lo que las columnas correspondientes al catálogo aparecen como `NULL`.

Este resultado puede indicar un error de carga o un problema de calidad de los datos.

## 3. ¿Qué representan los valores NULL en cada resultado?

Los valores `NULL` indican que SQL no encontró una fila relacionada en la otra tabla.

En la Consulta 1, si `venta_id` es `NULL`, significa que el producto existe en el catálogo pero no tiene ninguna venta registrada.

Por ejemplo, el producto 108, Hub USB-C 7p, existe en `productos` pero no aparece en ninguna fila de `ventas`.

Lo mismo sucede con el producto 109, Parlante Bluetooth.

En la Consulta 2, si `producto_id` de la tabla `productos` aparece como `NULL`, significa que existe una venta pero no se encontró ese producto en el catálogo.

El ejemplo concreto es la venta número 10. Esa venta tiene `producto_id = 999`, pero ese producto no existe en `productos`.

## 4. ¿Cuándo usaría FULL OUTER JOIN en un caso real de negocio?

Usaría `FULL OUTER JOIN` cuando necesito comparar dos fuentes de información y conservar todos los registros de ambas, tengan o no coincidencia.

Por ejemplo, podría utilizarse para comparar el catálogo de productos de un sistema de inventario con las ventas registradas en otro sistema.

De esta manera sería posible detectar al mismo tiempo:

- productos existentes en el catálogo que nunca fueron vendidos;
- ventas correctamente asociadas a productos;
- ventas con códigos de productos inexistentes.

En MiniStore, la consulta permite detectar los productos 108 y 109 sin ventas y también la venta 10 asociada al producto inexistente 999.

Esto resulta útil en procesos de auditoría y control de calidad de datos antes de construir reportes o dashboards.

## Nota sobre MySQL

MySQL no soporta `FULL OUTER JOIN` directamente.

Por eso se puede simular combinando `LEFT JOIN` y `RIGHT JOIN` mediante `UNION`.
