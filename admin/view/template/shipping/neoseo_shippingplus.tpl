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
        <button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if (!empty($hiden)) { ?>
    <div class="alert alert-info"><i class="fa fa-check-circle"></i> <?php echo $text_hide_shipping; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-body">
        <ul class="nav nav-tabs">
          <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
			<?php if( !isset($license_error) ) { ?>
          <li><a href="#tab-methods" data-toggle="tab"><?php echo $text_list; ?></a></li>
          <li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
          <?php } ?>
          <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
          <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
        </ul>

        <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
          <div class="tab-content">
            <div class="tab-pane active" id="tab-general">
              <?php if( !isset($license_error) ) { ?>

              <?php $widgets->dropdown('status', array(0 => $text_disabled, 1 => $text_enabled)); ?>
              <?php $widgets->input('sort_order'); ?>

              <?php } else { ?>

              <?php echo $license_error; ?>

              <?php } ?>

            </div>

            <div class="tab-pane" id="tab-methods">
              <div class="container-fluid">
                <div class="pull-right">
                  <?php if( !isset($license_error) ) { ?>
                  <a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                  <button id="button-copy" type="button" data-toggle="tooltip" title="<?php echo $button_copy; ?>" class="btn btn-default" ><i class="fa fa-copy"></i></button>
                  <button id="button-remove" type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" ><i class="fa fa-trash-o"></i></button>
                  <?php } else { ?>
                  <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>" class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
                  <?php } ?>
                </div>
              </div>
              <div class="panel-body">
                <div id="form-shippings">
                  <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                      <thead>
                      <tr>
                        <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                        <td class="text-left"><?php echo $column_name; ?></td>
                        <td class="text-left"><?php echo $column_status; ?></td>
                        <td class="text-right"><?php echo $column_sort_order; ?></td>
                        <td class="text-right"><?php echo $column_action; ?></td>
                      </tr>
                      </thead>
                      <tbody>
                      <?php if ($shippings) { ?>
                      <?php foreach ($shippings as $shipping) { ?>
                      <tr>
                        <td class="text-center"><?php if (in_array($shipping['shipping_id'], $selected)) { ?>
                          <input type="checkbox" name="selected[]" value="<?php echo $shipping['shipping_id']; ?>" checked="checked" />
                          <?php } else { ?>
                          <input type="checkbox" name="selected[]" value="<?php echo $shipping['shipping_id']; ?>" />
                          <?php } ?></td>
                        <td class="text-left"><?php echo $shipping['name']; ?></td>
                        <td class="text-left"><?php echo $shipping['status'] ?></td>
                        <td class="text-right"><?php echo $shipping['sort_order']; ?></td>
                        <td class="text-right">
                          <a href="<?php echo $shipping['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
                          <a href="<?php echo $shipping['delete']; ?>" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></a>
                        </td>
                      </tr>
                      <?php } ?>
                      <?php } else { ?>
                      <tr>
                        <td class="text-center" colspan="5"><?php echo $text_no_results; ?></td>
                      </tr>
                      <?php } ?>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>

            <?php if( !isset($license_error) ) { ?>
            <div class="tab-pane" id="tab-logs">
              <?php $widgets->debug_and_logs('debug', array(0 => $text_disabled, 1 => $text_enabled), $clear, $button_clear_log ); ?>
              <textarea style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
            </div>
            <?php } ?>

            <div class="tab-pane" id="tab-support">
              <?php echo $mail_support; ?>
            </div>

            <div class="tab-pane" id="tab-license">
              <?php echo $module_licence; ?>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>

<script type="text/javascript">
    $(document).ready(function (e) {
        $('#button-remove').on('click', function () {
            if (confirm('<?php echo $text_confirm; ?>')) {
                var hiddenForm = $('<form  method="post" enctype="multipart/form-data" id="form-shippings-hidden">');
				hiddenForm.attr('action', '<?php echo $delete; ?>'.replace(/&amp;/g, '&'));
                hiddenForm.append($('#form-shippings :input[name*=\'selected\']:checked').clone());
				$(document.body).append(hiddenForm);
                hiddenForm.submit();
            }
        });
        $('#button-copy').on('click', function () {
            var hiddenForm = $('<form  method="post" enctype="multipart/form-data" id="form-shippings-hidden">');
            hiddenForm.attr('action', '<?php echo $clone; ?>'.replace(/&amp;/g, '&'));
            hiddenForm.append($('#form-shippings :input[name*=\'selected\']:checked').clone());
			$(document.body).append(hiddenForm);
            hiddenForm.submit();
        });
    });
</script>