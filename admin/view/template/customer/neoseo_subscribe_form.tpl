<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-attribute" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default" /><i class="fa fa-close"></i> <?php echo $button_close; ?></a></div>
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
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $entry_date; ?></label>
                        <div class="col-sm-10">
                            <div class="input-group date">
                                <input type="text" name="item[date]" value="<?php echo $item['date']; ?>" data-date-format="YYYY-MM-DD" id="input-date-available" class="form-control" />
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                </span></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $entry_email; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="item[email]" value="<?php echo $item['email']; ?>"  id="input-email" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $entry_name; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="item[name]" value="<?php echo $item['name']; ?>"  id="input-name" class="form-control" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>$('.date').datetimepicker({
        pickTime: false
    });</script>
<?php echo $footer; ?>
