<div class="costumer-comments">
	<h2 id="comments-header">
		<?php if (!empty($heading_title)) { ?>
			<?php echo $heading_title; ?>
		<?php } else { ?>
			<?php echo $text_comments; ?>
		<?php } ?>
	</h2>

	<div class="clearfix">
		<form class="form-horizontal <?php echo $captcha ? 'with-captcha' : ''; ?>" id="form-comment">
			<div itemscope="" id="comments"><?php echo $reviews; ?></div>
			<div class="costumer-form">
				<h3 id="comment_write">
					<?php echo $text_write; ?>
					<a href="#" id="reply-remove" class="hide small" onclick="return removeReply();">[<?php echo $text_cancel_reply; ?>]</a>
				</h3>
				<input type="hidden" value="0" id="reply-id" name="reply_id"/>
				<div class="form-group required">
					<div class="customer-info col-sm-12">
						<label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
						<input type="text" name="name" value="" id="input-name" class="form-control"/>
					</div>
				</div>
				<div class="form-group required">
					<div class="customer-comment col-sm-12">
						<label class="control-label" for="input-review"><?php echo $entry_comment; ?></label>
						<textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
					</div>
				</div>
				<div class="costumer-form-submit">
					<div class="form-group required">
						<div class="col-sm-12 rating-fl">
							<label class="control-label zrate-label"><?php echo $entry_rating; ?></label>
							<div class="row">
								<div class="col-lg-12">
									<div class="star-rating">
										<span class="fa fa-star-o" data-rating="1"></span>
										<span class="fa fa-star-o" data-rating="2"></span>
										<span class="fa fa-star-o" data-rating="3"></span>
										<span class="fa fa-star-o" data-rating="4"></span>
										<span class="fa fa-star-o" data-rating="5"></span>
										<input type="hidden" name="rating" class="rating-value" value="3">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-12 comment-captcha">
						<?php echo $captcha; ?>
					</div>
					<div class="buttons">
						<div class="text-left">
							<button type="button" id="button-comment" data-loading-text="<?php echo $text_loading; ?>" class="btn comment-reply-link "><?php echo $button_submit; ?></button>
						</div>
					</div>
				</div>

			</div>
		</form>
	</div>
</div>

<script>
	var $star_rating = $('.star-rating .fa');

	var SetRatingStar = function () {
		return $star_rating.each(function () {
			if (parseInt($star_rating.siblings('input.rating-value').val()) >= parseInt($(this).data('rating'))) {
				return $(this).removeClass('fa-star-o ').addClass('fa-star');
			} else {
				return $(this).removeClass('fa-star').addClass('fa-star-o');
			}
		});
	};

	$star_rating.hover(function () {
		$star_rating.siblings('input.rating-value').val($(this).data('rating'));
		return SetRatingStar();
	});

	SetRatingStar();

	function removeReply() {
		$("#reply-id").val(0);
		$("#reply-remove").addClass('hide');

		return false;
	}

	function replyComment(comment_id) {
		$("#reply-id").val(comment_id);
		$("#reply-remove").removeClass('hide');

		$('html, body').animate({
			scrollTop: $("#comment_write").offset().top
		}, 500);

		return false;
	}

	$('#button-comment').on('click', function () {
		$.ajax({
			url: 'index.php?route=blog/neoseo_blog_comment/write&article_id=<?php echo $article_id; ?>',
			type: 'post',
			dataType: 'json',
			data: $("#form-comment").serialize(),
			beforeSend: function () {
				$('#button-review').button('loading');
			},
			complete: function () {
				$('#button-comment').button('reset');
			},
			success: function (json) {
				$('.alert-success, .alert-danger').remove();

				if (json['error']) {
					$('#comments').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
					$('.alert').delay(3000).fadeOut('slow');
				}

				if (json['success']) {
					$('#comments').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
					$('.alert').delay(3000).fadeOut('slow');

					$('input[name=\'name\']').val('');
					$('textarea[name=\'text\']').val('');

					removeReply();

					$('#comments').load('index.php?route=blog/neoseo_blog_comment&article_id=<?php echo $article_id; ?>');
				}
			}
		});
	});

	// STARS
	$('.z_stars span').mouseenter(function (e) {
		var n = $(this).index();
		$(this).siblings('span').each(function (index, element) {
			if ($(this).index() < n ) $(this).addClass('active');
			else $(this).removeClass('active');
		});
	});
	$('.z_stars span').mouseleave(function (e) {
		var n = $(this).index();
		var p = $(this).parent('.z_stars');
		var s = p.data('value');
		if (s ) {
			if (n == s - 1) {
				$(this).addClass('active');
			} else {
				p.find('span').each(function (index, element) {
					if ($(this).index() < s) {
						$(this).addClass('active');
					} else {
						$(this).removeClass('active');
					}
				});
			}
		} else {
			$(this).siblings('span').each(function (index, element) {
				$(this).removeClass('active');
			});
		}
	});
	$('.z_stars span').click(function (e) {
		var i = $(this).index();
		$(this).parent('.z_stars').data('value', i + 1);
		$(this).parent('.z_stars').find('input.inp-rating').val(i+1);
		$(this).addClass('active');
	});
	$('.z_stars').mouseleave(function (e) {
		var s = $(this).data('value');
		if (s) {
			$(this).find('span').each(function (index, element) {
				if ($(this).index() < s ) $(this).addClass('active');
			});
		}
	});
	$('.z_stars').data('value',3);
	$('.z_stars .inp-rating').val(3);
	$('.z_stars span:lt(3)').addClass('active');
</script> 	