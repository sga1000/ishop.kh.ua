<div class='parent'>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="input-status"><?php echo $entry_related_status; ?></label>
        <div class="col-sm-9">
            <select name="related_tabs[<?php echo $related_max_id;?>][status]" id="input-status" class="form-control">
            <?php if ($related_tabs[$related_max_id]['status']) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" ><?php echo $entry_related_title_tab;?></label>
        <div class="col-sm-9">
            <?php foreach ($languages as $language) {  ?>
            <div class="input-group">
                <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                <input class="form-control" name="related_tabs[<?php echo $related_max_id; ?>][name][<?php echo $language['language_id']; ?>]" value="<?php echo (isset($related_tabs[$related_max_id]['name'][$language['language_id']])) ? $related_tabs[$related_max_id]['name'][$language['language_id']] : ''; ?>"/>
            </div>
            <?php } ?>
        </div>
    </div> 
    <!-- 
    <div class="form-group">
    <label class="col-sm-3 control-label" for="input-status"><?php echo $entry_related_limit; ?></label>
    <div class="col-sm-9">
        <input type="text" name="related_tabs[<?php echo $related_max_id;?>][limit]" value="<?php echo (isset($related_tabs[$related_max_id]['limit'])) ? $related_tabs[$related_max_id]['limit'] : ''; ?>" class="form-control" />
    </div>
    </div> -->
    <div class="form-group">
        <label class="col-sm-3 control-label" for="input-status"><?php echo $entry_related_width; ?></label>
        <div class="col-sm-9">
            <input type="text" name="related_tabs[<?php echo $related_max_id;?>][width]" value="<?php echo (isset($related_tabs[$related_max_id]['width'])) ? $related_tabs[$related_max_id]['width'] : ''; ?>" class="form-control" />
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="input-status"><?php echo $entry_related_height; ?></label>
        <div class="col-sm-9">
            <input type="text" name="related_tabs[<?php echo $related_max_id;?>][height]" value="<?php echo (isset($related_tabs[$related_max_id]['height'])) ? $related_tabs[$related_max_id]['height'] : ''; ?>" class="form-control" />
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-3 control-label" for="input-status"><?php echo $entry_related_order; ?></label>
        <div class="col-sm-9">
            <input type="text" name="related_tabs[<?php echo $related_max_id;?>][order]" value="<?php echo (isset($related_tabs[$related_max_id]['order'])) ? $related_tabs[$related_max_id]['order'] : ''; ?>" class="form-control" />
        </div>
    </div>
    <div class="form-group" id='show_products'>
        <label class="col-sm-3 control-label" for="input-product"><?php echo $entry_related_products; ?></label>
        <div class="col-sm-9">
            <input type="text" name="tab_product" value="" placeholder="<?php echo $entry_related_products; ?>" id="<?php echo $related_max_id;?>" class="form-control" />
            <div id="label-hand-product-<?php echo $related_max_id;?>" class="well well-sm" style="height: 150px; overflow: auto;">

            </div>
        </div>
    </div>
    <input type="hidden" name="related_tabs[<?php echo $related_max_id;?>][module_id]" value="module-id" class="form-control" />
</div>
