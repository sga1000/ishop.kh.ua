<div class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="glyphicon glyphicon-remove"></i></button>
                <h3 class="modal-title"><?php echo $text_popup_cart_title; ?></h3>
            </div>
            <div class="modal-body"></div>

			<!-- NeoSeo QuickOrder - begin -->
			<?php if (!empty($neoseo_quick_order_popup_type) && $neoseo_quick_order_popup_type === 'form') echo $neoseo_quick_order_popup_form_template; ?>
			<!-- NeoSeo QuickOrder - end -->

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $button_continue; ?></button>
				<!-- NeoSeo QuickOrder - begin -->
				<?php if (!empty($neoseo_quick_order_popup_type) && $neoseo_quick_order_popup_type === 'link') echo $neoseo_quick_order_popup_form_template; ?>
				<!-- NeoSeo QuickOrder - end -->
                <a href="<?php echo $button_checkout_url; ?>" class="btn btn-primary"><?php echo $button_checkout; ?></a>
            </div>
        </div>
    </div>
</div>
