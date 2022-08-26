<ul id="menu">
  <li id="dashboard"><a href="<?php echo $home; ?>"><i class="fa fa-dashboard fa-fw"></i> <span><?php echo $text_dashboard; ?></span></a></li>
  <!-- NeoSeo Unistor -->
  <?php if($neoseo_unistor) { ?>
  <li><a href="<?php echo $neoseo_unistor; ?>"><i class="fa fa-magic fa-fw"></i> <span><?php echo $text_neoseo_unistor; ?></span></a></li>
  <?php } ?>
  <!-- NeoSeo Unistor- end -->
  <li id="catalog"<?php echo $catalog_style; ?>><a class="parent"><i class="fa fa-tags fa-fw"></i> <span><?php echo $text_catalog; ?></span></a>
    <ul>
      <li<?php echo $category_style; ?>><a href="<?php echo $category; ?>"><?php echo $text_category; ?></a></li>
      <li<?php echo $product_style; ?>><a href="<?php echo $product; ?>"><?php echo $text_product; ?></a></li>
      <li<?php echo $recurring_style; ?>><a href="<?php echo $recurring; ?>"><?php echo $text_recurring; ?></a></li>
      <li<?php echo $filter_style; ?>><a href="<?php echo $filter; ?>"><?php echo $text_filter; ?></a></li>
      <li<?php echo $attribute_menu_style; ?>><a class="parent"><?php echo $text_attribute; ?></a>
        <ul>
          <li<?php echo $attribute_style; ?>><a href="<?php echo $attribute; ?>"><?php echo $text_attribute; ?></a></li>
          <li<?php echo $attribute_group_style; ?>><a href="<?php echo $attribute_group; ?>"><?php echo $text_attribute_group; ?></a></li>
        </ul>
      </li>
      <li<?php echo $option_style; ?>><a href="<?php echo $option; ?>"><?php echo $text_option; ?></a></li>
      <li<?php echo $manufacturer_style; ?>><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
      <li<?php echo $download_style; ?>><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
      <?php if ($neoseo_testimonials) { ?>
      <li><a href="<?php echo $neoseo_testimonials; ?>"><?php echo $text_neoseo_testimonials; ?></a></li>
      <?php } ?>
      <li<?php echo $review_style; ?>><a href="<?php echo $review; ?>"><?php echo $text_review; ?></a></li>
      <li<?php echo $information_style; ?>><a href="<?php echo $information; ?>"><?php echo $text_information; ?></a></li>
      <!-- NeoSeo Action Manager - begin -->
      <?php if ($neoseo_action_manager) { ?>
      <li><a href="<?php echo $neoseo_action_manager; ?>"><?php echo $text_neoseo_action_manager; ?></a></li>
      <?php } ?>
      <!-- NeoSeo Action Manager - end -->
    </ul>
  </li>
  <li id="extension"<?php echo $extension_style; ?>><a class="parent"><i class="fa fa-puzzle-piece fa-fw"></i> <span><?php echo $text_extension; ?></span></a>
    <ul>
      <li<?php echo $installer_style; ?>><a href="<?php echo $installer; ?>"><?php echo $text_installer; ?></a></li>
      <li<?php echo $modification_style; ?>><a href="<?php echo $modification; ?>"><?php echo $text_modification; ?></a></li>
      <li<?php echo $analytics_style; ?>><a href="<?php echo $analytics; ?>"><?php echo $text_analytics; ?></a></li>
      <li<?php echo $captcha_style; ?>><a href="<?php echo $captcha; ?>"><?php echo $text_captcha; ?></a></li>
      <li<?php echo $feed_style; ?>><a href="<?php echo $feed; ?>"><?php echo $text_feed; ?></a></li>
      <li<?php echo $fraud_style; ?>><a href="<?php echo $fraud; ?>"><?php echo $text_fraud; ?></a></li>
      <li<?php echo $module_style; ?>><a href="<?php echo $module; ?>"><?php echo $text_module; ?></a></li>
      <li<?php echo $payment_style; ?>><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
      <li<?php echo $shipping_style; ?>><a href="<?php echo $shipping; ?>"><?php echo $text_shipping; ?></a></li>
      <li<?php echo $total_style; ?>><a href="<?php echo $total; ?>"><?php echo $text_total; ?></a></li>
      <?php if ($openbay_show_menu == 1) { ?>
      <li<?php echo $openbay_extension_style; ?>><a class="parent"><?php echo $text_openbay_extension; ?></a>
        <ul>
          <li<?php echo $openbay_link_extension_style; ?>><a href="<?php echo $openbay_link_extension; ?>"><?php echo $text_openbay_dashboard; ?></a></li>
          <li<?php echo $openbay_link_orders_style; ?>><a href="<?php echo $openbay_link_orders; ?>"><?php echo $text_openbay_orders; ?></a></li>
          <li<?php echo $openbay_link_items_style; ?>><a href="<?php echo $openbay_link_items; ?>"><?php echo $text_openbay_items; ?></a></li>
          <?php if ($openbay_markets['ebay'] == 1) { ?>
          <li<?php echo $openbay_ebay_style; ?>><a class="parent"><?php echo $text_openbay_ebay; ?></a>
            <ul>
              <li<?php echo $openbay_link_ebay_style; ?>><a href="<?php echo $openbay_link_ebay; ?>"><?php echo $text_openbay_dashboard; ?></a></li>
              <li<?php echo $openbay_link_ebay_settings; ?>><a href="<?php echo $openbay_link_ebay_settings; ?>"><?php echo $text_openbay_settings; ?></a></li>
              <li<?php echo $openbay_link_ebay_links_style; ?>><a href="<?php echo $openbay_link_ebay_links; ?>"><?php echo $text_openbay_links; ?></a></li>
              <li<?php echo $openbay_link_ebay_orderimport_style; ?>><a href="<?php echo $openbay_link_ebay_orderimport; ?>"><?php echo $text_openbay_order_import; ?></a></li>
            </ul>
          </li>
          <?php } ?>
          <?php if ($openbay_markets['amazon'] == 1) { ?>
          <li<?php echo $openbay_amazon_style; ?>><a class="parent"><?php echo $text_openbay_amazon; ?></a>
            <ul>
              <li<?php echo $openbay_link_amazon_style; ?>><a href="<?php echo $openbay_link_amazon; ?>"><?php echo $text_openbay_dashboard; ?></a></li>
              <li<?php echo $openbay_link_amazon_settings_style; ?>><a href="<?php echo $openbay_link_amazon_settings; ?>"><?php echo $text_openbay_settings; ?></a></li>
              <li<?php echo $openbay_link_amazon_links_style; ?>><a href="<?php echo $openbay_link_amazon_links; ?>"><?php echo $text_openbay_links; ?></a></li>
            </ul>
          </li>
          <?php } ?>
          <?php if ($openbay_markets['amazonus'] == 1) { ?>
          <li<?php echo $openbay_amazonus_style; ?>><a class="parent"><?php echo $text_openbay_amazonus; ?></a>
            <ul>
              <li<?php echo $openbay_link_amazonus_style; ?>><a href="<?php echo $openbay_link_amazonus; ?>"><?php echo $text_openbay_dashboard; ?></a></li>
              <li<?php echo $openbay_link_amazonus_settings_style; ?>><a href="<?php echo $openbay_link_amazonus_settings; ?>"><?php echo $text_openbay_settings; ?></a></li>
              <li<?php echo $openbay_link_amazonus_links_style; ?>><a href="<?php echo $openbay_link_amazonus_links; ?>"><?php echo $text_openbay_links; ?></a></li>
            </ul>
          </li>
          <?php } ?>
          <?php if ($openbay_markets['etsy'] == 1) { ?>
          <li<?php echo $openbay_etsy_style; ?>><a class="parent"><?php echo $text_openbay_etsy; ?></a>
            <ul>
              <li<?php echo $openbay_link_etsy_style; ?>><a href="<?php echo $openbay_link_etsy; ?>"><?php echo $text_openbay_dashboard; ?></a></li>
              <li<?php echo $openbay_link_etsy_settings_style; ?>><a href="<?php echo $openbay_link_etsy_settings; ?>"><?php echo $text_openbay_settings; ?></a></li>
              <li<?php echo $openbay_link_etsy_links_style; ?>><a href="<?php echo $openbay_link_etsy_links; ?>"><?php echo $text_openbay_links; ?></a></li>
            </ul>
          </li>
          <?php } ?>
        </ul>
      </li>
      <?php } ?>
    </ul>
  </li>
  <!-- NeoSeo Improvement - begin -->
  <li id="neoseo_improvement"><a class="parent"><i class="fa fa-star"></i> <span><?php echo $text_improvement; ?></span></a>
    <ul>
      <li><a href="<?php echo $main_page; ?>"><?php echo $text_main_page; ?></a></li>
      <li><a href="<?php echo $category_page; ?>"><?php echo $text_category_page; ?></a></li>
      <li><a href="<?php echo $product_page; ?>"><?php echo $text_product_page; ?></a></li>
      <li><a href="<?php echo $checkout_page; ?>"><?php echo $text_checkout_page; ?></a></li>
      <li><a href="<?php echo $account_page; ?>"><?php echo $text_account_page; ?></a></li>
      <li><a href="<?php echo $admin_home_page; ?>"><?php echo $text_admin_home_page; ?></a></li>
      <li><a href="<?php echo $integration_services; ?>"><?php echo $text_integration_services; ?></a></li>
      <li><a href="<?php echo $adding_products; ?>"><?php echo $text_adding_products; ?></a></li>
      <li><a href="<?php echo $technical_modules; ?>"><?php echo $text_technical_modules; ?></a></li>
      <li><a href="<?php echo $advancement; ?>"><?php echo $text_advancement; ?></a></li>
    </ul>
  </li>
  <!-- NeoSeo Improvement - end -->
  <li id="design"<?php echo $design_style; ?>><a class="parent"><i class="fa fa-television fa-fw"></i> <span><?php echo $text_design; ?></span></a>
    <ul>
      <!-- NeoSeo Unistor -->
      <?php if($neoseo_unistor) { ?>
      <li><a href="<?php echo $neoseo_unistor; ?>"><?php echo $text_neoseo_unistor; ?></a></li>
      <?php } ?>
      <!-- NeoSeo Unistor- end -->
      <li<?php echo $layout_style; ?>><a href="<?php echo $layout; ?>"><?php echo $text_layout; ?></a></li>
      <li<?php echo $banner_style; ?>><a href="<?php echo $banner; ?>"><?php echo $text_banner; ?></a></li>
    </ul>
  </li>
  <!-- NeoSeo Blog - begin -->
  <li id="blog" <?php echo $blog_style; ?>><a class="parent"><i class="fa fa-file-text-o fa-fw"></i> <span><?php echo $text_blogs; ?></span></a>
      <ul>
          <li <?php echo $blog_category_style; ?>><a href="<?php echo $blog_category; ?>"><?php echo $text_blog_category; ?></a></li>
          <li <?php echo $blog_author_style; ?>><a href="<?php echo $blog_author; ?>"><?php echo $text_blog_author; ?></a></li>
          <li <?php echo $blog_article_style; ?>><a href="<?php echo $blog_article; ?>"><?php echo $text_blog_article; ?></a></li>
          <li <?php echo $blog_comment_style; ?>><a href="<?php echo $blog_comment; ?>"><?php echo $text_blog_comment; ?></a></li>
          <li <?php echo $blog_report_style; ?>><a href="<?php echo $blog_report; ?>"><?php echo $text_blog_report; ?></a></li>
      </ul>
  </li>
  <!-- NeoSeo Blog - end -->
  <li id="sale"<?php echo $sale_style; ?>><a class="parent"><i class="fa fa-shopping-cart fa-fw"></i> <span><?php echo $text_sale; ?></span></a>
    <ul>
      <li<?php echo $order_style; ?>><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
      <!-- NeoSeo Checkout - begin -->
      <?php if(isset($dropped_cart)) { ?><li><a href="<?php echo $dropped_cart; ?>"><?php echo $text_dropped_cart; ?></a></li><?php } ?>
      <!-- NeoSeo Checkout - end -->
      <?php if ($neoseo_callback) { ?>
      <li><a href="<?php echo $neoseo_callback; ?>"><?php echo $text_neoseo_callback; ?></a></li>
      <?php } ?>
      <li<?php echo $order_recurring_style; ?>><a href="<?php echo $order_recurring; ?>"><?php echo $text_order_recurring; ?></a></li>
      <li<?php echo $return_style; ?>><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
      <li<?php echo $voucher_parent_style; ?>><a class="parent"><?php echo $text_voucher; ?></a>
        <ul>
          <li<?php echo $voucher_style; ?>><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
          <li<?php echo $voucher_theme_style; ?>><a href="<?php echo $voucher_theme; ?>"><?php echo $text_voucher_theme; ?></a></li>
        </ul>
      </li>
      <li<?php echo $paypal_style; ?>><a class="parent"><?php echo $text_paypal ?></a>
        <ul>
          <li<?php echo $paypal_search_style; ?>><a href="<?php echo $paypal_search ?>"><?php echo $text_paypal_search ?></a></li>
        </ul>
      </li>
    </ul>
  </li>
  <li id="setting"<?php echo $customer_parent_style; ?>><a class="parent"><i class="fa fa-user fa-fw"></i> <span><?php echo $text_customer; ?></span></a>
    <ul>
      <li<?php echo $customer_style; ?>><a href="<?php echo $customer; ?>"><?php echo $text_customer; ?></a></li>
       <!-- NeoSeo Subscribe - begin -->
      <?php if( isset($neoseo_subscribe_status) && $neoseo_subscribe_status == 1) { ?>
            <li><a href="<?php echo $neoseo_subscribe; ?>"><?php echo $text_neoseo_subscribe; ?></a></li>
      <?php } ?>
      <!-- NeoSeo Subscribe - end -->
      <li<?php echo $customer_group_style; ?>><a href="<?php echo $customer_group; ?>"><?php echo $text_customer_group; ?></a></li>
      <li<?php echo $custom_field_style; ?>><a href="<?php echo $custom_field; ?>"><?php echo $text_custom_field; ?></a></li>
    </ul>
  </li>
  <li<?php echo $marketing_parent_style; ?>><a class="parent"><i class="fa fa-share-alt fa-fw"></i> <span><?php echo $text_marketing; ?></span></a>
    <ul>
      <li<?php echo $marketing_style; ?>><a href="<?php echo $marketing; ?>"><?php echo $text_marketing; ?></a></li>
      <li<?php echo $affiliate_style; ?>><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
      <li<?php echo $coupon_style; ?>><a href="<?php echo $coupon; ?>"><?php echo $text_coupon; ?></a></li>
      <li<?php echo $contact_style; ?>><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
    </ul>
  </li>
  <li id="system"<?php echo $system_style; ?>><a class="parent"><i class="fa fa-cog fa-fw"></i> <span><?php echo $text_system; ?></span></a>
    <ul>
      <li<?php echo $setting_style; ?>><a href="<?php echo $setting; ?>"><?php echo $text_setting; ?></a></li>
      <li<?php echo $user_parent_style; ?>><a class="parent"><?php echo $text_users; ?></a>
        <ul>
          <li<?php echo $user_style; ?>><a href="<?php echo $user; ?>"><?php echo $text_user; ?></a></li>
          <li<?php echo $user_group_style; ?>><a href="<?php echo $user_group; ?>"><?php echo $text_user_group; ?></a></li>
          <li<?php echo $api_style; ?>><a href="<?php echo $api; ?>"><?php echo $text_api; ?></a></li>
        </ul>
      </li>
      <li<?php echo $localisation_parent_style; ?>><a class="parent"><?php echo $text_localisation; ?></a>
        <ul>
          <li<?php echo $location_style; ?>><a href="<?php echo $location; ?>"><?php echo $text_location; ?></a></li>
          <li<?php echo $language_style; ?>><a href="<?php echo $language; ?>"><?php echo $text_language; ?></a></li>
          <li<?php echo $currency_style; ?>><a href="<?php echo $currency; ?>"><?php echo $text_currency; ?></a></li>
          <li<?php echo $stock_status_style; ?>><a href="<?php echo $stock_status; ?>"><?php echo $text_stock_status; ?></a></li>
          <li<?php echo $order_status_style; ?>><a href="<?php echo $order_status; ?>"><?php echo $text_order_status; ?></a></li>
          <li<?php echo $return_style; ?>><a class="parent"><?php echo $text_return; ?></a>
            <ul>
              <li<?php echo $return_status_style; ?>><a href="<?php echo $return_status; ?>"><?php echo $text_return_status; ?></a></li>
              <li<?php echo $return_action_style; ?>><a href="<?php echo $return_action; ?>"><?php echo $text_return_action; ?></a></li>
              <li<?php echo $return_reason_style; ?>><a href="<?php echo $return_reason; ?>"><?php echo $text_return_reason; ?></a></li>
            </ul>
          </li>
          <li<?php echo $country_style; ?>><a href="<?php echo $country; ?>"><?php echo $text_country; ?></a></li>
          <li<?php echo $zone_style; ?>><a href="<?php echo $zone; ?>"><?php echo $text_zone; ?></a></li>
          <!-- NeoSeo Checkout - begin -->
          <?php if( isset($address) ) { ?>
          <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
          <?php } ?>
          <?php if( isset($city) ) { ?>
          <li><a href="<?php echo $city; ?>"><?php echo $text_city; ?></a></li>
          <?php } ?>
          <!-- NeoSeo Checkout - end -->
          <li<?php echo $geo_zone_style; ?>><a href="<?php echo $geo_zone; ?>"><?php echo $text_geo_zone; ?></a></li>
          <li<?php echo $tax_style; ?>><a class="parent"><?php echo $text_tax; ?></a>
            <ul>
              <li<?php echo $tax_class_style; ?>><a href="<?php echo $tax_class; ?>"><?php echo $text_tax_class; ?></a></li>
              <li<?php echo $tax_rate_style; ?>><a href="<?php echo $tax_rate; ?>"><?php echo $text_tax_rate; ?></a></li>
            </ul>
          </li>
          <li<?php echo $length_class_style; ?>><a href="<?php echo $length_class; ?>"><?php echo $text_length_class; ?></a></li>
          <li<?php echo $weight_class_style; ?>><a href="<?php echo $weight_class; ?>"><?php echo $text_weight_class; ?></a></li>
        </ul>
      </li>
      <li<?php echo $tools_style; ?>><a class="parent"><?php echo $text_tools; ?></a>
        <ul>
          <li<?php echo $upload_style; ?>><a href="<?php echo $upload; ?>"><?php echo $text_upload; ?></a></li>
          <?php if ($neoseo_order_referrer) { ?>
          <li><a href="<?php echo $neoseo_order_referrer; ?>"><?php echo $text_neoseo_order_referrer; ?></a></li>
          <?php } ?>
          <li<?php echo $backup_style; ?>><a href="<?php echo $backup; ?>"><?php echo $text_backup; ?></a></li>
          <?php if ($neoseo_route_manager) { ?>
          <li><a href="<?php echo $neoseo_route_manager; ?>"><?php echo $text_neoseo_route_manager; ?></a></li>
          <?php } ?>
          <?php if( isset($neoseo_robots_generator_status) && $neoseo_robots_generator_status == 1) { ?>
          <li><a href="<?php echo $neoseo_robots_generator; ?>"><?php echo $text_neoseo_robots_generator; ?></a></li>
          <?php } ?>
            
          <li<?php echo $error_log_style; ?>><a href="<?php echo $error_log; ?>"><?php echo $text_error_log; ?></a></li>
        </ul>
      </li>
    </ul>
  </li>
  <li id="reports"<?php echo $reports_style; ?>><a class="parent"><i class="fa fa-bar-chart-o fa-fw"></i> <span><?php echo $text_reports; ?></span></a>
    <ul>
      <li<?php echo $report_sale_style; ?>><a class="parent"><?php echo $text_sale; ?></a>
        <ul>
          <li<?php echo $report_sale_order_style; ?>><a href="<?php echo $report_sale_order; ?>"><?php echo $text_report_sale_order; ?></a></li>
          <li<?php echo $report_sale_tax_style; ?>><a href="<?php echo $report_sale_tax; ?>"><?php echo $text_report_sale_tax; ?></a></li>
          <li<?php echo $report_sale_shipping_style; ?>><a href="<?php echo $report_sale_shipping; ?>"><?php echo $text_report_sale_shipping; ?></a></li>
          <li<?php echo $report_sale_return_style; ?>><a href="<?php echo $report_sale_return; ?>"><?php echo $text_report_sale_return; ?></a></li>
          <li<?php echo $report_sale_coupon_style; ?>><a href="<?php echo $report_sale_coupon; ?>"><?php echo $text_report_sale_coupon; ?></a></li>
        </ul>
      </li>
      <li<?php echo $report_product_style; ?>><a class="parent"><?php echo $text_product; ?></a>
        <ul>
          <li<?php echo $report_product_viewed_style; ?>><a href="<?php echo $report_product_viewed; ?>"><?php echo $text_report_product_viewed; ?></a></li>
          <li<?php echo $report_product_purchased_style; ?>><a href="<?php echo $report_product_purchased; ?>"><?php echo $text_report_product_purchased; ?></a></li>
        </ul>
      </li>
      <li<?php echo $report_customer_style; ?>><a class="parent"><?php echo $text_customer; ?></a>
        <ul>
          <li<?php echo $report_customer_online_style; ?>><a href="<?php echo $report_customer_online; ?>"><?php echo $text_report_customer_online; ?></a></li>
          <li<?php echo $report_customer_activity_style; ?>><a href="<?php echo $report_customer_activity; ?>"><?php echo $text_report_customer_activity; ?></a></li>
          <li<?php echo $report_customer_order_style; ?>><a href="<?php echo $report_customer_order; ?>"><?php echo $text_report_customer_order; ?></a></li>
          <li<?php echo $report_customer_reward_style; ?>><a href="<?php echo $report_customer_reward; ?>"><?php echo $text_report_customer_reward; ?></a></li>
          <li<?php echo $report_customer_credit_style; ?>><a href="<?php echo $report_customer_credit; ?>"><?php echo $text_report_customer_credit; ?></a></li>
        </ul>
      </li>
      <li<?php echo $report_parent_marketing_style; ?>><a class="parent"><?php echo $text_marketing; ?></a>
        <ul>
          <li<?php echo $report_marketing_style; ?>><a href="<?php echo $report_marketing; ?>"><?php echo $text_marketing; ?></a></li>
          <li<?php echo $report_affiliate; ?>><a href="<?php echo $report_affiliate; ?>"><?php echo $text_report_affiliate; ?></a></li>
          <li<?php echo $report_affiliate_activity_style; ?>><a href="<?php echo $report_affiliate_activity; ?>"><?php echo $text_report_affiliate_activity; ?></a></li>
        </ul>
      </li>
    </ul>
  </li>
</ul>
<div class="qs-menu">
  <a href="<?php echo $qs_stepped_link; ?>"><span class="rocket-text"><?php echo $text_qs; ?></span><?php echo $text_qs_rocket; ?></a>
</div>