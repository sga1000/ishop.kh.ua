<?php
$has_data = false;
if ($modules) {
    foreach ($modules as $module) {
        if( trim($module) ) {
            $has_data = true;
            break;
        }
    }
}
if ($has_data) { ?>
<aside id="column-right" class="col-sm-3 hidden-xs">
    <?php foreach ($modules as $module) { ?>
    <?php echo $module; ?>
    <?php } ?>
</aside>
<?php } ?>
