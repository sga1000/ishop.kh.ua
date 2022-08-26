<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-address" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-address" class="form-horizontal">
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name-2"><?php echo $column_language_id; ?></label>
            <div class="col-sm-10">
              <?php foreach($languages as $language ) { ?>
              <div class="input-group">
                <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"></span>
                <input class="form-control" name="names[<?php echo $language['language_id']; ?>]" value="<?php echo isset($names[$language['language_id']]) ? $names[$language['language_id']] : ''; ?>">
              </div>
              <?php } ?>
            </div>

          </div>


          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-zone"><?php echo $entry_zone; ?></label>
            <div class="col-sm-10">
              <select name="zone_id" id="input-zone" class="form-control">
                <?php foreach ($zones as $id => $name ) { ?>
                <?php if ( $id == $zone_id ) { ?>
                <option value="<?php echo $id; ?>" selected="selected"><?php echo $name; ?></option>
                <?php } else { ?>
                <option value="<?php echo $id; ?>"><?php echo $name; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>


          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-city"><?php echo $entry_city; ?></label>
			<div class="col-sm-10">
				<?php foreach($languages as $language ) { ?>
					<div class="input-group">
						<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"></span>
						<input class="form-control" name="cities[<?php echo $language['language_id']; ?>]" value="<?php echo isset($cities[$language['language_id']]) ? $cities[$language['language_id']] : ''; ?>">
					</div>
				<?php } ?>
			</div>
          </div>

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-shipping_method"><?php echo $entry_shipping_method; ?></label>
            <div class="col-sm-10">
              <select name="shipping_method" id="input-shipping_method" class="form-control">
                <?php foreach ($shipping_methods as $code => $name ) { ?>
                <?php if ( $code == $shipping_method ) { ?>
                <option value="<?php echo $code; ?>" selected="selected"><?php echo $name; ?></option>
                <?php } else { ?>
                <option value="<?php echo $code; ?>"><?php echo $name; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>


        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>