<div class="module">
    <div class="about_us_main box-shadow box-corner">
        <?php if($heading_title) { ?>
        <h3><?php echo $heading_title; ?></h3>
        <?php } ?>
        <div id="about_us_content-<?php echo $module; ?>"><?php echo $html; ?></div>
    </div>
</div>

<?php if ($height) { ?>
<script>
    $('#about_us_content-<?php echo $module; ?>').readmore({
        maxHeight: <?php echo $height; ?>,
    moreLink: '<a class="moreLink" href="#"><span><?php echo $text_read_more; ?></span></a>',
        lessLink: '<a class="moreLink" style=" background: none;" href="#"><span><?php echo $text_read_less; ?></span></a>'
    });
</script>
<?php } ?>