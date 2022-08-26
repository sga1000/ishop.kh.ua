 <?php if($product_options_status) { ?>
              <style>
                #tab-related-options + .row {
                  display: none;
                }
                #tab-related-options.hidden + .row,
                .tab-content-related > .active {
                  display: block;
                }
              </style>
              <div class="form-group">
                <label class="col-sm-12">
                  <input class="pull-left" type="checkbox" name="use_related_options" value="1" id="check_related_box" <?php echo !empty($product_options_pro['option_rows']) ? 'checked="checked"' : '' ?> onclick="checkRelatedOption()">
                  <h4 class="col-sm-4 pull-left"><?php echo $text_use_options_pro; ?></h4>
                </label>
              </div>
              <div class="row" id="tab-related-options">
                <label class="col-sm-2 control-label" for="input-model"><?php echo $text_option; ?></label>
                <div class="col-sm-10">
                  <select name="related-option" class="form-control">
                    <?php foreach ($options_pro as $product_option_pro_id => $product_option_pro) { ?>
                    <?php if(isset($product_options_pro['product_option_pro_id']) && $product_options_pro['product_option_pro_id'] == $product_option_pro_id) { ?>
                    <option value="<?php echo $product_option_pro_id; ?>" selected="selected"><?php echo $product_option_pro['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $product_option_pro_id; ?>"><?php echo $product_option_pro['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
                <div class="col-sm-12">
                  <div class="tab-content-related">
                    <?php $option_related_value_row = 0; ?>
                    <?php if($product_options_pro['total_options']) { ?>
                    <div class="form-group">
                      <div class="col-sm-12">
                        <div class="table-responsive">
                          <table id="option-related-value" class="table table-striped table-bordered table-hover">
                            <thead>
                              <tr>
                                <?php foreach($product_options_pro['total_options'] as $option_id) { ?>
                                  <?php if(isset($options[$option_id])) { ?>
                                    <td class="text-left"><?php echo $options[$option_id]['name']; ?></td>
                                  <?php } ?>
                                <?php } ?>
				 <td class="text-right"><?php echo $entry_option_model; ?></td>
                                <td class="text-right"><?php echo $entry_option_articul; ?></td>
                                <td class="text-right"><?php echo $entry_quantity; ?></td>
                                <td class="text-right"><?php echo $entry_price; ?></td>
                                <?php if($base_price_status){ ?>
                                <td class="text-right"><?php echo $entry_base_price; ?></td>
                                <?php } ?>
                                <td></td>
                              </tr>
                            </thead>
                            <tbody>
                              <?php foreach($product_options_pro['option_rows'] as $option_row) { ?>
                                <tr id="option-value-row<?php echo $option_related_value_row; ?>">
                                  <?php foreach($product_options_pro['total_options'] as $option_id) { ?>
                                  <td class="text-left" style="min-width: 120px;">
                                  <?php if(isset($options[$option_id]['option_values']) && !empty($options[$option_id]['option_values'])) { ?>
                                    <select name="product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][option_related_value_id][<?php echo $option_id; ?>]" class="form-control">
                                      <?php foreach($options[$option_id]['option_values'] as $option_value) { ?>
                                        <?php if($option_value['option_value_id'] == $option_row['options'][$option_id]) { ?>
                                        <option value="<?php echo $option_value['option_value_id']; ?>" selected="selected"><?php echo $option_value['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
                                        <?php } ?>
                                      <?php } ?>
                                    </select><input type="hidden" name="product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][product_option_value_id] value="" />
                                  <?php } ?>
                                  </td>
                                  <?php } ?>
				  <td class="text-right" style="min-width: 120px;"><input type="text" name="product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][model]" value="<?php echo $option_row['model']; ?>" placeholder="<?php echo $entry_option_model; ?>" class="form-control" /></td>
                                  <td class="text-right" style="min-width: 120px;"><input type="text" name="product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][articul]" value="<?php echo $option_row['articul']; ?>" placeholder="<?php echo $entry_option_articul; ?>" class="form-control" /></td>
                                  <td class="text-right" style="min-width: 120px;"><input type="text" name="product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][quantity]" value="<?php echo $option_row['quantity']; ?>" placeholder="<?php echo $entry_quantity; ?>" class="form-control" /></td>
                                  <td class="text-center" style="min-width: 120px;">
                                    <?php foreach($customer_groups as $customer_group) { ?>
                                      <?php echo $customer_group["name"]; ?>
                                      <input type="text" name="product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][price][<?php echo $customer_group['customer_group_id'] ?>]" value="<?php echo isset($option_row['price'][$customer_group['customer_group_id']]) ? $option_row['price'][$customer_group['customer_group_id']] : ''; ?>" placeholder="<?php echo $entry_price; ?>" class="form-control" />
                                    <?php } ?>
                                    </td>
                                  
                                  <?php if($base_price_status){ ?>
                                  <td class="text-center" style="min-width: 120px;">
                                    <?php foreach($customer_groups as $customer_group) { ?>
                                      <?php echo $customer_group["name"]; ?>
                                      <input type="text" name="product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][base_price][<?php echo $customer_group['customer_group_id'] ?>]" value="<?php echo isset($option_row['base_price'][$customer_group['customer_group_id']]) ? $option_row['base_price'][$customer_group['customer_group_id']] : ''; ?>" placeholder="<?php echo $entry_base_price; ?>" class="form-control" />
                                    <?php } ?>
                                  </td>
                                  <script>
                                   <?php foreach($customer_groups as $customer_group) { ?>
                                   $('input[name=\'product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][base_price][<?php echo $customer_group['customer_group_id'] ?>]\']').on('keyup', function(e) {
                                     var manufacturer_id = $('select[name=\'manufacturer_id\']').val() ? $('select[name=\'manufacturer_id\']').val() : '0',
                                         base_price = $('input[name=\'product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][base_price][<?php echo $customer_group['customer_group_id'] ?>]\']').val() ? $('input[name=\'product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][base_price][<?php echo $customer_group['customer_group_id'] ?>]\']').val() : '0';
                                         
                                     $.ajax({
                                       url: 'index.php?route=catalog/neoseo_product_options_pro/getCurrencys&token=<?php echo $token; ?>&manufacturer_id=' +  encodeURIComponent(manufacturer_id) + '&base_price=' + encodeURIComponent(base_price),
                                       dataType: 'json',
                                       success: function(json) {
                                         if (json['price'] >= 1) {
                                           $('input[name=\'product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][price][<?php echo $customer_group['customer_group_id'] ?>]\']').val(json['price']);
                                         }else{
                                           $('input[name=\'product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][price][<?php echo $customer_group['customer_group_id'] ?>]\']').val(0);
                                         }
                                       }
                                     });
                                   });
                                   <?php } ?>
                                 </script>
                                 <?php } ?>
                                  
                                  <td class="text-left" style="min-width: 120px;"><button type="button" onclick="$(this).tooltip('destroy'); $('#option-value-row<?php echo $option_related_value_row; ?>').remove();" data-toggle="tooltip" rel="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                </tr>
                                <?php $option_related_value_row++; ?>
                              <?php } ?>
                            </tbody>
                            <tfoot>
                              <tr>
                                <td colspan="<?php echo (count($product_options_pro['total_options']) + 4); ?>"></td>
                                <td class="text-left"><button type="button" onclick="addOptionRelatedValue(<?php echo $product_options_pro['product_option_pro_id']; ?>);" data-toggle="tooltip" title="<?php echo $button_option_value_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                              </tr>
                            </tfoot>
                          </table>
                        </div>
                        <?php foreach($product_options_pro['total_options'] as $option_id) { ?>
                          <?php if(isset($options[$option_id]['option_values']) && !empty($options[$option_id]['option_values'])) { ?>
                            <select name="used_options[<?php echo $option_id; ?>]" data-key="<?php echo $option_id; ?>" id="option-related-values-<?php echo $option_id; ?>" style="display: none;">
                              <?php foreach($options[$option_id]['option_values'] as $option_value) { ?>
                              <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
                              <?php } ?>
                            </select>
                          <?php } ?>
                        <?php } ?>
                      </div>
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>
            <?php } ?>
	    
	    <script type="text/javascript"><!--
	    	   var option_related_value_row = <?php echo $option_related_value_row; ?>;

function addOptionRelatedValue(option_id) {
	var i, options, a;

	options  = JSON.parse(option_id);
	var html = '<tr id="option-value-row' + option_related_value_row + '">';
    $('[id^=\'option-related-values\']').each(function() {
		i = $(this).data('key');

		html += '  <td class="text-left" style="min-width: 120px;"><select name="product_option_related[' + option_id + '][product_option_value][' + option_related_value_row + '][option_related_value_id][' + i + ']" class="form-control">';
		html += $('#option-related-values-' + i).html();
	});
	html += '  </select><input type="hidden" name="product_option_related[' + option_id + '][product_option_value][' + option_related_value_row + '][product_option_value_id] value="" /></td>';
	html += '  <td class="text-right" style="min-width: 120px;"><input type="text" name="product_option_related[' + option_id + '][product_option_value][' + option_related_value_row + '][model]" value="" placeholder="<?php echo $entry_option_model; ?>" class="form-control" /></td>';
	html += '  <td class="text-right" style="min-width: 120px;"><input type="text" name="product_option_related[' + option_id + '][product_option_value][' + option_related_value_row + '][articul]" value="" placeholder="<?php echo $entry_option_articul; ?>" class="form-control" /></td>';
	html += '  <td class="text-right" style="min-width: 120px;"><input type="text" name="product_option_related[' + option_id + '][product_option_value][' + option_related_value_row + '][quantity]" value="" placeholder="<?php echo $entry_quantity; ?>" class="form-control" /></td>';
	html += '<td class="text-center" style="min-width: 120px;">';
    <?php foreach($customer_groups as $customer_group) { ?>
    html += '<?php echo $customer_group["name"]; ?>';
	html += '  <input type="text" name="product_option_related[' + option_id + '][product_option_value][' + option_related_value_row + '][price][<?php echo $customer_group["customer_group_id"] ?>]" value="" placeholder="<?php echo $entry_price; ?>" class="form-control" />';
    <?php } ?>
    html += '  </td>';
    
 <?php if($base_price_status){ ?>
 html += '<td class="text-center" style="min-width: 120px;">';
 <?php foreach($customer_groups as $customer_group) { ?>
    html += '<?php echo $customer_group["name"]; ?>';
	html += '  <input type="text" name="product_option_related[' + option_id + '][product_option_value][' + option_related_value_row + '][base_price][<?php echo $customer_group["customer_group_id"] ?>]" value="" placeholder="<?php echo $entry_base_price; ?>" class="form-control" />';
    <?php } ?>
    html += '  </td>';
 <?php } ?>
 
	html += '  <td class="text-left" style="min-width: 120px;"><button type="button" onclick="$(this).tooltip(\'destroy\');$(\'#option-value-row' + option_related_value_row + '\').remove();" data-toggle="tooltip" rel="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';

	$('#option-related-value tbody').append(html);
        $('[rel=tooltip]').tooltip();
  
  <?php if($base_price_status){ ?>
   <?php foreach($customer_groups as $customer_group) { ?>
   $('input[name=\'product_option_related[' + option_id + '][product_option_value][' + option_related_value_row + '][base_price][<?php echo $customer_group["customer_group_id"] ?>]\']').on('keyup', function(e) {
     //console.log('input[name=\'product_option_related[' + option_id + '][product_option_value][' + option_related_value_row + '][base_price][<?php echo $customer_group["customer_group_id"] ?>]\']');
     var manufacturer_id = $('select[name=\'manufacturer_id\']').val() ? $('select[name=\'manufacturer_id\']').val() : '0',
         base_price = $('input[name=\'product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][base_price][<?php echo $customer_group['customer_group_id'] ?>]\']').val() ? $('input[name=\'product_option_related[<?php echo $product_options_pro['product_option_pro_id']; ?>][product_option_value][<?php echo $option_related_value_row; ?>][base_price][<?php echo $customer_group['customer_group_id'] ?>]\']').val() : '0';
         
     $.ajax({
       url: 'index.php?route=catalog/neoseo_product_options_pro/getCurrencys&token=<?php echo $token; ?>&manufacturer_id=' +  encodeURIComponent(manufacturer_id) + '&base_price=' + encodeURIComponent(base_price),
       dataType: 'json',
       success: function(json) {
         if (json['price'] >= 1) {
           $('input[name=\'product_option_related[' + option_id + '][product_option_value][' + (option_related_value_row-1) + '][price][<?php echo $customer_group["customer_group_id"] ?>]\']').val(json['price']);
         }else{
           $('input[name=\'product_option_related[' + option_id + '][product_option_value][' + (option_related_value_row-1) + '][price][<?php echo $customer_group["customer_group_id"] ?>]\']').val(0);
         }
       }
     });
   });
  <?php } ?>
 <?php } ?>

	option_related_value_row++;
}
//--></script>