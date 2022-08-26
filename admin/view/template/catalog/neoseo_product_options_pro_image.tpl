 <?php if($product_options_status) { ?>
            <style>
              #option-image-table tbody {
                display: none;
              }
            </style>
            <div class="tab-pane" id="tab-image-option">
              <div class="tab-content">
					  <h3 class="text-center"><?php echo $text_selected_displayed; ?></h3>
			  </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-option-priority"><?php echo $text_option_priority; ?></label>
                <div class="col-sm-10">
                    <select name="product_option_priority" class="form-control" id="input-option-priority">
                    <?php /*Пока скрываем вывод расширенной опции на вкладке "Изображения опций"*/?>
                    <?php if(false && $product_options_images) { ?>
                    <?php if (count($product_options_images['options']) > 0) { ?>
                    <option value="<?php echo '0_'.$product_options_images['product_option_pro_id']; ?>" <?php echo ($option_images['option_priority'] == '0_'.$product_options_images['product_option_pro_id']) ? 'selected="selected"' : ''; ?>><?php echo $product_options_images['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                    <?php foreach ($product_options as $product_option) { ?>
                    <?php if ($product_option['type'] == 'related' ||
                              $product_option['type'] == 'select' ||
                              $product_option['type'] == 'radio' ||
                              $product_option['type'] == 'checkbox' ||
                              $product_option['type'] == 'image' &&
                              count($product_option['product_option_value']) > 0) { ?>
                      <option value="<?php echo $product_option['option_id']; ?>" <?php echo ($option_images['option_priority'] == $product_option['option_id']) ? 'selected="selected"' : ''; ?>><?php echo $product_option['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="table-responsive">
                <table class="table table-bordered table-hover" id="option-image-table">
                  <thead>
					  <tr>
						  <td style="width: 15%" class="text-left"><?php echo $text_option_value; ?></td>
						  <td class="text-left"><?php echo $text_image; ?></td>
					  </tr>
                  </thead>
                  <?php $image_option_row = 0; ?>
                  <?php if($product_options_images && count($product_options_images['options']) > 0) { ?>
                    <tbody class="options_pro option_image_0_<?php echo $product_options_images['product_option_pro_id']; ?>">
                      <?php foreach ($product_options_images['options'] as $row_id => $product_options_image) { ?>
                        <tr>
                          <td><?php echo $product_options_image['name']; ?></td>
                          <td name="product_option_value<?php echo $row_id; ?>">
                            <button type="button" onclick="addOptionImage('options_pro', <?php echo $row_id; ?>);" data-toggle="tooltip" title="<?php echo $button_image_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
                            <?php if(isset($product_option_value['images'])) { ?>
                            <?php foreach ($product_option_value['images'] as $image) { ?>
                              <span id="option-image-span<?php echo $image_option_row; ?>">
                                <a href="" id="thumb-image-option<?php echo $image_option_row; ?>" data-toggle="image" class="img-thumbnail">
                                    <img src="<?php echo $image['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
                                </a>
                                <input type="hidden" name="product_option_pro_image['options_pro'][<?php echo $product_options_images['product_option_pro_id']; ?>][<?php echo $row_id; ?>][image]" value="<?php echo $image['image']; ?>" id="input-image-option<?php echo $image_option_row; ?>" />
                                <button type="button" onclick="$('#option-image-span<?php echo $image_option_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>
                                <?php $image_option_row++; ?>
                              </span>
                            <?php } ?>
                            <?php } ?>
                          </td>
                        </tr>
                      <?php } ?>
                    </tbody>
                  <?php } ?>
                    <?php foreach ($product_options as $product_option) { ?>
                      <tbody class="default_options option_image_<?php echo $product_option['option_id']; ?>">
                        <?php if ($product_option['type'] == 'related' || $product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') { ?>
						  <?php if (count($product_option['product_option_value']) > 0) { ?>
							<?php foreach ($product_option['product_option_value'] as $product_option_value) { ?>
							  <tr>
                                <td><?php echo $options[$product_option['option_id']]['option_values'][$product_option_value['option_value_id']]['name']; ?></td>
                                <td name="product_option_value<?php echo $product_option_value['product_option_value_id']; ?>">
                                    <button type="button" onclick="addOptionImage('default_options', <?php echo $product_option_value['product_option_value_id']; ?>);" data-toggle="tooltip" title="<?php echo $button_image_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
                                    <?php if(isset($option_images['images'][$product_option_value['product_option_value_id']])) { ?>
                                    <?php foreach ($option_images['images'][$product_option_value['product_option_value_id']] as $image) { ?>
                                    <span id="option-image-span<?php echo $image_option_row; ?>">
                                      <a href="" id="thumb-image-option<?php echo $image_option_row; ?>" data-toggle="image" class="img-thumbnail">
                                          <img src="<?php echo $image['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
                                      </a>
                                      <input type="hidden" name="product_option_pro_image[default_options][<?php echo $product_option_value['product_option_value_id']; ?>][<?php echo $image_option_row; ?>][image]" value="<?php echo $image['image']; ?>" id="input-image-option<?php echo $image_option_row; ?>" />
                                      <button type="button" onclick="$('#option-image-span<?php echo $image_option_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>
                                      <?php $image_option_row++; ?>
                                    </span>
                                    <?php } ?>
                                    <?php } ?>
                                </td>
							  </tr>
							<?php } ?>
		                  <?php } ?>
                        <?php } ?>
                      </tbody>
                    <?php } ?>
                </table>
              </div>
            </div>
            <script>
              function changeOptionPriority() {
                  var current_checked_row = $('[name="product_option_priority"]').val();
                  $('#option-image-table tbody').hide();
                  $('.option_image_' + current_checked_row).show();
              }
              $('[name="product_option_priority"]').on('change', changeOptionPriority);
             
                  function checkRelatedOption() {
                    if($('#check_related_box:checked').length == 0) {
                      $('#tab-related-options').addClass('hidden');
		      $("#tab-related-options").next().next().removeClass('hidden');
                    } else {
                      $('#tab-related-options').removeClass('hidden');
		      $("#tab-related-options").next().next().addClass('hidden');
                    }
                  }
		   changeOptionPriority();
                  checkRelatedOption();
                </script>
            </script>
            <?php } ?>

	    	    
	    <?php if($product_options_status) { ?>
<script type="text/javascript"><!--
$('[name="related-option"]').on('change', getRelated);
var optionArray = [];
function getRelated() {
    var html = '';
    var i,j,index,current_option;
    var product_option_pro_id = $("[name='related-option']").val();

    <?php foreach($options as $key => $option) { ?>
        <?php $sort_options[$key] = $option; ?>
        <?php if(isset($option['option_values']) && $option['option_values']) { ?>
            <?php $option_values = array();?>
            <?php foreach($option['option_values'] as $option_value) { ?>
                <?php $option_values[]=$option_value; ?>
            <?php } ?>
            <?php $sort_options[$key]['option_values'] =$option_values; ?>
        <?php } ?>
    <?php } ?>
        
    var options = <?php echo json_encode($sort_options); ?>;
    var options_pro = <?php echo json_encode($options_pro); ?>;

    if((options_pro[product_option_pro_id].options).length != 0) {
        optionArray = options_pro[product_option_pro_id].options;
        html += '<div class="form-group">';
        html += '<div class="col-sm-12">';
        html += '<div class="table-responsive">';
        html += '  <table id="option-related-value" class="table table-striped table-bordered table-hover">';
        html += '  	 <thead>';
        html += '      <tr>';
        for(i = 0; i < optionArray.length; i++) {
            index = optionArray[i];
            if(options[index]) {
                current_option = options[index];
                html += '        <td class="text-left">' + current_option.name + '</td>';
            }
        }
        html += '        <td class="text-right"><?php echo $entry_option_articul; ?></td>';
        html += '        <td class="text-right"><?php echo $entry_quantity; ?></td>';
        html += '        <td class="text-right"><?php echo $entry_price; ?></td>';
        html += '        <td></td>';
        html += '      </tr>';
        html += '  	 </thead>';
        html += '  	 <tbody>';
        html += '    </tbody>';
        html += '    <tfoot>';
        html += '      <tr>';
        html += '        <td colspan="' + (optionArray.length + 3) + '"></td>';
        html += '        <td class="text-left"><button type="button" onclick="addOptionRelatedValue(' + product_option_pro_id + ');" data-toggle="tooltip" title="<?php echo $button_option_value_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>';
        html += '      </tr>';
        html += '    </tfoot>';
        html += '  </table>';
        html += '</div>';
        for (i=0; i < optionArray.length; i++) {
            index = optionArray[i];
            current_option = options[index];
            html += '  <select name="used_options[' + current_option.option_id + ']" data-key="' + current_option.option_id + '" id="option-related-values-' + current_option.option_id + '" style="display: none;">';
            for (j = 0; j < Object.keys(current_option.option_values).length; j++) {
                html += '  <option value="' + current_option.option_values[Object.keys(current_option.option_values)[j]].option_value_id + '">' + current_option.option_values[Object.keys(current_option.option_values)[j]].name + '</option>';
            }
            html += '  </select>';
        }
        html += '</div>';
        html += '</div>';
    }

    $('#tab-related-options .tab-content-related').html(html);

    $('.date').datetimepicker({
        pickTime: false
    });
    $('.time').datetimepicker({
        pickDate: false
    });
    $('.datetime').datetimepicker({
        pickDate: true,
        pickTime: true
    });
}

var image_option_row = <?php echo $image_option_row; ?>;

function addOptionImage(option_class, product_option_value_id) {
	html  = '<span id="option-image-span' + image_option_row + '">';
	html += '  <a href="" id="thumb-image-option' + image_option_row + '" data-toggle="image" class="img-thumbnail">';
	html += '      <img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />';
	html += '  </a>';
	html += '  <input type="hidden" name="product_option_pro_image[' + option_class + '][' + product_option_value_id + '][' + image_option_row + '][image]" value="" id="input-image-option' + image_option_row + '" />';
	html += '  <button type="button" onclick="$(\'#option-image-span' + image_option_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>';
	html += '</span>';

	$('.' + option_class + ' [name=\'product_option_value'+product_option_value_id+'\']').append(html);

	image_option_row++;
}

//--></script>
<?php } ?>