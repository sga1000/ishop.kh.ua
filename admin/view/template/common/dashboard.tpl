<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_install) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_install; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if(false) { ?>
    <div class="row">
      <div class="col-lg-3 col-md-3 col-sm-6"><?php echo $order; ?></div>
      <div class="col-lg-3 col-md-3 col-sm-6"><?php echo $sale; ?></div>
      <div class="col-lg-3 col-md-3 col-sm-6"><?php echo $customer; ?></div>
      <div class="col-lg-3 col-md-3 col-sm-6"><?php echo $online; ?></div>
    </div>
    <div class="row">
      <div class="col-lg-6 col-md-12 col-sx-12 col-sm-12"><?php echo $map; ?></div>
      <div class="col-lg-6 col-md-12 col-sx-12 col-sm-12"><?php echo $chart; ?></div>
    </div>
    <div class="row">
      <div class="col-lg-4 col-md-12 col-sm-12 col-sx-12"><?php echo $activity; ?></div>
      <div class="col-lg-8 col-md-12 col-sm-12 col-sx-12"> <?php echo $recent; ?> </div>
    </div>
    <?php } ?>
    <div class="row">

      <!-- NeoSeo Callback Widget - begin -->
    <?php if(isset($neoseo_callback_widget)) { ?>
      <div class="tile-dash-wrapper col-lg-3 col-md-6 col-sm-6"> <?php echo $neoseo_callback_widget; ?> </div>
    <?php } ?>
    <!-- NeoSeo Callback Widget - end -->
    <!-- Neoseo Testimonials Widget - begin -->
    <?php if(isset($neoseo_testimonials_widget)) { ?>
      <div class="tile-dash-wrapper col-lg-3 col-md-6 col-sm-6"> <?php echo $neoseo_testimonials_widget; ?> </div>
    <?php } ?>
    <!-- Neoseo Testimonials Widget - end -->
    <!-- Neoseo Review Widget - begin -->
    <?php if(isset($neoseo_review_widget)) { ?>
      <div class="tile-dash-wrapper col-lg-3 col-md-6 col-sm-6"> <?php echo $neoseo_review_widget; ?> </div>
    <?php } ?>
    <!-- Neoseo Review Widget - end -->
    <!-- NeoSeo Broken Links Widget - begin -->
    <?php if(isset($neoseo_broken_links_widget)) { ?>
      <div class="tile-dash-wrapper col-lg-3 col-md-6 col-sm-6"> <?php echo $neoseo_broken_links_widget; ?> </div>
    <?php } ?>
    <!-- NeoSeo Broken Links Widget - end -->
    </div>

    <div class="row block-flex">


      <!-- NeoSeo Dropped Cart Widget - begin -->
      <?php if(isset($neoseo_dropped_cart_widget)) { ?>
        <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12"> <?php echo $neoseo_dropped_cart_widget; ?> </div>
      <?php } ?>
      <!-- NeoSeo Dropped Cart Widget  - end -->

      <!-- NeoSeo Widget Orders - begin -->
      <?php if(isset($neoseo_widget_orders)) { ?>
        <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12"> <?php echo $neoseo_widget_orders; ?> </div>
      <?php } ?>
      <!-- NeoSeo Widget Orders - end -->

    </div>

    <div class="row">
    <div class="col-xs-12 col-md-6">
      <!-- NeoSeo Backup Widget- begin -->
      <?php if(isset($neoseo_backup_widget)) { ?>
      <?php echo $neoseo_backup_widget; ?>
      <?php } ?>
      <!-- NeoSeo Backup Wwidget - end -->
    </div>
    <div class="col-xs-12 col-md-6">
      <!-- NeoSeo Notes Widget - begin -->
      <?php if(isset($neoseo_notes_widget)) { ?>
      <?php echo $neoseo_notes_widget; ?>
      <?php } ?>
      <!-- NeoSeo Notes Widget - end -->
    </div>
    </div>
    
  </div>

  </div>
  <?php echo $footer; ?>
</div>