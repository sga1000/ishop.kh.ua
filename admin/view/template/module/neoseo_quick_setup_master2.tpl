<?php echo $header; ?>
<style>

    .m2_list {
        padding: 20px 0 30px 14px;
        font-size: 16px;
    }

    .m2_list > li {
        margin-bottom: 8px;
    }

    .m2_list > li > a {
        color: #0000FF;
        border-bottom: 1px dashed;
        cursor: pointer;
    }

    a.free-link {
        color: #0000FF;
        border-bottom: 1px dashed;
        cursor: pointer;
    }
    p {
        font-size: 16px;
    }

</style>
<div id="content">
    <div class="settings-master">
        <div class="settings-master__nav">
            <div class="settings-master__nav-item done">
                <a href="<?php echo $neoseo_m1_link; ?>" >
                    <?php echo $neoseo_m1_title; ?>
                </a>
            </div>
            <div class="settings-master__nav-item current">
                <a href="<?php echo $neoseo_m2_link; ?>" >
                    <?php echo $neoseo_m2_title; ?>
                </a>
            </div>
            <div class="settings-master__nav-item">
                <a href="<?php echo $neoseo_m3_link; ?>" >
                    <?php echo $neoseo_m3_title; ?>
                </a>
            </div>
            <div class="settings-master__nav-item">
                <a href="<?php echo $neoseo_m4_link; ?>" >
                    <?php echo $neoseo_m4_title; ?>
                </a>
            </div>
        </div>
        <div class="settings-master__content">
            <div class="page-header">
                <div class="container-fluid">
                    <ul class="breadcrumbs-tabs">
                        <li class="current"><span><span class="hidden-xs"><?php echo $text_step; ?></span>  1</span></li>
                        <li><span><span class="hidden-xs"><?php echo $text_step; ?></span>   2</span></li>
                    </ul>
                    <h2><?php echo $m2_heading_h2_title; ?></h2>
                </div>
            </div>


            <div class="container-fluid">

                <?php if ($error_warning) { ?>
                <div class="alert alert-danger">
                    <i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
                <?php } ?>

                <?php if (isset($success) && $success) { ?>
                <div class="alert alert-success">
                    <i class="fa fa-check-circle"></i>
                    <?php echo $success; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
                <?php } ?>

                <div class="panel panel-default">
                    <div class="panel-body>" >
                        <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                            <div id="step1">
                                <h1><?php echo $m2_text1; ?></h1>
                                <ol class="m2_list">
                                    <li>
                                        <?php if($neoseo_exchange1c_status) { ?>
                                        <?php echo $m2_text_1c; ?>
                                        <a onclick="stepTo('1c')"><?php echo $m2_text_link_step; ?></a>
                                    <?php } else { ?>
                                        <?php echo $m2_text_1c_not_installed; ?>
                                    <?php } ?>
                                    <li>
                                        <?php if($neoseo_import_yml_status) { ?>
                                        <?php echo $m2_text_yml; ?>
                                        <a onclick="stepTo('yml')"><?php echo $m2_text_link_step; ?></a>
                                        <?php } else { ?>
                                        <?php echo $m2_text_import_yml_not_installed; ?>
                                        <?php } ?>
                                    </li>
                                    <li>
                                        <?php if($neoseo_simple_excel_exchange_status) { ?>
                                        <?php echo $m2_text_excel; ?>
                                        <a onclick="stepTo('excel')"><?php echo $m2_text_link_step; ?></a>
                                        <?php } else { ?>
                                        <?php echo $m2_text_simple_excel_not_installed; ?>
                                        <?php } ?>
                                    </li>
                                    <li>
                                        <?php echo $m2_text_by_hand; ?>
                                        <a onclick="stepTo('by_hands')"><?php echo $m2_text_link_hands; ?></a>
                                    </li>
                                </ol>
                                <div style="padding: 5px;">
                                    <p style="font-size: 16px"><?php echo $m2_text_delete_demo; ?></p>
                                    <button type="button" class="btn btn-danger clear-demo-data-btn" data-toggle="modal" data-target="#cleaner-modal">
                                        <?php echo $m2_cleaner_title; ?>
                                    </button>
                                </div>
                                <a href="<?php echo $cancel_link; ?>" class="btn btn-warning hidden" ><?php echo $text_cancel; ?></a>
                            </div>
                            <div id="step2" style="display: none;">
                                <div id="step_1c" style="display: none;" class="sub-steps">
                                    <h1><?php echo $m2_text_1c_h1; ?></h1>
                                    <p><?php echo $m2_1c_text; ?></p>
                                    <p class='m2p'>
                                        <strong><?php echo $m2_1c_url; ?></strong> <?php echo $link_1c; ?><br>
                                        <strong><?php echo $m2_1c_username; ?></strong> <?php echo $username_1c; ?><br>
                                        <strong><?php echo $m2_1c_passwprd; ?></strong> <?php echo $password_1c; ?><br>
                                    </p>
                                    <p><?php echo $m2_1c_text_2; ?> <a class="free-link" href="<?php echo $settings_link_1c; ?>" target="_blank"><?php echo $m2_1c_setting_link; ?></a> </p>
                                    <p><?php echo $m2_1c_text_3; ?></p>
                                    <p><?php echo $m2_1c_text_4; ?></p>
                                    <br><br>
                                </div>
                                <div id="step_yml" style="display: none;" class="sub-steps">
                                    <h1><?php echo $text_step_2_of_2; ?> <?php echo $m2_text_yml_h1; ?></h1>
                                    <p><?php echo $m2_yml_text; ?> <a class="free-link" href="<?php echo $settings_link_yml; ?>" target="_blank"><?php echo $m2_yml_setting_link; ?></a> </p>
                                    <p><?php echo $m2_yml_text_2; ?></p>
                                    <p><?php echo $m2_yml_text_3; ?></p>
                                    <p><?php echo $m2_yml_text_4; ?></p>
                                    <br><br>
                                </div>
                                <div id="step_excel" style="display: none;" class="sub-steps">
                                    <h1><?php echo $text_step_2_of_2; ?> <?php echo $m2_text_excel_h1; ?></h1>
                                    <p class='m2p'><?php echo $m2_text_import_excel; ?></p>
                                    <p>
                                        <?php echo $m2_text_import_excel_tpl; ?> <a class="free-link" onclick="$('#f_tpl').submit();"><?php echo $m2_text_on_link; ?></a>
                                    </p>
                                    <p>
                                        <?php echo $m2_text_import_excel_tpl_demo; ?> <a class="free-link" onclick="$('#f_tpl_demo').submit();"><?php echo $m2_text_on_link; ?></a>
                                    </p>

                                    <p>
                                        <?php echo $m2_text_import_excel_fill; ?>
                                    </p>
                                    <button type="button" class="btn btn-primary" onclick="openIframe()">
                                        <i class="fa fa-upload"></i>
                                        <?php echo $m2_text_import_excel_import; ?>
                                    </button>
                                    <br><br><br>
                                    <p><?php echo $m2_text_instruction_scv; ?></p>
                                    <p><?php echo $m2_text_forum; ?></p>
                                    <br><br><br>
                                </div>
                                <div id="step_by_hands" style="display: none;" class="sub-steps">
                                    <h1><?php echo $text_step_2_of_2; ?> <?php echo $m2_text_by_hand_h1; ?></h1>
                                    <p><?php echo $m2_manual_text; ?></p>
                                    <p><?php echo $m2_text_manual_category; ?> <a class="free-link" href="<?php echo $manual_category_link; ?>"  target="_blank"><?php echo $m2_text_manual_category_link; ?></a>
                                    <p><?php echo $m2_text_manual_products; ?> <a class="free-link" href="<?php echo $manual_products_link; ?>"  target="_blank"><?php echo $m2_text_manual_products_link; ?></a>
                                    <p><?php echo $m2_manual_text2; ?></p>
                                    <br><br>
                                </div>
                                <input type="hidden" name="master2" value="1">
                                <input type="hidden" name="action" value="complete">
                                <button type="button" class="btn btn-warning"  onclick="stepTo('step1')"><?php echo $text_prev; ?></button>
                                <button type="submit" class="btn btn-success pull-right" value="complete" name="action"><?php echo $m2_complete; ?></button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>


</div>

</div>
</div>



<!-- Modal -->
<div id="cleaner-modal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><?php echo $m2_cleaner_title; ?></h4>
            </div>
            <div class="modal-body">
                <p><?php echo $m2_cleaner_text; ?></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="if(confirm('<?php echo $m2_confirm; ?>'))cleanerRun();"><?php echo $m2_yes; ?></button>
                <button type="button" class="btn btn-warning" data-dismiss="modal"><?php echo $m2_no; ?></button>
            </div>
        </div>

    </div>
</div>

<!-- Modal -->
<div id="common-modal" class="modal fade" role="dialog">
    <div class="modal-dialog"  style="width: 100%;max-width: 1050px">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="i_modal_title"><?php echo $m2_text_import_excel_import; ?></h4>
            </div>
            <div class="modal-body">
                <iframe src="<?php echo $import_excel_import_link; ?>" width="1024" height="768" align="left" id="iframe_in_modal">
                    oooops!!!
                </iframe>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal"><?php echo $button_close; ?></button>
            </div>
        </div>

    </div>
</div>
<div style="display: none;">
    <form id="f_tpl" method="post" action="<?php echo $import_excel_tpl; ?>" enctype="multipart/form-data">
        <input type="hidden" name="example" value="1">
    </form>
    <form id="f_tpl_demo" method="post" action="<?php echo $import_excel_tpl; ?>" enctype="multipart/form-data">
    </form>
</div>
<style>
    .m2p{
        font-size: 20px;
    }
</style>
<script>

    function openIframe() {
        $('#common-modal').modal('show');
    }

    function cleanerRun()
    {
        $.get('<?php echo $demo_delete_demo_link; ?>');
        $('.clear-demo-data-btn').fadeOut(300);
    }

    function stepTo(next_step)
    {

        if(next_step !== 'step1'){
            $('.breadcrumbs-tabs li.current').eq(-1).toggleClass('complete').next().addClass('current');
            $('#step1').fadeOut(300,function () {
                $('#step2').fadeIn(300);
                $('#step_'+next_step).fadeIn(300);
            });

        } else {
            $('.breadcrumbs-tabs li.complete').eq(-1).removeClass('complete').addClass('current');
            $('.breadcrumbs-tabs li.current').eq(-1).removeClass('current');
            $('#step2').fadeOut(300,function () {
                $('#step1').fadeIn(300);
                $('.sub-steps').hide();
            });
        }
    }
</script>
<?php echo $footer; ?>
