<?php
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets($moduleName,$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>
<div class='parent'>
    <?php $widgets->dropdownA('status', 'tabs', $max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
    <?php $widgets->inputA('order', 'tabs', $max_id); ?>
    <div class="form-group" id="field_tabs-class-1" style="display: inline-block; width: 100%;">
        <div class="col-sm-5">
            <label class="control-label" ><?php echo $entry_title_tab;?></label>
            <br>
        </div>
        <div class="col-sm-7">
            <?php foreach ($languages as $language) {  ?>    
            <div class="input-group">
                <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                <input class="form-control" name="tabs[<?php echo $max_id; ?>][name][<?php echo $language['language_id']; ?>]" value="<?php echo (isset($tabs[$max_id]['name'][$language['language_id']])) ? $tabs[$max_id]['name'][$language['language_id']] : ''; ?>"/>
            </div>
            <?php } ?>
        </div>
    </div>
    <?php //$widgets->inputA('limit', 'tabs', $max_id); ?>
    <?php $widgets->inputA('width', 'tabs', $max_id); ?>
    <?php $widgets->inputA('height', 'tabs', $max_id); ?>
    <div class="form-group" id='show_products'>
        <label class="col-sm-5 control-label" for="input-product"><?php echo $entry_products; ?></label>
        <div class="col-sm-7">
            <input type="text" name="tab_product" value="" placeholder="<?php echo $entry_products; ?>" id="<?php echo $max_id;?>" class="form-control" />
            <div id="label-hand-product-<?php echo $max_id;?>" class="well well-sm" style="height: 150px; overflow: auto;">

            </div>
        </div>
    </div>

</div>
