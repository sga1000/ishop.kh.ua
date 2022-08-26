<?php foreach( $options as $option ) { ?>
<div style="display: inline-block; width: 100%; margin-bottom: 10px;">
	<div class="col-sm-5">
		<label class="control-label" for="option_<?php echo $option['option_id']; ?>"><?php echo $option['name']; ?></label>
	</div>
	<div class="col-sm-7">
		<select name="option_<?php echo $option['option_id']; ?>[]"
				id="option_<?php echo $option['option_id']; ?>"
				class="form-control"
				multiple="multiple"
		>
			<?php foreach ($option['values'] as $value => $value_data) { ?>
			<?php if ($value_data['selected']) { ?>
			<option value="<?php echo $value; ?>" selected="selected"><?php echo $value_data['name']; ?></option>
			<?php } else { ?>
			<option value="<?php echo $value; ?>"><?php echo $value_data['name']; ?></option>
			<?php } ?>
			<?php } ?>
		</select>
		<script>
			$("#option_<?php echo $option['option_id'] ?>").multiselect({
				nonSelectedText: '',
				nSelectedText: 'выбрано',
				allSelectedText: 'Все',
			});
		</script>
	</div>
</div>
<?php } ?>

