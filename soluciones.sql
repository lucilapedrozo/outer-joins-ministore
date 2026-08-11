-- ══════════════════════════════════════════
-- MiniStore — Soluciones con Outer JOINs
-- Autor: Lucila Pedrozo
-- Fecha: 11/08/2026
-- ══════════════════════════════════════════


-- ── CONSULTA 1: LEFT JOIN ─────────────────
-- Pregunta de negocio: ¿Qué productos del catálogo nunca fueron vendidos?
-- Mostramos todos los productos y sus ventas asociadas.

SELECT
    p.producto_id,
    p.nombre,
    p.categoria,
    p.precio,
    v.venta_id,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
LEFT JOIN ventas v
    ON p.producto_id = v.producto_id
ORDER BY p.producto_id, v.venta_id;

-- Filtro para ver solamente los productos que nunca fueron vendidos
SELECT
    p.producto_id,
    p.nombre,
    p.categoria,
    p.precio,
    v.venta_id
FROM productos p
LEFT JOIN ventas v
    ON p.producto_id = v.producto_id
WHERE v.venta_id IS NULL
ORDER BY p.producto_id;


-- ── CONSULTA 2: RIGHT JOIN ────────────────
-- Pregunta de negocio: ¿Existen ventas registradas con productos
-- que no figuran en nuestro catálogo?
-- productos está a la izquierda y ventas a la derecha.

SELECT
    p.producto_id AS producto_catalogo,
    p.nombre,
    p.categoria,
    p.precio,
    v.venta_id,
    v.producto_id AS producto_vendido,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
RIGHT JOIN ventas v
    ON p.producto_id = v.producto_id
ORDER BY v.venta_id;

-- Filtro para ver solamente las ventas con productos inexistentes
SELECT
    p.producto_id AS producto_catalogo,
    p.nombre,
    v.venta_id,
    v.producto_id AS producto_vendido,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
RIGHT JOIN ventas v
    ON p.producto_id = v.producto_id
WHERE p.producto_id IS NULL
ORDER BY v.venta_id;


-- ── CONSULTA 3: FULL OUTER JOIN ───────────
-- Pregunta de negocio: Vista completa de auditoría.
-- MySQL no soporta FULL OUTER JOIN directamente,
-- por eso se simula con LEFT JOIN + UNION + RIGHT JOIN.

SELECT
    p.producto_id AS producto_catalogo,
    p.nombre,
    p.categoria,
    p.precio,
    v.venta_id,
    v.producto_id AS producto_vendido,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
LEFT JOIN ventas v
    ON p.producto_id = v.producto_id

UNION

SELECT
    p.producto_id AS producto_catalogo,
    p.nombre,
    p.categoria,
    p.precio,
    v.venta_id,
    v.producto_id AS producto_vendido,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
RIGHT JOIN ventas v
    ON p.producto_id = v.producto_id
ORDER BY producto_catalogo, venta_id;
