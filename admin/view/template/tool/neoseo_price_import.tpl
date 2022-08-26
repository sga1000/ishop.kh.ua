<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">

    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <a href="<?php echo $setting_vendor; ?>" data-toggle="tooltip" title="<?php echo $button_setting_vendor; ?>" class="btn btn-primary"><i class="fa fa-cogs" aria-hidden="true"></i> <?php echo $button_setting_vendor; ?></a>
                <a href="<?php echo $settings; ?>" data-toggle="tooltip" title="<?php echo $button_settings; ?>" class="btn btn-default"><i class="fa fa-cog" aria-hidden="true"></i> <?php echo $button_settings ?></a>
            </div>
            <img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
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

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"> <?php echo $text_price_import; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="import" class="form-horizontal">
                    <div class="form-group" >
                        <label class="col-sm-2 control-label" ><?php echo $entry_vendor; ?></label>
                        <div class="col-sm-4">
                            <select name="vendor_id"  class="form-control">
                                <?php foreach ($vendors as $vendor) { ?>
                                <option value="<?php echo $vendor['id'];?>" > <?php echo $vendor['name']; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>

                    <div class="form-group" >
                        <label class="col-sm-2 control-label" ><?php echo $entry_file; ?></label>
                        <div class="col-sm-4">
                            <input type="file" name="upload" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $entry_coefficient; ?></label>
                        <div class="col-sm-4">
                            <input type="text" name="coefficient" value="1" id="input-list" class="form-control" />
                        </div>
                        <div class="col-sm-2">
                            <a onclick="$('#import').submit()" data-toggle="tooltip" title="<?php echo $button_process; ?>" class="btn btn-primary"><i class="fa fa-spinner" aria-hidden="true"></i> <?php echo $button_process; ?></a>
                        </div>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>
<?php echo $footer; ?>