<?php if($product['options']) { ?>
<form id="product_options_form_<?php echo $product['product_id']; ?>" class="options_pro_form">
  <input type="hidden" name="product_id" value="<?php echo $product['product_id']; ?>">
  <input type="hidden" name="minimum" value="<?php echo $product['minimum']; ?>">
  <div class="caption">
    <?php foreach($product['options'] as $option) { ?>
    <?php if ($option['type'] == 'select') { $option['type'] = 'radio'; /* Пока отключаем опции типа select */  } ?>
    <?php if ($option['type'] == 'select') { ?>
    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
      <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
        <option value=""><?php echo $text_select; ?></option>
        <?php foreach ($option['product_option_value'] as $option_value) { ?>
        <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
        <?php } ?>
      </select>
    </div>
    <?php } ?>
    <?php if ($option['type'] == 'radio') { ?>
    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
      <label class="control-label"><?php echo $option['name']; ?></label>
      <div id="input-option<?php echo $option['product_option_id']; ?>">
        <?php foreach ($option['product_option_value'] as $option_value) { ?>
        <div class="radio radio-square">
          <label>
            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
            <span class="square"><?php echo $option_value['name']; ?></span>
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
          <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
          <label>
             <?php echo $option_value['name']; ?>
          </label>
        </div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
    <?php if ($option['type'] == 'image') { ?>
    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
      <label class="control-label"><?php echo $option['name']; ?></label>
      <div id="input-option<?php echo $option['product_option_id']; ?>" class="form-radio">
        <div class="radio-image-wrapper">
          <?php foreach ($option['product_option_value'] as $option_value) { ?>
          <div class="radio-product-image">
            <label>
              <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
              <span><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /></span>
              <!-- <?php echo $option_value['name']; ?> -->
            </label>
          </div>
          <?php } ?>
        </div>
      </div>
    </div>
    <?php } ?>
    <?php } ?>
  </div>
</form>
<?php } ?>