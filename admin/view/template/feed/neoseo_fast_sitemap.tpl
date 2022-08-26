<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_fast_sitemap_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if( !isset($license_error) ) { ?>
                <a onclick="$('#form').attr('action', '<?php echo $save; ?>'); $('#form').submit();" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></a>
                <a onclick="$('#form').attr('action', '<?php echo $save_and_close; ?>'); $('#form').submit();" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></a>
                <?php } else { ?>
                <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
                <?php } ?>
                <a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
            </div>
            <img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
            <h1><?php echo $heading_title_raw . " " . $text_module_version; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>

    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger">
            <i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <?php if (isset($success) && $success) { ?>
        <div class="alert alert-success">
            <i class="fa fa-check-circle"></i>
            <?php echo $success; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-body">

                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                    <?php if( !isset($license_error) ) { ?><li><a href="#tab-store" data-toggle="tab"><?php echo $tab_store; ?></a></li><?php } ?>
                    <?php if( !isset($license_error) ) { ?><li><a href="#tab-blog" data-toggle="tab"><?php echo $tab_blog; ?></a></li><?php } ?>
                    <?php if( !isset($license_error) ) { ?><li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li><?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>

                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            <?php if( !isset($license_error) ) { ?>

                            <?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('seo_status',array( 0 => $text_seo_0, 1 => $text_seo_1, 2 => $text_seo_2)); ?>
                            <?php $widgets->dropdown('seo_url_include_path',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('seo_lang_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php if( $hasAddresses ) { ?>
                            <?php $widgets->dropdown('addresses_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php } ?>
                            <?php $widgets->dropdown('partition_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->input('partition_volume',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('multistore_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('gzip_status', array( 0 => $text_gzip_0, 1 => $text_gzip_1, 2 => $text_gzip_2, 3 => $text_gzip_3, 4 => $text_gzip_4, 5 => $text_gzip_5, 6 => $text_gzip_6, 7 => $text_gzip_7, 8 => $text_gzip_8, 9 => $text_gzip_9)); ?>
                            <?php $widgets->dropdown('image_status', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->text('url'); ?>

                            <?php } else { ?>

                            <?php echo $license_error; ?>

                            <?php } ?>
                        </div>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-store">

                            <ul class="nav nav-pills col-sm-2">
                                <li class="active"><a href="#tab-store-information" data-toggle="tab"><?php echo $tab_store_information; ?></a></li>
                                <li><a href="#tab-store-category" data-toggle="tab"><?php echo $tab_store_category; ?></a></li>
                                <li><a href="#tab-store-manufacturer" data-toggle="tab"><?php echo $tab_store_manufacturer; ?></a></li>
                                <li><a href="#tab-store-product" data-toggle="tab"><?php echo $tab_store_product; ?></a></li>
                            </ul>
                            <div class="tab-content col-sm-10">
                                <div class="tab-pane active" id="tab-store-information">
                                    <?php $widgets->dropdown('information_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('information_url_frequency'); ?>
                                    <?php $widgets->input('information_url_priority'); ?>
                                </div>
                                <div class="tab-pane" id="tab-store-category">
                                    <?php $widgets->dropdown('category_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('category_brand_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('filterpro_seo_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('filtervier_seo_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('ocfilter_seo_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('mfilter_seo_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('filter_seo_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('category_url_date', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('category_url_frequency'); ?>
                                    <?php $widgets->input('category_url_priority'); ?>
                                </div>
                                <div class="tab-pane" id="tab-store-manufacturer">
                                    <?php $widgets->dropdown('manufacturer_status', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('manufacturer_line_by_tima',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('manufacturer_url_frequency'); ?>
                                    <?php $widgets->input('manufacturer_url_priority'); ?>
                                </div>
                                <div class="tab-pane" id="tab-store-product">
                                    <?php $widgets->dropdown('product_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('product_url_date', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('product_url_frequency'); ?>
                                    <?php $widgets->input('product_url_priority'); ?>
                                </div>
                            </div>

                        </div>
                        <?php } ?>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-blog">
                            <ul class="nav nav-pills col-sm-2">
                                <li class="active"><a href="#tab-blog-module" data-toggle="tab"><?php echo $tab_blog_module; ?></a></li>
                                <li><a href="#tab-blog-category" data-toggle="tab"><?php echo $tab_blog_category; ?></a></li>
                                <li><a href="#tab-blog-author" data-toggle="tab"><?php echo $tab_blog_author; ?></a></li>
                                <li><a href="#tab-blog-article" data-toggle="tab"><?php echo $tab_blog_article; ?></a></li>
                            </ul>
                            <div class="tab-content col-sm-10">
                                <div class="tab-pane active" id="tab-blog-module">
                                    <?php $widgets->dropdown('blog_freecart_status', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('blog_seocms_status', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('blog_pavo_status', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('blog_blogmanager_status', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                </div>
                                <div class="tab-pane" id="tab-blog-category">
                                    <?php $widgets->dropdown('blog_category_status', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('blog_category_url_date', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('blog_category_url_frequency'); ?>
                                    <?php $widgets->input('blog_category_url_priority'); ?>
                                </div>
                                <div class="tab-pane" id="tab-blog-author">
                                    <?php $widgets->dropdown('blog_author_status', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('blog_author_url_date', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('blog_author_url_frequency'); ?>
                                    <?php $widgets->input('blog_author_url_priority'); ?>
                                </div>
                                <div class="tab-pane" id="tab-blog-article">
                                    <?php $widgets->dropdown('blog_article_status', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('blog_article_url_date', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('blog_article_url_frequency'); ?>
                                    <?php $widgets->input('blog_article_url_priority'); ?>
                                </div>
                            </div>
                        </div>
                        <?php } ?>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-logs">
                            <?php $widgets->debug_and_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $button_clear_log ); ?>
                            <textarea style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
                        </div>
                        <?php } ?>

                        <div class="tab-pane" id="tab-support">
                            <?php echo $mail_support; ?>
                        </div>

                        <div class="tab-pane" id="tab-license">
                            <?php echo $module_licence; ?>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<style>.nav-pills > li { width: 100% }</style>
<?php echo $footer; ?>