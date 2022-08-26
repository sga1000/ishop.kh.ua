<div class="form-group" style="display: inline-block; width: 100%;">
    <label class="col-sm-5 control-label" for="input-google-feeded"><?php echo $entry_google_status; ?></label>
    <div class="col-sm-7">
        <select name="google_feeded" id="input-google-feeded" class="form-control">
            <?php if ($google_feeded) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
</div>
<div class="form-group" style="display: inline-block; width: 100%;">
    <label class="col-sm-5 control-label" for="google-category-name"><?php echo $entry_google_category_used; ?></label>
    <div class="col-sm-7">
        <select name="google_category_id" id="google-category-name" class="form-control">
            <?php if ($google_category_id) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
        </select>
    </div>
</div>
