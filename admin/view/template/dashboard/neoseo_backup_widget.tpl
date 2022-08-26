<div class="tile tile-dash tile-special tile-backup">
	<div class="tile-heading">
		<a href="<?php echo $more; ?>" target="_blank" class="tile-title"><?php echo $title; ?> (<?php echo $count_files; ?>)</a>
		<a href="<?php echo $setting_widget; ?>" target="_blank" class="widget-link widget-link-r" ></a>
	</div>
	<div class="tile-body">
		<?php if(isset($warning) && $warning) { ?>
		<div class="alert alert-danger alert-note">
			<div class="note-text">
				<i class="fa fa-exclamation-circle"></i><span><?php echo $warning; ?></span>
			</div>
		</div>
		<?php } ?>
		<?php if($count_files) { ?>
		<div class="block-flex term-action">
			<div>
				<span class="term-day"><?php echo $day_week; ?></span>
				<span class="term-date"><?php echo $date; ?></span>
				<span class="term-time"><?php echo $time; ?></span>
			</div>
			<?php if($interval_days == 0){ ?>
			<div class="term-overday">
				<?php echo $text_now; ?>
			</div>
			<?php } ?>
		</div>
		<?php }else{ ?>
		<div class="alert alert-danger alert-note">
			<div class="note-text">
				<i class="fa fa-exclamation-circle"></i> <span><?php echo $text_no_result; ?></span>
			</div>
		</div>
		<?php } ?>
	</div>
</div>