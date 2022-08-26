<div class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="glyphicon glyphicon-remove"></i></button>
                <h3 class="modal-title"><?php echo $heading_title_login; ?></h3>
            </div>
            <div class="modal-body">
                <div class="form-group required">
                    <label class="control-label"><?php echo $entry_email; ?></label>
                    <input class="form-control" type="text" name="email" value="" class="large-field"/>
                </div>
                <div class="form-group required">
                    <label class="control-label"><?php echo $entry_password; ?></label>
                    <input class="form-control" type="password" name="password" value="" class="large-field"/>
                </div>
                <div class="form-group" style="margin-bottom: 0;">
                    <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $button_continue; ?></button>
                <a id="button-login" class="btn btn-primary"><?php echo $button_login; ?></a>
            </div>
        </div>
    </div>
</div>
