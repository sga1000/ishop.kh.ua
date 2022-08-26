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
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <div class="personal-area-container">
                <h1><?php echo $heading_title; ?></h1>
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
                <fieldset>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $entry_newsletter; ?></label>
                        <div class="col-sm-10">
                            <?php if ($newsletter) { ?>
								<div class="radio radio-checkout">
									<label for="news-1">
                                        <input type="radio" id="news-1" name="newsletter" value="1" checked="checked"/>
                                        <span><?php echo $text_yes; ?></span>
                                    </label>
								</div>
								<div class="radio radio-checkout">
									<label for="news-2">
                                        <input id="news-2" type="radio" name="newsletter" value="0"/>
                                        <span><?php echo $text_no; ?></span>
                                    </label>
								</div>
                            <?php } else { ?>
								<div class="radio radio-checkout">
									<label for="news-1">
                                        <input id="news-1" type="radio" name="newsletter" value="1"/>
                                        <span><?php echo $text_yes; ?></span>
                                    </label>
								</div>
								<div class="radio radio-checkout">
									<label for="news-2">
                                        <input id="news-2" type="radio" name="newsletter" value="0" checked="checked"/>
                                        <span><?php echo $text_no; ?></span>
                                    </label>
								</div>
                            <?php } ?>
                        </div>
                    </div>
                </fieldset>
                <div class="buttons clearfix">
                    <div class="pull-right">
                        <input type="submit" value="<?php echo $button_update; ?>" class="btn btn-primary"/>
                    </div>
                </div>
            </form>
            </div>
            <?php echo $content_bottom; ?>
        </div>
        <?php echo $column_right; ?>
    </div>
</div>
<?php echo $footer; ?>