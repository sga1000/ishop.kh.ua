<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title"><i class="fa fa-shopping-cart"></i> <?php echo $heading_title; ?></h3>
  </div>
  <div class="table-responsive">
    <table class="table">
      <thead>
        <tr>
          <td class="text-right"><?php echo $column_order_id; ?></td>
          <td><?php echo $column_customer; ?></td>
          <td><?php echo $column_status; ?></td>
          <td><?php echo $column_date_added; ?></td>

<!-- NeoSeo Order Referrer - begin -->
<style>
.dont-break-out {
	/* These are technically the same, but use both */
	overflow-wrap: break-word;
	word-wrap: break-word;

	-ms-word-break: break-all;
	/* This is the dangerous one in WebKit, as it breaks things wherever */
	word-break: break-all;
	/* Instead use this non-standard one: */
	word-break: break-word;

	/* Adds a hyphen where the word breaks, if supported (No Blink) */
	-ms-hyphens: auto;
	-moz-hyphens: auto;
	-webkit-hyphens: auto;
	hyphens: auto;
}
</style>
<!-- NeoSeo Order Referrer - end -->
        	
          <td class="text-right"><?php echo $column_total; ?></td>

                <!-- NeoSeo Order Referrer - begin -->
                <td class="text-left"><?php echo $column_referrer; ?></td>
                <!-- NeoSeo Order Referrer - end -->
                
          <td class="text-right"><?php echo $column_action; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php if ($orders) { ?>
        <?php foreach ($orders as $order) { ?>
        <tr>
          <td class="text-right"><?php echo $order['order_id']; ?></td>
          <td><?php echo $order['customer']; ?></td>
          <td><?php echo $order['status']; ?></td>
          <td><?php echo $order['date_added']; ?></td>
          <td class="text-right"><?php echo $order['total']; ?></td>

                <!-- NeoSeo Order Referrer - begin -->
                <td class="text-left dont-break-out"><?php echo $order['first_referrer']; ?><br><?php echo $order['last_referrer']; ?></td>
                <!-- NeoSeo Order Referrer - end -->
                
          <td class="text-right"><a href="<?php echo $order['view']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info"><i class="fa fa-eye"></i></a></td>
        </tr>
        <?php } ?>
        <?php } else { ?>
        <tr>
          <td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
  </div>
</div>
