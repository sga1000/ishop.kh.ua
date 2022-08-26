<div class="module">
    <div class="row">
        <div class="subscribe box-shadow box-corner">
            <div class="subscribe-container">
                <div class="subscribe-title"><?php echo $text_subscribe_title; ?></div>
                <div class="subscribe-paragraph"><?php echo $text_subscribe_par; ?></div>
                <?php if ($show_name) { ?>
                <input type="text" id="subscribe-name<?php echo $module; ?>" name="subscribe_name" placeholder="<?php echo $text_name; ?>">
                <?php } ?>
                <div class="subscribe-group">
                    <input type="text" id="subscribe<?php echo $module; ?>" name="subscribe" placeholder="<?php echo $text_email; ?>">
                    <input type="submit" onclick="processSubscribe(<?php echo $module; ?>)" value="<?php echo $button_action; ?>" class="btn" aria-label="Button subscribe">
                </div>
            </div>
        </div>
    </div>
</div>