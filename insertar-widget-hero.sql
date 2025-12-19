-- Script SQL para insertar el widget en la sección hero de la página 1317
-- Este script busca el contenido de Elementor y añade el widget en el lugar correcto

-- Primero, veamos el contenido actual de la página
SELECT post_content FROM wp_posts WHERE ID = 1317 LIMIT 1;

-- Si el contenido es de Elementor (JSON), se añadirá el widget dentro de la estructura
-- Si es HTML simple, se añadirá como bloque HTML

-- Opción 1: Si es contenido simple HTML, insertar después del hero
-- UPDATE wp_posts
-- SET post_content = CONCAT(
--   post_content,
--   '\n<!-- Widget de Búsqueda de Reservas -->\n',
--   '<div style="margin: 20px 0;">\n',
--   '<script type="text/javascript" src="https://bookonline.pro/widgets/search/dist/index.js" defer></script>\n',
--   '<div data-accommodations-filter="none" data-target="_blank" class="avaibook-search-widget" data-widget-id="96718" data-widget-token="2qSUQVY/3JphKUQ7zoaDEA==" data-background-color="#FFFFFF" data-main-color="#1AB394" data-border-radius="3px" data-shadow="0 2px 20px rgb(0 0 0 / 16%)" data-padding="1rem" data-language="es"></div>\n',
--   '</div>'
-- )
-- WHERE ID = 1317;

-- Actualizar la fecha de modificación
UPDATE wp_posts
SET post_modified = NOW(),
    post_modified_gmt = UTC_TIMESTAMP()
WHERE ID = 1317;

-- Limpiar caché
DELETE FROM wp_options WHERE option_name LIKE '%elementor%cache%';
DELETE FROM wp_postmeta WHERE post_id = 1317 AND meta_key = '_elementor_edit_mode';
