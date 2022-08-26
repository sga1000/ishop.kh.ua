<?php echo $header; ?>
<!-- NeoSeo Product Link - begin -->
<?php if (isset( $edit_link ) ) { ?>
<script>
    $(document).ready(function(){
        $("h1").after('<div class="edit"><a target="_blank" href="<?php echo $edit_link; ?>">Редактировать ( видит только админ )</a></div>');
    });
</script>
<?php } ?>
<!-- NeoSeo Product Link - end -->
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
            <div class="information-container box-shadow box-corner">
            <h1><?php echo $heading_title; ?></h1>
            <?php echo $description; ?>
            </div>
            <?php echo $content_bottom; ?>
        </div>
        <?php echo $column_right; ?>
    </div>
</div>
<?php echo $footer; ?>