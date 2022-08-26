<?php echo $header; ?><?php echo $column_left; ?>
<?php $show = true;?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right"><a href="<?php echo $invoice; ?>" target="_blank" data-toggle="tooltip"
                    title="<?php echo $button_invoice_print; ?>" class="btn btn-info"><i class="fa fa-print"></i></a> <a
                    href="<?php echo $shipping; ?>" target="_blank" data-toggle="tooltip"
                    title="<?php echo $button_shipping_print; ?>" class="btn btn-info"><i class="fa fa-truck"></i></a>
                <a href="<?php echo $edit; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>"
                    class="btn btn-primary"><i class="fa fa-pencil"></i></a> <a href="<?php echo $cancel; ?>"
                    data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i
                        class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><?php echo $text_order; ?></h3>
                    </div>
                    <table class="table">
                        <tbody>
                            <?php if(count($stores)>1):?>
                            <tr>
                                <td style="width: 1%;"><button data-toggle="tooltip" title="<?php echo $text_store; ?>"
                                        class="btn btn-info btn-xs"><i class="fa fa-shopping-cart fa-fw"></i></button>
                                </td>
                                <td colspan="2"><a href="<?php echo $store_url; ?>"
                                        target="_blank"><?php echo $store_name; ?></a></td>
                            </tr>
                            <?php endif; //count($stores)?>
                            <tr>
                                <td><?php echo $text_order_id; ?></td>
                                <td colspan="2"><?php echo $order_id; ?> </td>
                            </tr>
                            <tr>
                                <td><?php echo $text_date_added; ?></td>
                                <td colspan="2"><?php echo $date_added; ?></td>
                            </tr>

                            <tr>
                                <td><?php echo $text_order_total_sum; ?></td>
                                <td colspan="2"><?php $sum=end($totals); echo $sum['text'];?></td>
                            </tr>
                            <tr>
                                <td>
                                    <button data-toggle="tooltip" title="" class="btn btn-info btn-xs"
                                        data-original-title="<?php echo $text_payment_method; ?>"><i
                                            class="fa fa-credit-card fa-fw"></i></button>
                                </td>
                                <td colspan="2"><b><?php echo $payment_method; ?></b></td>
                            </tr>


                            <?php if ($shipping_method) { ?>
                            <tr>
                                <td>
                                    <button data-toggle="tooltip" title="" class="btn btn-info btn-xs"
                                        data-original-title="<?php echo $text_shipping_method; ?>"><i
                                            class="fa fa-truck fa-fw"></i></button>
                                </td>
                                <td><b><?php echo $shipping_method; ?></b><br><?php echo str_replace("<br />",", ", $shipping_address); ?>
                                </td>
                            </tr>
                            <?php foreach ($custom_fields as $custom_field) { ?>

                            <?php if ($custom_field['location'] == 'address') { ?>
                            <?php if ($custom_field['type'] == 'select') { ?>
                            <tr>
                                <td><?php echo $custom_field['name']; ?></td>
                                <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                <?php if (isset($shipping_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $shipping_custom_field[$custom_field['custom_field_id']]) { ?>
                                <td><?php echo $custom_field_value['name']; ?></td>
                                <?php } ?>
                                <?php } ?>
                            </tr>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'radio') { ?>
                            <tr>
                                <td><?php echo $custom_field['name']; ?></td>
                                <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                <?php if (isset($shipping_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $shipping_custom_field[$custom_field['custom_field_id']]) { ?>
                                <td><?php echo $custom_field_value['name']; ?></td>
                                <?php } ?>
                                <?php } ?>
                            </tr>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'text') { ?>
                            <tr>
                                <td><?php echo $custom_field['name']; ?></td>
                                <td><?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
                                </td>
                            </tr>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'date') { ?>
                            <tr>
                                <td><?php echo $custom_field['name']; ?></td>
                                <td><?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
                                </td>
                            </tr>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'time') { ?>
                            <tr>
                                <td><?php echo $custom_field['name']; ?></td>
                                <td><?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
                                </td>
                            </tr>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'datetime') { ?>
                            <tr>
                                <td><?php echo $custom_field['name']; ?></td>
                                <td><?php echo (isset($shipping_custom_field[$custom_field['custom_field_id']]) ? $shipping_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
                                </td>
                            </tr>
                            <?php } ?>
                            <?php } ?>
                            <?php } ?>
                            <?php } ?>




                            <?php if($coupon_status):?>
                            <tr>
                                <td><?php echo $entry_coupon; ?></td>
                                <td class="text-right"><?php echo $coupon; ?></td>
                                <td class="text-center"><?php if ($customer && $coupon) { ?>
                                    <?php if (!$coupon_total) { ?>
                                    <button id="button-reward-add" data-loading-text="<?php echo $text_loading; ?>"
                                        data-toggle="tooltip" title="<?php echo $button_reward_add; ?>"
                                        class="btn btn-success btn-xs"><i class="fa fa-plus-circle"></i></button>
                                    <?php } else { ?>
                                    <button id="button-reward-remove" data-loading-text="<?php echo $text_loading; ?>"
                                        data-toggle="tooltip" title="<?php echo $button_reward_remove; ?>"
                                        class="btn btn-danger btn-xs"><i class="fa fa-minus-circle"></i></button>
                                    <?php } ?>
                                    <?php } else { ?>
                                    <button disabled="disabled" class="btn btn-success btn-xs"><i
                                            class="fa fa-plus-circle"></i></button>
                                    <?php } ?></td>
                            </tr>
                            <?php endif;//coupon_status?>

                            <?php if($voucher_status):?>
                            <tr>
                                <td><?php echo $entry_voucher; ?></td>
                                <td class="text-right" colspan="2"><?php echo $voucher; ?></td>

                            </tr>
                            <?php endif;//voucher_status?>

                            <?php if($reward_status):?>
                            <tr>
                                <td><?php echo $text_reward; ?></td>
                                <td class="text-right"><?php echo $reward; ?></td>
                                <td class="text-center" style="width: 1%;"><?php if ($customer && $reward) { ?>
                                    <?php if (!$reward_total) { ?>
                                    <button id="button-reward-add" data-loading-text="<?php echo $text_loading; ?>"
                                        data-toggle="tooltip" title="<?php echo $button_reward_add; ?>"
                                        class="btn btn-success btn-xs"><i class="fa fa-plus-circle"></i></button>
                                    <?php } else { ?>
                                    <button id="button-reward-remove" data-loading-text="<?php echo $text_loading; ?>"
                                        data-toggle="tooltip" title="<?php echo $button_reward_remove; ?>"
                                        class="btn btn-danger btn-xs"><i class="fa fa-minus-circle"></i></button>
                                    <?php } ?>
                                    <?php } else { ?>
                                    <button disabled="disabled" class="btn btn-success btn-xs"><i
                                            class="fa fa-plus-circle"></i></button>
                                    <?php } ?></td>
                            </tr>
                            <?php endif;//reward_status?>


                            <?php if( false ) {?>
                            <tr>
                                <td><?php echo $text_invoice; ?></td>
                                <td id="invoice" class="text-right"><?php echo $invoice_no; ?></td>
                                <td style="width: 1%;" class="text-center"><?php if (!$invoice_no) { ?>
                                    <button id="button-invoice" data-loading-text="<?php echo $text_loading; ?>"
                                        data-toggle="tooltip" title="<?php echo $button_generate; ?>"
                                        class="btn btn-success btn-xs"><i class="fa fa-cog"></i></button>
                                    <?php } else { ?>
                                    <button disabled="disabled" class="btn btn-success btn-xs"><i
                                            class="fa fa-refresh"></i></button>
                                    <?php } ?></td>
                            </tr>

                            <?php } ?>
                            <?php if( false ):?>
                            <tr>
                                <td><?php echo $text_affiliate; ?>
                                    <?php if ($affiliate) { ?>
                                    (<a href="<?php echo $affiliate; ?>"><?php echo $affiliate_firstname; ?>
                                        <?php echo $affiliate_lastname; ?></a>)
                                    <?php } ?></td>
                                <td class="text-right"><?php echo $commission; ?></td>
                                <td class="text-center"><?php if ($affiliate) { ?>
                                    <?php if (!$commission_total) { ?>
                                    <button id="button-commission-add" data-loading-text="<?php echo $text_loading; ?>"
                                        data-toggle="tooltip" title="<?php echo $button_commission_add; ?>"
                                        class="btn btn-success btn-xs"><i class="fa fa-plus-circle"></i></button>
                                    <?php } else { ?>
                                    <button id="button-commission-remove"
                                        data-loading-text="<?php echo $text_loading; ?>" data-toggle="tooltip"
                                        title="<?php echo $button_commission_remove; ?>"
                                        class="btn btn-danger btn-xs"><i class="fa fa-minus-circle"></i></button>
                                    <?php } ?>
                                    <?php } else { ?>
                                    <button disabled="disabled" class="btn btn-success btn-xs"><i
                                            class="fa fa-plus-circle"></i></button>
                                    <?php } ?></td>
                            </tr>
                            <?php endif;//show?>


                            <?php if ($comment):?>
                            <tr>
                                <td><?php echo $text_comment; ?></td>
                                <td colspan="2"><?php echo $comment; ?></td>
                            </tr>
                            <?php endif; //$comment?>

                            <tr>
                                <td><?php echo $entry_order_status; ?>:</td>
                                <td colspan="2">
                                    <?php foreach ($order_statuses as $order_status): ?>
                                    <?php if ($order_status['order_status_id'] == $order_status_id): ?>
                                    <?php echo $order_status['name']; ?>
                                    <?php endif;?>
                                    <?php endforeach;?>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-user"></i> <?php echo $text_customer_detail; ?></h3>
                    </div>
                    <table class="table">
                        <tr>
                            <td style="width: 1%;"><button data-toggle="tooltip" title="<?php echo $text_customer; ?>"
                                    class="btn btn-info btn-xs"><i class="fa fa-user fa-fw"></i></button></td>
                            <td><?php if ($customer) { ?>
                                <a href="<?php echo $customer; ?>" target="_blank"><?php echo $firstname; ?>
                                    <?php echo $lastname; ?></a>
                                <?php } else { ?>
                                <?php echo $firstname; ?> <?php echo $lastname; ?>
                                <?php } ?></td>
                        </tr>
                        <?php if(count($customer_groups)>1):?>
                        <tr>
                            <td><button data-toggle="tooltip" title="<?php echo $text_customer_group; ?>"
                                    class="btn btn-info btn-xs"><i class="fa fa-group fa-fw"></i></button></td>
                            <td><?php echo $customer_group; ?></td>
                        </tr>
                        <?php endif;//count($customer_groups)?>
                        <tr>
                            <td><button data-toggle="tooltip" title="<?php echo $text_telephone; ?>"
                                    class="btn btn-info btn-xs"><i class="fa fa-phone fa-fw"></i></button></td>
                            <td><a href="tel:<?php echo $telephone; ?>"><?php echo $telephone; ?></a></td>
                        </tr>
                        <tr>
                            <td><button data-toggle="tooltip" title="<?php echo $text_email; ?>"
                                    class="btn btn-info btn-xs"><i class="fa fa-envelope-o fa-fw"></i></button></td>
                            <td><a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></td>
                        </tr>
                        <?php if($fax!=''):?>
                        <tr>
                            <td><button data-toggle="tooltip" title="<?php echo $text_fax; ?>"
                                    class="btn btn-info btn-xs"><i class="fa fa-fax"></i></button></td>
                            <td><?php echo $fax; ?></td>
                        </tr>
                        <?php endif;//fax?>
                        <?php if($show):?>
                        <tr>
                            <td><?php echo $text_ip; ?></td>
                            <td><?php echo $ip; ?></td>
                        </tr>
                        <?php if ($forwarded_ip) { ?>
                        <tr>
                            <td><?php echo $text_forwarded_ip; ?></td>
                            <td><?php echo $forwarded_ip; ?></td>
                        </tr>
                        <?php } ?>
                        <tr>
                            <td><?php echo $text_user_agent; ?></td>
                            <td><?php echo $user_agent; ?></td>
                        </tr>
                        <tr>
                            <td><?php echo $text_accept_language; ?></td>
                            <td><?php echo $accept_language; ?></td>
                        </tr>
                        <?php foreach ($custom_fields as $custom_field) { ?>
                        <?php if ($custom_field['location'] == 'account') { ?>
                        <?php if ($custom_field['type'] == 'select') { ?>
                        <tr>
                            <td><?php echo $custom_field['name']; ?></td>
                            <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                            <?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
                            <td><?php echo $custom_field_value['name']; ?></td>
                            <?php } ?>
                            <?php } ?>
                        </tr>
                        <?php } ?>
                        <?php if ($custom_field['type'] == 'radio') { ?>
                        <tr>
                            <td><?php echo $custom_field['name']; ?></td>
                            <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                            <?php if (isset($account_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $account_custom_field[$custom_field['custom_field_id']]) { ?>
                            <td><?php echo $custom_field_value['name']; ?></td>
                            <?php } ?>
                            <?php } ?>
                        </tr>
                        <?php } ?>
                        <?php if ($custom_field['type'] == 'text') { ?>
                        <tr>
                            <td><?php echo $custom_field['name']; ?></td>
                            <td><?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
                            </td>
                        </tr>
                        <?php } ?>
                        <?php if ($custom_field['type'] == 'date') { ?>
                        <tr>
                            <td><?php echo $custom_field['name']; ?></td>
                            <td><?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
                            </td>
                        </tr>
                        <?php } ?>
                        <?php if ($custom_field['type'] == 'time') { ?>
                        <tr>
                            <td><?php echo $custom_field['name']; ?></td>
                            <td><?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
                            </td>
                        </tr>
                        <?php } ?>
                        <?php if ($custom_field['type'] == 'datetime') { ?>
                        <tr>
                            <td><?php echo $custom_field['name']; ?></td>
                            <td><?php echo (isset($account_custom_field[$custom_field['custom_field_id']]) ? $account_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>
                            </td>
                        </tr>
                        <?php } ?>
                        <?php } ?>
                        <?php } ?>

                        <?php endif;//show?>
                    </table>
                </div>
            </div>
        </div>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <td class="text-left"><?php echo $column_product; ?></td>
                    <td class="text-left"><?php echo $column_model; ?></td>
                    <td class="text-right"><?php echo $column_quantity; ?></td>
                    <td class="text-right"><?php echo $column_price; ?></td>
                    <td class="text-right"><?php echo $column_total; ?></td>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($products as $product) { ?>
                <tr>
                    <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                        <?php foreach ($product['option'] as $option) { ?>
                        <br />
                        <?php if ($option['type'] != 'file') { ?>
                        &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                        <?php } else { ?>
                        &nbsp;<small> - <?php echo $option['name']; ?>: <a
                                href="<?php echo $option['href']; ?>"><?php echo $option['value']; ?></a></small>
                        <?php } ?>
                        <?php } ?></td>
                    <td class="text-left"><?php echo $product['model']; ?></td>
                    <td class="text-right"><?php echo $product['quantity']; ?></td>
                    <td class="text-right"><?php echo $product['price']; ?></td>
                    <td class="text-right"><?php echo $product['total']; ?></td>
                </tr>
                <?php } ?>
                <?php foreach ($vouchers as $voucher) { ?>
                <tr>
                    <td class="text-left"><a
                            href="<?php echo $voucher['href']; ?>"><?php echo $voucher['description']; ?></a></td>
                    <td class="text-left"></td>
                    <td class="text-right">1</td>
                    <td class="text-right"><?php echo $voucher['amount']; ?></td>
                    <td class="text-right"><?php echo $voucher['amount']; ?></td>
                </tr>
                <?php } ?>
                <?php foreach ($totals as $total) { ?>
                <tr>
                    <td colspan="4" class="text-right"><?php echo $total['title']; ?></td>
                    <td class="text-right"><?php echo $total['text']; ?></td>
                </tr>
                <?php } ?>
            </tbody>
        </table>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-comment-o"></i> <?php echo $text_history; ?></h3>
            </div>
            <div class="panel-body">
                <?php if(count($tabs)>0):?>
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-history" data-toggle="tab"><?php echo $tab_history; ?></a></li>
                    <?php if($show):?>
                    <li><a href="#tab-additional" data-toggle="tab"><?php echo $tab_additional; ?></a></li>
                    <?php endif;//show?>
                    <?php foreach ($tabs as $tab) { ?>
                    <li><a href="#tab-<?php echo $tab['code']; ?>" data-toggle="tab"><?php echo $tab['title']; ?></a>
                    </li>
                    <?php } ?>

                </ul>
                <?php endif; //count($tabs)?>
                <div class="tab-content">
                    <div class="tab-pane active" id="tab-history">
                        <div id="history"></div>
                        <br />
                        <fieldset>
                            <legend><?php echo $text_history_add; ?></legend>
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label"
                                        for="input-order-status"><?php echo $entry_order_status; ?></label>
                                    <div class="col-sm-10">
                                        <select name="order_status_id" id="input-order-status" class="form-control">
                                            <?php foreach ($order_statuses as $order_statuses) { ?>
                                            <?php if ($order_statuses['order_status_id'] == $order_status_id) { ?>
                                            <option value="<?php echo $order_statuses['order_status_id']; ?>"
                                                selected="selected"><?php echo $order_statuses['name']; ?></option>
                                            <?php } else { ?>
                                            <option value="<?php echo $order_statuses['order_status_id']; ?>">
                                                <?php echo $order_statuses['name']; ?></option>
                                            <?php } ?>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label"
                                        for="input-notify"><?php echo $entry_notify; ?></label>
                                    <div class="col-sm-10">
                                        <input type="checkbox" name="notify" value="1" id="input-notify" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label"
                                        for="input-comment"><?php echo $entry_comment; ?></label>
                                    <div class="col-sm-10">
                                        <textarea name="comment" rows="8" id="input-comment"
                                            class="form-control"></textarea>
                                    </div>
                                </div>
                            </form>
                        </fieldset>
                        <div class="text-right">
                            <button id="button-history" data-loading-text="<?php echo $text_loading; ?>"
                                class="btn btn-primary"><i class="fa fa-plus-circle"></i>
                                <?php echo $button_history_add; ?></button>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab-additional">
                        <?php if ($account_custom_fields) { ?>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <td colspan="2"><?php echo $text_account_custom_field; ?></td>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($account_custom_fields as $custom_field) { ?>
                                <tr>
                                    <td><?php echo $custom_field['name']; ?></td>
                                    <td><?php echo $custom_field['value']; ?></td>
                                </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                        <?php } ?>
                        <?php if ($payment_custom_fields) { ?>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <td colspan="2"><?php echo $text_payment_custom_field; ?></td>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($payment_custom_fields as $custom_field) { ?>
                                <tr>
                                    <td><?php echo $custom_field['name']; ?></td>
                                    <td><?php echo $custom_field['value']; ?></td>
                                </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                        <?php } ?>
                        <?php if ($shipping_method && $shipping_custom_fields) { ?>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <td colspan="2"><?php echo $text_shipping_custom_field; ?></td>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($shipping_custom_fields as $custom_field) { ?>
                                <tr>
                                    <td><?php echo $custom_field['name']; ?></td>
                                    <td><?php echo $custom_field['value']; ?></td>
                                </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                        <?php } ?>

                    </div>
                    <?php foreach ($tabs as $tab) { ?>
                    <div class="tab-pane" id="tab-<?php echo $tab['code']; ?>"><?php echo $tab['content']; ?></div>
                    <?php } ?>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    <!--
    $(document).delegate('#button-invoice', 'click', function() {
        $.ajax({
            url: 'index.php?route=sale/order/createinvoiceno&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
            dataType: 'json',
            beforeSend: function() {
                $('#button-invoice').button('loading');
            },
            complete: function() {
                $('#button-invoice').button('reset');
            },
            success: function(json) {
                $('.alert').remove();

                if (json['error']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' +
                        json['error'] + '</div>');
                }

                if (json['invoice_no']) {
                    $('#invoice').html(json['invoice_no']);

                    $('#button-invoice').replaceWith(
                        '<button disabled="disabled" class="btn btn-success btn-xs"><i class="fa fa-cog"></i></button>'
                        );
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $(document).delegate('#button-reward-add', 'click', function() {
        $.ajax({
            url: 'index.php?route=sale/order/addreward&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
            type: 'post',
            dataType: 'json',
            beforeSend: function() {
                $('#button-reward-add').button('loading');
            },
            complete: function() {
                $('#button-reward-add').button('reset');
            },
            success: function(json) {
                $('.alert').remove();

                if (json['error']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' +
                        json['error'] + '</div>');
                }

                if (json['success']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' +
                        json['success'] + '</div>');

                    $('#button-reward-add').replaceWith(
                        '<button id="button-reward-remove" data-toggle="tooltip" title="<?php echo $button_reward_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-minus-circle"></i></button>'
                        );
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $(document).delegate('#button-reward-remove', 'click', function() {
        $.ajax({
            url: 'index.php?route=sale/order/removereward&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
            type: 'post',
            dataType: 'json',
            beforeSend: function() {
                $('#button-reward-remove').button('loading');
            },
            complete: function() {
                $('#button-reward-remove').button('reset');
            },
            success: function(json) {
                $('.alert').remove();

                if (json['error']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' +
                        json['error'] + '</div>');
                }

                if (json['success']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' +
                        json['success'] + '</div>');

                    $('#button-reward-remove').replaceWith(
                        '<button id="button-reward-add" data-toggle="tooltip" title="<?php echo $button_reward_add; ?>" class="btn btn-success btn-xs"><i class="fa fa-plus-circle"></i></button>'
                        );
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $(document).delegate('#button-commission-add', 'click', function() {
        $.ajax({
            url: 'index.php?route=sale/order/addcommission&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
            type: 'post',
            dataType: 'json',
            beforeSend: function() {
                $('#button-commission-add').button('loading');
            },
            complete: function() {
                $('#button-commission-add').button('reset');
            },
            success: function(json) {
                $('.alert').remove();

                if (json['error']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' +
                        json['error'] + '</div>');
                }

                if (json['success']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' +
                        json['success'] + '</div>');

                    $('#button-commission-add').replaceWith(
                        '<button id="button-commission-remove" data-toggle="tooltip" title="<?php echo $button_commission_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-minus-circle"></i></button>'
                        );
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $(document).delegate('#button-commission-remove', 'click', function() {
        $.ajax({
            url: 'index.php?route=sale/order/removecommission&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
            type: 'post',
            dataType: 'json',
            beforeSend: function() {
                $('#button-commission-remove').button('loading');
            },
            complete: function() {
                $('#button-commission-remove').button('reset');
            },
            success: function(json) {
                $('.alert').remove();

                if (json['error']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' +
                        json['error'] + '</div>');
                }

                if (json['success']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' +
                        json['success'] + '</div>');

                    $('#button-commission-remove').replaceWith(
                        '<button id="button-commission-add" data-toggle="tooltip" title="<?php echo $button_commission_add; ?>" class="btn btn-success btn-xs"><i class="fa fa-plus-circle"></i></button>'
                        );
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    var token = '';

    // Login to the API
    $.ajax({
        url: '<?php echo $store_url; ?>index.php?route=api/login',
        type: 'post',
        dataType: 'json',
        data: 'key=<?php echo $api_key; ?>',
        crossDomain: true,
        success: function(json) {
            $('.alert').remove();

            if (json['error']) {
                if (json['error']['key']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json[
                            'error']['key'] +
                        ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

                if (json['error']['ip']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json[
                            'error']['ip'] +
                        ' <button type="button" id="button-ip-add" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-danger btn-xs pull-right"><i class="fa fa-plus"></i> <?php echo $button_ip_add; ?></button></div>'
                        );
                }
            }

            if (json['token']) {
                token = json['token'];
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });

    $(document).delegate('#button-ip-add', 'click', function() {
        $.ajax({
            url: 'index.php?route=user/api/addip&token=<?php echo $token; ?>&api_id=<?php echo $api_id; ?>',
            type: 'post',
            data: 'ip=<?php echo $api_ip; ?>',
            dataType: 'json',
            beforeSend: function() {
                $('#button-ip-add').button('loading');
            },
            complete: function() {
                $('#button-ip-add').button('reset');
            },
            success: function(json) {
                $('.alert').remove();

                if (json['error']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' +
                        json['error'] +
                        ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>'
                        );
                }

                if (json['success']) {
                    $('#content > .container-fluid').prepend(
                        '<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' +
                        json['success'] +
                        ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>'
                        );
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('#history').delegate('.pagination a', 'click', function(e) {
        e.preventDefault();

        $('#history').load(this.href);
    });

    $('#history').load('index.php?route=sale/order/history&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>');

    $('#button-history').on('click', function() {
        $.ajax({
            url: '<?php echo $store_url; ?>index.php?route=api/order/history&token=' + token +
                '&order_id=<?php echo $order_id; ?>',
            type: 'post',
            dataType: 'json',
            data: 'order_status_id=' + encodeURIComponent($('select[name=\'order_status_id\']').val()) +
                '&notify=' + ($('input[name=\'notify\']').prop('checked') ? 1 : 0) + '&override=' + ($(
                    'input[name=\'override\']').prop('checked') ? 1 : 0) + '&append=' + ($(
                    'input[name=\'append\']').prop('checked') ? 1 : 0) + '&comment=' + encodeURIComponent(
                    $('textarea[name=\'comment\']').val()),
            beforeSend: function() {
                $('#button-history').button('loading');
            },
            complete: function() {
                $('#button-history').button('reset');
            },
            success: function(json) {
                $('.alert').remove();

                if (json['error']) {
                    $('#history').before(
                        '<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' +
                        json['error'] +
                        ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>'
                        );
                }

                if (json['success']) {
                    $('#history').load(
                        'index.php?route=sale/order/history&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>'
                        );

                    $('#history').before(
                        '<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' +
                        json['success'] +
                        ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>'
                        );

                    $('textarea[name=\'comment\']').val('');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    //-->
    </script>
</div>
<?php echo $footer; ?>