<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/soforp_view.php' );
$widgets = new SoforpWidgets('',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>


<div id="content">

    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" name="action" value="save" onclick="beforeSave();" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <button href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></button>
            </div>
            <img width="36" height="36" style="float:left;margin-right: 10px;" src="view/image/neoseo.png" alt=""> 
            <h1><?php echo $heading_title . " " . $text_module_version; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if (isset($warning) && $warning) { ?>
        <div class="alert alert-danger">
            <i class="fa fa-exclamation-circle"></i> <?php echo $warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <?php if (isset($success) && $success) { ?>
        <div class="alert alert-success">
            <i class="fa fa-check-circle"></i>
            <?php echo $success; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="content">

            <div class="ui-helper-clearfix" style="height: 55px">
                <div class="pull-right">
                    <?= $widgets->storesDropdown($stores) ?>
                </div>
            </div>

            <?php echo $text_description; ?>
	   <button onclick="generate();" title="<?php echo $button_ganerate; ?>" class="btn btn-primary pull-right" style="margin-bottom: 10px"><i class="fa fa-spinner"></i> <?php echo $button_ganerate; ?></button>
            <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form" class="row">
                <?php $widgets->textareaWideMultiStore($stores, 'content', 6, 'width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll'); ?>
            </form>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('a.save').click(function () {
            if (!confirm("<?php echo $text_confirm_save; ?>")) {
                return false;
            }
        });
    });
    function generate() {
        var stores = [<?php echo implode(',', $js_stores); ?>];

        $.ajax({
            url: 'index.php?route=tool/neoseo_robots_generator/generate&token=<?php echo $token; ?>',
            type: 'post',
            dataType: 'json',
            data: '',
            success: function(json) {
            $('.alert').remove();
            if (json['error']) {
                $('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
            }

            if (json['content'] && json['success']) {
                $('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                stores.forEach(function(item){
                    console.log(item);
                    $('[id="content[' + item + ']"]').val(json['content']);
                });

            }
            },
            error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
</script>
<?php echo $footer; ?>