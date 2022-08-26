<div class="modal modal--quick fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="modal-close-button close" data-dismiss="modal">
                    <span></span>
                    <span></span>
                </button>
                <h3 class="modal-title"><i class="fa fa-shopping-cart" aria-hidden="true"></i><?php echo $heading_title; ?></h3>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-6 text-center">
                        <img style="width:70%" src="/image/neoseo_quick_order.jpg">
                    </div>
                    <div class="col-sm-6">
                        <p><?php echo $order_complete; ?></p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-long-arrow-left" aria-hidden="true"></i><?php echo $button_continue; ?></button>
            </div>
        </div>
    </div>
</div>
