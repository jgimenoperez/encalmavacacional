<?php
/**
 * Script para insertar automáticamente el widget de búsqueda en la página 1317
 *
 * Uso: Coloca este archivo en la raíz de WordPress y accede a:
 * http://localhost:8080/insertar-widget.php?token=seguro
 *
 * O ejecuta desde línea de comandos:
 * docker-compose exec wordpress php insertar-widget.php
 */

// Cargar WordPress
require_once('wp-load.php');

// Verificar permisos (opcional, comentar para desarrollo)
// if (!current_user_can('manage_options')) {
//     wp_die('Acceso denegado');
// }

// ID de la página
$page_id = 1317;

// Widget HTML + Script
$widget_code = '<!-- Widget de Búsqueda de Reservas Bookonline -->
<div class="widget-search-container" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px 20px; margin: 30px 0; border-radius: 10px;">
  <script type="text/javascript" src="https://bookonline.pro/widgets/search/dist/index.js" defer></script>
  <div data-accommodations-filter="none" data-target="_blank" class="avaibook-search-widget" data-widget-id="96718" data-widget-token="2qSUQVY/3JphKUQ7zoaDEA==" data-background-color="#FFFFFF" data-main-color="#1AB394" data-border-radius="3px" data-shadow="0 2px 20px rgb(0 0 0 / 16%)" data-padding="1rem" data-language="es"></div>
</div>';

// Obtener la página
$page = get_post($page_id);

if (!$page) {
    echo "❌ Error: No se encontró la página con ID $page_id\n";
    exit(1);
}

echo "Página encontrada: " . $page->post_title . "\n";
echo "Estado: " . $page->post_status . "\n\n";

// Verificar si ya tiene el widget
if (strpos($page->post_content, 'widget-search-container') !== false) {
    echo "⚠️  El widget ya existe en esta página. ¿Deseas reemplazarlo? (s/n)\n";
    $input = trim(fgets(STDIN));
    if ($input !== 's' && $input !== 'y') {
        echo "Operación cancelada.\n";
        exit(0);
    }

    // Remover widget existente
    $page->post_content = preg_replace(
        '/<div class="widget-search-container".*?<\/div>/s',
        '',
        $page->post_content
    );
}

// Insertar al inicio del contenido
$new_content = $widget_code . "\n\n" . $page->post_content;

// Actualizar la página
$result = wp_update_post(array(
    'ID' => $page_id,
    'post_content' => $new_content
));

if (is_wp_error($result)) {
    echo "❌ Error al actualizar: " . $result->get_error_message() . "\n";
    exit(1);
}

echo "✅ Widget insertado correctamente en la página $page_id\n";
echo "📍 Accede a: http://localhost:8080\n";
echo "\nSi no ves el widget, recarga con Ctrl+F5\n";
exit(0);
?>
