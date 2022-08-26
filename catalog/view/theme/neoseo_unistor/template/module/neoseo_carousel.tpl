<div class="module">
    <div class="carousel-container box-shadow box-corner">
        <h3><?php echo $header_title ?></h3>
        <div id="carousel<?php echo $module; ?>" class="owl-carousel">
            <?php foreach ($banners as $banner) { ?>
            <div class="item text-center">
                <?php if ($banner['link']) { ?>
                <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
                <?php } else { ?>
                <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>"  />
                <?php } ?>
            </div>
            <?php } ?>
        </div>
    </div>
</div>
<script>
    $('#carousel<?php echo $module; ?>').owlCarousel({
        loop:true,
        items:6,
        dots: false,
        nav: true,
        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
        autoplay: true,
        autoplayTimeout: 3000,
        responsiveClass:true,
        responsive:{
            0:{
                items:2,
                nav:true
            },
            768:{
                items:4,
                nav:true
            },
            1199:{
                items:6,
                nav:true
            }
        }
    });
</script>