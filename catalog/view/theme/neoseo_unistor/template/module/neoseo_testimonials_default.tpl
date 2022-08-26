<?php if($total != 0) { ?>
<div class="module" style="margin: 0">
    <h3><?php echo $testimonial_title; ?></h3>
    <div class="carousel-mode testimonials-main">
        <?php if (count($testimonials) > 1) { ?>
        <div id="testimonials-<?php echo $module; ?>" class="owl-carousel carousel-t testimonial-container" >
        <?php } else { ?>
            <div class="carousel-t testimonial-container">
        <?php } ?>

            <?php foreach ($testimonials as $testimonial) { ?>
            <div class="testimonials-item">
                <div class="testimonials-item_top">
                    <div class="_left">
                        <div class="name">
                            <a href="<?php echo $testimonial['href']; ?>"><?php echo $testimonial['name']; ?></a>
                        </div>
                        <div class="date">
                            <span><?php echo $testimonial['date_added']; ?></span>
                        </div>
                    </div>
                    <div class="_right">
                        <?php if ($testimonial['rating']) { ?>
                        <div class="rating">
                            <?php for ($i = 1; $i <= 5; $i++) { ?>
                            <?php if ($testimonial['rating'] < $i) { ?>
                            <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                            <?php } else { ?>
                            <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                            <?php } ?>
                            <?php } ?>
                        </div>
                        <?php } ?>
                    </div>

                </div>
                <div class="testimonials-item_bottom">
                    <div class="_left">
                        <i class="fa fa-quote-right" aria-hidden="true"></i>
                    </div>
                    <div class="_right">
                        <span><?php echo $testimonial['description']; ?></span>
                    </div>
                </div>
            </div>
            <?php } ?>
        </div>
    </div>
</div>
<?php } ?>
<?php if(count($testimonials) > 1) { ?>
<script >
    $(document).ready(function () {
        $('#testimonials-<?php echo $module; ?>').owlCarousel({
            loop:true,
            autoplay: true,
            items: 1,
            nav: false,
            dot: false,
        });
    });

</script>
<?php } ?>
