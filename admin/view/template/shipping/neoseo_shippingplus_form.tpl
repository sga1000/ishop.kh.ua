<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_shippingplus_', $params);
?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <?php if( !isset($license_error) ) { ?>
        <button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
        <button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
        <?php } else { ?>
        <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>" class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
        <?php } ?>
        <a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
      </div>
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
        <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">

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
                  <input type="text" name="shipping_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($shipping_description[$language['language_id']]) ? $shipping_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                  <?php if (isset($error_name[$language['language_id']])) { ?>
                  <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                <div class="col-sm-10">
                  <textarea name="shipping_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($shipping_description[$language['language_id']]) ? $shipping_description[$language['language_id']]['description'] : ''; ?></textarea>
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
									<input type="checkbox" name="shipping_stores[<?php echo $store_id ?>]" <?php echo isset($shipping_stores[$store_id]) ? 'checked=""' : '' ?> />
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
            <label class="col-sm-2 control-label" for="input-fix-payment"><span data-toggle="tooltip" title="<?php echo $help_fix_payment; ?>"><?php echo $entry_fix_payment; ?></span></label>
            <div class="col-sm-10">
              <input type="text" name="fix_payment" value="<?php echo $fix_payment; ?>" placeholder="<?php echo $entry_fix_payment; ?>" id="input-fix-payment" class="form-control" />
            </div>
          </div>

          <div class="form-group">
            <div class="col-sm-5">
              <label class="control-label" for="input-order-status"><?php echo $entry_geo_zone; ?></label>
              <br>
              <p><?php echo $entry_geo_zone_desc; ?></p>
            </div>
            <div class="col-sm-7">
              <div class="well well-sm" style="min-height: 100px;max-height: 300px;overflow: auto;">
                <?php $class = 'odd';  $count = 0;?>
                <?php foreach( $geo_zones as $geo_zone) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <label>
                    <?php if (in_array($geo_zone['geo_zone_id'], $geo_zone_id)) { ?>
                    <input type="checkbox" name="geo_zone_id[<?php echo $geo_zone['geo_zone_id']; ?>]" value="<?php echo $geo_zone['geo_zone_id']; ?>" checked="checked" />
                    <?php echo $geo_zone['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="geo_zone_id[<?php echo $geo_zone['geo_zone_id']; ?>]" value="<?php echo $geo_zone['geo_zone_id']; ?>" />
                    <?php echo $geo_zone['name']; ?>
                    <?php } ?>
                  </label>
                </div>
                <?php $count ++; } ?>

              </div>
              <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
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


          <table id="shipping_weight_price_id" class="table table-bordered table-hover">
            <thead>
            <tr>
              <td class="left"><?php echo $entry_weight_price_zone; ?></td>
              <td class="left"><?php echo $entry_weight_price_types; ?></td>
              <td></td>
            </tr>
            </thead>
            <tbody>
            <?php $price_row = 0;?>
            <?php if($shipping_weight_price){ ?>
            <?php foreach ($shipping_weight_price as $obj) { ?>

            <tr id="shipping_weight_price_row<?php echo $price_row; ?>">

              <td class="left">
                <select class="form-control" name="shipping_weight_price[<?php echo $price_row; ?>][geo_zone_id]">
                  <option value="0"><?php echo $text_all_zones; ?></option>
                  <?php foreach ($geo_zones as $geo_zone) { ?>
                  <?php if ($geo_zone['geo_zone_id'] == $obj['geo_zone_id']) { ?>
                  <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </td>
              <td class="left"><input class="form-control" type="text" name="shipping_weight_price[<?php echo $price_row; ?>][weight_price_params]" value="<?php  echo $obj['weight_price_params']; ?>" /></td>
              <td class="center"><a onclick="$('#shipping_weight_price_row<?php echo $price_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
            </tr>

            <?php $price_row++; ?>
            <?php } ?>
            <?php } ?>
            </tbody>
            <tfoot>
            <tr>
              <td colspan="2"></td>
              <td class="left"><a onclick="addConfigPriceType();" class="btn btn-primary"><?php echo $button_insert; ?></a></td>
            </tr>
            </tfoot>
          </table>


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




    var price_row = <?php echo $price_row; ?>;
    function addConfigPriceType() {
      html  = '';
      html += '  <tr id="shipping_weight_price_row' + price_row + '">';

      html += '    <td class="left"><select class="form-control" name="shipping_weight_price[' + price_row + '][geo_zone_id]">';
    <?php foreach ($geo_zones as $geo_zone) { ?>
        html += '      <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>';
      <?php } ?>
      html += '    </select></td>';
      html += '    <td class="left"><input type="text" class="form-control" name="shipping_weight_price[' + price_row + '][weight_price_params]" value="" /></td>';
      html += '    <td class="center"><a onclick="$(\'#shipping_weight_price_row' + price_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
      html += '  </tr>';

      $('#shipping_weight_price_id tbody').append(html);

      price_row++;
    }
  $('#language a:first').tab('show');
//--></script>
<?php echo $footer; ?>