<?php if (isset($gift_products) && $gift_products) { ?>
<div class="gift-box">
    <h3 class="gift-box__title"><?php echo $title; ?></h3>
    <form action="">
        <?php foreach ($gift_products as $product) { ?>
        <div class="gift-item">
            <a class="gift-item__image" href="<?php echo $product['href']; ?>">
                <img src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>">
            </a>
            <div  class="gift-item__name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
            <button class="gift-item__btn <?php echo $addGiftSelector; ?>" data-product-id="<?php echo $product['product_id']; ?>"><?php echo $button_choose ?></button>
        </div>
        <?php } ?>
    </form>
</div>
<script>

    setTimeout(function () {
        if ($('header .cart .gift-box .gift-item').length === 2  ) {
            $('.cart .gift-box form ').addClass('gift-slider');
            $('.cart .gift-box .gift-slider').owlCarousel({
                items: 2,
                nav: false,
                dots: false,
                navText: ['<i class="fa fa-chevron-left"></i>', '<i class="fa fa-chevron-right"></i>'],
                responsiveClass:true,
                responsive:{
                    0:{
                        items:1,
                        nav:true
                    },
                    768:{
                        items:2,
                        nav:false
                    }
                }
            });
        } else 	if ($('header .gift-box .gift-item').length > 2) {
            $('.gift-box form').addClass('gift-slider');
            $('.gift-box .gift-slider').owlCarousel({
                items: 2,
                nav: true,
                dots: false,
                navText: ['<i class="fa fa-chevron-left"></i>', '<i class="fa fa-chevron-right"></i>'],
                responsiveClass:true,
                responsive:{
                    0:{
                        items:1,
                    },
                    768:{
                        items:2,
                    }
                }
            });
        }
        $('.cart__products-list').css({
            'display' : 'none',
            'opacity' : '1'
        });
    },500);

</script>
<?php } ?>