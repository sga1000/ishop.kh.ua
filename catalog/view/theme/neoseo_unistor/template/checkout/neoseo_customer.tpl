<?php if( count($customer_groups) > 1 ) { ?>
<?php foreach( $customer_groups as $type => $name ) { ?>
<div class="field"  <?php if( $neoseo_checkout_compact ) { ?>style="display: inline-block; margin-right: 1em;"<?php } ?> >
    <input type="radio" id="type_<?php echo $type; ?>" <?php if( $type == $type_selected ) { ?> checked="checked" <?php } ?> name="type" value="<?php echo $type; ?>" />
    <label for="type_<?php echo $type; ?>"><?php echo $name; ?>:</label>
</div>
<?php } ?>
<?php } else { ?>
<input type="hidden" name="type" value="<?php $keys = array_keys($customer_groups); echo $keys[0]; ?>" />
<?php } ?>

<?php $i=0; foreach( $fieldset as $type => $fields1 ) { $i++; ?>
<div class="types type-<?php echo $type; ?>" <?php if( $i != 1 ) { ?> style="display:none" <?php } ?> >
<?php echo $fields1; ?>
</div>
<?php } ?>

<script>
<?php if( count($customer_groups) > 1 ) { ?>
    function changeType(type){
        $(".types").hide();
        $(".types input").attr("disabled", true);
        $(".types select").attr("disabled", true);
        $(".types textarea").attr("disabled", true);

        $(".type-" + type).show();
        $(".type-" + type + " input").attr("disabled", false);
        $(".type-" + type + " select").attr("disabled", false);
        $(".type-" + type + " textarea").attr("disabled", false);
        registerChanged();
    }
    $('[name=type]').click(function(e){
        var type = $(this).val();
        changeType(type);
    });
    window.email_required = ( $("[for^=email]:first").html().indexOf('required') > 0 );
    $('[name=type]:checked').trigger('click');

    $('[name=type]').on('ifChanged',function(){
        var type = $(this).val();
        changeType(type);
    });

<?php } else { ?>
    registerChanged();
<?php } ?>

    $('[name=register]').on('ifChanged',function(){
        var type = $(this).val();
        registerChanged();
    });
</script>

