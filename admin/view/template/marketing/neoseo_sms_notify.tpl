<div class="modal fade"  role="dialog"  id="modal-sms-notify">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button"><i class="fa fa-times" aria-hidden="true"></i></button>
                <img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
                <h1><?php echo $heading_title; ?></h1>
            </div>
            <div class="modal-body">

                <?php $widgets->input('header_phone'); ?>
                <?php $widgets->textarea('header_message'); ?>

            </div>
            <div class="modal-footer">
                <button id="send_sms_from_header_button" class="btn btn-success" onclick="sendSmsFromHeader(); return false;"><i class="fa fa-envelope" aria-hidden="true"></i> <?php echo $button_send;?></button>
                <button type="button" class="btn btn-primary" data-dismiss="modal"><?php echo $button_close;?></button>
            </div>
        </div>
    </div>
</div>