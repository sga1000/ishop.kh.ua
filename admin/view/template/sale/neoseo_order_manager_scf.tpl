<?php if (!$read_only) { ?>
<?php foreach ($custom_fields as $custom_field) { ?>
<?php if ($custom_field['location'] == 'address') { ?>
<?php if ($custom_field['type'] == 'select') { ?>
<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
    <label class="col-sm-4 control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
    <div class="col-sm-8">
        <select name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="save form-control">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
            <?php if (isset($shipping_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $shipping_custom_field[$custom_field['custom_field_id']]) { ?>
            <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
            <?php } ?>
            <?php } ?>
        </select>
    </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'radio') { ?>
<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
    <label class="col-sm-4 control-label"><?php echo $custom_field['name']; ?></label>
    <div class="col-sm-8">
        <div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
            <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
            <div class="radio">
                <?php if (isset($shipping_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $shipping_custom_field[$custom_field['custom_field_id']]) { ?>
                <label>
                    <input type="radio" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" class="save" />
                    <?php echo $custom_field_value['name']; ?></label>
                <?php } else { ?>
                <label>
                    <input type="radio" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" class="save" />
                    <?php echo $custom_field_value['name']; ?></label>
                <?php } ?>
            </div>
            <?php } ?>
        </div>
    </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'checkbox') { ?>
<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
    <label class="control-label"><?php echo $custom_field['name']; ?></label>
    <div>
        <div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
            <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
            <div class="checkbox">
                <?php if (isset($shipping_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $shipping_custom_field[$custom_field['custom_field_id']])) { ?>
                <label>
                    <input type="checkbox" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" class="save_check" />
                    <?php echo $custom_field_value['name']; ?></label>
                <?php } else { ?>
                <label>
                    <input type="checkbox" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" class="save_check" />
                    <?php echo $custom_field_value['name']; ?></label>
                <?php } ?>
            </div>
            <?php } ?>
        </div>
    </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'text') { ?>
<div class="form-group custom-field">
    <label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
    <div>
        <input type="text" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="save form-control" />
    </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'textarea') { ?>
<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
    <label class="col-sm-4 control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
    <div class="col-sm-8">
        <textarea name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="save form-control"><?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
    </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'file') { ?>
<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
    <label class="col-sm-4 control-label"><?php echo $custom_field['name']; ?></label>
    <div class="col-sm-8">
        <button type="button" id="button-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
        <input type="hidden" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : ''); ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
    </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'date') { ?>
<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
    <label class="control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
    <div>
        <div class="input-group date">
            <input type="text" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="save form-control" />
            <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
            </span></div>
    </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'time') { ?>
<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
    <label class="col-sm-4 control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
    <div class="col-sm-8">
        <div class="input-group time">
            <input type="text" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="save form-control" />
            <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
            </span></div>
    </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'datetime') { ?>
<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
    <label class="col-sm-4 control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
    <div class="col-sm-8">
        <div class="input-group datetime">
            <input type="text" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="save form-control" />
            <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
            </span></div>
    </div>
</div>
<?php } ?>
<?php } ?>
<?php } ?>
<?php } else { ?>
<?php foreach ($custom_fields as $custom_field) { ?>
<?php if ($custom_field['location'] == 'address') { ?>
<?php if ($custom_field['type'] == 'select') { ?>
<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
    <label class="col-sm-4 control-label" for="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
    <div class="col-sm-8">
        <select name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" disabled="disabled" class="save form-control">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
            <?php if (isset($shipping_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $shipping_custom_field[$custom_field['custom_field_id']]) { ?>
            <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
            <?php } ?>
            <?php } ?>
        </select>
    </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'radio') { ?>
<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
    <label class="col-sm-4 control-label"><?php echo $custom_field['name']; ?></label>
    <div class="col-sm-8">
        <div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
            <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
            <div class="radio">
                <?php if (isset($shipping_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $shipping_custom_field[$custom_field['custom_field_id']]) { ?>
                <label>
                    <input type="radio" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" class="save" />
                    <?php echo $custom_field_value['name']; ?></label>
                <?php } else { ?>
                <label>
                    <input type="radio" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" class="save" />
                    <?php echo $custom_field_value['name']; ?></label>
                <?php } ?>
            </div>
            <?php } ?>
        </div>
    </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'checkbox') { ?>
<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
    <label class="control-label"><?php echo $custom_field['name']; ?></label>
    <div>
        <div id="input-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>">
            <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
            <div class="checkbox">
                <?php if (isset($shipping_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $shipping_custom_field[$custom_field['custom_field_id']])) { ?>
                <label>
                    <input type="checkbox" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" class="save_check" readonly disabled="disabled" />
                    <?php echo $custom_field_value['name']; ?></label>
                <?php } else { ?>
                <label>
                    <input type="checkbox" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" class="save_check" readonly disabled="disabled" />
                    <?php echo $custom_field_value['name']; ?></label>
                <?php } ?>
            </div>
            <?php } ?>
        </div>
    </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'text') { ?>
	<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
<?php } ?>
<?php if ($custom_field['type'] == 'textarea') { ?>
	<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
<?php } ?>
<?php if ($custom_field['type'] == 'file') { ?>
<div class="form-group custom-field custom-field<?php echo $custom_field['custom_field_id']; ?>" data-sort="<?php echo $custom_field['sort_order'] + 3; ?>">
    <label class="col-sm-4 control-label"><?php echo $custom_field['name']; ?></label>
    <div class="col-sm-8">
        <button type="button" id="button-shipping-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
        <input type="hidden" name="shipping_custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : ''); ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
    </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'date') { ?>
	<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
<?php } ?>
<?php if ($custom_field['type'] == 'time') { ?>
	<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
<?php } ?>
<?php if ($custom_field['type'] == 'datetime') { ?>
	<?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
<?php } ?>
<?php } ?>
<?php } ?>
<?php } ?>

