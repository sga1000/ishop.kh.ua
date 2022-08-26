<div id="actions">

    <script type="text/javascript" src="catalog/view/theme/default/javascript/jquery.responsive_countdown.min.js"></script>

    <div class="container">
        <div class="">
            <h1 class="action-grid-heading"><span><?php echo $actions_heading; ?></span></h1>
            <div id="action-grid-list">
                <?php $x=0; foreach ($actions as $action) { $x++; ?>

                <div class="col-sm-6 col-lg-4 action-item-grid">
                    <div class="action-item-grid__image">
                        <img alt="" src="<?php echo $action["image"]; ?>">
                    </div>
                    <div class="action-item-grid__content">
                        <h3 class="action-item-grid__title">
                            <a href="<?php echo $action["href"]; ?>"><?php echo $action["name"]; ?></a>
                        </h3>

                        <div class="action-item-grid__info">
                            <?php   if( $action["date_end"] != 'EXP'){  ?>
                            <div class="action-item-grid__time">
                                <div class="action-item-grid__time-title"><?php echo $till_finish; ?></div>
                                <script type="text/javascript">
                                    $(function () {
                                        $("#countdown-action-<?php echo $x; ?>").ResponsiveCountdown({
                                            target_date: "<?php echo $action["date_end"]; ?>",
                                            time_zone: 0, target_future: true,
                                            set_id: 0, pan_id: 0, day_digits: 2,
                                            fillStyleSymbol1: "rgba(255,255,255,1)",
                                            fillStyleSymbol2: "rgba(255,255,255,1)",
                                            fillStylesPanel_g1_1: "rgba(140,140,140,1)",
                                            fillStylesPanel_g1_2: "rgba(90,90,90,1)",
                                            fillStylesPanel_g2_1: "rgba(140,140,140,1)",
                                            fillStylesPanel_g2_2: "rgba(90,90,90,1)",
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
                                <div class="action-item-grid__time-count" id="countdown-action-<?php echo $x; ?>" style="position: relative; height:auto;"></div>
                            </div>
                            <?php } else { ?>
                            <div class="action-item-grid__finish"><?php echo $action_finish; ?></div>
                            <?php } ?>
                            <?php   if( $action["date_end"] != 'EXP'){  ?>
                            <a href="<?php echo $action['href']; ?>" class="action-item-grid__link">
                                <?php echo $text_action_more ?>
                            </a>
                            <?php } ?>
                        </div>
                    </div>

                </div>

                <?php } ?>
            </div>

        </div>

    </div>
</div>
