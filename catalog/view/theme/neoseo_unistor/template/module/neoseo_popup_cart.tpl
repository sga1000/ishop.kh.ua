<div class="modal modal--cart fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="modal-close-button close" data-dismiss="modal" aria-hidden="true">
                    <span></span>
                    <span></span>
                </button>
                <h3 class="modal-title"><?php echo $text_popup_cart_title; ?></h3>
            </div>
            <div class="modal-body"></div>


            <div class="modal-footer">

                <!-- NeoSeo QuickOrder - begin -->
                <?php if (!empty($neoseo_quick_order_popup_type) && $neoseo_quick_order_popup_type === 'form') echo $neoseo_quick_order_popup_form_template; ?>
                <!-- NeoSeo QuickOrder - end -->

                <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $button_continue; ?></button>
				<!-- NeoSeo QuickOrder - begin -->
				<?php if (!empty($neoseo_quick_order_popup_type) && $neoseo_quick_order_popup_type === 'link') echo $neoseo_quick_order_popup_form_template; ?>
				<!-- NeoSeo QuickOrder - end -->
                <a href="<?php echo $button_checkout_url; ?>" class="btn btn-primary"><?php echo $button_checkout; ?></a>
            </div>
        </div>
    </div>
</div>
