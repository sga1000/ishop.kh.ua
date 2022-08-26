<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_product_labels_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>
<div class='parent'>
    <?php $widgets->dropdownA('status', 'labels', $max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
    <div class="form-group" id="field_labels-class-1" style="display: inline-block; width: 100%;">
        <div class="col-sm-5">
            <label class="control-label" ><?php echo $entry_name;?></label>
            <br>
        </div>
        <div class="col-sm-7">
            <?php foreach ($languages as $language) {  ?>
            <div class="input-group">
                <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                <input class="form-control" name="labels[<?php echo $max_id; ?>][name][<?php echo $language['language_id']; ?>]" value="<?php echo (isset($labels[$max_id]['name'][$language['language_id']])) ? $labels[$max_id]['name'][$language['language_id']] : ''; ?>"/>
            </div>
            <?php } ?>
        </div>
    </div>
    <?php $widgets->dropdownA('label_type', 'labels', $max_id, $array_type_label); ?>
    <?php $widgets->dropdownA('position', 'labels', $max_id, $array_position); ?>
    <?php $widgets->inputA('class', 'labels', $max_id); ?>
    <?php $widgets->inputA('style', 'labels', $max_id); ?>
    <?php $widgets->inputA('priority', 'labels', $max_id); ?>
    <div class="form-group"  style="display: inline-block; width: 100%;">
        <div class="col-sm-5">
            <label class="control-label" >  <?php echo $entry_color; ?></label>
        </div>
        <div class='col-sm-7'>
            <input id="<?php echo $max_id?>" style="float: left" type="text" name="labels[<?php echo $max_id; ?>][color]" value="f12717" class="col-sm-3 pick_color-new"/>
        </div>
    </div>
    <div class="form-group" style="display: none; width: 100%">
        <label class="col-sm-5 control-label" for="input-limit-<?php echo $max_id; ?>"><?php echo $entry_limit; ?></label>
        <div class="col-sm-7">
            <input type="number" id="input-limit-<?php echo $max_id; ?>" name="labels[<?php echo $max_id; ?>][product_limit]" value="10" class="form-control" />
        </div>
    </div>
    <div class="form-group" id="field_labels-type-<?php echo $max_id; ?>" style="display: inline-block; width: 100%;">
        <div class="col-sm-5">
            <label class="control-label" for="neoseo_product_labels-type-<?php echo $max_id; ?>"><?php echo $entry_type; ?></label>
            <br>
        </div>
        <div class="col-sm-7">
            <select name="labels[<?php echo $max_id; ?>][type]" id="neoseo_product_labels-type-<?php echo $max_id; ?>" data-type_id = "<?php echo $max_id; ?>" class="form-control">
                <?php foreach ($array_params as $value => $name) { ?>
                <option value="<?php echo $value; ?>"><?php echo $name; ?></option>
                <?php } ?>
            </select>
        </div>
    </div>
    <div class="form-group type-element" id="type-element-<?php echo $max_id; ?>-0" style="display: block">
        <label class="col-sm-5 control-label"><?php echo $entry_products; ?></label>
        <div class="col-sm-7">
            <input type="text" name="label_product" value="" placeholder="<?php echo $entry_products; ?>" id="<?php echo $max_id; ?>" class="form-control" />
            <div id="label-hand-product-<?php echo $max_id; ?>" class="well well-sm" style="height: 150px; overflow: auto;"></div>
        </div>
        <input type="hidden" name="labels[<?php echo $max_id; ?>][label_id]" value="<?php echo $max_id; ?>" />
    </div>
    <div class="form-group">
        <label class="col-sm-5 control-label"><?php echo $entry_store; ?></label>
        <div class="col-sm-7">
            <div class="well well-sm" style="height: 150px; overflow: auto;">
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="labels[<?php echo $max_id; ?>][stores][]" value="0" />
                        <?php echo $text_default; ?>
                    </label>
                </div>
                <?php foreach ($stores as $store) { ?>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="labels[<?php echo $max_id; ?>][stores][]" value="<?php echo $store['store_id']; ?>" />
                        <?php echo $store['name']; ?>
                    </label>
                </div>
                <?php } ?>
            </div>
        </div>
    </div>
    <div class="form-group type-element" id="type-element-<?php echo $max_id; ?>-1" style="display: none">
        <label class="col-sm-5 control-label"><?php echo $entry_duration_days; ?></label>
        <div class="col-sm-7">
            <input type="number" name="labels[<?php echo $max_id; ?>][days]" value="0" class="form-control" />
        </div>
    </div>
    <div class="form-group type-element" id="type-element-<?php echo $max_id; ?>-2" style="display: none">
        <label class="col-sm-5 control-label"><?php echo $entry_view_counts; ?></label>
        <div class="col-sm-7">
            <input type="number" name="labels[<?php echo $max_id; ?>][viewes]" value="0" class="form-control" />
        </div>
    </div>
    <div class="form-group type-element" id="type-element-<?php echo $max_id; ?>-3" style="display: none">
        <label class="col-sm-5 control-label"><?php echo $entry_sold; ?></label>
        <div class="col-sm-7">
            <input type="number" name="labels[<?php echo $max_id; ?>][sold]" value="0" class="form-control" />
        </div>
    </div>
</div>