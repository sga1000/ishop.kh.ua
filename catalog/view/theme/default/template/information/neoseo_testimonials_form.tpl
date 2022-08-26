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
        <div id="content" class="<?php echo $class; ?> neoseo_testimonial_content testimonial_form"><?php echo $content_top; ?>
            <h1><?php echo $heading_title; ?></h1>
            <?php if($error){ ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error; ?></div>
            <?php } ?>
            <div class="content"><p><?php echo $text_conditions ?></p></div>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="testimonial" class="form-horizontal <?php echo $captcha ? 'with-captcha' : ''; ?>">

                <div class="form-group required">
                    <label class="col-sm-12 col-md-3 control-label" for="input-name"><?php echo $entry_name ?></label>
                    <div class="col-sm-12 col-md-9">
                        <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name ?>" id="input-name" class="form-control">
                    </div>
                </div>

                <div class="form-group required">
                    <label class="col-sm-12 col-md-3 control-label" for="input-description"><?php echo $entry_enquiry ?></label>
                    <div class="col-sm-12 col-md-9">
                        <textarea name="description" id="description" rows="6" placeholder="<?php echo $description; ?>" class="form-control"><?php echo $description; ?></textarea>
                    </div>
                </div>

                <div class="form-group required">
                    <label class="col-sm-12 col-md-3 control-label" for="input-rating"><?php echo $entry_rating ?></label>
                    <div class="col-sm-12 col-md-9">
                        <span><?php echo $entry_bad; ?></span>&nbsp;
                        <input type="radio" name="rating" value="1" style="margin: 0;" <?php if ( $rating == 1 ) echo 'checked="checked"';?> />
                        &nbsp;
                        <input type="radio" name="rating" value="2" style="margin: 0;" <?php if ( $rating == 2 ) echo 'checked="checked"';?> />
                        &nbsp;
                        <input type="radio" name="rating" value="3" style="margin: 0;" <?php if ( $rating == 3 ) echo 'checked="checked"';?> />
                        &nbsp;
                        <input type="radio" name="rating" value="4" style="margin: 0;" <?php if ( $rating == 4 ) echo 'checked="checked"';?> />
                        &nbsp;
                        <input type="radio" name="rating" value="5" style="margin: 0;" <?php if ( $rating == 5 ) echo 'checked="checked"';?> />
                        &nbsp; <span><?php echo $entry_good; ?></span>

                    </div>
                </div>

                <?php if($need_youtube) { ?>

                <div class="form-group">
                    <label class="col-sm-12 col-md-3 control-label" for="input-name"><?php echo $entry_yt ?></label>
                    <div class="col-sm-12 col-md-9">
                        <input type="text" name="youtube" value="<?php echo $yt_link; ?>" placeholder="<?php echo $entry_yt_desc ?>" id="input-name" class="form-control">
                    </div>
                </div>
                <?php } ?>

                <div class="form-group">
                    <label class="col-sm-12 col-md-3 control-label" for="input-captcha"></label>
                    <div class="col-sm-12 col-md-9">
                        <?php echo $captcha; ?>
                    </div>
                </div>

                <div class="buttons">
                    <div class="pull-right">
                        <a onclick="$('#testimonial').submit();" class="btn btn-primary"><?php echo $text_write; ?></a>
                    </div>
                </div>
            </form>
            <?php echo $content_bottom; ?>
        </div>
        <?php echo $column_right; ?>
    </div>
</div>
<?php echo $footer; ?>