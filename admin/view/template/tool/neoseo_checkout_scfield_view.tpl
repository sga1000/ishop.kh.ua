
<?php
foreach( $customData as $fieldName => $fieldData ) {
$label = $fieldData['label'];
if( is_array($fieldData['label']) ) {
$label = $fieldData['label'][$language_id];
}
?>
<tr>
	<td><?php echo $fieldData['label']; ?>:</td>
	<td><?php echo $fieldData['value']; ?></td>
</tr>
<?php } ?>
