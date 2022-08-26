<?php echo $header; ?>
<div class="container">
    <?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
    <?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } else { ?>
    <?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
    <?php } ?>
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
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
            <div class="row">
                <div class="col-sm-6">
                    <div class="well box-shadow box-corner">
                        <h2><?php echo $text_new_customer; ?></h2>
                        <p><strong><?php echo $text_register; ?></strong></p>
                        <p><?php echo $text_register_account; ?></p>
                        <a href="<?php echo $register; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="well box-shadow box-corner">
                        <h2><?php echo $text_returning_customer; ?></h2>
                        <p><strong><?php echo $text_i_am_returning_customer; ?></strong></p>
                        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                            <?php if ($redirect) { ?>
                            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>"/>
                            <?php } ?>
                            <div class="row">
                                <div class="form-group col-md-12 col-lg-6">
                                    <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control"/>
                                </div>
                                <div class="form-group col-md-12 col-lg-6">
                                    <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-12 col-lg-6">
                                    <input type="submit" value="<?php echo $button_login; ?>" class="btn btn-primary"/>
                                </div>
                                <div class="form-group col-md-12 col-lg-6">
                                    <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <?php echo $content_bottom; ?>
        </div>
        <?php echo $column_right; ?>
    </div>
</div>
<?php echo $footer; ?>