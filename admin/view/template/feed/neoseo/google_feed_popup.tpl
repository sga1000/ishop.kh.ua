<div class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="glyphicon glyphicon-remove"></i></button>
                <h4 class="modal-title"><?php echo $heading_title; ?></h4>
                <div class="form-group">
                    <label class="control-label"><span data-toggle="tooltip" title="<?php echo $help_exports; ?>"><?php echo $entry_exports; ?></label>
                </div>
                <div class="form-group" id="exports">
                    <?php foreach ($list_feeds as $list_feed) { ?>
                    <button type="button" name="feed-<?php echo $list_feed['feed_id']; ?>" data-feed="<?php echo $list_feed['feed_id']; ?>" class="btn btn-success"><?php echo $list_feed['name']; ?></button>
                    <?php } ?>
                </div>
                <div class="form-group">
                    <button type="button" name="new_export" class="btn btn-danger"><?php echo $button_new; ?></button>
                </div>
            </div>
			<div class="modal-alert">
			</div>
            <div class="modal-body">
                <div class="panel-body">
                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-custom-field" class="form-horizontal">
                        <div class="panel-body" name="edit" style="display: none">
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="input-store-name"><span data-toggle="tooltip" title="<?php echo $help_store_name; ?>"><?php echo $entry_store_name; ?></label>
                                <div class="col-sm-9">
                                    <input type="text" name="popup_store_name" value="<?php echo $store_name; ?>" placeholder="<?php echo $entry_store_name_desc; ?>" id="input-store-name" class="form-control" />
                                    <input type="hidden" name="feed_id" value="<?php echo $feed_id; ?>" id="input-feed-id" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group" id="display-value">
                                <label class="col-sm-3 control-label" for="input-full-store-name"><span data-toggle="tooltip" title="<?php echo $help_full_store_name; ?>"><?php echo $entry_full_store_name; ?></label>
                                <div class="col-sm-9">
                                    <input type="text" name="popup_full_store_name" value="<?php echo $full_store_name; ?>" placeholder="<?php echo $entry_full_store_name_desc; ?>" id="input-input-full-store-name" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="input-currency"><span data-toggle="tooltip" title="<?php echo $help_currency; ?>"><?php echo $entry_currency; ?></label>
                                <div class="col-sm-9">
                                    <select name="popup_currency_id">
                                        <?php foreach ($currencies as $currency) { ?>
                                        <option value="<?php echo $currency['currency_id']; ?>"><?php echo $currency['title']; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" for="input-category-type"><span data-toggle="tooltip" title="<?php echo $help_category; ?>"><?php echo $entry_category_type; ?></label>
                                <div class="col-sm-9">
                                    <select name="popup_category_type">
                                        <?php foreach ($select_type as $value => $category_type) { ?>
                                        <option value="<?php echo $value; ?>"><?php echo $category_type; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group" name="type_category" style="display: block">
                                <div class="col-sm-12">
                                    <div class="well well-sm" style="min-height: 150px;max-height: 300px;overflow: auto;">
                                        <table class="table table-striped">
                                            <?php foreach ($categories as $category) { ?>
                                            <tr>
                                                <td class="checkbox">
                                                    <label>
                                                        <?php if (in_array($category['category_id'], $product_category)) { ?>
                                                        <input type="checkbox" name="product_category[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
                                                        <?php echo $category['name']; ?>
                                                        <?php } else { ?>
                                                        <input type="checkbox" name="product_category[]" value="<?php echo $category['category_id']; ?>" />
                                                        <?php echo $category['name']; ?>
                                                        <?php } ?>
                                                    </label>
                                                </td>
                                            </tr>
                                            <?php } ?>
                                        </table>
                                    </div>
                                    <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a></div>
                            </div>
                            <div class="form-group" name="type_page" style="display: none">
                                <div class="col-sm-12">
                                    <div class="well well-sm" style="min-height: 150px;max-height: 300px;overflow: auto;">
                                        <table class="table table-striped">
                                            <?php foreach ($pages as $page) { ?>
                                            <tr>
                                                <td class="checkbox">
                                                    <label>
                                                        <?php if (in_array($page['page_id'], $product_page)) { ?>
                                                        <input type="checkbox" name="product_page[]" value="<?php echo $page['page_id']; ?>" checked="checked" />
                                                        <?php echo $page['name']; ?>
                                                        <?php } else { ?>
                                                        <input type="checkbox" name="product_page[]" value="<?php echo $page['page_id']; ?>" />
                                                        <?php echo $page['name']; ?>
                                                        <?php } ?>
                                                    </label>
                                                </td>
                                            </tr>
                                            <?php } ?>
                                        </table>
                                    </div>
                                    <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            <div class="modal-pre-footer">
                <div class="form-group">
                    <div class="modal-link"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" name="delete" disabled="disabled" class="btn btn-default"><?php echo $button_delete; ?></button>
                <button type="button" name="save" disabled="disabled" class="btn btn-default"><?php echo $button_save; ?></button>
                <button type="button" name="ecxecute" disabled="disabled" class="btn btn-primary"><?php echo $button_ecxecute; ?></button>
                <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $button_continue; ?></button>
            </div>
        </div>
    </div>
<script type="text/javascript"><!--
    $('button[name=\'new_export\']').on('click', function () {
        $('.modal-alert').html('<div class="alert alert-success">' + '<?php echo $text_new_export?>' + '</div>');
        $('input[name=\'popup_store_name\']').val('');
        $('input[name=\'popup_full_store_name\']').val('');
        $('input[name=\'feed_id\']').val('0');
        $('button[name=\'save\']').prop('disabled', false);
        $('button[name=\'ecxecute\']').prop('disabled', true);
        $('button[name=\'delete\']').prop('disabled', true);
        $('select[name=\'popup_category_type\']').val('1');
        $('div[name=\'edit\']').css('display', 'block');
        $('div[name=\'type_category\']').parent().find(':checkbox').prop('checked', false);
        $('div[name=\'type_page\']').parent().find(':checkbox').prop('checked', false);
        $('div[name=\'type_page\']').css('display', 'none');
        $('div[name=\'type_category\']').css('display', 'block');
        $(".modal-link").html('');
    })

    $('select[name=\'popup_category_type\']').on('change', function () {
        if($(this).val() == 1) {
            $('div[name=\'type_page\']').css('display', 'none');
            $('div[name=\'type_category\']').css('display', 'block');
        } else {
            $('div[name=\'type_page\']').css('display', 'block');
            $('div[name=\'type_category\']').css('display', 'none');
        }
    })

    $('button[name=\'save\']').on('click', function () {
        $.ajax({
            url: 'index.php?route=feed/neoseo/google_feed/saveFeed&token=<?php echo $token; ?>',
            type: 'post',
            data: $('input[name=\'feed_id\'], input[name=\'popup_store_name\'], input[name=\'popup_full_store_name\'], div[name=\'type_category\'] input[type=checkbox]:checked, div[name=\'type_page\'] input[type=checkbox]:checked, select[name=\'popup_category_type\'], select[name=\'popup_currency_id\']'),
            dataType: 'json',
            success: function(json) {
                if (json.success != '') {
                    $('.modal-alert').html('<div class="alert alert-success">' + json.success + '</div>');
                    $('div[name=\'edit\']').css('display', 'none');
                    $('button[name=\'save\']').prop('disabled', true);
                    $('button[name=\'ecxecute\']').prop('disabled', true);
                    $('button[name=\'delete\']').prop('disabled', true);
                    $(".modal-link").html('');
                    refreshFeed();
                } else {
                    $('.modal-alert').html('<div class="alert alert-danger">' + 'Error!' + '</div>');
                }
            }
        });

    })
    $('#exports').delegate('button', 'click', function () {
        $('button[name=\'save\']').prop('disabled', false);
        $('button[name=\'ecxecute\']').prop('disabled', false);
        $('button[name=\'delete\']').prop('disabled', false);
        var feed_id = $(this).data('feed');
        $.ajax({
            url: 'index.php?route=feed/neoseo/google_feed/getFeed&token=<?php echo $token; ?>',
            type: 'post',
            data: {feed_id: feed_id},
            dataType: 'json',
            success: function (json) {
                $('.modal-alert').html('<div class="alert alert-success">' + '<?php echo $text_edit; ?>' + json.name  + '</div>');
                $('input[name=\'popup_store_name\']').val(json.name);
                $('input[name=\'popup_full_store_name\']').val(json.full_store_name);
                $('input[name=\'feed_id\']').val(json.feed_id);
                $('select[name=\'popup_currency_id\']').val(json.currency);
                $('select[name=\'popup_category_type\']').val(json.category);
                $('div[name=\'type_category\']').parent().find(':checkbox').prop('checked', false);
                $('div[name=\'type_page\']').parent().find(':checkbox').prop('checked', false);
                if(json.category == 1) {
                    $('div[name=\'type_page\']').css('display', 'none');
                    $('div[name=\'type_category\']').css('display', 'block');
                    $('input[name=\'product_category[]\']').each(function (i, item){
                        if (-1 != $.inArray($(item).val(), json.product_category)) {
                            $(item).prop('checked', true);
                        }
                    });
                } else {
                    $('div[name=\'type_page\']').css('display', 'block');
                    $('div[name=\'type_category\']').css('display', 'none');
                    $('input[name=\'product_page[]\']').each(function (i, item){
                        if (-1 != $.inArray($(item).val(), json.product_page)) {
                            $(item).prop('checked', true);
                        }
                    });
                }
                $('div[name=\'edit\']').css('display', 'block');
                $(".modal-link").html('');
            }
        });
    })
    $('button[name=\'delete\']').on('click', function () {
        var feed_id = $('input[name=\'feed_id\']').val();
        var name = $('input[name=\'popup_store_name\']').val();
        jConfirm('<?php echo $text_confirm_delete; ?> <b>' + name + '</b>?', '<?php echo $text_confirm_delete_title; ?>', function(r) {
            if(r) {
                $.ajax({
                    url: 'index.php?route=feed/neoseo/google_feed/deleteFeed&token=<?php echo $token; ?>',
                    type: 'post',
                    data: {feed_id: feed_id},
                    dataType: 'json',
                    success: function (json) {
                        $('.modal-alert').html('<div class="alert alert-success">' + json.success + '</div>');
                        $('div[name=\'edit\']').css('display', 'none');
                        $('button[name=\'save\']').prop('disabled', true);
                        $('button[name=\'ecxecute\']').prop('disabled', true);
                        $('button[name=\'delete\']').prop('disabled', true);
                        $(".modal-link").html('');
                        refreshFeed();
                    }
                });
            }
        });
    })
    function refreshFeed() {
        $.ajax({
            url: 'index.php?route=feed/neoseo/google_feed/refreshFeeds&token=<?php echo $token; ?>',
            dataType: 'json',
            success: function (json) {
                $('#exports').html('');
                var list = $.map(json, function(item) {
                    return {
                        id: item['feed_id'],
                        name: item['name']
                    }
                })
                if (list.length) {
                    for (i = 0; i < list.length; i++) {
                        $('#exports').append('<button type="button" name="feed-' + list[i]['id'] + '" data-feed="' + list[i]['id'] + '" class="btn btn-success">' + list[i]['name'] + '</button>');
                    }
                }
            }
        });
    }
    $('button[name=\'ecxecute\']').on('click', function () {
        var feed_id = $('input[name=\'feed_id\']').val();
        $.ajax({
            url: 'index.php?route=feed/neoseo/google_feed/saveFeed&token=<?php echo $token; ?>',
            type: 'post',
            data: $('input[name=\'feed_id\'], input[name=\'popup_store_name\'], input[name=\'popup_full_store_name\'], div[name=\'type_category\'] input[type=checkbox]:checked, div[name=\'type_page\'] input[type=checkbox]:checked, select[name=\'popup_category_type\'], select[name=\'popup_currency_id\']'),
            dataType: 'json',
            success: function (json) {
                $.ajax({
                    url: 'index.php?route=feed/neoseo/google_feed/generate&token=<?php echo $token; ?>',
                    type: 'post',
                    data: {feed_id: feed_id},
                    dataType: 'json',
                    beforeSend: function() {
                        $(".modal-link").html('');
                    },
                    success: function(json) {
                        jAlert('<p><?php echo $text_ecxecute?></p>' + json["xml_link"], '<?php echo $text_ecxecute_title?>');
                    }
                });
            }
        });
    })
    //--></script>
</div>
