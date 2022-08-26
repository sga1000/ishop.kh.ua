<div id="tab-scfields">

    <?php if( count($customer_groups) > 1 ) { ?>
    <?php $i = 0; foreach( $customer_groups as $type => $name ) { $i++; ?>
    <div class="field radiobox custom-radiobox" >
        <input type="radio" id="type-<?php echo $type; ?>" <?php if( $type == $customData['type'] ) { ?> checked="checked" <?php } ?> name="type" value="<?php echo $type; ?>" class="large-field" />
        <label for="type-<?php echo $type; ?>"><?php echo $name; ?>:</label>
    </div>
    <?php } ?>
    <?php } else { ?>
    <input type="hidden" name="type" value="<?php $keys = array_keys($customer_groups); echo $keys[0]; ?>" />
    <?php } ?>

<?php foreach ($customData['fields'] as $type => $fields) { ?>

<div class="types type-<?php echo $type; ?>">

<table class="form">

<?php  foreach ($fields as $field) {
    $type  = $field['type'];
    $name = $field['name'];
    $value =  isset($field['value']) ? $field['value'] : $field['default'];
    $label = $field['label'];
    if( is_array($field['label']) ) {
        $label = $field['label'][$language_id];
    }
    $error_style = isset($errors) && isset($errors[$name]) ? 'style="border:1px solid #f00; background:#F8ACAC;"' : "";
    $error_name = isset($errors) && isset($errors[$name]) ? '<br><span class="error">' . $errors[$name] . '</span>' : "";

    if( !$field['display'] ) {
        continue;
    }

    ?>

<?php if( $type == "input") { ?>
    <tr>
        <td><?php echo $label; ?></td>
        <td><input id="scfield-<?php echo $name; ?>" type="text" name="<?php echo $name; ?>" value="<?php echo $value; ?>" <?php echo $error_style; ?> /> <?php echo $error_name; ?></td>
    </tr>
<?php } else if( $type == "password") { ?>
    <tr>
        <td><?php echo $label; ?></td>
        <td><input id="scfield-<?php echo $name; ?>" type="password" id="guest_<?php echo $name; ?>" name="<?php echo $name; ?>" value="<?php echo $value; ?>" <?php echo $error_style; ?> /> <?php echo $error_name; ?></td>
    </tr>
<?php } else if( $type == "checkbox") { ?>
    <tr>
        <td><?php echo $label; ?></td>
        <td><input id="scfield-<?php echo $name; ?>" type="checkbox" id="guest_<?php echo $name; ?>" name="<?php echo $name; ?>" value="<?php echo $value; ?>" <?php echo $error_style; ?> /> <?php echo $error_name; ?></td>
    </tr>
<?php } else if( $type == "radio") { ?>
    <tr>
        <td><?php echo $label; ?></td>
        <td><input id="scfield-<?php echo $name; ?>" type="radio" id="guest_<?php echo $name; ?>" name="<?php echo $name; ?>" value="<?php echo $value; ?>" <?php echo $error_style; ?> /> <?php echo $error_name; ?></td>
    </tr>
<?php } else if( $type == "textarea") { ?>
    <tr>
        <td><?php echo $label; ?></td>
        <td><textarea id="scfield-<?php echo $name; ?>" name="<?php echo $name; ?>" <?php echo $error_style; ?> > <?php echo $value; ?> </textarea> <?php echo $error_name; ?></td>
    </tr>
<?php } ?>

<?php } ?>

</table>

</div>

<?php } ?>

<script>
<?php if( count($customer_groups) > 1 ) { ?>
    $('[name=type]').click(function(e){
        var type = $(this).val();
        $(".types").hide();
        $(".types input").attr("disabled", true);
        $(".types select").attr("disabled", true);
        $(".types textarea").attr("disabled", true);

        $(".type-" + type).show();
        $(".type-" + type + " input").attr("disabled", false);
        $(".type-" + type + " select").attr("disabled", false);
        $(".type-" + type + " textarea").attr("disabled", false);
    });
    $('#type-<?php echo $customData["type"]; ?>').click();
<?php } ?>

    $(document).ready(function(){
    <?php foreach ($fields as $field) { if( $field['display'] && $field['mask'] ) { ?>
        $("#scfield-<?php echo $field['name']; ?>").mask("<?php echo $field['mask']; ?>");
    <?php } } ?>
    });
</script>

</div>