<?php if ($reviews) { ?>
<div class="module-carousel">
<h3><?php echo $header_title; ?></h3>

    <div class="carousel-nav neoseo_product_reviews<?php echo $module; ?>">
        <div class="prev" onclick="$('#neoseo_product_reviews<?php echo $module; ?> .owl-prev').trigger('click')"><i class="fa fa-angle-left"></i></div>
        <div class="next" onclick="$('#neoseo_product_reviews<?php echo $module; ?> .owl-next').trigger('click')"><i class="fa fa-angle-right"></i></div>
    </div>

<div id="neoseo_product_reviews<?php echo $module; ?>" class="row">
    <?php foreach ($reviews as $review) { ?>
    <div class="product-layout text-center">
        <div class="product-reviews-container box-shadow box-corner">
            <h6><a href="<?php echo $review['href']; ?>"><?php echo $review['name']; ?></a></h6>
        <a href="<?php echo $review['href']; ?>"><img class="img-responsive" src="<?php echo $review['image']; ?>" alt="<?php echo $review['name']; ?>"  width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>"/></a>
            <?php if ($review['rating']) { ?>
            <div class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($review['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php } ?>
                <?php } ?>
            </div>
            <?php } ?>
            <div class="autor">
                <h5><b><?php echo $review['author']; ?></b></h5>
                <p><?php echo $review['text']; ?></p>
            </div>
        </div>
    </div>
    <?php } ?>
</div>
</div>
<script>
    $(function () {

        $('#neoseo_product_reviews<?php echo $module; ?>').owlCarousel({
            items: 1,
            dots: false,
            nav: true,
            margin: 30,
            responsiveClass: true,
            responsive: {
                768: {
                    items: 2
                },
                992: {
                    items: 4
                },
                <?php if ($limit >= 5 ) { ?>
                    1200: {
                        items: <?php echo $limit; ?>
                    }
                <?php } ?>
            }
        });

        if ($(window).width() > 992) {
            if ($('#neoseo_product_reviews<?php echo $module; ?> .owl-item ').length <= <?php echo  $limit; ?>) {
                $('.carousel-nav.neoseo_product_reviews<?php echo $module; ?>').hide();
            }
        }

        if ($(window).width() > 767 && $(window).width() < 991) {
            if ($('#neoseo_product_reviews<?php echo $module; ?> .owl-item ').length < 3) {
                $('.carousel-nav.neoseo_product_reviews<?php echo $module; ?>').hide();
            }
        }

        if ($(window).width() < 768) {
            if ($('#neoseo_product_reviews<?php echo $module; ?> .owl-item ').length < 2) {
                $('.carousel-nav.neoseo_product_reviews<?php echo $module; ?>').hide();
            }
        }

        $(window).resize(function() {
            if ($(window).width() > 992) {
                if ($('#neoseo_product_reviews<?php echo $module; ?> .owl-item ').length < 5) {
                    $('.carousel-nav.neoseo_product_reviews<?php echo $module; ?>').hide();
                } else {
                    $('.carousel-nav.neoseo_product_reviews<?php echo $module; ?>').show();
                }
            }

            if ($(window).width() > 767 && $(window).width() < 991) {
                if ($('#neoseo_product_reviews<?php echo $module; ?> .owl-item ').length < 3) {
                    $('.carousel-nav.neoseo_product_reviews<?php echo $module; ?>').hide();
                } else {
                    $('.carousel-nav.neoseo_product_reviews<?php echo $module; ?>').show();
                }
            }

            if ($(window).width() < 768) {
                if ($('#neoseo_product_reviews<?php echo $module; ?> .owl-item ').length < 2) {
                    $('.carousel-nav.neoseo_product_reviews<?php echo $module; ?>').hide();
                } else {
                    $('.carousel-nav.neoseo_product_reviews<?php echo $module; ?>').show();
                }
            }
        });

    });

</script>
<?php } ?>