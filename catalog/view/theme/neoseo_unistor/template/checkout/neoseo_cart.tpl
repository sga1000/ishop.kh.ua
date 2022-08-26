<?php if($loyality_data != '') echo "<div class='alert alert-info'>$loyality_data</div>"; ?>
<?php if ($products || $vouchers) { ?>

    <?php foreach ($products as $product) { ?>
    <div class="row" style="margin-bottom:10px;">
        <div class="col-sm-3">
            <?php if ($product['thumb']) { ?>
            <a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
            <?php } ?>
        </div>
        <div class="col-sm-9">
            <a class="name-link" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
            <div class="description">
                <?php foreach ($product['option'] as $option) { ?>
                - <?php echo $option['name']; ?>: <?php echo $option['value']; ?> <br/>
                <?php } ?>
            </div>
			<?php echo $product['quantity']; ?> <?php echo $text_unit;?> <?php echo $product['price']; ?><br>
			<div class="btn-group btn-group-xs" role="group">
				<input type="hidden" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>">
				<a class="plus btn btn-xs"><i class="glyphicon glyphicon-plus"></i></a>
				<a class="trash btn btn-xs" href="<?php echo $product['key']; ?>" ><i class="glyphicon glyphicon-trash"></i></a>
				<a class="minus btn btn-xs"><i class="glyphicon glyphicon-minus"></i></a>
			</div>
        </div>
    </div>
    <?php } ?>
	<?php if( count($vouchers) > 0 ) { ?>
	<hr>
    <?php foreach ($vouchers as $voucher) { ?>
    <div class="row vouchers">
        <div class="col-sm-7"><?php echo $voucher['description']; ?></div>
        <div class="col-sm-5 text-right"><?php echo $voucher['amount']; ?></div>
    </div>
    <?php } ?>
	<?php } ?>
	<hr>
    <?php foreach ($totals as $total) { if(isset($total['value']) != 0 ) { ?>
    <div class="row totals">
        <div class="col-sm-7"><?php echo $total['title']; ?></div>
        <div class="col-sm-5 text-right"><?php echo $total['text']; ?></div>
    </div>
    <?php } } ?>

<?php } ?>


<div class="form-group"></div>
<div class="panel-group">
<?php if( $coupon_status ) { ?>
<div class="panel panel-default">
    <div class="panel-heading confirm-order-list">
        <h4 class="panel-title confirm-order-title"><a href="#collapse-coupon" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"><?php echo $entry_coupon; ?> <i class="fa fa-caret-down"></i></a></h4>
    </div>
    <div id="collapse-coupon" class="panel-collapse collapse">
        <div class="panel-body">
            <div class="input-group">
                <input type="text" name="coupon" value="" placeholder="<?php echo $text_use_coupon; ?>" id="input-coupon" class="form-control" />
                <span class="input-group-btn">
                    <input type="button" value="<?php echo $button_coupon; ?>" id="button-coupon" data-loading-text="<?php echo $text_loading; ?>"  class="btn btn-primary" />
                </span>
            </div>
        </div>
    </div>
</div>
<?php } ?>

<?php if( $voucher_status ) { ?>
<div class="panel panel-default">
    <div class="panel-heading confirm-order-list">
        <h4 class="panel-title confirm-order-title"><a href="#collapse-voucher" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"><?php echo $entry_voucher; ?> <i class="fa fa-caret-down"></i></a></h4>
    </div>
    <div id="collapse-voucher" class="panel-collapse collapse">
        <div class="panel-body">
            <div class="input-group">
                <input type="text" name="voucher" value="" placeholder="<?php echo $text_use_voucher; ?>" id="input-voucher" class="form-control" />
                <span class="input-group-btn">
                    <input type="button" value="<?php echo $button_voucher; ?>" id="button-voucher" data-loading-text="<?php echo $text_loading; ?>"  class="btn btn-primary" />
                </span>
            </div>
        </div>
    </div>
</div>
<?php } ?>

<?php if ($reward_status) { ?>
<div class="panel panel-default">
    <div class="panel-heading confirm-order-list">
        <h4 class="panel-title confirm-order-title"><a href="#collapse-reward" class="accordion-toggle" data-toggle="collapse" data-parent="#accordion"><?php echo $entry_reward; ?> <i class="fa fa-caret-down"></i></a></h4>
    </div>
    <div id="collapse-reward" class="panel-collapse collapse">
        <div class="panel-body">
            <div class="input-group">
                <input type="text" name="reward" value="" placeholder="<?php echo $text_use_reward; ?>" id="input-reward" class="form-control" />
                <span class="input-group-btn">
                    <input type="button" value="<?php echo $button_reward; ?>" id="button-reward" data-loading-text="<?php echo $text_loading; ?>"  class="btn btn-primary" />
                </span>
            </div>
        </div>
    </div>
</div>
<?php } ?>
</div>




