<?php if($total != 0) { ?>
<div id="neoseo_testimonial">
    <h3 class="testimonial-header"><?php echo $testimonial_title; ?></h3>

    <div class="testimonial-wrapper">
        <?php foreach ($testimonials as $testimonial) { ?>
        <div class="item text-center">
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
                    <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i
                                class="fa fa-star-o fa-stack-1x"></i></span>
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
                    <a href="<?php echo $testimonial['href']; ?>"><b><?php echo $admin_name; ?>Юлия - рыба</b></a>
                </div>
                <div class="admin-text"><?php echo $testimonial['admin_text']; ?></div>
            </div>
            <?php } ?>

            <div class="show_more text-right">
                <a href="<?php echo $showall_url; ?>" title="<?php echo $show_all; ?>"><?php echo $show_all; ?></a>
            </div>

        </div>
        <?php } ?>
    </div>
</div>
<?php } ?>