<?php if ($reviews) { ?>
<?php foreach ($reviews as $review) { ?>
<div class="reviews">
    <div class="reviews-top">
        <div class="reviews-top_title">
            <div class="top_title-author">
                <?php echo $review['author']; ?>
            </div>
            <div class="top_title-date">
                <?php echo $review['date_added']; ?>
            </div>
        </div>
        <div class="review-top_rating">
            <span class="top_rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($review['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php } ?>
                <?php } ?>
            </span>
        </div>

    </div>
    <div class="reviews-middle">
        <div class="middle_comment-text">
            <?php echo $review['text']; ?>
        </div>
    </div>
</div>
<?php } ?>
<div class="text-right"><?php echo $pagination; ?></div>
<script>
<?php if( $page > 1 ) { ?>
    $('a[href=#tab-review]').click();
	$('html, body').animate({
		scrollTop: $('a[href=#tab-review]').offset().top
	}, 2000);
<?php } ?>
</script>
<?php } else { ?>
<p><?php echo $text_no_reviews; ?></p>
<?php } ?>

