<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">

  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-product" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-product" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
          </ul>
          <div class="tab-content">
              <div class="tab-pane active" id="tab-general">
                  <?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled));?>
                  <?php $widgets->input('bundle_name');?>
                  <?php $widgets->input('sort');?>

                <div class="form-group">
                    <div class="col-sm-5">
                        <label class="control-label" for="input-related"><span data-toggle="tooltip" title="<?php echo $help_related; ?>"><?php echo $related_text ?></span></label>
                    </div>
                    <div class="col-sm-7">
                        <input type="text" name="related" value="" placeholder="" id="input-related" class="form-control" />
                        <div id="product-related" class="well well-sm" style="height: 150px; overflow: auto;">
                            <?php foreach ($product_relateds as $product_related) { ?>
                                <div id="product-related<?php echo $product_related['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product_related['name']; ?> <i class="fa fa-pencil" onclick="$('#optionsmodalb<?php echo $product_related['product_id']; ?>').modal('show')" style="cursor: pointer;"><?php echo $text_select_options; ?></i>
                                    <input type="hidden" name="product_related[]" value="<?php echo $product_related['product_id']; ?>" />
                                    <!-- Modal top -->
                                    <div id="optionsmodalb<?php echo $product_related['product_id']; ?>" class="modal fade" role="dialog">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title" style="text-align: left;"><?php echo $text_select_options; ?></h4>
                                                </div>
                                                <div class="modal-body" style="padding: 0 50px 0 50px;text-align: left;" id="modalbodyb<?php echo $product_related['product_id']; ?>">
                                                    <p><?php echo $product_related['options_form']; ?></p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
                                                </div>
                                            </div>
                                     <!-- Modal top -->
                                        </div>
                                    </div>

                                </div>
                            <?php } ?>
                        </div>
                    </div>
                </div>
                  <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-related"><span data-toggle="tooltip" title="<?php echo $help_related; ?>"><?php echo $complected_products; ?></span></label>
                      <div class="col-sm-10">
                      <div class="table-responsive">
                    <table id="bundles" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>

                            <td class="text-right"><?php echo $product_text; ?></td>
                            <td class="text-right"><?php echo $row_text; ?></td>
                            <td class="text-right"><?php echo $entry_price; ?></td>
                            <td class="text-right"><?php echo $entry_sort; ?></td>

                            <td></td>
                        </tr>
                        </thead>
                        <tbody>
                        <?php $bundle_row = 0; ?>
                        <?php foreach ($product_bundles as $product_bundle) { ?>
                            <tr id="bundle-row<?php echo $bundle_row; ?>">
                                <td class="text-right"><input type="text" name="bundle_product-<?php echo $bundle_row; ?>" value="<?php echo $product_bundle['name']; ?>" placeholder="" id="input-related" class="form-control" />
                                    <!-- Modal -->
                                    <div id="optionsmodal<?php echo $bundle_row; ?>" class="modal fade" role="dialog">
                                        <div class="modal-dialog">
                                            <!-- Modal content-->
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title" style="text-align: left;"><?php echo $text_select_options; ?></h4>
                                                </div>
                                                <div class="modal-body" style="padding: 0 50px 0 50px;text-align: left;" id="modalbody<?php echo $bundle_row; ?>">
                                                    <p><?php echo $product_bundle['options_form']; ?></p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <i class="fa fa-pencil" onclick="$('#optionsmodal<?php echo $bundle_row; ?>').modal('show')" style="cursor: pointer;"><?php echo $text_select_options; ?></i>
                                </td>
                                <input type="hidden" id="bundle_product-<?php echo $bundle_row; ?>" name="product_bundles[<?php echo $bundle_row; ?>][product_id]" value="<?php echo $product_bundle['product_id']; ?>" placeholder="<?php echo $entry_related; ?>" id="input-related" class="form-control" />
                                <td class="text-right">
                                    <select name="product_bundles[<?php echo $bundle_row; ?>][row_id]" class="form-control">
                                        <?php foreach ($rownames as $value => $name) { ?>
                                        <?php if ($value == $product_bundle['row_id']) { ?>
                                        <option value="<?php echo $value; ?>" selected="selected"><?php echo $name; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $value; ?>"><?php echo $name; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </td>
                                <td class="text-right"><input type="text" name="product_bundles[<?php echo $bundle_row; ?>][special]" value="<?php echo $product_bundle['special']; ?>" placeholder="<?php echo $entry_price; ?>" class="form-control" /></td>
                                <td class="text-right"><input type="text" name="product_bundles[<?php echo $bundle_row; ?>][sort]" value="<?php echo $product_bundle['sort']; ?>" placeholder="<?php echo $entry_sort; ?>" class="form-control" /></td>
                                <td class="text-left"><button type="button" onclick="$('#bundle-row<?php echo $bundle_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                            </tr>
                        
                            <?php $bundle_row++; ?>
                        <?php } ?>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="5"></td>
                            <td class="text-left"><button type="button" onclick="addBundle();" data-toggle="tooltip" title="<?php echo $button_bundle_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                        </tr>
                        </tfoot>
                    </table>
                      </div>
                      </div>
                </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script type="text/javascript"><!--

      var bundle_row = <?php echo $bundle_row; ?>;

      function addBundle() {
          var bundle_id = bundle_row;

          html  =    '<tr id="bundle-row'+bundle_id+'">';
          html +=    '<td class="text-right"><input type="text" name="bundle_product'+bundle_id+'" value="" placeholder="<?php echo $entry_related; ?>" id="input-related" class="form-control" />';
          html +=    '<div id="optionsmodal'+bundle_id+'" class="modal fade" role="dialog">';
          html +=    '    <div class="modal-dialog">';
          html +=    '    <div class="modal-content">';
          html +=    '    <div class="modal-header">';
          html +=    '    <button type="button" class="close" data-dismiss="modal">&times;</button>';
          html +=    '<h4 class="modal-title" style="text-align: left;"><?php echo $text_select_options; ?></h4>';
          html +=    '</div>';
          html +=    '<div class="modal-body" style="padding: 0 50px 0 50px;text-align: left;" id="modalbody'+bundle_id+'">';
          html +=    '</div>';
          html +=    '<div class="modal-footer">';
          html +=    '   <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>';
          html +=    '   </div>';
          html +=    '   </div>';
          html +=    '    </div>';
          html +=    '    </div>';
          html +=    '    <i class="fa fa-pencil" onclick="$(\'#optionsmodal'+bundle_id+'\').modal(\'show\')" style="cursor: pointer;"><?php echo $text_select_options; ?></i>';

          html +=    '</td>';
          html +=    '<input type="hidden" id="bundle_product-' + bundle_id + '" name="product_bundles[' + bundle_id + '][product_id]" value="" placeholder="<?php echo $entry_related; ?>" id="input-related" class="form-control" />';
          html +=    '<td class="text-right">          <select name="product_bundles[' + bundle_id + '][row_id]" class="form-control">' +
              '<?php foreach ($rownames as $value => $name) { ?><option value="<?php echo $value; ?>"><?php echo $name; ?></option><?php } ?>' +
              '</select></td>';
          html +=    '<td class="text-right"><input type="text" name="product_bundles[' + bundle_id + '][special]" value="" placeholder="<?php echo $entry_price; ?>" class="form-control" /></td>';
          html +=    '<td class="text-right"><input type="text" name="product_bundles[' + bundle_id + '][sort]" value="0" placeholder="<?php echo $entry_sort; ?>" class="form-control" /></td>';
          html +=    '<td class="text-left"><button type="button" onclick="$(\'#bundle-row' + bundle_id + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
          html +=    '</tr>'
          $('#bundles tbody').append(html);

          $('input[name=\'bundle_product'+bundle_id+'\']').autocomplete({
              'source': function(request, response) {
                  $.ajax({
                      url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_status=1&filter_name=' +  encodeURIComponent(request),
                      dataType: 'json',
                      success: function(json) {
                          response($.map(json, function(item) {
                              return {
                                  label: item['name'],
                                  value: item['product_id']
                              }
                          }));
                      }
                  });
              },
              'select': function(item) {
                  $.ajax({
                      url: 'index.php?route=catalog/neoseo_product_bundles/optform&product_id='+item['value'],
                      data: {token : '<?php echo $token; ?>' ,by_ajax : '1'},
                      success: function(data) {
                          $("#modalbody"+bundle_id).html(data);
                      }
                  });
                  $('input[name=\'bundle_product'+bundle_id+'\']').val(item['label']);
                  $('#bundle_product-'+ bundle_id).val(item['value']);
              }
          });
          bundle_row++;
      }

// Related
$('input[name=\'related\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_status=1&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['product_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'related\']').val('');
		$('#product-related' + item['value']).remove();
        html =    '<div id="optionsmodalb'+item['value']+'" class="modal fade" role="dialog">';
        html +=    '    <div class="modal-dialog">';
        html +=    '    <div class="modal-content">';
        html +=    '    <div class="modal-header">';
        html +=    '    <button type="button" class="close" data-dismiss="modal">&times;</button>';
        html +=    '<h4 class="modal-title" style="text-align: left;"><?php echo $text_select_options; ?></h4>';
        html +=    '</div>';
        html +=    '<div class="modal-body" style="padding: 0 50px 0 50px;text-align: left;" id="modalbodyb'+item['value']+'">';
        html +=    '</div>';
        html +=    '<div class="modal-footer">';
        html +=    '   <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>';
        html +=    '   </div>';
        html +=    '   </div>';
        html +=    '    </div>';
        html +=    '    </div>';
        html +=    '    <i class="fa fa-pencil" onclick="$(\'#optionsmodalb'+item['value']+'\').modal(\'show\')" style="cursor: pointer;"><?php echo $text_select_options; ?></i>';

        $('#product-related').append('<div id="product-related' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_related[]" value="' + item['value'] + '" />'+html+'</div>');

        $.ajax({
            url: 'index.php?route=catalog/neoseo_product_bundles/optform&product_id='+item['value'],
            data: {token : '<?php echo $token; ?>' ,by_ajax : '1'},
            success: function(data) {
                $("#modalbodyb"+item['value']).html(data);
            }
        });

	}
});

$('#product-related').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});
      $( document ).ready(function() {
          $('.date').datetimepicker({
              pickTime: false
          });

          $('.datetime').datetimepicker({
              pickDate: true,
              pickTime: true
          });

          $('.time').datetimepicker({
              pickDate: false
          });

      <?php for($i=0;$i<=$bundle_row;$i++) { ?>
              $('input[name=\'bundle_product-<?php echo $i; ?>\']').autocomplete({
                  'source': function(request, response) {
                      $.ajax({
                          url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_status=1&filter_name=' +  encodeURIComponent(request),
                          dataType: 'json',
                          success: function(json) {
                              response($.map(json, function(item) {
                                  return {
                                      label: item['name'],
                                      value: item['product_id']
                                  }
                              }));
                          }
                      });
                  },
                  'select': function(item) {
                      $.ajax({
                          url: 'index.php?route=catalog/neoseo_product_bundles/optform&product_id='+item['value'],
                          data: {token : '<?php echo $token; ?>' ,by_ajax : '1'},
                          success: function(data) {
                                  $("#modalbody<?php echo $i; ?>").html(data);
                          }
                      });
                      $("input[name='bundle_product-<?php echo $i; ?>']").val(item['label']);
                      $("#bundle_product-<?php echo $i; ?>").val(item['value']);
                  }
              });
      <?php } ?>
      });

//--></script>



</div>
<?php echo $footer; ?>
