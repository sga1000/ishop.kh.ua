<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-attribute" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
            <h1><?php echo $heading_title_raw . " " . $text_module_version; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-attribute" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label" ><?php echo $entry_cl_name; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="item[name]" value="<?php echo $item['name']; ?>" id="input-date-available" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" ><?php echo $entry_cl_align; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="item[align]" value="<?php echo $item['align']; ?>" id="input-date-available" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" ><?php echo  $entry_cl_width; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="item[width]" value="<?php echo $item['width']; ?>" id="input-date-available" class="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-date-available"><?php echo $entry_cl_pattern; ?></label>
                        <div class="col-sm-10">
                            <textarea id="pattern" rows="3" style="width:100%" name="item[pattern]" class="form-control"><?php echo $item['pattern']; ?></textarea>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript"><!--
            <?php if ($ckeditor) { ?>
            ckeditorInit('pattern', '<?php echo $token; ?>');
            <?php } else { ?>
            $('#pattern').summernote({height: 300, lang:'ru-RU'});
            <?php } ?>
            //-->
</script>
<?php echo $footer; ?>
