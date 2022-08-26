<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-blog-comment" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>
			<img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
			<h1><?php echo $heading_title_raw . " " . $text_module_version; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
					<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div> <!-- end of page-header class -->

	<div class="container-fluid">
		<?php if ($error_warning) { ?>
			<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>

		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
			</div>

			<div class="panel-body">


				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-blog-comment" class="form-horizontal">

					<?php if( $comment_reply_id > 0 ) { ?>
					<input type="hidden" name="comment_reply_id" value="<?php echo $comment_reply_id; ?>"/>
					<input type="hidden" name="article_id" value="<?php echo $article_id; ?>"/>
					<input type="hidden" name="article_name" value="doesn't matter at all"/>
					<input type="hidden" name="rating" value="1"/>
					<div class="form-group" style="background: #eeeeee">
						<div>
							<b class="col-lg-2 col-md-2 col-sm-2 col-xs-12 text-right"><?php echo $entry_article; ?></b>
							<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
								<p><?php echo $article_name; ?></p>
							</div>
						</div>

						<div>
							<b class="col-lg-2 col-md-2 col-sm-2 col-xs-12 text-right"><?php echo $text_parent_comment; ?></b>
							<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
								<p><b><?php echo $comment_reply_author_name; ?></b>, <?php echo $comment_reply_date; ?></p>
								<p>
									<?php foreach( range(1,5) as $i ) { ?>
									<?php if( $comment_reply_rating > $i ) { ?>
									<span class="fa fa-star"></span>
									<?php } else { ?>
									<span class="fa fa-star-o"></span>
									<?php } ?>
									<?php } ?>
								</p>
								<p><?php echo $comment_reply_comment; ?></p>
								<p><a href="<?php echo $comment_reply_url; ?>"><?php echo $text_goto_comment; ?></a></p>
							</div>
						</div>
					</div>
					<?php } ?>

					<div class="form-group required">
						<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_author; ?></label>
						<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
							<input type="text" name="author_name" value="<?php echo $author_name; ?>" class="form-control" />
							<?php if ($error_author) { ?>
								<span class="text-danger"><?php echo $error_author; ?></span>
							<?php } ?>
						</div>
					</div>

					<?php if( $comment_reply_id == 0 ) { ?>
					<div class="form-group required">
						<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><span data-toggle="tooltip" title="<?php echo $help_article; ?>"><?php echo $entry_article; ?></label>
						<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
							<input type="text" name="article_name" value="<?php echo $article_name; ?>" class="form-control" />
							<input type="hidden" name="article_id" value="<?php echo $article_id; ?>"/>
							<?php if ($error_article_name) { ?>
								<span class="text-danger"><?php echo $error_article_name; ?></span>
							<?php } ?>
						</div>
					</div>
					<?php } ?>

					<?php if( $comment_reply_id == 0 ) { ?>
					<div class="form-group required">
						<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_rating; ?></label>
						<div class="col-sm-10">
							<label class="radio-inline">
								<?php if ($rating == 1) { ?>
								<input type="radio" name="rating" value="1" checked="checked" />
								1
								<?php } else { ?>
								<input type="radio" name="rating" value="1" />
								1
								<?php } ?>
							</label>
							<label class="radio-inline">
								<?php if ($rating == 2) { ?>
								<input type="radio" name="rating" value="2" checked="checked" />
								2
								<?php } else { ?>
								<input type="radio" name="rating" value="2" />
								2
								<?php } ?>
							</label>
							<label class="radio-inline">
								<?php if ($rating == 3) { ?>
								<input type="radio" name="rating" value="3" checked="checked" />
								3
								<?php } else { ?>
								<input type="radio" name="rating" value="3" />
								3
								<?php } ?>
							</label>
							<label class="radio-inline">
								<?php if ($rating == 4) { ?>
								<input type="radio" name="rating" value="4" checked="checked" />
								4
								<?php } else { ?>
								<input type="radio" name="rating" value="4" />
								4
								<?php } ?>
							</label>
							<label class="radio-inline">
								<?php if ($rating == 5) { ?>
								<input type="radio" name="rating" value="5" checked="checked" />
								5
								<?php } else { ?>
								<input type="radio" name="rating" value="5" />
								5
								<?php } ?>
							</label>
							<?php if ($error_rating) { ?>
							<div class="text-danger"><?php echo $error_rating; ?></div>
							<?php } ?>
						</div>
					</div>
					<?php } ?>

					<div class="form-group required">
						<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_comment; ?></label>
						<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
							<textarea name="comment" class="form-control" rows="6"><?php echo $comment; ?></textarea>
							<?php if ($error_comment) { ?>
							<span class="text-danger"><?php echo $error_comment; ?></span>
							<?php } ?>
						</div>
					</div>

					<div class="form-group">
								<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_status; ?></label>
								<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
									<select name="status" class="form-control">
										<option value="1" <?php echo ($status == 1) ? "selected='selected'" : ""; ?>><?php echo $text_enabled; ?></option>
										<option value="0" <?php echo ($status == 0) ? "selected='selected'" : ""; ?>><?php echo $text_disabled; ?></option>
									</select>
								</div>
							</div>

					<?php if( $comment_id > 0 && $comment_reply_id == 0) { ?>
					<div class="form-group" style="background: #eeeeee">
						<label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $text_child_comments; ?></label>
						<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">

							<p><a class="btn btn-primary" href="<?php echo $add_comment; ?>"><?php echo $text_add ;?></a></p>

							<?php if( isset($child_comments) && $child_comments ) { ?>
							<?php foreach( $child_comments as $child_comment ) { ?>
							<p><b><?php echo $child_comment['author_name']; ?></b>, <?php echo $child_comment['date']; ?></p>
							<p>
								<?php foreach( range(1,5) as $i ) { ?>
								<?php if( $child_comment['rating'] > $i ) { ?>
								<span class="fa fa-star"></span>
								<?php } else { ?>
								<span class="fa fa-star-o"></span>
								<?php } ?>
								<?php } ?>
							</p>
							<p><?php echo $child_comment['comment']; ?></p>
							<p><a href="<?php echo $child_comment['url']; ?>"><?php echo $text_goto_comment; ?></a></p>
							<hr>
							<?php } ?>
							<?php } ?>
						</div>
					</div>
					<?php } ?>
				</form>
			</div>
		</div>
	</div>        
</div>

<script type="text/javascript">
var module_row = <?php echo $module_row; ?>;
		
function addReply() {			

  html  = '<tbody id="reply-' + module_row + '">';
	html += '	<tr>';
	html += '		<td class="text-left">';
	html += '			<input type="text" name="comment_reply[' + module_row + '][author]" value="" class="form-control" />';
	html += '		</td>';			
	html += '		<td class="text-left">';
	html += '			<textarea name="comment_reply[' + module_row + '][comment]" class="form-control"></textarea>';
	html += '		</td>';			
	html += '		<td class="text-left">';
	html += '			<select name="comment_reply[' + module_row + '][status]" class="form-control">';
	html +='				<option value="1"><?php echo $text_enabled; ?></option>';
	html +='				<option value="0"><?php echo $text_disabled; ?></option>';
	html += '			</select>';
	html += '		</td>';			
	html += '		<td class="text-left"><button type="button" onclick="$(\'#reply-' + module_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '	</tr>';
	html += '</tbody>';
			
	$('#comment-reply tfoot').before(html);
		   
	module_row++;
}		
</script>
	
<script type="text/javascript">
$('input[name=\'article_name\']').autocomplete({
  'source': function (request, response) {
	  $.ajax({
		url: 'index.php?route=blog/neoseo_blog_article/autocomplete&token=<?php echo $token; ?>&article_name=' +  encodeURIComponent(request),
		dataType: 'json',
		success: function (json) {
		  response($.map(json, function (item) {
			return {
			  label: item['name'],
			  value: item['article_id']
			}
		  }));
		}
	  });
  },
  'select': function (item) {
	  $('input[name=\'article_name\']').val(item['label']);
		$('input[name=\'article_id\']').val(item['value']);
  }
});   
</script>
	
<?php echo $footer; ?>