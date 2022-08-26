<?php echo $header; ?>
<?php echo $content_top; ?>


<div class="container">
    <?php require_once(dirname(__FILE__) . '/../common/breadcrumbs.tpl'); ?>

    <div class="">
        <div id="content">

            <?php if ( true ) { ?>
            <script type="text/javascript" src="catalog/view/theme/neoseo_unistor/javascript/jquery.responsive_countdown.min.js"></script>
            <?php } ?>

            <h1><span><?php echo $heading_title; ?></span></h1>
            <?php $x=0; foreach ($actions as $action) { $x++; ?>
            <div class="action-container">

                <div class="item action-list clearfix">

                    <div class="item-timerAndPic">

                        <div class="item-pic">
                            <a href="<?php echo $action["href"]; ?>"><img alt="" src="<?php echo $action["image"]; ?>"></a>
                        </div>
                    </div>


                    <div class="item-desc">
                        <div class="item-timer">
                            <?php if ( false ) { ?>
                            <div class="item-type"><?php echo $action["action_status_title"]; ?></div>
                            <?php } ?>
                            <h2 class="item-title">
                                <a href="<?php echo $action["href"]; ?>"><?php echo $action["name"]; ?></a>
                            </h2>
                            <?php
                                       if( $action["date_end"] != 'EXP'){  ?>
                            <div class="timer-title"><?php echo $till_finish; ?>:</div>
                            <script type="text/javascript">
                                $(function () {
                                    $("#countdown-<?php echo $x; ?>").ResponsiveCountdown({
                                        target_date: "<?php echo $action["date_end"]; ?>",
                                        time_zone: 0, target_future: true,
                                        set_id: 0, pan_id: 0, day_digits: 2,
                                        fillStyleSymbol1: "rgba(255,255,255,1)",
                                        fillStyleSymbol2: "rgba(255,255,255,1)",
                                        fillStylesPanel_g1_1: "rgba(223,83,42,1)",
                                        fillStylesPanel_g1_2: "rgba(223,83,42,1)",
                                        fillStylesPanel_g2_1: "rgba(223,83,42,1)",
                                        fillStylesPanel_g2_2: "rgba(223,83,42,1)",
                                        text_color: "rgba(68, 68, 68, 1)",
                                        text_glow: "rgba(0,0,0,0)",
                                        show_ss: true, show_mm: true,
                                        show_hh: true, show_dd: true,
                                        f_family: "Arial", show_labels: true,
                                        type3d: "group", max_height: 100,
                                        days_long: "<?php echo $days_left; ?>", days_short: "dd",
                                        hours_long: "<?php echo $hours_left; ?>", hours_short: "hh",
                                        mins_long: "<?php echo $minutes_left; ?>", mins_short: "mm",
                                        secs_long: "<?php echo $seconds_left; ?>", secs_short: "ss",
                                        min_f_size: 11, max_f_size: 36,
                                        spacer: "circles", groups_spacing: 3, text_blur: 2,
                                        font_to_digit_ratio: 0.125, labels_space: 1.2
                                    });
                                });
                            </script>
                            <div class="timer-time" id="countdown-<?php echo $x; ?>" style="position: relative; height:auto;"></div>
                            <?php } else {
                                            echo '<div class="timer-title">'.$action_finish.'</div>';
                        }?></div>
                        <div class="item-text"><?php echo $action["short_text"]; ?></div>
                        <?php if ( false ) { ?>
                        <div class="item-actions"><a href="<?php echo $action["href"]; ?>" class="btn btn-primary"><span><?php echo $read_more; ?></span></a></div>
                        <?php } ?>
                    </div>
                    <?php if ( false ) { ?>
                    <div class="tag bigTag"><span class="<?php echo $action["action_status_class"]; ?>"><?php echo $action["action_status_content"]; ?></span></div>
                    <?php } ?>

                </div>

            </div>

            <?php } ?>
        </div>

    </div>
</div>
</div>

<?php echo $content_bottom; ?>

<?php echo $footer; ?>