<?php if($total != 0) { ?>
<div id="neoseo_testimonial" class="carousel-mode">
    <h3 class="testimonial-header"><?php echo $testimonial_title; ?></h3>

    <div id="carousel-tt" class="owl-carousel carousel-t">
        <?php foreach ($testimonials as $testimonial) { ?>
        <div class="item">
            <div class="name">
                <a href="<?php echo $testimonial['href']; ?>"><b><?php echo $testimonial['name']; ?></b></a>
                <span class="date-added pull-right"><?php echo $testimonial['date_added']; ?></span>
            </div>
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
            <?php if ($testimonial['youtube']) { ?>
            <div class="youtube"><?php echo $testimonial['youtube']; ?></div>
            <?php } ?>
            <div class="description"><?php echo $testimonial['description']; ?></div>

            <?php if($testimonial['admin_text'] !='') { ?>
            <div class="admin-block">
                <div class="name admin-answer"><?php echo $admin_answer; ?></div>
                <div class="name">
                    <a href="<?php echo $testimonial['href']; ?>"><b><?php echo $admin_name; ?></b></a>
                </div>
                <div class="admin-text"><?php echo $testimonial['admin_text']; ?></div>
            </div>
            <?php } ?>

            <div class="show_more">
                <a href="<?php echo $showall_url; ?>" title="<?php echo $show_all; ?>"><?php echo $show_all; ?></a>
            </div>

        </div>
        <?php } ?>
    </div>
    <script src="/media/catalog_view_javascript_jquery_owl-carousel_owl.carousel.min.js" type="text/javascript"></script>
    <script type="text/javascript"><!--
        $('#carousel-tt').owlCarousel({
            items: 1,
            autoPlay: 5000,
            navigation: true,
            navigationText: ['<a class="btn btn-secondary prev"><i class="icon-arrow-pointing-left"></i></a>', '<a class="btn btn-secondary next"><i class="icon-right-arrow"></i></a>'],
            pagination: false,
            singleItem: true
        });
        --></script>
</div>
<?php } ?>