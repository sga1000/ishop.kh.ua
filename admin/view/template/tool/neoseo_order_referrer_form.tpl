<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-attribute" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
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
                    <div class="form-group" >
                        <label class="col-sm-2 control-label" ><?php echo  $entry_name; ?></label>
                        <div class="col-sm-10">
                            <input name="item[name]" class="form-control" value="<?php echo isset($item['name'])? $item['name']: ''; ?>"/>
                        </div>
                    </div>

                    <div class="form-group" >
                        <label class="col-sm-2 control-label" ><?php echo $entry_url_param; ?></label>
                        <div class="col-sm-10">
                            <input name="item[url_param]" class="form-control" value="<?php echo isset($item['url_param'])? $item['url_param']: ''; ?>"/>
                        </div>
                    </div>

                    <div class="form-group" >
                        <label class="col-sm-2 control-label" ><?php echo $entry_url_mask; ?></label>
                        <div class="col-sm-10">
                            <input name="item[url_mask]" class="form-control" value="<?php echo isset($item['url_mask'])? $item['url_mask']: ''; ?>"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    < ?php echo $footer; ? >