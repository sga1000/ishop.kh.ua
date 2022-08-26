<footer>
  <div class="container">
    <div class="row">
      <?php if ($informations) { ?>
      <div class="col-sm-3">
        <h5><?php echo $text_information; ?></h5>
        <ul class="list-unstyled">
          <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
      <?php } ?>
      <div class="col-sm-3">
        <h5><?php echo $text_service; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <h5><?php echo $text_extra; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
          <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
          <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
          <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <h5><?php echo $text_account; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
          <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
        </ul>
      </div>
    </div>
    <hr>
    <p><?php echo $powered; ?></p>
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
<script type="text/javascript">
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
                

<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->

<!-- Theme created by Welford Media for OpenCart 2.0 www.welfordmedia.co.uk -->


<?php if ($neoseo_smart_search_status) { ?>
<!-- NeoSeo Ajax Search - begin -->
<script type="text/javascript">
    $('<?php echo $neoseo_smart_search_selector; ?>')
        .after('<div id="search_main" style="display:none"></div>')
        .keyup(function () {
            var language = "";
            if( window.current_language ) {
                language = window.current_language;
            }
            $.ajax({
                url: language + 'index.php?route=module/neoseo_smart_search',
                type: 'get',
                dataType: 'json',
                data: 'filter_name=' + encodeURIComponent($(this).val()),
                success: function (data) {
                    if (data['content']) {
                        $('#search_main').html(data['content']);
                        $('#search_main').show();
                    } else {
                        $('#search_main').hide();
                    }
                }
            });
        });
</script>
<!-- NeoSeo Ajax Search - end -->
<?php } ?>
                
</body></html>