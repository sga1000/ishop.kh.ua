<footer>
    <script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" sync="true" ></script>
    <?php if( $sections[1] || $sections[2] ) { ?>
    <div class="row footer-top">
        <div class="container">
            <div class="col-sm-6 text-left"><?php echo $sections[1]; ?></div>
            <div class="col-sm-6 text-right"><?php echo $sections[2]; ?></div>
        </div>
    </div>
    <?php } ?>
    <div class="footer-middle">
        <div class="container">
            <?php foreach( range(1,4) as $column_id ) { ?>
            <?php if($columns[$column_id]['type'] == "2" ) { ?>
            <!-- Subscrobe form BEGIN -->
            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="subscribe-footer">
                    <h5><?php echo $text_subscribe_title; ?></h5>
                    <div class="subscribe-par"><?php echo $text_subscribe_par; ?></div>
                    <div class="input-group">
                        <input type="text" id="subscribefooter" name="subscribe" placeholder="<?php echo $entry_email; ?>">
                        <button type="submit" onclick="processSubscribe('footer')" class="btn submit-btn" aria-label="Button subscribe">
                            <i class="fa fa-long-arrow-right" aria-hidden="true"></i>
                        </button>
                    </div>
                </div>
                <h5 class="payment-title"><?php echo $text_payments_title; ?></h5>
                <?php echo $sections[5]; ?>
            </div>
            <!-- Subscribe form END -->
            <?php } else { ?>
            <!-- Regular column BEGIN -->
            <div class="footer-list-info col-md-<?php echo $column_id == 1 ? 3 : 3; ?> col-sm-<?php echo $column_id == 1 ? 6 : 6; ?> col-xs-<?php echo $column_id == 1 ? 12 : 12; ?>">
                <h5><?php echo $columns[$column_id]['name']; ?> <i class="fa fa-angle-down" aria-hidden="true"></i></h5>
                <?php if( $columns[$column_id]['type'] == "1" ) { ?>
                <ul class="list-unstyled">
                    <?php foreach ($columns[$column_id]['items'] as $item) { ?>
                    <li><a href="<?php echo $item['href']; ?>"><?php echo $item['name'] ?></a>
                        <?php } ?>
                </ul>
                <?php } else { ?>
                <div class="eshop-info"><?php echo $columns[$column_id]['items']; ?></div>
                <?php } ?>
                <?php if ($column_id == 4) { ?>
                <h5 class="payment-title"><?php echo $text_payments_title; ?></h5>
                <?php echo $sections[5]; ?>
                <?php } ?>
            </div>
            <!-- Regular column END -->
            <?php } // else type != 2 ?>
            <?php } ?>

        </div>
    </div>
    
</footer>

<?php if( $neoseo_google_analytics_remarketing && $neoseo_google_analytics_remarketing['conversion'] ) { ?>
<!-- NeoSeo Google Remarketing Tag -->
<script type="text/javascript">
    var google_tag_params = {
    <?php if( is_array($neoseo_google_analytics_remarketing["ecomm_prodid"]) ) { ?>
        ecomm_prodid: ['<?php echo implode("', '", $neoseo_google_analytics_remarketing["ecomm_prodid"]); ?>'],
    <?php } else { ?>
        ecomm_prodid: '<?php echo $neoseo_google_analytics_remarketing["ecomm_prodid"]; ?>',
    <?php } ?>
    ecomm_pagetype: '<?php echo $neoseo_google_analytics_remarketing["ecomm_pagetype"]; ?>',
    <?php if( is_array($neoseo_google_analytics_remarketing["ecomm_totalvalue"]) ) { ?>
        ecomm_totalvalue: [<?php echo implode(", ",$neoseo_google_analytics_remarketing["ecomm_totalvalue"]); ?>],
    <?php } else { ?>
        ecomm_totalvalue: <?php echo $neoseo_google_analytics_remarketing["ecomm_totalvalue"]; ?>,
    <?php } ?>
    };
</script>
<script>
    var google_conversion_id = <?php echo $neoseo_google_analytics_remarketing['conversion']; ?>;
    var google_custom_params = window.google_tag_params;
    var google_remarketing_only = true;
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js"></script>
<noscript>
    <div style="display:inline;">
        <img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/<?php echo $neoseo_google_analytics_remarketing['conversion']; ?>/?value=0&amp;guid=ON&amp;script=0"/>
    </div>
</noscript>
<!-- End of NeoSeo Google Remarketing Tag -->
<?php } ?>


<script>
    <?php if( "1" == $neoseo_unistor_hover_image ) { ?>
        function hoverableImages(){
            $(".hoverable")
                .mouseover(function() {
                    if($(this).data("over")){
                        $(this).attr("src", $(this).data("over"));
                    }
                })
                .mouseout(function() {
                    if($(this).data("out")){
                        $(this).attr("src", $(this).data("out"));
                    }
                });
        }
        $(window).load(function(){
            hoverableImages();
        });
    <?php } ?>


    $('.footer-middle h5').click(function(){
        if( $(this).css('cursor')!='pointer' ) return;
        $(this).toggleClass('active')
            .next('ul').slideToggle(200);
    });
    $('.footer-middle h5').click(function(){
        if( $(this).css('cursor')!='pointer' ) return;
        $(this).next('.eshop-info').slideToggle(200);
    });

    $(window).resize(function(){
        if($('.footer-middle h5:first').css('cursor')!='pointer' ) {
            $('.footer-middle h5').removeClass('active').next('ul').css('display','block');
        } else {
            $('.footer-middle h5').removeClass('active').next('ul').slideUp(200);
        }
    });
</script>
<?php if ($neoseo_smart_search_status) { ?>
<!-- NeoSeo Ajax Search - begin -->
<script>
    $('<?php echo $neoseo_smart_search_selector; ?>:not(#input-search)')
        .after('<div id="search_main" style="display:none"></div>')
        .keyup(function () {
            if ($('#stiky_box').hasClass('active')) {
                $('<?php echo $neoseo_smart_search_selector; ?>').val($(this).val())
            } else {
                $('#stiky_box <?php echo $neoseo_smart_search_selector; ?>').val($(this).val())
            }
            var language = "";
            if( window.current_language ) {
                language = window.current_language;
            }
            var filter_category = $('.category-list-title').attr('data-categoryid');
            if (filter_category) {
                var filter_category_id = '&filter_category='+filter_category+'&sub_category=true';
            } else {
                var filter_category_id = '';
            }
            $.ajax({
                url: language + 'index.php?route=module/neoseo_smart_search',
                type: 'get',
                dataType: 'json',
                data: 'filter_name=' + encodeURIComponent($(this).val())+filter_category_id,
                success: function (data) {
                    if (data['content']) {
                        $('#search_main, #stiky_box #search_main').html(data['content']);
                        $('#search_main, #stiky_box #search_main').show();
                    } else {
                        $('#search_main, #stiky_box #search_main').hide();
                    }
                }
            });
        });
</script>
<!-- NeoSeo Ajax Search - end -->
<?php } ?>
<script>

$(document).ready(function(){
    if ($('.-quick-buttons-').length > 0) {
        $('.-quick-buttons-').attr('data-toggle','tooltip').attr('title','<?php echo $text_quickview; ?>');
        $('div[data-toggle="tooltip"').tooltip();
    }

})
</script>

</body></html>

