<?php if(count($product_options) > 0) { foreach ($product_options as $option) { ?>
    <?php if ($option['type'] == 'select') { ?>
<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
    <select name="option[<?php echo $product_id;?>][<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
        <option value=""><?php echo $text_select; ?></option>
        <?php foreach ($option['product_option_value'] as $option_value) { ?>
        <option value="<?php echo $option_value['product_option_value_id']; ?>" <?php if(isset($cur_values[$option['product_option_id']]) && $cur_values[$option['product_option_id']] == $option_value['product_option_value_id']) echo "selected" ?>><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
        </option>
        <?php } ?>
    </select>
</div>
<?php } ?>
<?php if ($option['type'] == 'radio') { ?>
<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
    <label class="control-label"><?php echo $option['name']; ?></label>
    <div id="input-option<?php echo $option['product_option_id']; ?>">
        <?php foreach ($option['product_option_value'] as $option_value) { ?>
        <div class="radio">
            <label>
                <input type="radio" name="option[<?php echo $product_id;?>][<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" <?php if(isset($cur_values[$option['product_option_id']]) && $cur_values[$option['product_option_id']] == $option_value['product_option_value_id']) echo " checked='checked'" ?>/>
                <?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
            </label>
        </div>
        <?php } ?>
    </div>
</div>
<?php } ?>
<?php if ($option['type'] == 'checkbox') { ?>
<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
    <label class="control-label"><?php echo $option['name']; ?></label>
    <div id="input-option<?php echo $option['product_option_id']; ?>">
        <?php foreach ($option['product_option_value'] as $option_value) { ?>
        <div class="checkbox">
            <label>
                <input type="checkbox" name="option[<?php echo $product_id;?>][<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" <?php if(isset($cur_values[$option['product_option_id']]) && in_array($option_value['product_option_value_id'],$cur_values[$option['product_option_id']])) echo " checked='checked'" ?>/>
                <?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
            </label>
        </div>
        <?php } ?>
    </div>
</div>
<?php } ?>

<?php if ($option['type'] == 'image') { ?>
<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
    <label class="control-label"><?php echo $option['name']; ?></label>
    <div id="input-option<?php echo $option['product_option_id']; ?>">
        <?php foreach ($option['product_option_value'] as $option_value) { ?>
        <div class="radio">
            <label>
                <input type="radio" name="option[<?php echo $product_id;?>][<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" <?php if(isset($cur_values[$option['product_option_id']]) && $cur_values[$option['product_option_id']] == $option_value['product_option_value_id']) echo " checked='checked'" ?>/>
                <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
            </label>
        </div>
        <?php } ?>
    </div>
</div>
<?php } ?>

<?php if ($option['type'] == 'text') { ?>
<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
    <input type="text" name="option[<?php echo $product_id;?>][<?php echo $option['product_option_id']; ?>]" value="<?php if(isset($cur_values[$option['product_option_id']])) echo $cur_values[$option['product_option_id']] ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
</div>
<?php } ?>
<?php if ($option['type'] == 'textarea') { ?>
<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
    <textarea name="option[<?php echo $product_id;?>][<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php if(isset($cur_values[$option['product_option_id']])) echo $cur_values[$option['product_option_id']] ?></textarea>
</div>
<?php } ?>

<?php if ($option['type'] == 'date') { ?>
<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
    <div class="input-group datetime">
        <input type="text" name="option[<?php echo $product_id;?>][<?php echo $option['product_option_id']; ?>]" value="<?php if(isset($cur_values[$option['product_option_id']])) echo $cur_values[$option['product_option_id']] ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
        <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
</div>
<?php } ?>

<?php if ($option['type'] == 'datetime') { ?>
<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
    <div class="input-group datetime">
        <input type="text" name="option[<?php echo $product_id;?>][<?php echo $option['product_option_id']; ?>]" value="<?php if(isset($cur_values[$option['product_option_id']])) echo $cur_values[$option['product_option_id']] ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
        <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
</div>
<?php } ?>
<?php if ($option['type'] == 'time') { ?>
<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
    <div class="input-group time">
        <input type="text" name="option[<?php echo $product_id;?>][<?php echo $option['product_option_id']; ?>]" value="<?php if(isset($cur_values[$option['product_option_id']])) echo $cur_values[$option['product_option_id']]?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
        <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
</div>
<?php } ?>

<?php } ?>
<?php } else echo $no_options?>