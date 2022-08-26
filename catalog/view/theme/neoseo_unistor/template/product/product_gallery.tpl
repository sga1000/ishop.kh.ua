<script src="catalog/view/theme/neoseo_unistor/javascript/jquery.ez-plus.js"></script>
<div class="popupGallery">
    <div class="popupGallery__box">
        <div class="popupGallery__head">
            <div class="popupGallery__title"></div>
            <div class="popupGallery__close"></div>
        </div>
        <div class="popupGallery__content">
            <div class="popupGallery__imageList">
                <div class="popupGallery__imageList-Box">
                    <img href="<?php echo  $thumb; ?>" src="<?php echo $thumb; ?>" data-image="<?php echo  $thumb; ?>" data-zoom-image="<?php echo  $popup; ?>" alt="<?php echo  $heading_title; ?>"/>

                    <?php foreach ($images as $image) { ?>
                    <img href="<?php echo $image['mouseover_thumb']; ?>" src="<?php echo $image['thumb']; ?>" data-zoom-image="<?php echo $image['popup']; ?>" alt="<?php echo $heading_title; ?>"/>
                    <?php } ?>
                </div>
            </div>
            <div class="popupGallery__image"><img src="" data-zoom-image=""></div>
        </div>
    </div>
</div>