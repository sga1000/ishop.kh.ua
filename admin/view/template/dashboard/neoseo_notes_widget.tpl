<div class="tile  tile-dash tile-special tile-host">
	<div class="tile-heading"><a href="<?php echo $more; ?>" target="_blank" class="tile-title"><?php echo $title; ?> (<?php echo $count_items; ?>)</a> <a href="<?php echo $setting_widget; ?>" target="_blank" class="widget-link widget-link-r" ></a>
	</div>
	<div class="tile-body">
		<div class="notes-wrap">
			<?php if($items){ ?>
			<?php foreach ($items as $item) { ?>
			<div class="notedrop">
				<div class="block-flex note dropdown-toggle" data-toggle="dropdown" style="background-color:<?php echo $item['color']; ?>; color:<?php echo $item['font_color']; ?>">
					<div>
						<?php echo $item['title']; ?>
					</div>
					<?php if($item['use_notification'] && $item['interval_days']!='') { ?>
					<div class="term-overday">
						<?php echo $item['interval_days']; ?> <?php echo $text_days; ?>
					</div>
					<?php } ?>
				</div>
				<div class="dropdown-menu dropdown-menu-right note-dropdown">
					<h4 class="note__title" style="background-color:<?php echo $item['color']; ?>; color:<?php echo $item['font_color']; ?>"><?php echo $item['title']; ?></h4>
					<div class="note__body">
						<?php if($item['use_notification']) { ?>
						<div class="note__info"><?php echo $text_date_notification; ?> <span><?php echo $item['date_notification']; ?></span>
						</div>
						<?php } ?>
						<div class="note__text"><?php echo $item['text']; ?></div>
						<div class="note__info"><br><a href="<?php echo $item['view']; ?>" class="btn btn-tile" target="_blank"><?php echo $text_view; ?></a></div>
					</div>
				</div>
			</div>
			<?php } ?>
			<?php }else{ ?>
			<div class="block-flex term-action">
				<?php echo $text_no_result; ?>
			</div>
			<?php } ?>
		</div>
  </div>
</div>
<?php if($notification_items) { ?>
<script>
	$(function() {
	<?php foreach($notification_items as $note_id => $text_notification){ ?>
		$('.container-fluid:first').after('<div class="alert alert-danger alert-note" id="notify_note_<?php echo $note_id; ?>"><div class="note-text"><i class="fa fa-exclamation-circle"></i> <span>' + '<?php echo $text_notification; ?>' + '</span></div> <div class="alert-btns"><button type="button" class="btn btn-primary" onclick="changeStatusNotify(<?php echo $note_id; ?>)"><?php echo $button_notified; ?></button> <button type="button" class="btn " data-dismiss="alert"><i class="fa fa-times"></i>Скрыть</button></div></div>');
		<?php } ?>
	});
	
	function changeStatusNotify(note_id){
			$.ajax({
			url: 'index.php?route=dashboard/neoseo_notes_widget/changeStatusNotify&token=<?php echo $token;?>',
			type: 'post',
			data: {'note_id' : note_id},
			dataType: 'json',
			success: function (json) {
				$('#notify_note_'+note_id).remove();
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
</script>
<?php } ?>
