<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <img width="36" height="36" style="float:left;margin-right: 10px;" src="view/image/neoseo.png" alt=""> 
      <h1><?php echo $heading_title_raw; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <td class="text-center"><?php echo $column_module_name; ?></td>
                  <td class="text-center"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if (isset($modules) && $modules) { ?>
                <?php foreach ($modules as $module) { ?>
                <tr>
                  <td class="text-left">
                      <img width="24" height="24" src="view/image/neoseo.png" style="margin-right: 10px;float: left;">
                      <p style="margin:0;line-height: 24px;">
                          <?php echo $module['name']; ?>
                          <?php if($module['install']){ ?>
                          <span class="label label-success">(<?php echo $text_install; ?>)<span>
                          <?php } ?>
                      </p>
                  </td>
                  <td class="text-center">
                      <a href="<?php echo $module['link']; ?>" target="_new" data-toggle="tooltip" title="" class="btn btn-success" data-original-title="<?php echo $button_view; ?>">&nbsp;<?php echo $button_more; ?></a>
                  </td>
                </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="text-center" colspan="2"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>
