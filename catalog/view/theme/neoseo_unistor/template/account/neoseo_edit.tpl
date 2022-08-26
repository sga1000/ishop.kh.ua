<?php echo $header; ?>
<div class="container">
    <?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
    <?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } else { ?>
    <?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } ?>
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
    <?php } ?>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <div class="account-container box-shadow box-corner">
            <h1><?php echo $heading_title; ?></h1>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                <div class="login-register">
                    <div class="form">
                        <?php if( count($customer_groups) > 1 ) { ?>
                        <?php foreach( $customer_groups as $type => $name ) { ?>
                        <div class="radio radio-primary radio-inline" >
                            <input type="radio" id="type_<?php echo $type; ?>" <?php if( $type == $type_selected ) { ?> checked="checked" <?php } ?> name="type" value="<?php echo $type; ?>" class="large-field" />
                            <label for="type_<?php echo $type; ?>"><?php echo $name; ?>:</label>
                        </div>
                        <?php } ?>
                        <?php } else { ?>
                        <input type="hidden" name="type" value="<?php $keys = array_keys($customer_groups); echo $keys[0]; ?>" />
                        <?php } ?>

                        <?php $i=0; foreach( $fieldset as $type => $fields1 ) { $i++; ?>
                        <div class="types type-<?php echo $type; ?>" <?php if( $i != 1 ) { ?> style="display:none" <?php } ?> >
                        <?php echo $fields1; ?>
                    </div>
                    <?php } ?>

                    <script>
						$('[name=type]').click(function(e){
							var type = $(this).val();
							$(".types").hide();
							$(".types input").attr("disabled", true);
							$(".types select").attr("disabled", true);
							$(".types textarea").attr("disabled", true);

							$(".type-" + type).show();
							$(".type-" + type + " input").attr("disabled", false);
							$(".type-" + type + " select").attr("disabled", false);
							$(".type-" + type + " textarea").attr("disabled", false);
						});
						<?php if( count($customer_groups) > 1 ) { ?>
							$('[name=type]:checked').trigger('click');
						<?php } else { ?>
							$('[name=type]').trigger('click');
						<?php }?>
                    </script>

                    <div class="button-holder text-right">
                        <input type="submit" value="<?php echo $button_update; ?>" class="btn btn-primary" />
                    </div>
                </div>
        </div>
        </form>
            </div>
        <?php echo $content_bottom; ?>
    </div>
    <?php echo $column_right; ?>
</div>
</div>

<?php echo $footer; ?>