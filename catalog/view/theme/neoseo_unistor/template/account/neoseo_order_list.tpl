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
            <div class="account-container box-shadow box-corner orders-block">
                <h1><?php echo $heading_title; ?></h1>

                <?php if ($orders) { ?>
                <div class="panel-group" id="accordion">
                    <?php foreach( $orders as $order ) { ?>
                    <div class="panel panel-default">
                        <div class="panel-heading order-list order-start-collapse" data-toggle="collapse" data-parent="#accordion" href="#order<?php echo $order['order_id']; ?>">
                            <div class="order-list-left col-xs-12 col-sm-12 col-md-7 col-lg-8">
                                <div class="panel-title order-list-number col-xs-6 col-sm-3 col-md-2 col-lg-2 text-center">
                                    <span>
                                        <a class="order-list-number" >№ <?php echo $order['order_id']; ?></a>

                                    </span>
                                </div>
                                <div class="order-list-date col-xs-6 col-sm-2 col-md-2 col-lg-2">
                                    <span><?php echo $order['date_added']; ?></span>
                                </div>
                                <div class="order-list-basket hidden-xs col-xs-2 col-sm-4 col-md-3 col-lg-4">
                                    <?php foreach( $order['products'] as $product ) { ?>
                                    <span><a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><img width="40px" height="40px" src="<?php echo $product['thumb']; ?>" alt="img"></a></span>
                                    <?php } ?>
                                </div>
                                <div class="order-list-total-prise hidden-xs col-xs-4 col-sm-4 col-md-5 col-lg-4 text-right">
                                    <span><?php echo $order['quantity']; ?> <?php echo $order['text_quantity']; ?> <b><?php echo $order['total']; ?></b></span>
                                </div>
                                <div class="order-list-print col-xs-4 col-sm-1 col-md-1 col-lg-1 text-center">
                                    <span><a href="<?php echo $order['href']; ?>"><i class="fa fa-info-circle" aria-hidden="true"></i></a></span>
                                </div>
                            </div>
                            <div class="order-list-right hidden-xs hidden-sm col-xs-3 col-sm-2 col-md-5 col-lg-4">
                                <div class="order-list-status col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <span><?php echo $order['status']; ?></span>
                                </div>
                            </div>
                        </div>
                        <div id="order<?php echo $order['order_id']; ?>" class="panel-collapse collapse">
                            <div class="panel-body order-product-list column-portable">
                                <div class="order-product-list_left col-xs-12 col-sm-12 col-md-7 col-lg-8">
                                    <?php foreach( $order['products'] as $product ) { ?>
                                    <div class="product-list-info col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                        <div class="product-list-image col-xs-6 col-sm-2 col-md-2 col-lg-2" >
                                            <a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>">
                                                <img width="100px" height="auto" src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" class="img-responsive">
                                            </a>
                                        </div>

                                        <div class="column-product col-xs-12 col-sm-8 col-md-8 col-lg-8">
                                            <div class="product-list-caption">
                                                <a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><?php echo $product['name']; ?></a>
                                                <p class="product-caption-article"><?php echo $product['model']; ?></p>
                                            </div>
                                            <div class="producr-list-price">
                                                <h5 class="product-caption-price"><?php echo $product['price']; ?></h5>
                                                <p><?php echo $product['quantity']; ?> шт</p>
                                                <h5 class="product-caption-price"></h5>
                                            </div>
                                        </div>

                                        <?php if($product['reorder']){ ?>
                                        <div class="product-list-buy col-xs-12 col-sm-2 col-md-2 col-lg-2">
                                            <button onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');" class="cart-add-button" type="button">
                                                <i class="fa fa-shopping-cart hidden-sm hidden-md hidden-lg"></i>
                                                <span><?php echo $button_cart; ?></span>
                                            </button>
                                            <?php if($neoseo_quick_order_status) { ?>
                                            <a class="buy-one-click" onclick="showQuickOrder('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><?php echo $text_one_click_buy; ?></a>
                                            <?php } ?>
                                        </div>
                                        <?php } ?>

                                    </div>
                                    <?php } ?>
                                </div>
                                <div class="order-product-list_right col-xs-12 col-sm-12 col-md-5 col-lg-4">
                                    <div class="list_right-content column-status col-xs-12 col-sm-12 col-md-12 col-lg-12">

                                        <ul class="list-unstyled">
                                            <li><span class="option-name">Статус:</span><span class="option-value status"><?php echo $order['status']; ?></span></li>
                                            <li><span class="option-name"><?php echo $text_payment_method; ?></span> <span class="option-value"><?php echo $order['payment_method']; ?></span></li>
                                            <li><span class="option-name"><?php echo $text_shipping_method; ?></span> <span class="option-value"><?php echo $order['shipping_method']; ?>, <?php echo $order['shipping_zone']; ?>, <?php echo $order['shipping_city']; ?>, <?php echo $order['shipping_address_1']; ?>  <?php echo $order['shipping_address_2'] ?></span></li>
                                        </ul>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <?php } ?>

                </div>
            </div>
            <div class="text-right"><?php echo $pagination; ?></div>
            <?php } else { ?>
        </div>
        <div class="empty-box box-shadow box-corner">
            <p class="empty-title"><?php echo $text_empty; ?></p>
        </div>
        <?php } ?>
        <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>

<script>
    $('document').ready(function (){
        $('.order-start-collapse').on('click', function (){
            $(this).removeClass('order-start-collapse')
        })
    })
</script>
