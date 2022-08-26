<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-attribute" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
                        <label class="col-sm-2 control-label" ><?php echo  $entry_date; ?></label>
                        <div class="col-sm-2">
                            <input name="item[date]" class="form-control" value="<?php echo isset($item['date'])? $item['date']: ''; ?>" disabled/>
                        </div>
                        <label class="col-sm-1 control-label" ><?php echo  $entry_name; ?></label>
                        <div class="col-sm-7">
                            <input name="item[name]" class="form-control" value="<?php echo isset($item['name'])? $item['name']: ''; ?>" disabled/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" ><?php echo  $entry_phone; ?></label>
                        <div class="col-sm-2">
                            <input name="item[phone]" class="form-control" value="<?php echo isset($item['phone'])? $item['phone']: ''; ?>" disabled/>
                        </div>
                        <label class="col-sm-1 control-label" ><?php echo  $entry_email; ?></label>
                        <div class="col-sm-4">
                            <input name="item[email]" class="form-control" value="<?php echo isset($item['email'])? $item['email']: ''; ?>" disabled/>
                        </div>
                        <label class="col-sm-1 control-label" ><?php echo  $entry_time; ?></label>
                        <div class="col-sm-2">
                            <label class="col-sm-2 control-label" ><?php echo  $entry_time_from; ?></label>
                            <div class="col-sm-4">
                                <input name="item[time_from]" class="form-control" value="<?php echo isset($item['time_from'])? $item['time_from']: ''; ?>" disabled/>
                            </div>
                            <label class="col-sm-2 control-label" ><?php echo  $entry_time_to; ?></label>
                            <div class="col-sm-4">
                                <input name="item[time_to]" class="form-control" value="<?php echo isset($item['time_to'])? $item['time_to']: ''; ?>" disabled/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-2 control-label" ><?php echo  $entry_message; ?></label>
                        <div class="col-sm-10">
                            <textarea name="item[message]" class="form-control" rows='3' disabled><?php echo isset($item['message'])? $item['message']: ''; ?></textarea>
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-2 control-label" ><?php echo  $entry_status; ?></label>
                        <div class="col-sm-2">
                            <select name="item[status]" id="input-status" class="form-control">
                                <?php if (!$item['status'] && !is_null($item['status'])) { ?>
                                <option value="0" selected="selected"><?php echo $text_status_new; ?></option>
                                <?php } else { ?>
                                <option value="0"><?php echo $text_status_new; ?></option>
                                <?php } ?>
                                <?php if ($item['status']) { ?>
                                <option value="1" selected="selected"><?php echo $text_status_done; ?></option>
                                <?php } else { ?>
                                <option value="1"><?php echo $text_status_done; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                        <label class="col-sm-2 control-label" ><?php echo  $entry_manager; ?></label>
                        <div class="col-sm-6">
                            <input name="item[manager]" class="form-control" value="<?php echo isset($item['manager'])? $item['manager']: ''; ?>"/>
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-2 control-label" ><?php echo  $entry_comment; ?></label>
                        <div class="col-sm-10">
                            <textarea name="item[comment]" class="form-control" rows='3'><?php echo isset($item['comment'])? $item['comment']: ''; ?></textarea>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    <?php echo $footer; ?>
