<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
	    <a href="<?php echo $refresh; ?>" data-toggle="tooltip" title="<?php echo $button_refresh; ?>" class="btn btn-default"><i class="fa fa-refresh"></i></a>
		  <a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-country').submit() : false;"><i class="fa fa-trash-o"></i></button>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete_all; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm_all; ?>') ? location.replace('<?php echo $delete_all; ?>') : false;"><i class="fa fa-trash-o"></i></button>
      </div>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <div class="well">
          <div class="row">
            <div class="col-sm-3">
              <div class="form-group">
                <label class="control-label" for="input-zone"><?php echo $column_zone; ?></label>
                <input type="text" name="filter[zone]" value="<?php echo isset($filter['zone'])?$filter['zone']:''; ?>" placeholder="<?php echo $entry_zone; ?>" id="input-zone" class="form-control" />
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label class="control-label" for="input-city"><?php echo $column_city; ?></label>
                <input type="text" name="filter[city]" value="<?php echo isset($filter['city'])?$filter['city']:''; ?>" placeholder="<?php echo $entry_city; ?>" id="input-city" class="form-control" />
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label class="control-label" for="input-name"><?php echo $column_name; ?></label>
                <input type="text" name="filter[name]" value="<?php echo isset($filter['name'])?$filter['name']:''; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              </div>
            </div>
            <div class="col-sm-3">
              <div class="form-group">
                <label class="control-label" for="input-shipping_method"><?php echo $column_shipping_method; ?></label>
                <select name="filter[shipping_method]" id="input-shipping_method" class="form-control">
                  <option value=""></option><?php
                  foreach($shipping_methods as $method){ ?>
                    <option value="<?php echo $method['code']; ?>"<?php echo (isset($filter['shipping_method']) && $filter['shipping_method'] == $method['code']) ? ' selected="selected"' : '';?>><?php echo $method['name'];?></option>
                  <?php } ?>
                </select>
              </div>
              <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
            </div>
          </div>
        </div>
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-country">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
              <tr>
                <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                <td class="text-left"><?php if ($sort == 'name') { ?>
                  <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                  <?php } ?></td>
                <td class="text-left"><?php if ($sort == 'zone') { ?>
                  <a href="<?php echo $sort_zone; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_zone; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_zone; ?>"><?php echo $column_zone; ?></a>
                  <?php } ?></td>
                <td class="text-left"><?php if ($sort == 'city') { ?>
                  <a href="<?php echo $sort_city; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_city; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_city; ?>"><?php echo $column_city; ?></a>
                  <?php } ?></td>
                <td class="text-left"><?php if ($sort == 'shipping_method') { ?>
                  <a href="<?php echo $sort_shipping_method; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_shipping_method; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_shipping_method; ?>"><?php echo $column_shipping_method; ?></a>
                  <?php } ?></td>
                <td class="text-right"><?php echo $column_action; ?></td>
              </tr>
              </thead>
              <tbody>
              <?php if ($addresses) { ?>
              <?php foreach ($addresses as $address) { ?>
              <tr>
                <td class="text-center"><?php if (in_array($address['address_id'], $selected)) { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $address['address_id']; ?>" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $address['address_id']; ?>" />
                  <?php } ?></td>
                <td class="text-left"><?php echo $address['name']; ?></td>
                <td class="text-left"><?php echo $address['zone']; ?></td>
                <td class="text-left"><?php echo $address['city']; ?></td>
                <td class="text-left"><?php

                foreach($shipping_methods as $metod){
                  if($metod['code']==$address['shipping_method']) {
                    echo $metod['name'];
                    break;
                  }
                }

                ?></td>
                <td class="text-right"><a href="<?php echo $address['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
              </tr>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  $(document).ready(function (e) {
	  $('#button-filter').on('click', function() {
		  var url = 'index.php?route=localisation/neoseo_address&token=<?php echo $token; ?>';

		  $('.panel-body #input-name,#input-zone,#input-city,#input-shipping_method').each(function(e) {
              if($(this).val())
              	url += '&'+$(this).attr('name')+'='+encodeURIComponent($(this).val());
          });

		  location = url;
	  });
  });
</script>
<?php echo $footer; ?>