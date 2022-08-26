<?php echo $header; ?>
<style>
    a.free-link {
        color: #0000FF;
        border-bottom: 1px dashed;
        cursor: pointer;
    }
    p {
        font-size: 16px;
    }
    p.easy-p {
        font-size: 14px;
        padding: 10px 0 10px 20px;
    }

    p.easy-p > button {
        margin-top: 10px;
    }

    .btn-primary {
        min-width: 160px;
    }

    label {
        font-size: 14px;
    }

    .attention {
        background: #fff1a9;
        padding: 10px;
        color: #000;
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
            <div class="settings-master__nav-item done">
                <a href="<?php echo $neoseo_m2_link; ?>" >
                    <?php echo $neoseo_m2_title; ?>
                </a>
            </div>
            <div class="settings-master__nav-item current">
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
                        <li><span><span class="hidden-xs"><?php echo $text_step; ?></span>   3</span></li>
                    </ul>
                    <h2><?php echo $m3_heading_h2_title; ?></h2>
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
                                <h2><?php echo $m3_title_for_shipping; ?></h2>
                                <br>
                                <p><?php echo $m3_subtitle_for_shipping; ?></p>
                                <br>
                                <?php foreach($shippings as $s_key => $s_data ) { ?>

                                <div class="shipping-container">
                                    <input type="checkbox" class="checkbox-s shipping-cb" id="s<?php echo $s_key; ?>" onclick="showInfo('<?php echo $s_key; ?>')" <?php if ($s_data['status'] == 1) { ?> checked='checked' <?php } ?>/>
                                    <label for="s<?php echo $s_key; ?>" onclick="showInfo('<?php echo $s_key; ?>')" id="labels<?php echo $s_key; ?>"><?php echo ${'m3_text_s_'.$s_key}; ?></label>
                                    <p id="s<?php echo $s_key; ?>_d" class="easy-p" <?php if ($s_data['status'] != 1) { ?>style="display: none;"<?php } ?>>
                                        <?php echo ${'m3_text_s_'.$s_key.'_desc'}; ?><br>
                                        <a class="free-link" onclick="openIframe('<?php echo $s_data['link']; ?>','<?php echo 's'.$s_key; ?>')"><?php echo ${'m3_text_s_'.$s_key.'_link'}; ?></a>
                                        <?php echo ${'m3_text_s_'.$s_key.'_desc2'}; ?>
                                    </p>
                                </div>
                                <?php } /* foreach shippings */ ?>
                                <button type="button" class="btn btn-success pull-right"  onclick="step(1,2)"><?php echo $text_next; ?></button>
                                <a href="<?php echo $cancel_link; ?>" class="btn btn-warning" ><?php echo $text_cancel; ?></a>

                            </div>
                            <div id="step2" style="display: none;">
                                <h2><?php echo $m3_title_for_payment; ?></h2>
                                <?php foreach($payments as $p_key => $p_data ) { ?>
                                <?php if(!isset($payment_shipping_links['payment_methods_list'][$p_key]) && !isset(${'m3_text_p_'.$p_key})) continue; ?>
                                <div class="shipping-container">
                                    <input type="checkbox" class="checkbox-s payment-cb" id="s<?php echo $p_key; ?>" onclick="showInfo('<?php echo $p_key; ?>')" <?php if ($p_data['status'] == 1) { ?> checked='checked' <?php } ?>/>
                                    <label for="s<?php echo $p_key; ?>" onclick="showInfo('<?php echo $p_key; ?>')" id="labelp<?php echo $p_key; ?>"><?php echo isset(${'m3_text_p_'.$p_key})?${'m3_text_p_'.$p_key}:$payment_shipping_links['payment_methods_list'][$p_key]['name'] ?></label>
                                    <p id="s<?php echo $p_key; ?>_d"  class="easy-p" <?php if ($p_data['status'] != 1) { ?>style="display: none;"<?php } ?>>
                                        <?php echo isset(${'m3_text_p_'.$p_key.'_desc'})?${'m3_text_p_'.$p_key.'_desc'}:""; ?><br>
                                        <a class="free-link" onclick="openIframe('<?php echo $p_data['link']; ?>','<?php echo 'p'.$p_key; ?>')"><?php echo ${'m3_text_p_'.$p_key.'_link'}; ?></a>
                                        <?php echo isset(${'m3_text_p_'.$p_key.'_desc2'})?${'m3_text_p_'.$p_key.'_desc2'}:""; ?><br>
                                    </p>
                                </div>
                                <?php } /* foreach shippings */ ?>
                                <button type="button" class="btn btn-warning"  onclick="step(2,1)"><?php echo $text_prev; ?></button>
                                <button type="button" class="btn btn-success pull-right"  onclick="step(2,3)"><?php echo $text_next; ?></button>
                            </div>

                            <div id="step3" style="display: none;">
                                <h2><?php echo $text_links_shipping_with_payment; ?></h2>
                                <p><?php echo $text_links_shipping_with_payment_desc; ?></p>
                                <p><?php echo $text_links_shipping_with_payment_desc2; ?></p>
                                <br>
                                <p class="attention"><?php echo $text_links_shipping_with_payment_desc3; ?></p>
                                <br><br>
                                <div id="links_content">
                                    <!-- -->
                                </div>
                                <button type="button" class="btn btn-warning"  onclick="step(3,2)"><?php echo $text_prev; ?></button>
                                <button type="submit" class="btn btn-success pull-right" value="complete" name="action"><?php echo $m2_complete; ?></button>
                            </div>
                            <input type="hidden" name="master3" value="1">
                            <input type="hidden" name="action" value="complete">

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
<div id="common-modal" class="modal fade" role="dialog">
    <div class="modal-dialog" style="width: 100%;max-width: 1050px">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="i_modal_title">[title]</h4>
            </div>
            <div class="modal-body">
                <iframe src="#" width="1024" height="768" align="left" id="iframe_in_modal">
                    oooops!!!
                </iframe>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal" onclick="closeIframe()"><?php echo $button_close; ?></button>
            </div>
        </div>

    </div>
</div>

<style>
    .m2p{
        font-size: 20px;
    }
    .shipping-container{
        padding: 8px 0px 8px 0px;
    }
</style>
<script>

    function closeIframe(){
        $('button[type="submit"][name="action"].btn-primary',$('#iframe_in_modal').contents()).click();
    }
    function openIframe(i_src,i_title) {
        $('#iframe_in_modal').attr('src',i_src);
        $('#i_modal_title').html($('#label'+i_title).html());
        $('#common-modal').modal('show');

    }

    function showInfo(method) {
        if($('#s'+method).is(':checked')){
            $('#s'+method+'_d').fadeIn(200);
        } else {
            $('#s'+method+'_d').fadeOut(200);
        }
       // console.log($('#s'+method+'_d'));
    }

    function step(from,to)
    {
        if (to > from) {
            $('.breadcrumbs-tabs li.current').eq(-1).toggleClass('complete').next().addClass('current');
        } else {
            $('.breadcrumbs-tabs li.complete').eq(-1).removeClass('complete').addClass('current');
            $('.breadcrumbs-tabs li.current').eq(-1).removeClass('current');
        }
        if(from == 1){
            if($('.shipping-cb:checked').length == 0){
                alert('<?php echo $m3_text_select_one_shipping; ?>');
                return;
            }
        }
        if(to == 3){
            $('#links_content').html('Loading...');
            $.ajax({
                url: 'index.php?route=module/neoseo_quick_setup/master3Links&token=<?php echo $token; ?>',
                type : 'GET',
                //dataType: 'json',
                beforeSend: function() {

                },
                complete: function() {
                    //$('.fa-spin').remove();
                },
                success: function(data) {
                    $('#links_content').html(data);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        }
        $('#step'+from).slideToggle();
        $('#step'+to).slideToggle();
        $("body,html").animate({ scrollTop:0 }, 500);

    }
    $(document)
        .on('click', 'form button[type=submit]', function(e) {
            isValid = true;
            if($('.payment-cb:checked').length == 0){
                alert('<?php echo $m3_text_select_one_payment; ?>');
                isValid = false;
                //return;
            }
            if(!isValid) {
                e.preventDefault(); //prevent the default action
            }
        });
</script>
<style>
    .checkbox-s {
        position: absolute;
        z-index: -1;
        opacity: 0;
        margin: 10px 0 0 20px;
    }
    .checkbox-s + label {
        position: relative;
        padding: 0 0 0 60px;
        cursor: pointer;
    }
    .checkbox-s + label:before {
        content: '';
        position: absolute;
        top: -4px;
        left: 0;
        width: 50px;
        height: 26px;
        border-radius: 13px;
        background: #CDD1DA;
        box-shadow: inset 0 2px 3px rgba(0,0,0,.2);
        transition: .2s;
    }
    .checkbox-s + label:after {
        content: '';
        position: absolute;
        top: -2px;
        left: 2px;
        width: 22px;
        height: 22px;
        border-radius: 10px;
        background: #FFF;
        box-shadow: 0 2px 5px rgba(0,0,0,.3);
        transition: .2s;
    }
    .checkbox-s:checked + label:before {
        background: #9FD468;
    }
    .checkbox-s:checked + label:after {
        left: 26px;
    }
    .checkbox-s:focus + label:before {
        box-shadow: inset 0 2px 3px rgba(0,0,0,.2), 0 0 0 3px rgba(255,255,0,.7);
    }
    .disabled-block {
        background: #D9D9D9;;
        background-image: repeating-linear-gradient(30deg,
        hsla(0,0%,100%,.1), hsla(0,0%,100%,.1) 15px,
        transparent 0, transparent 30px);
        border-radius: 5px;
    }
    .master3-pls-block{
        margin-bottom: 20px;
        padding: 20px;
    }
    .disabled_label{
        color:red;
    }
    .master3-pls-cb-div{
        margin: 3px 0px 3px 0px;
    }
</style>
<script>
    $(document).ready(function() {
        $('.j-tooltip').each(function () {
            jQuery("<img>").attr("src", $($(this).attr('title')).attr('src'));
            console.log($($(this).attr('title')).attr('src'));
        })
        $('.j-tooltip').tooltipster({
            contentAsHTML: true,
            side: 'right',
            delay: 500,
            trackOrigin:true,
            trackTooltip:true,
        });
    });
</script>
<?php echo $footer; ?>