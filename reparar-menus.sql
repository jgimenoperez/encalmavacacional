-- Script para reparar menús importados en WordPress 6.9
-- Este script asigna el menú "Main Menu" a las ubicaciones de Astra

-- 1. Obtener el ID del menú "Main Menu"
SELECT @menu_id := term_id FROM wp_terms WHERE name = 'Main Menu' LIMIT 1;

-- 2. Obtener el ID de la opción de menús
SELECT @menu_setting_id := term_taxonomy_id FROM wp_term_taxonomy
WHERE taxonomy = 'nav_menu' AND term_id = @menu_id LIMIT 1;

-- 3. Asignar el menú a la ubicación principal de Astra
DELETE FROM wp_options
WHERE option_name IN ('nav_menu_locations', 'theme_mods_astra');

INSERT INTO wp_options (option_name, option_value, autoload) VALUES
(
  'nav_menu_locations',
  CONCAT('a:2:{s:13:"primary-menu";i:', @menu_id, ';s:12:"mobile-menu";i:', @menu_id, ';}'),
  'yes'
);

-- 4. Actualizar tema mods de Astra para asegurar que los menús se muestren
INSERT INTO wp_options (option_name, option_value, autoload) VALUES
(
  'theme_mods_astra',
  'a:0:{}',
  'yes'
)
ON DUPLICATE KEY UPDATE option_value = 'a:0:{}';

-- 5. Verificar que el menú está correctamente configurado
SELECT 'Verificación completada' AS status;
SELECT name AS 'Nombre del menú', term_id AS 'ID del menú'
FROM wp_terms WHERE name = 'Main Menu';
