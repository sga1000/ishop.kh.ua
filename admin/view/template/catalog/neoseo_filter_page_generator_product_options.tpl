<?php foreach( $options as $option ) { ?>
<div style="display: inline-block; width: 33%; margin-bottom: 10px;">

	<label class="control-label col-sm-4" for="option_<?php echo $option['option_id']; ?>"><?php echo $option['name']; ?></label>
	<div class="col-sm-8 filter-options-values">
		<div class="well well-sm" style="height: 100px; overflow: auto; margin-bottom: 0px;">
			<?php $class = 'odd'; ?>
			<?php foreach ($option['values'] as $value => $value_data) { ?>
			<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
			<div class="<?php echo $class; ?>">
				<label>
					<input type="checkbox" name="filter_option[<?php echo $option['option_id']; ?>][]"
					       value="<?php echo $value; ?>" <?php if ($value_data['selected']) { ?> checked="checked" <?php } ?>/>
					       <?php echo $value_data['name']; ?>
				</label>
			</div>
			<?php } ?>
		</div>
		<div class="text-right">
			<a onclick="$(this).parents('.filter-options-values').find(':checkbox').prop('checked', true);">
				<?php echo $text_select_all; ?>
			</a>&nbsp;
			<a onclick="$(this).parents('.filter-options-values').find(':checkbox').prop('checked', false);">
				<?php echo $text_unselect_all; ?>
			</a>
		</div>
	</div>
</div>
<?php } ?>