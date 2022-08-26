<?php echo $header; ?>
<div class="container">
    <?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
    <?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } else { ?>
    <?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } ?>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?> neoseo_testimonial_content"><?php echo $content_top; ?>
            <div class="testimonial-users-container box-shadow box-corner">
                <div class="testimonial-users--top">
                    <div class="testimonial-users--title">
                        <h1><?php echo $heading_title; ?></h1>
                    </div>
                    <div class="testimonial-users--write-post">
                        <div class="buttons">
                            <div class="pull-right">
                                <?php if (isset($write_url)) { ?>
                                <a class="btn btn-post" href="<?php echo $write_url;?>"
                                   title="<?php echo $text_write;?>"><?php echo $text_write;?></a>
                                <?php }?>
                                <?php if (isset($showall_url)) { ?>
                                <a class="btn btn-post" href="<?php echo $showall_url;?>"
                                   title="<?php echo $text_showall;?>"><?php echo $text_showall;?></a>
                                <?php }?>
                            </div>
                        </div>
                    </div>
                </div>

                <?php if( count($testimonials) > 0 ) { ?>
                <?php foreach ($testimonials as $testimonial) { ?>
                <hr>
                <div class="item">
                    <div class="testimonial-reviewer">
                        <?php if ($testimonial['user_image']) { ?>
                        <div class="user-image"><img src="<?php echo $testimonial['user_image']; ?>" /></div>
                        <?php } ?>
                        <div class="line1">
                            <a href="<?php echo $testimonial['url']; ?>" class="reviewer-name"><?php echo $testimonial['name']; ?></a>
                            <span class="date"><?php echo $testimonial['date_added']; ?></span>
                        </div>
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
                        <?php if ($testimonial['youtube']) { ?>
                        <div class="youtube variable"><?php echo $testimonial['youtube']; ?></div>
                        <?php } ?>
                        <br>
                        <div class="description"><?php echo $testimonial['description']; ?></div>
                        <?php if($testimonial['admin_text']) { ?>
                            <div class="admin-block">
                                <div class="line2">
                                    <a class="admin-name"><i class="fa fa-reply" aria-hidden="true"></i><?php echo $admin_answer; ?></a>
                                    <span class="date"><?php echo $testimonial['date_admin_added']; ?></span>
                                </div>
                                <br>
                                <div class="admin-description"><?php echo $testimonial['admin_text']; ?></div>
                            </div>
                        <?php }?>
                    </div>
                </div>
                <?php } ?>
                <?php } else { ?>
                <p><?php echo $text_empty; ?></p>
                <?php } ?>

                <?php if ( isset($pagination) and $pagination ) { ?>
                <div class="pagination"><?php echo $pagination;?></div>
                <?php }?>
            </div>
        </div>
        <?php echo $content_bottom; ?>
        <?php echo $column_right; ?>
    </div>
</div>

<?php echo $footer; ?>