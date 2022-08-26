<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
            <h1><?php echo $heading_title . " " . $text_module_version; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
            <a href="<?php echo $clear; ?>" title="<?php echo $button_clear; ?>" class="btn btn-primary pull-right"><i class="fa fa-trash-o" aria-hidden="true"></i> <?php echo $button_clear; ?></a>

        </div>
    </div>
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
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <?php if ($success) { ?>
        <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading" style=" height: 58px;">
                <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
            </div>
            <div class="panel-body">
                <div class="well">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-label" for="input-status"><?php echo $entry_date;  ?></label>
                                <div class="input-group date">
                                    <input type="text" name="filter_date" value="<?php echo $filter_date; ?>" placeholder="<?php echo $entry_date; ?>" data-date-format="YYYY-MM-DD" id="input-date-available" class="form-control" />
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                    </span></div>
                            </div>

                            <div class="form-group">
                                <label class="control-label" for="input-price"><?php echo $entry_referer;  ?></label>
                                <input type="text" name="filter_referer" value="<?php echo $filter_referer; ?>"  placeholder="<?php echo $entry_referer; ?>" id="input-price" class="form-control" />

                            </div> </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="control-label" for="input-model"><?php echo $entry_ip; ?></label>
                                <input type="text" name="filter_ip" value="<?php echo $filter_ip; ?>" placeholder="<?php echo $entry_ip; ?>" id="input-model" class="form-control" />
                            </div>


                            <div class="form-group">
                                <label class=" control-label" for="input-date-available"><?php echo $entry_request_uri; ?></label>

                                <input type="text" name="filter_request_uri" value="<?php echo $filter_request_uri; ?>" placeholder="<?php echo $entry_request_uri; ?>" data-date-format="YYYY-MM-DD" id="input-date-available" class="form-control" />
                            </div>   </div>
                        <div class="col-sm-4">
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class=" control-label" for="input-date-available"><?php echo $entry_browser; ?></label>
                                <input type="text" name="filter_browser" value="<?php echo $filter_browser; ?>" placeholder="<?php echo $entry_browser; ?>" data-date-format="YYYY-MM-DD" id="input-date-available" class="form-control" />
                            </div>
                            <div class="form-group">
                                <br> <br>
                                <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
                            </div>
                        </div>

                    </div>
                </div>
                <form  method="post" enctype="multipart/form-data" id="form-attribute">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <td class="text-center">
                                        <?php if ($sort == 'date_record') { ?>
                                        <a href="<?php echo $sort_date; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_date; ?>"><?php echo $column_date; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php if ($sort == 'ip') { ?>
                                        <a href="<?php echo $sort_ip; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_ip; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_ip; ?>"><?php echo $column_ip; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php if ($sort == 'browser') { ?>
                                        <a href="<?php echo $sort_browser; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_browser; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_browser; ?>"><?php echo $column_browser; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php if ($sort == 'referer') { ?>
                                        <a href="<?php echo $sort_referer; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_referer; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_referer; ?>"><?php echo $column_referer; ?></a>
                                        <?php } ?></td>
                                    <td class="text-center"><?php if ($sort == 'request_uri') { ?>
                                        <a href="<?php echo $sort_request_uri; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_request_uri; ?></a>
                                        <?php } else { ?>
                                        <a href="<?php echo $sort_request_uri; ?>"><?php echo $column_request_uri; ?></a>
                                        <?php } ?></td>
                                    <?php if(isset($redirect_manager)) { ?>
                                    <td class="text-center">Действие</td>
                                    <?php } ?>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if ($links) { ?>
                                <?php foreach ($links as $link) { ?>
                                <tr>
                                    <td class="text-left"><?php echo $link['date_record']; ?></td>
                                    <td class="text-left"><?php echo $link['ip']; ?></td>
                                    <td class="text-left"><?php echo $link['browser']; ?></td>
                                    <td class="text-left dont-break-out"><?php echo $link['referer']; ?></td>
                                    <td class="text-left dont-break-out"><?php echo $link['request_uri']; ?></td>
                                    <?php if ($link['isset_redirect']) { ?>
                                    <td class="text-left"> <?php echo $text_isset_redirect; ?></td>
                                    <?php }else{ if($link['add_redirect']) { ?>
                                    <td class="text-left"> <a href="<?php echo $link['add_redirect']; ?>" title="<?php echo $button_add_redirect; ?>" class="btn btn-primary pull-right"><i class="fa fa-plus" aria-hidden="true"></i> <?php echo $button_add_redirect; ?></a>
                                    </td>
                                    <?php } }?>
                                </tr>
                                <?php } ?>
                                <?php } else { ?>
                                <tr>
                                    <td class="text-center" colspan="9"><?php echo $text_no_results; ?></td>
                                </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </form>
                <div class="row">
                    <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
                    <div class="col-sm-6 text-right"><?php echo $results; ?></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        var filter_response_code = $('input[name=\'filter_response_code\']').val();
    });
    $('#button-filter').on('click', function () {
        var url = 'index.php?route=tool/neoseo_broken_links&token=<?php echo $token; ?>';

        var filter_date = $('input[name=\'filter_date\']').val();
        if (filter_date != '*') {
            url += '&filter_date=' + encodeURIComponent(filter_date);
        }

        var filter_referer = $('input[name=\'filter_referer\']').val();
        if (filter_referer != '*') {
            url += '&filter_referer=' + encodeURIComponent(filter_referer);
        }

        var filter_ip = $('input[name=\'filter_ip\']').val();
        if (filter_ip) {
            url += '&filter_ip=' + encodeURIComponent(filter_ip);
        }

        var filter_request_uri = $('input[name=\'filter_request_uri\']').val();
        if (filter_request_uri) {
            url += '&filter_request_uri=' + encodeURIComponent(filter_request_uri);
        }

        var filter_browser = $('input[name=\'filter_browser\']').val();
        if (filter_browser) {
            url += '&filter_browser=' + encodeURIComponent(filter_browser);
        }
        location = url;
    });
</script>
<script>$('.date').datetimepicker({
        pickTime: false
    });</script>
<?php echo $footer; ?>
