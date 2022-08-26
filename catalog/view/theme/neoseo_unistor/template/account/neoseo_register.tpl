<?php echo $header; ?>
<div class="container">
    <?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
    <?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } else { ?>
    <?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } ?>
    <div class="account-container box-shadow box-corner">

        <div class="row"><?php echo $column_left; ?>
            <?php if ($column_left && $column_right) { ?>
            <?php $class = 'col-sm-6'; ?>
            <?php } elseif ($column_left || $column_right) { ?>
            <?php $class = 'col-sm-9'; ?>
            <?php } else { ?>
            <?php $class = 'col-sm-12'; ?>
            <?php } ?>
            <div id="content" class="checkout-bl <?php echo $class; ?> register"><?php echo $content_top; ?>

                <?php if ($error_warning) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
                <?php } ?>
                <h1 class="reg-title"><i class="fa fa-check" aria-hidden="true"></i> <span><?php echo $heading_title; ?></span></h1>
                <!-- <p><?php echo $text_account_already; ?></p> -->

                <!-- NeoSeo Social Auth - begin -->
                <?php if($neoseo_social_auth_status){ ?>
                <?php if (isset($social_error)) { echo $social_error; } ?>
                <div class="socialLogin">
                    <span><?php echo $social_auth_title; ?></span>
                    <script src="https://ulogin.ru/js/ulogin.js"></script>
                    <div id="uLogin"  data-ulogin="display=panel;theme=flat;fields=first_name,last_name,email,phone,city,country;mobilebuttons=0;sort=<?php echo $social_auth_sort; ?>;providers=<?php echo $social_networks;?>;hidden=;redirect_uri=<?php echo $domain; ?>"></div>
                </div>
                <?php } ?>
                <!-- NeoSeo Social Auth - end -->

                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                    <div class="login-register">

                        <div class="form">
                            <div class="radio-box">
                                <?php if( count($customer_groups) > 1 ) { ?>
                                <?php foreach( $customer_groups as $type => $name ) { ?>
                                <div class="radio radio-primary radio-inline">
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

                        <?php if ($text_agree) { ?>
                        <?php $agree_error = isset($errors) && isset($errors['agree']) ? $errors['agree'] : ''; ?>

                        <div class="row field form-group">
                            <div style="" class="politics col-sm-offset-4 col-sm-8 checkbox checkbox-primary checkbox-inline <?php if ( $agree_error ) { ?> has-error<?php } ?>">
                                <input class="checkbox" id="agree" type="checkbox" name="agree" value="1" <?php if ($agree) { ?> checked="checked" <?php } ?> />
                                <label for="agree"><?php echo $text_agree; ?></label>
                                <?php if ( $agree_error ) { ?><br><span class="error"><?php echo $agree_error; ?></span><?php } ?>
                            </div>
                        </div>
                        <?php } ?>

                        <?php if($captcha) { ?>
                        <?php echo $captcha; ?>
                        <?php } ?>

                        <div class="button-holder">
                            <input type="submit" value="<?php echo $button_register; ?>" class="btn btn-primary"/>
                        </div>
                    </div>
            </div>
            </form>
            <?php echo $content_bottom; ?>
        </div>
        <?php echo $column_right; ?>
    </div>
</div>
</div>
<?php echo $footer; ?>