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

    .btn-primary {
        min-width: 160px;
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
            <div class="settings-master__nav-item done">
                <a href="<?php echo $neoseo_m3_link; ?>" >
                    <?php echo $neoseo_m3_title; ?>
                </a>
            </div>
            <div class="settings-master__nav-item current">
                <a href="<?php echo $neoseo_m4_link; ?>" >
                    <?php echo $neoseo_m4_title; ?>
                </a>
            </div>
        </div>
        <div class="settings-master__content">
            <div class="page-header">
                <div class="container-fluid">
                    <ul class="breadcrumbs-tabs">
                        <li class="current"><span><span class="hidden-xs"><?php echo $text_step; ?></span> 1</span></li>
                        <li><span><span class="hidden-xs"><?php echo $text_step; ?></span>   2</span></li>
                        <li><span><span class="hidden-xs"><?php echo $text_step; ?></span>   3</span></li>
                        <li><span><span class="hidden-xs"><?php echo $text_step; ?></span>   4</span></li>
                    </ul>
                    <h2><?php echo $m4_heading_h2_title; ?></h2>
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
                                <h2><?php echo $m4_title_for_2; ?></h2>
                                <button class="btn btn-primary" type="button" onclick="genAll()"><?php echo $text_seo_button_1; ?></button>
                                <br><br><br>
                                <div id="loader" style="display: none;">
                                    <i class="fa fa-spin fa-circle-o-notch" style="font-size: 60px;color: #53ca13;"></i>
                                </div>
                                <div id="succes_msg" class="alert alert-success" style="display: none;">
                                    <p><?php echo $text_generation_success; ?></p>
                                </div>
                                <p><?php echo $text_seo_button_1_desc; ?></p>
                                <button class="btn btn-primary" type="button" onclick="$('#soegen_iframe').slideToggle();"><?php echo $text_seo_button_2; ?></button>
                                <br><br><br>
                                <p><?php echo $text_seo_button_2_desc; ?></p>
                                <iframe src="<?php echo $seogen_iframe; ?>" width="100%" style="min-height: 1200px; display: none;" frameborder = "no" id="soegen_iframe"></iframe>
                                <br><br>
                                <button type="button" class="btn btn-success pull-right"  onclick="step(1,2)"><?php echo $text_next; ?></button>
                                <a href="<?php echo $cancel_link; ?>" class="btn btn-warning" ><?php echo $text_cancel; ?></a>

                            </div>
                            <div id="step2" style="display: none;">
                                <h2><?php echo $text_config_meta; ?></h2>
                                <?php $widgets->localeTextarea('config_meta_title',$languages ); ?>
                                <?php $widgets->localeTextarea('config_meta_description',$languages ); ?>
                                <?php $widgets->localeTextarea('config_meta_keyword' ,$languages); ?>

                                <button type="button" class="btn btn-warning"  onclick="step(2,1)"><?php echo $text_prev; ?></button>
                                <button type="button" class="btn btn-success pull-right"  onclick="step(2,3)"><?php echo $text_next; ?></button>
                            </div>
                            <div id="step3" style="display: none;">
                                <h2><?php echo $text_url_options; ?></h2>
                                <?php
                                    $widgets->dropdown('config_category_short',array( 0 => $text_short, 1 => $text_long));
                                    $widgets->dropdown('config_seo_url_include_path',array( 0 => $text_short, 1 => $text_full));
                                ?>
                                <?php echo $text_category_short_description; ?>
                                <p><?php echo $text_category_short_description2; ?></p>
                                <p><?php echo $text_category_short_description3; ?></p>

                                <br><br>
                                <h2><?php echo $m4_title_for_3; ?></h2>
                                <p><?php echo $m4_title_desk_3; ?></p>
                                <p style="margin-bottom: 15px">
                                    <input
                                            id="robots_cb"
                                    name="robots_cb"
                                    value = 0
                                    type="checkbox"
                                    class="checkbox-s"
                                    <?php if ($robots_state == 1) { ?> checked='checked' <?php } ?>
                                    onChange="robotsClicker()"
                                    />
                                    <label for="robots_cb" ><?php echo $m4_open_button; ?></label>
                                </p>
                                <p><?php echo $m4_title_desk_4 ?></p>
                                <br>
                                <p><?php echo $m4_title_desk_5; ?></p>
                                <br>
                                <div class="" id="robots_result"></div>

                                <button type="button" class="btn btn-warning"  onclick="step(3,2)"><?php echo $text_prev; ?></button>
                                <button type="button" class="btn btn-success pull-right"  onclick="step(3,4)"><?php echo $text_next; ?></button>
                            </div>
                            <div id="step4" style="display: none;">
                                <h2><?php echo $text_google_shopping_title; ?></h2>
                                <p><?php echo $m4_google_feed_desc; ?></p>
                                <br>
                                <p><?php echo $m4_google_feed_desc2; ?></p>
                                <p>
                                    <button type="button" class="btn btn-primary" onclick="doExport('google');" data-token="<?php echo $token; ?>"><?php echo $m4_google_feed_open; ?></button>
                                </p>
                                <br>

                                <p><?php echo $m4_google_feed_desc3; ?></p>
                                <br>
                                <br>
                                <button type="button" class="btn btn-warning"  onclick="step(4,3)"><?php echo $text_prev; ?></button>
                                <button type="submit" class="btn btn-success pull-right" value="complete" name="action"><?php echo $m2_complete; ?></button>
                            </div>
                            <input type="hidden" name="master4" value="1">
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



<script>

    function robotsClicker()
    {
        if($('#robots_cb').is(":checked")){
            generateRobots();
        } else {
            hideRobots();
        }
    }

    function generateRobots()
    {
        var stores = [0];
        $.ajax({
            url: 'index.php?route=tool/neoseo_robots_generator/generate&token=<?php echo $token ?>',
            type: 'post',
            dataType: 'json',
            data: '',
            success: function(json) {
                $('.alert').remove();
                if (json['error']) {
                    $('#robots_result').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

                if (json['content'] && json['success']) {
                    $('#robots_result').prepend('<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                    /*
                    stores.forEach(function(item){
                        console.log(item);
                        $('[id="content[' + item + ']"]').val(json['content']);
                    });*/
                    var stores = [0];
                    $.ajax({
                            url: 'index.php?route=tool/neoseo_robots_generator/save&token=<?php echo $token ?>',
                            type: 'post',
                            dataType: 'json',
                            data: {'content[0]':json['content'],'silent':1},});
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
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
            partial_save();
        }
        $('#step'+from).slideToggle();
        $('#step'+to).slideToggle();
        $("body,html").animate({ scrollTop:0 }, 500);

    }
    function partial_save()
    {
        $.ajax({
            type: "POST",
            url: '<?php echo html_entity_decode($save); ?>&quick_save=1',
            data: $('#form').serialize(),
        });
    }
    //$('#iframe_in_modal').contents()
    $( document ).ready(function() {
        $('.page-header',$('#soegen_iframe').contents()).hide();
    });
    document.getElementById('soegen_iframe').onload = function() {
        //$('.page-header',$('#soegen_iframe').contents()).hide();
        $('.page-header > .container-fluid > *',$('#soegen_iframe').contents()).not('.pull-right').hide();
        $('.page-header',$('#soegen_iframe').contents()).css('height','1px !important');
        $('.page-header',$('#soegen_iframe').contents()).css('margin','0');
        $('.sbtn',$('#soegen_iframe').contents()).css('margin','0px 50px -70px 0px');
        $('.hbtn',$('#soegen_iframe').contents()).hide();
        $('.alert',$('#soegen_iframe').contents()).fadeOut(1500);
    }

    function genAll()
    {
        $('#loader').fadeIn(100);
        for(var i=0;i < 10 ;i++){
            if($('.gen_btn',$('#soegen_iframe').contents()).eq(i).length){
                setTimeout(function (i) { $('.gen_btn',$('#soegen_iframe').contents()).eq(i).trigger('click');  },1000*i,i);
            }
        }

        setTimeout(function () { $('#loader').fadeOut(1000); $('#succes_msg').fadeIn(300)},10000);
    }

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
    function hideRobots()
    {
        //$('#robots_gen').slideToggle(300);
        var stores = [0];
        $.ajax({
            url: 'index.php?route=tool/neoseo_robots_generator/hide&token=<?php echo $token ?>',
            type: 'post',
            dataType: 'json',
            data: '',
            success: function(json) {
                $('.alert').remove();
                if (json['error']) {
                    $('#robots_result').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

                if (json['content'] && json['success']) {
                    $('#robots_result').prepend('<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    var stores = [0];
                    $.ajax({
                        url: 'index.php?route=tool/neoseo_robots_generator/save&token=<?php echo $token ?>',
                        type: 'post',
                        dataType: 'json',
                        data: {'content[0]':json['content'],'silent':1},});
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
</script>
<style>
    .tooltip-image {
        max-width: 700px;
        min-width: 400px;
        /*min-height: 300px;
        max-height: 700px;*/
    }
    .j-tooltip {
        cursor: help;
        border-bottom: 1px dashed #0000FF;
        color: #0000FF;
    }
    .tooltip_templates{
        display: none;
    }

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
</style>

<?php echo $footer; ?>