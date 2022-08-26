<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-progressive-web-application-general" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i>&nbsp;&nbsp;&nbsp;<?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i>&nbsp;&nbsp;&nbsp;<?php echo $button_cancel; ?></a></div>
        <h1><?php echo $heading_title; ?></h1>
        <ul class="breadcrumb">
          <?php foreach ($breadcrumbs as $key => $breadcrumb) { ?>
          <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
    </div>
    <div class="container-fluid">
      <?php if ($error_warning) { ?>
      <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
      <div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title"><i class="fa fa-pencil"></i>&nbsp;&nbsp;<?php echo $text_edit; ?></h3>
          <span class="pull-right">Extension by:&nbsp;&nbsp;<a href="mailto:todor.donev@gmail.com">Todor Donev</a></span>
        </div>
        <div class="panel-body">
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-progressive-web-application-general" class="form-horizontal">
            <div class="form-group">
              <div class="col-sm-1">&nbsp;</div>
              <div class="col-sm-10 alert alert-info"><?php echo $text_about; ?></div>
            </div>
            <div class="form-group">
              <label class="col-sm-4 control-label"><?php echo $text_stores; ?></label>
              <div class="col-sm-4 col-sm-offset-1">
                <style type="text/css">.dropdown > .dropdown-toggle > .caret { margin-top: 8px; } .dropdown > .dropdown-toggle { color: unset; } .nav > #selectStore { border: 1px solid #ccc }</style>
                <ul class="nav" style="width:100%">
                  <li id="selectStore" class="dropdown" style="cursor:pointer;"><a class="dropdown-toggle" data-toggle="dropdown"><?php echo $store['name']; echo ($store['store_id'] == 0) ? " <strong>(".$text_default.")</strong>" : ''; ?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="pull-right caret"></span><span class="sr-only"><?php echo $text_select_store; ?></span></a>
                    <ul class="dropdown-menu dropdown-menu-center col-sm-12">
                      <li class="dropdown-header"><?php echo $text_select_store; ?></li>
                      <li class="divider"></li>
                      <?php foreach ($stores  as $key => $value) { ?>
                      <li><a href="<?php echo $value['url']; ?>"><?php echo $value['name']; echo ($value['store_id'] == 0) ? ' - <strong>('.$text_default.')</strong>' : ''; ?></a></li>
                      <?php } ?> 
                    </ul>
                  </li>
                </ul>
              </div>    
            </div>
            <div class="form-group">
              <label class="col-sm-4 control-label" for="input-status"><span data-toggle="tooltip" title="<?php echo $help_status; ?>"><?php echo $entry_status; ?></span></label>
              <div class="col-sm-4 col-sm-offset-1">
                <select name="progressive_web_application_status[status]" id="input-status" class="form-control">
                  <?php if ($status) { ?>
                  <option value="1" selected="selected"><?php echo $text_activated; ?></option>
                  <option value="0"><?php echo $text_deactivated; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_activated; ?></option>
                  <option value="0" selected="selected"><?php echo $text_deactivated; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>

            <hr>

            <div class="col-sm-12">
             <!-- START MENU -->
             <ul class="nav nav-tabs">
              <li class="active"><a data-toggle="tab" href="#tab-general"><b><i class="fa fa-cog"></i>&nbsp;&nbsp;<?php echo $tab_general; ?></b></a></li>
              <li><a data-toggle="tab" href="#tab-support"><b><i class="fa fa-life-ring"></i>&nbsp;&nbsp;<?php echo $tab_support; ?></b></a></li>
            </ul>
            <!-- END MENU -->

            <!--START TAB CONTENT -->
            <div class="tab-content">
             <!-- START TAB GENERAL -->
             <div class="tab-pane active" id="tab-general">

              <div class="panel panel-default">
               <div class="panel-heading"><h3 class="panel-title" style="line-height:2"><b><i class="fa fa-cog"></i>&nbsp;&nbsp;<?php echo $head_general; ?></b></h3></div>
               <div class="panel-body">

                <legend><?php echo $legend_preloader; ?></legend>

                <div class="form-group">
                  <div class="col-sm-1">&nbsp;</div>
                  <div class="col-sm-10 alert alert-info"><?php echo $about_preloader; ?></div>
                  <label class="col-sm-4 control-label" for="input-preloader"><span data-toggle="tooltip" title="<?php echo $help_preloader; ?>"><?php echo $entry_preloader; ?></span></label>
                  <div class="col-sm-4 col-sm-offset-1">
                    <select name="progressive_web_application_status[preloader_status]" id="input-preloader" class="form-control">
                      <?php if ($preloader_status) { ?>
                      <option value="1" selected="selected"><?php echo $text_activated; ?></option>
                      <option value="0"><?php echo $text_deactivated; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_activated; ?></option>
                      <option value="0" selected="selected"><?php echo $text_deactivated; ?></option>
                      <?php } ?>
                    </select>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-4 control-label" for="input-preloader-background-color"><span data-toggle="tooltip" title="<?php echo $help_preloader_background_color; ?>"><?php echo $entry_preloader_background_color; ?></span></label>
                  <div class="col-sm-4 col-sm-offset-1">
                    <div id="preloader-background-color" class="input-group">
                      <span class="input-group-addon" style="min-width: 100px;"><i style="min-width: 100px;"></i></span>
                      <input type="text" name="progressive_web_application_status[preloader_background]" value="<?php echo (isset($preloader_background) and !empty($preloader_background)) ? $preloader_background : '' ?>"  id="input-preloader-background-color" class="form-control" />
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-4 control-label" for="input-preloader-balls-color"><span data-toggle="tooltip" title="<?php echo $help_preloader_balls_color; ?>"><?php echo $entry_preloader_balls_color; ?></span></label>
                  <div class="col-sm-4 col-sm-offset-1">
                    <div id="preloader-balls-color" class="input-group">
                      <span class="input-group-addon" style="min-width: 100px;"><i style="min-width: 100px;"></i></span>
                      <input type="text" name="progressive_web_application_status[preloader_balls_color]" value="<?php echo (isset($preloader_balls_color) and !empty($preloader_balls_color)) ? $preloader_balls_color : '' ?>"  id="input-preloader-balls-color" class="form-control" />
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-4 control-label" for="input-preloader-fadeout"><span data-toggle="tooltip" title="<?php echo $help_preloader_fadeout; ?>"><?php echo $entry_preloader_fadeout; ?></span></label>
                  <div class="col-sm-4 col-sm-offset-1">
                    <input type="range" min="5" max="10000" name="progressive_web_application_status[preloader_fadeout]" value="<?php echo (isset($preloader_fadeout) and !empty($preloader_fadeout)) ? $preloader_fadeout : '' ?>" id="input-preloader-fadeout" class="form-control" />
                    <p><?php echo $text_value; ?>&nbsp;&nbsp;<span id="preloader-fadeout-value"></span>&nbsp;<?php echo $text_milliseconds; ?></p>
                    <script>
                    var fadeout_slider = document.getElementById("input-preloader-fadeout");
                    var fadeout_output = document.getElementById("preloader-fadeout-value");
                    fadeout_output.innerHTML = fadeout_slider.value;

                    fadeout_slider.oninput = function() {
                      fadeout_output.innerHTML = this.value;
                    }
                    </script>
                    </div>
                    </div>

                    <div class="form-group">
                    <label class="col-sm-4 control-label" for="input-preloader-size"><span data-toggle="tooltip" title="<?php echo $help_preloader_size; ?>"><?php echo $entry_preloader_size; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="range" min="1" max="100" name="progressive_web_application_status[preloader_size]" value="<?php echo (isset($preloader_size) and !empty($preloader_size)) ? $preloader_size : '' ?>" id="input-preloader-size" class="form-control" />
                    <p><?php echo $text_value; ?>&nbsp;&nbsp;<span id="preloader-size-value"></span>&nbsp;%</p>
                    <script>
                    var slider = document.getElementById("input-preloader-size");
                    var output = document.getElementById("preloader-size-value");
                    output.innerHTML = slider.value;

                    slider.oninput = function() {
                      output.innerHTML = this.value;
                    }
                    </script>
                    </div>
                    </div>

                    <div class="form-group">
                    <label class="col-sm-4 control-label" for="input-preloader-balls-size"><span data-toggle="tooltip" title="<?php echo $help_preloader_balls_size; ?>"><?php echo $entry_preloader_balls_size; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="range" min="5" max="500" name="progressive_web_application_status[preloader_balls_size]" value="<?php echo (isset($preloader_balls_size) and !empty($preloader_balls_size)) ? $preloader_balls_size : '' ?>"  id="input-preloader-balls-size" class="form-control" />
                    <p><?php echo $text_value; ?>&nbsp;&nbsp;<span id="preloader-balls-size-value"></span>&nbsp;px</p>
                    <script>
                    var slider_balls = document.getElementById("input-preloader-balls-size");
                    var output_balls = document.getElementById("preloader-balls-size-value");
                    output_balls.innerHTML = slider_balls.value;

                    slider_balls.oninput = function() {
                      output_balls.innerHTML = this.value;
                    }
                    </script>
                    </div>
                    </div>

                    <legend> <?php echo $legend_preloader_displays; ?> </legend>
                    <div class="form-group ">
                    <label class="col-sm-4 control-label" for="input-preloader-display-small-phone"><span data-toggle="tooltip" title="<?php echo $help_preloader_display_small_phone; ?>"><?php echo $entry_preloader_display_small_phone; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="checkbox" id="input-preloader-display-small-phone" name="progressive_web_application_status[preloader_display][small_phone]" value="1" <?php echo isset($preloader_display['small_phone']) ? 'checked' : '' ?> class="col-sm-12" data-size="lg" data-toggle="toggle" data-onstyle="primary" data-on="<i class='fa fa-toggle-on'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_activated; ?>" data-off="<i class='fa fa-toggle-off'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_deactivated; ?>"data-width="100%">
                    </div>
                    </div>

                    <div class="form-group ">
                    <label class="col-sm-4 control-label" for="input-preloader-display-normal-phone"><span data-toggle="tooltip" title="<?php echo $help_preloader_display_normal_phone; ?>"><?php echo $entry_preloader_display_normal_phone; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="checkbox" id="input-preloader-display-normal-phone" name="progressive_web_application_status[preloader_display][normal_phone]" value="1" <?php echo isset($preloader_display['normal_phone']) ? 'checked' : '' ?> class="col-sm-12" data-size="lg" data-toggle="toggle" data-onstyle="primary" data-on="<i class='fa fa-toggle-on'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_activated; ?>" data-off="<i class='fa fa-toggle-off'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_deactivated; ?>"data-width="100%">
                    </div>
                    </div>

                    <div class="form-group ">
                    <label class="col-sm-4 control-label" for="input-preloader-display-large-phone"><span data-toggle="tooltip" title="<?php echo $help_preloader_display_large_phone; ?>"><?php echo $entry_preloader_display_large_phone; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="checkbox" id="input-preloader-display-large-phone" name="progressive_web_application_status[preloader_display][large_phone]" value="1" <?php echo isset($preloader_display['large_phone']) ? 'checked' : '' ?> class="col-sm-12" data-size="lg" data-toggle="toggle" data-onstyle="primary" data-on="<i class='fa fa-toggle-on'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_activated; ?>" data-off="<i class='fa fa-toggle-off'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_deactivated; ?>"data-width="100%">
                    </div>
                    </div>

                    <div class="form-group ">
                    <label class="col-sm-4 control-label" for="input-preloader-display-tablet"><span data-toggle="tooltip" title="<?php echo $help_preloader_display_tablet; ?>"><?php echo $entry_preloader_display_tablet; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="checkbox" id="input-preloader-display-tablet" name="progressive_web_application_status[preloader_display][tablet]" value="1" <?php echo isset($preloader_display['tablet']) ? 'checked' : '' ?> class="col-sm-12" data-size="lg" data-toggle="toggle" data-onstyle="primary" data-on="<i class='fa fa-toggle-on'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_activated; ?>" data-off="<i class='fa fa-toggle-off'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_deactivated; ?>"data-width="100%">
                    </div>
                    </div>

                    <div class="form-group ">
                    <label class="col-sm-4 control-label" for="input-preloader-display-large-tablet"><span data-toggle="tooltip" title="<?php echo $help_preloader_display_large_tablet; ?>"><?php echo $entry_preloader_display_large_tablet; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="checkbox" id="input-preloader-display-large-tablet" name="progressive_web_application_status[preloader_display][large_tablet]" value="1" <?php echo isset($preloader_display['large_tablet']) ? 'checked' : '' ?> class="col-sm-12" data-size="lg" data-toggle="toggle" data-onstyle="primary" data-on="<i class='fa fa-toggle-on'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_activated; ?>" data-off="<i class='fa fa-toggle-off'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_deactivated; ?>"data-width="100%">
                    </div>
                    </div>

                    <div class="form-group ">
                    <label class="col-sm-4 control-label" for="input-preloader-display-laptop"><span data-toggle="tooltip" title="<?php echo $help_preloader_display_laptop; ?>"><?php echo $entry_preloader_display_laptop; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="checkbox" id="input-preloader-display-laptop" name="progressive_web_application_status[preloader_display][laptop]" value="1" <?php echo isset($preloader_display['laptop']) ? 'checked' : '' ?> class="col-sm-12" data-size="lg" data-toggle="toggle" data-onstyle="primary" data-on="<i class='fa fa-toggle-on'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_activated; ?>" data-off="<i class='fa fa-toggle-off'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_deactivated; ?>"data-width="100%">
                    </div>
                    </div>

                    <div class="form-group ">
                    <label class="col-sm-4 control-label" for="input-preloader-display-large-laptop"><span data-toggle="tooltip" title="<?php echo $help_preloader_display_large_laptop; ?>"><?php echo $entry_preloader_display_large_laptop; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="checkbox" id="input-preloader-display-large-laptop" name="progressive_web_application_status[preloader_display][large_laptop]" value="1" <?php echo isset($preloader_display['large_laptop']) ? 'checked' : '' ?> class="col-sm-12" data-size="lg" data-toggle="toggle" data-onstyle="primary" data-on="<i class='fa fa-toggle-on'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_activated; ?>" data-off="<i class='fa fa-toggle-off'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_deactivated; ?>"data-width="100%">
                    </div>
                    </div>

                    <div class="form-group ">
                    <label class="col-sm-4 control-label" for="input-preloader-display-desktop"><span data-toggle="tooltip" title="<?php echo $help_preloader_display_desktop; ?>"><?php echo $entry_preloader_display_desktop; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="checkbox" id="input-preloader-display-desktop" name="progressive_web_application_status[preloader_display][desktop]" value="1" <?php echo isset($preloader_display['desktop']) ? 'checked' : '' ?> class="col-sm-12" data-size="lg" data-toggle="toggle" data-onstyle="primary" data-on="<i class='fa fa-toggle-on'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_activated; ?>" data-off="<i class='fa fa-toggle-off'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_deactivated; ?>"data-width="100%">
                    </div>
                    </div>

                    <div class="form-group ">
                    <label class="col-sm-4 control-label" for="input-preloader-display-large-desktop"><span data-toggle="tooltip" title="<?php echo $help_preloader_display_large_desktop; ?>"><?php echo $entry_preloader_display_large_desktop; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="checkbox" id="input-preloader-display-large-desktop" name="progressive_web_application_status[preloader_display][large_desktop]" value="1" <?php echo isset($preloader_display['large_desktop']) ? 'checked' : '' ?> class="col-sm-12" data-size="lg" data-toggle="toggle" data-onstyle="primary" data-on="<i class='fa fa-toggle-on'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_activated; ?>" data-off="<i class='fa fa-toggle-off'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_deactivated; ?>"data-width="100%">
                    </div>
                    </div>

                    <div class="form-group ">
                    <label class="col-sm-4 control-label" for="input-preloader-display-fhd"><span data-toggle="tooltip" title="<?php echo $help_preloader_display_fhd; ?>"><?php echo $entry_preloader_display_fhd; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="checkbox" id="input-preloader-display-fhd" name="progressive_web_application_status[preloader_display][fhd]" value="1" <?php echo isset($preloader_display['fhd']) ? 'checked' : '' ?> class="col-sm-12" data-size="lg" data-toggle="toggle" data-onstyle="primary" data-on="<i class='fa fa-toggle-on'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_activated; ?>" data-off="<i class='fa fa-toggle-off'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_deactivated; ?>"data-width="100%">
                    </div>
                    </div>

                    <div class="form-group ">
                    <label class="col-sm-4 control-label" for="input-preloader-display-uhd"><span data-toggle="tooltip" title="<?php echo $help_preloader_display_uhd; ?>"><?php echo $entry_preloader_display_uhd; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="checkbox" id="input-preloader-display-uhd" name="progressive_web_application_status[preloader_display][uhd]" value="1" <?php echo isset($preloader_display['uhd']) ? 'checked' : '' ?> class="col-sm-12" data-size="lg" data-toggle="toggle" data-onstyle="primary" data-on="<i class='fa fa-toggle-on'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_activated; ?>" data-off="<i class='fa fa-toggle-off'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_deactivated; ?>"data-width="100%">
                    </div>
                    </div>

                    <div class="form-group ">
                    <label class="col-sm-4 control-label" for="input-preloader-display-4k-uhd"><span data-toggle="tooltip" title="<?php echo $help_preloader_display_4k_uhd; ?>"><?php echo $entry_preloader_display_4k_uhd; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <input type="checkbox" id="input-preloader-display-4k-uhd" name="progressive_web_application_status[preloader_display][4k_uhd]" value="1" <?php echo isset($preloader_display['4k_uhd']) ? 'checked' : '' ?> class="col-sm-12" data-size="lg" data-toggle="toggle" data-onstyle="primary" data-on="<i class='fa fa-toggle-on'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_activated; ?>" data-off="<i class='fa fa-toggle-off'></i>&nbsp;&nbsp;&nbsp;<?php echo $text_deactivated; ?>"data-width="100%">
                    </div>
                    </div>


                    <legend> <?php echo $legend_manifest; ?> </legend>
                    <div class="form-group">
                    <div class="col-sm-1">&nbsp;</div>
                    <div class="col-sm-10 alert alert-info"><?php echo $about_offline_enabled; ?></div>
                    <label class="col-sm-4 control-label" for="input-offline-enabled"><span data-toggle="tooltip" title="<?php echo $help_offline_enabled; ?>"><?php echo $entry_offline_enabled; ?></span></label>
                    <div class="col-sm-4 col-sm-offset-1">
                    <select name="progressive_web_application_status[offline_enabled]" id="input-offline-enabled" class="form-control">
                    <?php if ($offline_enabled) { ?>
                      <option value="1" selected="selected"><?php echo $text_activated; ?></option>
                      <option value="0"><?php echo $text_deactivated; ?></option>
                      <?php } else { ?>
                        <option value="1"><?php echo $text_activated; ?></option>
                        <option value="0" selected="selected"><?php echo $text_deactivated; ?></option>
                        <?php } ?>
                        </select>
                        </div>
                        </div>

                        <div class="form-group">
                        <div class="col-sm-1">&nbsp;</div>
                        <div class="col-sm-10 alert alert-info"><?php echo $about_display; ?></div>
                        <label class="col-sm-4 control-label" for="input-display"><span data-toggle="tooltip" title="<?php echo $help_display; ?>"><?php echo $entry_display; ?></span></label>
                        <div class="col-sm-4 col-sm-offset-1">
                        <select name="progressive_web_application_status[display]" id="input-display" class="form-control">
                        <!-- <option value="browser" <?php echo (isset($display) and $display == 'browser') ? 'selected=selected' : '' ?>>browser (Default)</option> -->
                        <option value="fullscreen" <?php echo (isset($display) and $display == 'fullscreen') ? 'selected=selected' : '' ?>>fullscreen</option>
                        <option value="standalone" <?php echo (isset($display) and $display == 'standalone') ? 'selected=selected' : '' ?>>standalone (Default)</option>
                        <option value="minimal-ui" <?php echo (isset($display) and $display == 'minimal-ui') ? 'selected=selected' : '' ?>>minimal-ui</option>
                        </select>
                        </div>
                        </div>

                        <div class="form-group">
                        <div class="col-sm-1">&nbsp;</div>
                        <div class="col-sm-10 alert alert-info"><?php echo $about_orientation; ?></div>
                        <label class="col-sm-4 control-label" for="input-orientation"><span data-toggle="tooltip" title="<?php echo $help_orientation; ?>"><?php echo $entry_orientation; ?></span></label>
                        <div class="col-sm-4 col-sm-offset-1">
                        <select name="progressive_web_application_status[orientation]" id="input-orientation" class="form-control">
                        <option value="portrait" <?php echo (isset($orientation) and $orientation == 'portrait') ? 'selected=selected' : '' ?>>portrait (Default)</option>
                        <option value="portrait-primary" <?php echo (isset($orientation) and $orientation == 'portrait-primary') ? 'selected=selected' : '' ?>>portrait-primary</option>
                        <option value="portrait-secondary" <?php echo (isset($orientation) and $orientation == 'portrait-secondary') ? 'selected=selected' : '' ?>>portrait-secondary</option>
                        <option value="landscape" <?php echo (isset($orientation) and $orientation == 'landscape') ? 'selected=selected' : '' ?>>landscape</option>
                        <option value="landscape-primary" <?php echo (isset($orientation) and $orientation == 'landscape-primary') ? 'selected=selected' : '' ?>>landscape-primary</option>
                        <option value="landscape-secondary" <?php echo (isset($orientation) and $orientation == 'landscape-secondary') ? 'selected=selected' : '' ?>>landscape-secondary</option>
                        <option value="any" <?php echo (isset($orientation) and $orientation == 'any') ? 'selected=selected' : '' ?>>any</option>
                        <option value="natural" <?php echo (isset($orientation) and $orientation == 'natural') ? 'selected=selected' : '' ?>>natural</option>
                        </select>
                        </div>
                        </div>

                        <div class="form-group">
                        <div class="col-sm-1">&nbsp;</div>
                        <div class="col-sm-10 alert alert-info"><?php echo $about_direction; ?></div>
                        <label class="col-sm-4 control-label" for="input-direction"><span data-toggle="tooltip" title="<?php echo $help_display; ?>"><?php echo $entry_direction; ?></span></label>
                        <div class="col-sm-4 col-sm-offset-1">
                        <select name="progressive_web_application_status[direction]" id="input-direction" class="form-control">
                        <option value="auto" <?php echo (isset($direction) and $direction == 'auto') ? 'selected=selected' : '' ?>>Auto (Default)</option>
                        <option value="rtl" <?php echo (isset($direction) and $direction == 'rtl') ? 'selected=selected' : '' ?>>Left To Right</option>
                        <option value="ltr" <?php echo (isset($direction) and $direction == 'ltr') ? 'selected=selected' : '' ?>>Right To Lef</option>
                        </select>
                        </div>
                        </div>

                        <div class="form-group required">
                        <div class="col-sm-1">&nbsp;</div>
                        <div class="col-sm-10 alert alert-info"><?php echo $about_background_color; ?></div>
                        <label class="col-sm-4 control-label" for="input-background-color"><span data-toggle="tooltip" title="<?php echo $help_background_color; ?>"><?php echo $entry_background_color; ?></span></label>
                        <div class="col-sm-4 col-sm-offset-1">
                        <div id="background-color" class="input-group">
                        <span class="input-group-addon" style="min-width: 100px;"><i style="min-width: 100px;"></i></span>
                        <input type="text" name="progressive_web_application_status[background_color]" value="<?php echo (isset($background_color) and !empty($background_color)) ? $background_color : '' ?>"  id="input-background-color" class="form-control" />
                        </div>
                        </div>
                        </div>

                        <div class="form-group required">
                        <div class="col-sm-1">&nbsp;</div>
                        <div class="col-sm-10 alert alert-info"><?php echo $about_theme_color; ?></div>
                        <label class="col-sm-4 control-label" for="input-theme-color"><span data-toggle="tooltip" title="<?php echo $help_theme_color; ?>"><?php echo $entry_theme_color; ?></span></label>
                        <div class="col-sm-4 col-sm-offset-1">
                        <div class="input-group" id="theme-color">
                        <span class="input-group-addon" style="min-width: 100px;"><i style="min-width: 100px;"></i></span>
                        <input type="text" name="progressive_web_application_status[theme_color]" value="<?php echo (isset($theme_color) and !empty($theme_color)) ? $theme_color : '' ?>"  id="input-theme-color" class="form-control" />
                        </div>
                        </div>
                        </div>

                        <div class="form-group required">
                        <label class="col-sm-4 control-label" for="input-application-image"><span data-toggle="tooltip" title="<?php echo $help_icon; ?>"><?php echo $entry_icon; ?></span></label>
                        <div class="col-sm-4 col-sm-offset-2">
                        <?php if ($application_image) { ?>
                          <a href="" id="thumb-pwa-image" data-toggle="image" class="img-thumbnail"><img height="150px" width="150px" src="<?php echo $application_image; ?>" alt="" title="" data-placeholder="<?php echo $image_placeholder; ?>" /></a>
                          <input type="hidden" name="progressive_web_application_status[application_image]" value="<?php echo $thumb_application_image; ?>" id="input-application-image" />
                          <?php } else  {?>
                            <a href="" id="thumb-pwa-image" data-toggle="image" class="img-thumbnail"><img height="150px" width="150px" src="<?php echo $image_placeholder; ?>" alt="" title="" data-placeholder="<?php echo $image_placeholder; ?>" /></a>
                            <input type="hidden" name="progressive_web_application_status[application_image]" value="" id="input-application-image" />
                            <?php } ?>
                            </div>
                            </div>

                            <div class="form-group">
                            <div class="col-sm-12"> 
                            <ul class="nav nav-tabs" id="language">
                            <?php foreach ($languages as $key => $language) { ?>
                              <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />&nbsp;&nbsp;&nbsp;<?php echo $language['name']; ?></a></li>
                              <?php } ?>
                              </ul>
                              <div class="tab-content">
                              <?php foreach ($languages as $key => $language) { ?>
                                <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                                <div class="form-group required">
                                <label class="col-sm-3 control-label" for="input-short-name-<?php echo $language['language_id']; ?>"><span data-toggle="tooltip" title="<?php echo $help_short_name; ?>"><?php echo $entry_short_name; ?></span></label>
                                <div class="col-sm-7 col-sm-offset-1">
                                <div class="input-group">       
                                <label class="input-group-addon" for="input-short-name-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />&nbsp;&nbsp;&nbsp;<?php echo $language['name']; ?></label>
                                <input type="text" name="progressive_web_application_status[short_name][<?php echo $language['language_id']; ?>]" value="<?php echo isset($short_name[$language['language_id']]) ? $short_name[$language['language_id']] : ''; ?>" placeholder="<?php echo $placeholder_short_name; ?>" id="input-short-name-<?php echo $language['language_id']; ?>" class="form-control" />
                                </div>
                                <?php if (isset($error_short_name[$language['language_id']])) { ?>
                                  <div class="text-danger"><?php echo $error_short_name[$language['language_id']]; ?></div>
                                  <?php } ?>
                                  </div>
                                  </div>
                                  <script type="text/javascript">$('#input-short-name-<?php echo $language['language_id']; ?>').prop('maxlength', '32');</script>

                                  <div class="form-group required">
                                    <label class="col-sm-3 control-label" for="input-long-name-<?php echo $language['language_id']; ?>"><span data-toggle="tooltip" title="<?php echo $help_long_name; ?>"><?php echo $entry_long_name; ?></span></label>
                                    <div class="col-sm-7 col-sm-offset-1">
                                      <div class="input-group">
                                        <label class="input-group-addon" for="input-long-name-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />&nbsp;&nbsp;&nbsp;<?php echo $language['name']; ?></label>
                                        <input type="text" name="progressive_web_application_status[long_name][<?php echo $language['language_id']; ?>]" value="<?php echo isset($long_name[$language['language_id']]) ? $long_name[$language['language_id']] : ''; ?>" placeholder="<?php echo $placeholder_long_name; ?>" id="input-long-name-<?php echo $language['language_id']; ?>" class="form-control" />
                                      </div>
                                      <?php if (isset($error_long_name[$language['language_id']])) { ?>
                                      <div class="text-danger"><?php echo $error_long_name[$language['language_id']]; ?></div>
                                      <?php } ?>
                                    </div>
                                  </div>
                                  <script type="text/javascript">$('#input-long-name-<?php echo $language['language_id']; ?>').prop('maxlength', '64');</script>

                                  <div class="form-group required">
                                    <label class="col-sm-3 control-label" for="input-description-<?php echo $language['language_id']; ?>"><span data-toggle="tooltip" title="<?php echo $help_description; ?>"><?php echo $entry_description; ?></span></label>
                                    <div class="col-sm-7 col-sm-offset-1">
                                      <div class="input-group">
                                        <label class="input-group-addon" for="input-description-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />&nbsp;&nbsp;&nbsp;<?php echo $language['name']; ?></label>
                                        <?php if (isset($description[$language['language_id']])) { ?>
                                        <textarea rows="8" style="resize:vertical; overflow:auto;" name="progressive_web_application_status[description][<?php echo $language['language_id']; ?>]" placeholder="<?php echo $placeholder_description; ?>" id="input-description-<?php echo $language['language_id']; ?>" class="form-control col-sm-12" /><?php echo $description[$language['language_id']]; ?></textarea>
                                        <?php } else { ?>
                                        <textarea rows="8" style="resize:vertical; overflow:auto;" name="progressive_web_application_status[description][<?php echo $language['language_id']; ?>]" placeholder="<?php echo $placeholder_description; ?>" id="input-description-<?php echo $language['language_id']; ?>" class="form-control col-sm-12" /></textarea>
                                        <?php } ?>
                                        <input type="hidden" name="progressive_web_application_status[lang_code][<?php echo $language['language_id']; ?>]" value="<?php echo isset($lang_code[$language['language_id']]) ? $lang_code[$language['language_id']] : $language['code']; ?>"  />
                                      </div>
                                      <?php if (isset($error_description[$language['language_id']])) { ?>
                                      <div class="text-danger"><?php echo $error_description[$language['language_id']]; ?></div>
                                      <?php } ?>
                                    </div>
                                  </div>
                                  <script type="text/javascript">$('#input-description-<?php echo $language['language_id']; ?>').prop('maxlength', '1024');</script>
                                </div>
                                <?php } ?>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </form>

                  </div>
                  <!-- START TAB GENERAL -->


                  <div class="tab-pane" id="tab-support">
                   <!-- START TAB SUPPORT -->
                   <form method="post" enctype="multipart/form-data" id="form-progressive-web-application-support" class="form-horizontal">
                    <div class="panel panel-default">
                     <div class="panel-heading"><h3 class="panel-title" style="line-height:2"><b><i class="fa fa-life-ring"></i>&nbsp;&nbsp;<?php echo $head_support; ?></b></h3></div>
                     <div class="panel-body">

                      <div class="col-sm-12" id="results"></div>

                      <div class="form-group required">
                       <label class="col-md-3 control-label"><?php echo $entry_your_name; ?></label>
                       <div class="col-md-7">
                        <div class="input-group col-sm-12 col-xs-12 col-md-12 col-lg-12">
                         <input required autofocus placeholder="<?php echo $placeholder_your_name; ?>" id="progressive_web_application_support_name" name="progressive_web_application_support_name" type="text" value="" class="form-control" maxlength="64">
                         <script type="text/javascript">$('#progressive_web_application_support_name').prop('maxlength', '64');</script>
                       </div>
                     </div>
                   </div>
                   <div class="form-group required">
                     <label class="col-md-3 control-label"><?php echo $entry_your_email; ?></label>
                     <div class="col-md-7">
                      <div class="input-group col-sm-12 col-xs-12 col-md-12 col-lg-12">
                       <input required placeholder="<?php echo $placeholder_your_email; ?>" id="progressive_web_application_support_email" name="progressive_web_application_support_email" type="email" value="" class="form-control" maxlength="64">
                       <script type="text/javascript">$('#progressive_web_application_support_email').prop('maxlength', '64');</script>
                     </div>
                   </div>
                 </div>
                 <div class="form-group required">
                   <label class="col-md-3 control-label"><?php echo $entry_subject; ?></label>
                   <div class="col-md-7">
                    <div class="input-group col-sm-12 col-xs-12 col-md-12 col-lg-12">
                     <input required placeholder="<?php echo $placeholder_subject; ?>" id="progressive_web_application_support_subject" name="progressive_web_application_support_subject" type="text" value="" class="form-control">
                     <script type="text/javascript">$('#progressive_web_application_support_subject').prop('maxlength', '200');</script>
                   </div>
                 </div>
               </div>
               <div class="form-group required">
                 <label class="col-md-3 control-label"><?php echo $entry_problem_description; ?></label>
                 <div class="col-md-7">
                  <div class="input-group col-sm-12 col-xs-12 col-md-12 col-lg-12">
                   <textarea required rows="5" style="resize:vertical; overflow:auto;" placeholder="<?php echo $placeholder_problem_description; ?>" class="form-control" id="progressive_web_application_support_text" name="progressive_web_application_support_text" maxlength="1024"></textarea>
                   <script type="text/javascript">$('#progressive_web_application_support_text').prop('maxlength', '1024');</script>
                 </div>
               </div>
             </div>
             <div class="form-group required">
               <label class="col-md-3 control-label"><?php echo $entry_ftp_admin; ?></label>
               <div class="col-md-7">
                <div class="input-group col-sm-12 col-xs-12 col-md-12 col-lg-12">
                 <textarea required rows="5" style="resize:vertical; overflow:auto;" placeholder="<?php echo $placeholder_ftp_admin; ?>" class="form-control" id="progressive_web_application_support_connections" name="progressive_web_application_support_connections" maxlength="1024"></textarea>
                 <script type="text/javascript">$('#progressive_web_application_support_connections').prop('maxlength', '1024');</script>
               </div>
             </div>
           </div>
           <div class="form-group">
             <label class="col-md-3 control-label">&nbsp;&nbsp;</label>
             <div class="col-md-7">
              <button id="send-ticket" for="form-progressive-web-application-support" onclick="event.stopPropagation();event.preventDefault();" data-toggle="tooltip" title="<?php echo $button_ticket; ?>" data-loading-text="<?php echo $text_loading_content; ?>" class="btn btn-primary col-sm-12 col-xs-12 col-md-6 col-md-offset-3 col-lg-6 col-lg-offset-3"><i class="fa fa-bug"></i>&nbsp;&nbsp;&nbsp;<b><?php echo $button_ticket; ?></b></button>
            </div>
          </div>

        </div>
      </div>
    </form>

  </div><!-- END TAB SUPPORT -->
</div>
</div>


</div>
</div>
</div>
</div>
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.0/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.0/js/bootstrap-toggle.min.js" async></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-colorpicker/2.5.3/css/bootstrap-colorpicker.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-colorpicker/2.5.3/js/bootstrap-colorpicker.min.js" async></script>
<script type="text/javascript">
$(document).ready(function() {
  //$("ul.nav-tabs li:first").addClass("active");
  //$(".tab-content .tab-pane:first").addClass("active");
  //$('#language a[href="#language1"]').trigger('click');
  $('#language a:first').trigger('click');
  $("#background-color").colorpicker();
  $("#theme-color").colorpicker();
  $("#preloader-background-color").colorpicker();
  $("#preloader-balls-color").colorpicker();

  $("#input-theme-color").focus(function(){
    $("#theme-color").trigger('click');
  }); 

  $("#input-background-color").focus(function(){
    $("#background-color").trigger('click');
  }); 

});
</script>

<script>
$('#send-ticket').on('click', function(e) {
			//e.preventDefault();
			//e.stopPropagation();
            //e.stopImmediatePropagation();
            var node = this;
            var progressive_web_application_support_name = $('#progressive_web_application_support_name').val();
            var progressive_web_application_support_email = $('#progressive_web_application_support_email').val();
            var progressive_web_application_support_subject = $('#progressive_web_application_support_subject').val();
            var progressive_web_application_support_text = $('#progressive_web_application_support_text').val();
            var progressive_web_application_support_connections = $('#progressive_web_application_support_connections').val();
            $.ajax({
            	url: '<?php echo $send_ticket; ?>',
            	method: 'POST',
            	data: {
            		progressive_web_application_support_email: progressive_web_application_support_email, 
            		progressive_web_application_support_name: progressive_web_application_support_name, 
            		progressive_web_application_support_subject: progressive_web_application_support_subject, 
            		progressive_web_application_support_text: progressive_web_application_support_text, 
            		progressive_web_application_support_connections: progressive_web_application_support_connections
            	},
            	dataType: 'json',
            	beforeSend: function() {
            		$('#progressive_web_application_support_name').closest('.input-group').removeClass('has-error');
            		$('#progressive_web_application_support_email').closest('.input-group').removeClass('has-error');
            		$('#progressive_web_application_support_text').closest('.input-group').removeClass('has-error');
            		$('#progressive_web_application_support_subject').closest('.input-group').removeClass('has-error');
            		$('#progressive_web_application_support_connections').closest('.input-group').removeClass('has-error');
            		$('#support-alert').remove();
            		$('#loading').remove();
            		$(node).button('loading');
            		$('<div id="loading"><i class="fa fa-circle-o-notch fa-spin"></i>&nbsp;&nbsp;<?php echo $text_loading_content; ?></div>').prependTo('#results');

            		if ($('#progressive_web_application_support_name').val().length == 0 || $('#progressive_web_application_support_name').val() === undefined) {
            			$('#loading').remove();
            			$(node).button('reset');
            			$('#progressive_web_application_support_name').closest('.input-group').addClass('has-error');
            			$('html, body').animate({scrollTop: $("#results").offset().top-130}, 1500);
            			return false;
            		}

            		if ($('#progressive_web_application_support_email').val().length == 0 || $('#progressive_web_application_support_email').val() === undefined) {
            			$('#loading').remove();
            			$(node).button('reset');
            			$('#progressive_web_application_support_email').closest('.input-group').addClass('has-error');
            			$('html, body').animate({scrollTop: $("#results").offset().top-100}, 1500);
            			return false;
            		}

            		if ($('#progressive_web_application_support_subject').val().length == 0 || $('#progressive_web_application_support_subject').val() === undefined) {
            			$('#loading').remove();
            			$(node).button('reset');
            			$('#progressive_web_application_support_subject').closest('.input-group').addClass('has-error');
            			$('html, body').animate({scrollTop: $("#results").offset().top-70}, 1500);
            			return false;
            		}

            		if ($('#progressive_web_application_support_text').val().length == 0 || $('#progressive_web_application_support_text').val() === undefined) {
            			$('#loading').remove();
            			$(node).button('reset');
            			$('#progressive_web_application_support_text').closest('.input-group').addClass('has-error');
            			$('html, body').animate({scrollTop: $("#results").offset().top-40}, 1500);
            			return false;
            		}

            		if ($('#progressive_web_application_support_connections').val().length == 0 || $('#progressive_web_application_support_connections').val() === undefined) {
            			$('#loading').remove();
            			$(node).button('reset');
            			$('#progressive_web_application_support_connections').closest('.input-group').addClass('has-error');
            			$('html, body').animate({scrollTop: $("#results").offset().top-10}, 1500);
            			return false;
            		}

            		$('#send-ticket').prop("disabled", false); 
            		$('#progressive_web_application_support_name').prop("disabled", false);
            		$('#progressive_web_application_support_email').prop("disabled", false);
            		$('#progressive_web_application_support_text').prop("disabled", false);
            		$('#progressive_web_application_support_subject').prop("disabled", false);
            		$('#progressive_web_application_support_connections').prop("disabled", false);
            	},
            	complete: function() {
            		$('#loading').remove();
            		$('#send-ticket').prop("disabled", false); 
            		$('#progressive_web_application_support_name').prop("disabled", false);
            		$('#progressive_web_application_support_email').prop("disabled", false);
            		$('#progressive_web_application_support_text').prop("disabled", false);
            		$('#progressive_web_application_support_subject').prop("disabled", false);
            		$('#progressive_web_application_support_connections').prop("disabled", false);
            	},
            	success: function(json) {
            		$(node).button('reset');
            		$('#support-alert').remove();
            		if (json['success']) {
            			$('#results').prepend('<div id="support-alert" class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
            		}
            		if (json['error']) {
            			$('#results').prepend('<div id="support-alert" class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
            		}
            		$('#loading').remove();
            		$('#progressive_web_application_support_name').val('');
            		$('#progressive_web_application_support_email').val('');
            		$('#progressive_web_application_support_text').val('');
            		$('#progressive_web_application_support_subject').val('');
            		$('#progressive_web_application_support_connections').val('');
            		$('html, body').animate({scrollTop: $("#results").offset().top-180}, 1500);
            	},
            	error: function(xhr, ajaxOptions, thrownError) {
            		alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            		$('#loading').remove();
            		$(node).button('reset');
            		$('#support-alert').remove();
            		$('#results').prepend('<div id="support-alert" class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>Warning: Fatal Error! <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
            		$('#send-ticket').prop("disabled", false); 
            		$('#progressive_web_application_support_name').prop("disabled", false);
            		$('#progressive_web_application_support_email').prop("disabled", false);
            		$('#progressive_web_application_support_text').prop("disabled", false);
            		$('#progressive_web_application_support_subject').prop("disabled", false);
            		$('#progressive_web_application_support_connections').prop("disabled", false);
            		$('html, body').animate({scrollTop: $("#results").offset().top-180}, 1500);
            	},
            });
});
</script>

<?php echo $footer; ?> 
