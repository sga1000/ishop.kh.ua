<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php');
$widgets = new NeoSeoWidgets('neoseo_additional_scripts_', $params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>
<?php $widgets->dropdownA('status', 'neoseo_additional_scripts_code', $max_id, array(0 => $text_disabled, 1 => $text_enabled)); ?>
<?php $widgets->inputA('name', 'neoseo_additional_scripts_code', $max_id); ?>
<?php $widgets->localeTextareaA('script', 'neoseo_additional_scripts_code', $max_id, $languages, 12); ?>


