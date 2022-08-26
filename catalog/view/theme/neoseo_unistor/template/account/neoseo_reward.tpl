<?php echo $header; ?>
<div class="container">
    <?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
    <?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } else { ?>
    <?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } ?>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <div class="account-container box-shadow box-corner">
            <h1><?php echo $heading_title; ?></h1>
            <p class='reward-sum'><?php echo $text_total; ?> <b><?php echo $total; ?></b>.</p>
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="row-colored">
                    <tr>
                        <td class="text-left"><?php echo $column_date_added; ?></td>
                        <td class="text-left"><?php echo $column_description; ?></td>
                        <td class="text-right"><?php echo $column_points; ?></td>
                    </tr>
                    </thead>
                    <tbody>
                    <?php if ($rewards) { ?>
                    <?php foreach ($rewards  as $reward) { ?>
                    <tr>
                        <td class="text-left"><?php echo $reward['date_added']; ?></td>
                        <td class="text-left"><?php if ($reward['order_id']) { ?>
                            <a href="<?php echo $reward['href']; ?>"><?php echo $reward['description']; ?></a>
                            <?php } else { ?>
                            <?php echo $reward['description']; ?>
                            <?php } ?>
                        </td>
                        <td class="text-right"><?php echo $reward['points']; ?></td>
                    </tr>
                    <?php } ?>
                    <?php } else { ?>
                    <tr>
                        <td class="text-center bonus-0" colspan="3"><?php echo $text_empty; ?></td>
                    </tr>
                    <?php } ?>
                    </tbody>
                </table>
            </div>
            <div class="row row-results">
                <div class="col-sm-6 text-left"><?php echo $results; ?></div>
                <div class="col-sm-6 text-right"><?php echo $pagination; ?></div>
            </div>
            
            </div>
            <?php echo $content_bottom; ?>
        </div>
        <?php echo $column_right; ?>
    </div>
</div>
<?php echo $footer; ?>