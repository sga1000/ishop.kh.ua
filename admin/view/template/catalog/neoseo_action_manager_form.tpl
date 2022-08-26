<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
   <div class="page-header">
      <div class="container-fluid">
         <div class="pull-right">
            <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
            <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
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
      <div class="panel panel-default">
         <div class="panel-heading">
            <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
         </div>
         <div class="panel-body">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
               <ul class="nav nav-tabs">
                  <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                  <li><a href="#tab-links" data-toggle="tab"><?php echo $tab_other_data; ?></a></li>
               </ul>
               <div class="tab-content">
                  <div class="tab-pane active" id="tab-general">
                     <?php $widgets->localeInputRequired('name', $languages, true, $error_name); ?>
                     <?php $widgets->localeTextArea('short_text', $languages); ?>
                     <?php $widgets->localeTextArea('full_text', $languages); ?>
                     <?php $widgets->localeInput('meta_title', $languages); ?>
                     <?php $widgets->localeTextArea('meta_description', $languages); ?>
                     <?php $widgets->localeTextArea('meta_keyword', $languages); ?>
                  </div>
                  <div class="tab-pane" id="tab-links">
                      <!-- <?php $widgets->dropdown('action_status', $action_status_list); ?> -->
                      <?php $widgets->inputRequired('keyword', false, $error_keyword); ?>
                      <?php $widgets->dateInput('date_end', true, $error_date_end); ?>
                      <?php $widgets->inputImage('image', $placeholder, $thumb);?>
                      <?php $widgets->input('image_width'); ?>
                      <?php $widgets->input('image_height'); ?>
                      <?php $widgets->dropdown('main_page',array( 1 => $text_enabled, 0 => $text_disabled )); ?>
                      <?php $widgets->dropdown('all_category',array( 1 => $text_enabled, 0 => $text_disabled)); ?>
                      <?php $widgets->listAutocomplete('related_category',$actions_categories); ?>
                      <?php $widgets->listAutocomplete('related_brand',$actions_brands); ?>
                      <?php $widgets->listAutocomplete('related_products',$actions_products); ?>
                  </div>
               </div>
            </form>
         </div>
      </div>
   </div>
</div>
  <script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
<?php if ($ckeditor) { ?>
    ckeditorInit('neoseo_action_manager_short_text<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
    ckeditorInit('neoseo_action_manager_full_text<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
<?php } else { ?>
    $('#neoseo_action_manager_short_text<?php echo $language['language_id']; ?>').summernote({height: 300, lang:'<?php echo $lang; ?>'});
    $('#neoseo_action_manager_full_text<?php echo $language['language_id']; ?>').summernote({height: 300, lang:'<?php echo $lang; ?>'});
<?php } ?>
<?php } ?>
//--></script>
  <script type="text/javascript"><!--
// Related
$('input[name=\'input-related_products\']').autocomplete({
    'source': function(request, response) {

        $.ajax({
            url: 'index.php?route=catalog/neoseo_action_manager/autocomplete_product&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
            dataType: 'json',
            success: function(json) {

                response($.map(json, function(item) {
                    return {
                        label: item['name'],
                        type:  item['type'],
                        value: item['id']
                    }
                }));
            }
        });
    },
    'select': function(item) {
        if (item['type'] == 'product') {
            $('input[name=\'input-related_products\']').val('');

            $('#related_products' + item['value']).remove();

            $('#list-related_products').append('<div id="related_products' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="auto-related_products[]" value="' + item['value'] + '" /></div>');

        } else if (item['type'] == 'manufacturer') {
            $.ajax({
                url: 'index.php?route=catalog/neoseo_action_manager/products_list&token=<?php echo $token; ?>&filter_brand=' + item['value'],
                dataType: 'json',
                success: function(json) {
                    $.map(json, function(item) {
                        $('input[name=\'input-related_products\']').val('');

                        $('#related_products' + item['id']).remove();

                        $('#list-related_products').append('<div id="related_products' + item['id'] + '"><i class="fa fa-minus-circle"></i> ' + item['name'] + '<input type="hidden" name="auto-related_products[]" value="' + item['id'] + '" /></div>');
                    })
                }
            });
        } else if (item['type'] == 'category') {
            $.ajax({
                url: 'index.php?route=catalog/neoseo_action_manager/products_list&token=<?php echo $token; ?>&filter_category=' + item['value'],
                dataType: 'json',
                success: function(json) {
                    $.map(json, function(item) {
                        $('input[name=\'input-related_products\']').val('');

                        $('#related_products' + item['id']).remove();

                        $('#list-related_products').append('<div id="related_products' + item['id'] + '"><i class="fa fa-minus-circle"></i> ' + item['name'] + '<input type="hidden" name="auto-related_products[]" value="' + item['id'] + '" /></div>');
                    })
                }
            });
        }
    }
});

$('#list-related_products').delegate('.fa-minus-circle', 'click', function() {
    $(this).parent().remove();
});
//-->

// Related
$('input[name=\'input-related_category\']').autocomplete({
    'source': function(request, response) {

        $.ajax({
            url: 'index.php?route=catalog/neoseo_action_manager/autocomplete_category&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
            dataType: 'json',
            success: function(json) {

                response($.map(json, function(item) {
                    return {
                        label: item['name'],
                        value: item['id']
                    }
                }));
            }
        });
    },
    'select': function(item) {
        $('input[name=\'input-related_category\']').val('');

        $('#related_category' + item['value']).remove();

        $('#list-related_category').append('<div id="related_category' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="auto-related_category[]" value="' + item['value'] + '" /></div>');
    }
});

$('#list-related_category').delegate('.fa-minus-circle', 'click', function() {
    $(this).parent().remove();
});

// Related Brand
$('input[name=\'input-related_brand\']').autocomplete({
  'source': function(request, response) {

      $.ajax({
          url: 'index.php?route=catalog/neoseo_action_manager/autocomplete_brand&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
          dataType: 'json',
          success: function(json) {

              response($.map(json, function(item) {
                  return {
                      label: item['name'],
                      value: item['id']
                  }
              }));
          }
      });
  },
  'select': function(item) {
      $('input[name=\'input-related_brand\']').val('');

      $('#related_brand' + item['value']).remove();

      $('#list-related_brand').append('<div id="related_brand' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="auto-related_brand[]" value="' + item['value'] + '" /></div>');
  }
});

$('#list-related_brand').delegate('.fa-minus-circle', 'click', function() {
  $(this).parent().remove();
});

</script>
  <script type="text/javascript"><!--
$('#all_cat_y').change(function() {
    if ($(this).checked) {
        alert('ok');
    }
});
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
//--></script>
  <script type="text/javascript"><!--
$('#language a:first').tab('show');
$('#option a:first').tab('show');
//--></script>
 
<?php echo $footer; ?>
