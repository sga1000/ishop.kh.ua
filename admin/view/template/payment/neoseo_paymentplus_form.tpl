<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_paymentplus_', $params);
?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-category" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary" onclick="$('#form-paymentplus').submit();"><i class="fa fa-save"></i></button>
                <a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <img width="36" height="36" style="float:left;margin-right: 10px;" src="view/image/neoseo.png" alt=""> 
            <h1><?php echo $heading_title_raw; ?></h1>
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
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form-paymentplus" class="form-horizontal">

                    <ul class="nav nav-tabs" id="language">
                        <?php foreach ($languages as $language) { ?>
                        <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                        <?php } ?>
                    </ul>
                    <div class="tab-content">
                        <?php foreach ($languages as $language) { ?>
                        <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_name; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="payment_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($payment_description[$language['language_id']]) ? $payment_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                                    <?php if (isset($error_name[$language['language_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                                <div class="col-sm-10">
                                    <textarea name="payment_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($payment_description[$language['language_id']]) ? $payment_description[$language['language_id']]['description'] : ''; ?></textarea>
                                </div>
                            </div>
                        </div>
                        <?php } ?>
                    </div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-stores"><?php echo $entry_stores; ?>:</label>
						<div class="col-sm-10">
							<div class="well well-sm" style="height: 150px; overflow: auto;">
								<?php foreach ($stores as $store_id => $store) { ?>
									<div class="checkbox">
										<label>
											<input type="checkbox" name="payment_stores[<?php echo $store_id ?>]" <?php echo isset($payment_stores[$store_id]) ? 'checked=""' : '' ?> />
											<?php echo $store['name'] ?>
										</label>
									</div>
								<?php } ?>
							</div>
						</div>
					</div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-price-min"><span data-toggle="tooltip" title="<?php echo $help_min; ?>"><?php echo $entry_price_min; ?></span></label>
                        <div class="col-sm-10">
                            <input type="text" name="price_min" value="<?php echo $price_min; ?>" placeholder="<?php echo $entry_price_min; ?>" id="input-price-min" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-price-max"><span data-toggle="tooltip" title="<?php echo $help_max; ?>"><?php echo $entry_price_max; ?></span></label>
                        <div class="col-sm-10">
                            <input type="text" name="price_max" value="<?php echo $price_max; ?>" placeholder="<?php echo $entry_price_max; ?>" id="input-price-max" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
                        <div class="col-sm-10">
                            <select name="order_status_id" id="input-order-status" class="form-control">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                <?php if ($order_status['order_status_id'] == $order_status_id) { ?>
                                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                <?php } else { ?>
                                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone; ?></label>
                        <div class="col-sm-10">
                            <select name="geo_zone_id" id="input-geo-zone" class="form-control">
                                <option value="0"><?php echo $text_all_zones; ?></option>
                                <?php foreach ($geo_zones as $geo_zone) { ?>
                                <?php if ($geo_zone['geo_zone_id'] == $geo_zone_id) { ?>
                                <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                                <?php } else { ?>
                                <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                                <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-cities"><span data-toggle="tooltip" title="<?php echo $help_cities; ?>"><?php echo $entry_cities; ?></span></label>
                        <div class="col-sm-10">
                            <textarea name="cities" placeholder="<?php $entry_cities; ?>" id="input-cities" class="form-control" ><?php echo $cities; ?></textarea>
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

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script type="text/javascript"><!--
        <?php foreach ($languages as $language) { ?>
        <?php if ($ckeditor) { ?>
                ckeditorInit('input-description<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
            <?php } else { ?>
                $('#input-description<?php echo $language['language_id']; ?>').summernote({
                    height: 300,
                    lang:'<?php echo $lang; ?>'
                });
            <?php } ?>
        <?php } ?>
        //--></script>

    <script type="text/javascript"><!--
        $('#language a:first').tab('show');
        //--></script></div>
<?php echo $footer; ?>