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
    <div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
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
                <h2><?php echo $text_address_book; ?></h2>
                <?php if ($addresses) { ?>
                <table class="table table-bordered table-hover">
                    <?php foreach ($addresses as $result) { ?>
                    <tr>
                        <td class="text-left"><?php echo $result['address']; ?></td>
                        <td class="text-right">
                            <a href="<?php echo $result['update']; ?>" class="btn btn-info"><?php echo $button_edit; ?></a>
                            <a href="<?php echo $result['delete']; ?>" class="btn btn-danger"><?php echo $button_delete; ?></a>
                        </td>
                    </tr>
                    <?php } ?>
                </table>
                <?php } else { ?>
                <p><?php echo $text_empty; ?></p>
                <?php } ?>
                <div class="buttons adress-buttons-box clearfix">
                    <div class="back">
                        <a href="<?php echo $back; ?>" class="btn btn-default"><?php echo $button_back; ?></a>
                    </div>
                    <div class="new-adress">
                        <a href="<?php echo $add; ?>" class="btn btn-primary"><?php echo $button_new_address; ?></a>
                    </div>
                </div>
            </div>
            <?php echo $content_bottom; ?></div>
        <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>