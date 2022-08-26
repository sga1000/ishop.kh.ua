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
        <div id="content" class=" <?php echo $class; ?>"><?php echo $content_top; ?>
            <div class="personal-area-container">
                <h1><?php echo $heading_title; ?></h1>
                <?php if ($orders) { ?>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <td class="text-right"><?php echo $column_order_id; ?></td>
                            <td class="text-left"><?php echo $column_status; ?></td>
                            <td class="text-left"><?php echo $column_date_added; ?></td>
                            <td class="text-right"><?php echo $column_product; ?></td>
                            <td class="text-left"><?php echo $column_customer; ?></td>
                            <td class="text-right"><?php echo $column_total; ?></td>
                            <td></td>
                        </tr>
                        </thead>
                        <tbody>
                        <?php foreach ($orders as $order) { ?>
                        <tr>
                            <td class="text-right">#<?php echo $order['order_id']; ?></td>
                            <td class="text-left"><?php echo $order['status']; ?></td>
                            <td class="text-left"><?php echo $order['date_added']; ?></td>
                            <td class="text-right"><?php echo $order['products']; ?></td>
                            <td class="text-left"><?php echo $order['name']; ?></td>
                            <td class="text-right"><?php echo $order['total']; ?></td>
                            <td class="text-right">
                                <a href="<?php echo $order['href']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info"><i class="fa fa-eye"></i></a>
                            </td>
                        </tr>
                        <?php } ?>
                        </tbody>
                    </table>
                </div>
                <div class="text-right"><?php echo $pagination; ?></div>
                <?php } else { ?>
                <p><?php echo $text_empty; ?></p>
                <?php } ?>
            </div>
            <?php echo $content_bottom; ?></div>
        <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>