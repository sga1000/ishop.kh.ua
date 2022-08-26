<?php echo $header; ?>
<div class="container">

    <?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
    <?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } else { ?>
    <?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } ?>
    <div class="brands-box box-shadow box-corner">
        <div class="row"><?php echo $column_left; ?>
            <?php if ($column_left && $column_right) { ?>
            <?php $class = 'col-sm-6'; ?>
            <?php } elseif ($column_left || $column_right) { ?>
            <?php $class = 'col-sm-9'; ?>
            <?php } else { ?>
            <?php $class = 'col-sm-12'; ?>
            <?php } ?>
            <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
                <h1><?php echo $heading_title; ?></h1>
                <?php if ($categories) { ?>
                <p><strong><?php echo $text_index; ?></strong>
                    <?php foreach ($categories as $category) { ?>
                    &nbsp;&nbsp;&nbsp;<a href="index.php?route=product/manufacturer#<?php echo $category['name']; ?>"><?php echo $category['name']; ?></a>
                    <?php } ?>
                </p>
                <?php foreach ($categories as $category) { ?>
                <h2 id="<?php echo $category['name']; ?>"><?php echo $category['name']; ?></h2>
                <?php if ($category['manufacturer']) { ?>
                <?php foreach (array_chunk($category['manufacturer'], 4) as $manufacturers) { ?>
                <div class="row">
                    <?php foreach ($manufacturers as $manufacturer) { ?>
                    <div class="col-sm-3">
                        <a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a></div>
                    <?php } ?>
                </div>
                <?php } ?>
                <?php } ?>
                <?php } ?>
                <?php } else { ?>
                <div class="empty-box box-shadow box-corner">
                    <p class="empty-title"><?php echo $text_empty; ?></p>
                </div>
                <?php } ?>
                <?php echo $content_bottom; ?>
            </div>
            <?php echo $column_right; ?>
        </div>
    </div>
</div>
<?php echo $footer; ?>