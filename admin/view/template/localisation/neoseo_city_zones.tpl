<?php foreach ($zones as $zone) { ?>
<?php  if ($fromlist) { ?>
<?php  if ($zone['city_count'] >= 1) { // Если отключить подсчет, то будет отображать все регионы, а не те в которых есть города ?>
	<?php if ($zone['zone_id'] == $zone_id) { ?>
		<option value="<?php echo $zone['zone_id']; ?>" selected="selected"><?php echo $zone['name']; ?></option>
	<?php } else { ?>
		<option value="<?php echo $zone['zone_id']; ?>"><?php echo $zone['name']; ?></option>
	<?php } ?>
	<?php } ?>
<?php } else {
	if ($zone['zone_id'] == $zone_id) { ?>
		<option value="<?php echo $zone['zone_id']; ?>" selected="selected"><?php echo $zone['name']; ?></option>
	<?php } else { ?>
		<option value="<?php echo $zone['zone_id']; ?>"><?php echo $zone['name']; ?></option>
	<?php } ?>
   <?php } ?>
<?php } ?>
