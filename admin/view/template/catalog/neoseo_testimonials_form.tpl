<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-neoseo_testimonials" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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

                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-neoseo_testimonials" class="form-horizontal">
                    <div class="form-group required">
                        <label class="col-sm-2 control-label" for="input-text"><?php echo $entry_description; ?></label>
                        <div class="col-sm-10">
                            <textarea name="description" cols="60" rows="8" placeholder="<?php echo $entry_description; ?>" id="input-description" class="form-control"><?php echo $description; ?></textarea>
                            <?php if ($error_description) { ?>
                            <div class="description-danger"><?php echo $error_description; ?></div>
                            <?php } ?>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-admin_text"><?php echo $entry_admin_text; ?></label>
                        <div class="col-sm-10">
                            <textarea name="admin_text" cols="60" rows="8" placeholder="<?php echo $entry_admin_text; ?>" id="input-admin_text" class="form-control"><?php echo $admin_text; ?></textarea>
                        </div>
                    </div>
                    <div class="form-group ">
                        <label class="col-sm-2 control-label" for="input-author"><?php echo $entry_name; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-author" class="form-control" />
                            <?php if ($error_name) { ?>
                            <div class="text-danger"><?php echo $error_name; ?></div>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="form-group required">
                        <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_rating; ?></label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <?php if ($rating == 1) { ?>
                                <input type="radio" name="rating" value="1" checked="checked" />
                                1
                                <?php } else { ?>
                                <input type="radio" name="rating" value="1" />
                                1
                                <?php } ?>
                            </label>
                            <label class="radio-inline">
                                <?php if ($rating == 2) { ?>
                                <input type="radio" name="rating" value="2" checked="checked" />
                                2
                                <?php } else { ?>
                                <input type="radio" name="rating" value="2" />
                                2
                                <?php } ?>
                            </label>
                            <label class="radio-inline">
                                <?php if ($rating == 3) { ?>
                                <input type="radio" name="rating" value="3" checked="checked" />
                                3
                                <?php } else { ?>
                                <input type="radio" name="rating" value="3" />
                                3
                                <?php } ?>
                            </label>
                            <label class="radio-inline">
                                <?php if ($rating == 4) { ?>
                                <input type="radio" name="rating" value="4" checked="checked" />
                                4
                                <?php } else { ?>
                                <input type="radio" name="rating" value="4" />
                                4
                                <?php } ?>
                            </label>
                            <label class="radio-inline">
                                <?php if ($rating == 5) { ?>
                                <input type="radio" name="rating" value="5" checked="checked" />
                                5
                                <?php } else { ?>
                                <input type="radio" name="rating" value="5" />
                                5
                                <?php } ?>
                            </label>
                            <?php if ($error_rating) { ?>
                            <div class="text-danger"><?php echo $error_rating; ?></div>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class=" col-sm-2 control-label" for="input-date-added"><?php echo $entry_date_added; ?></label>
                        <div class="col-sm-10">
                            <div class="input-group date">
                                <input type="text" name="date_added" value="<?php echo $date_added; ?>" placeholder="<?php echo $entry_date_added; ?>" data-date-format="YYYY-MM-DD HH:mm:SS" id="input-date-added" class="form-control" />
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                </span></div>
                        </div> </div>

                    <div class="form-group">
                        <label class=" col-sm-2 control-label" for="input-date_admin_added"><?php echo $entry_date_admin_added; ?></label>
                        <div class="col-sm-10">
                            <div class="input-group date">
                                <input type="text" name="date_admin_added" value="<?php echo ($date_admin_added != "0000-00-00 00:00:00" ? $date_admin_added : ""); ?>" placeholder="<?php echo $entry_date_admin_added; ?>" data-date-format="YYYY-MM-DD HH:mm:SS" id="input-date-added" class="form-control" />
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                </span></div>
                        </div> </div>

                    <div class="form-group ">
                        <label class="col-sm-2 control-label" for="input-author"><?php echo $entry_youtube; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="youtube" value="<?php echo $youtube; ?>" placeholder="<?php echo $entry_youtube; ?>" id="input-author" class="form-control" />
                            <?php if ($youtube) { ?>
                            <br>
                            <a target="_blank" href="<?php echo $youtube; ?>"><?php echo $youtube; ?></a>
                            <?php } ?>
                        </div>

                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-store"><?php echo $entry_store;  ?></label>
                        <div class="col-sm-10">
                            <select placeholder="<?php echo $entry_store;?>" name='store_id' class='form-control'>
                                <?php foreach ($stores as $store_id => $store_data) { ?>
                                <?php if (isset($filter_store) && $filter_store == $store_id ) { ?>
                                <option value="<?php echo $store_id; ?>" selected="selected"><?php echo $store_data['name']; ?></option>
                                <?php } else { ?>
                                <option value="<?php echo $store_id; ?>"><?php echo $store_data['name']; ?></option>
                                <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-image"><?php echo $entry_user_image; ?></label>
                        <div class="col-sm-10">
                            <a href="" id="thumb-user_image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                            <input type="hidden" name="user_image" value="<?php echo $user_image; ?>" id="input-image" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                        <div class="col-sm-10">
                            <select name="status" id="input-status" class="form-control">
                                <?php if ($status) { ?>
                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                <option value="1"><?php echo $text_enabled; ?></option>
                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
<script type="text/javascript"><!--
    $('.date').datetimepicker({
        pickTime: false
    });
    //--></script>