<?php
if( !isset($group) ) {
$group = '';
}

foreach ($fields as $field) {
$field_id  = $field['name'] . $group;
$type  = $field['type'];
$name = $field['name'];
$only_register = (isset($field['only_register']) && $field['only_register']) ? 'true' : 'false';
$value =  isset($field['value']) ? $field['value'] : $field['default'];
$default = $field['default'];
$label = $field['label'];
if( is_array($field['label']) ) {
$label = $field['label'][$language_id];
}
$required = '';
if( $field['required'] )
$required = ' required';
//$label = '<span class="required">*</span> ' . $label;

$error_style = isset($errors) && isset($errors[$name]) ? ' has-error' : "";
$error_name = isset($errors) && isset($errors[$name]) ? '<span class="help-block">' . $errors[$name] . '</span>' : "";

if( !$field['display'] ) { ?>
<input type="hidden" name="<?php echo $name; ?>" value="<?php echo $value; ?>" />
<?php } else if( $type == "input") { ?>
<div class="row field form-group<?php echo $error_style; ?><?php echo $required; ?>">
	<!-- <div class="col-sm-4">
		<label for="<?php echo $field_id; ?>" class="control-label"><?php echo $label; ?>:</label>
	</div> -->
	
	<div class="field-main col-sm-4">
		<label for="<?php echo $field_id; ?>" class="control-label"></label>
		<input type="text" class="form-control" id="<?php echo $field_id; ?>" data-register="<?php echo $only_register;?>" name="<?php echo $name; ?>" value="<?php echo $value; ?>" class="large-field" placeholder="<?php echo $label; ?>" /> <?php echo $error_name; ?>
	</div>
	<?php if( $field['mask'] ) { ?><script>$("#<?php echo $field_id; ?>").mask("<?php echo $field['mask']; ?>");</script><?php } ?>
</div>
<?php } else if( $type == "password") { ?>
<div class="row field form-group<?php echo $error_style; ?><?php echo $required; ?>">
	<!-- <div class="col-sm-4">
		<label for="<?php echo $field_id; ?>" class="control-label"><?php echo $label; ?>:</label>
	</div> -->
	
	<div class="field-main col-sm-4">
		<label for="<?php echo $field_id; ?>" class="control-label"></label>
		<input type="password" class="form-control" id="<?php echo $field_id; ?>" data-register="<?php echo $only_register;?>" name="<?php echo $name; ?>" value="<?php echo $value; ?>" class="large-field" placeholder="<?php echo $label; ?>" /> <?php echo $error_name; ?>
	</div>
</div>
<?php } else if( $type == "checkbox") { ?>
<div class="row field form-group<?php echo $error_style; ?><?php echo $required; ?>">
	<div class="col-sm-4 text-left checkbox checkbox-primary checkbox-inline subscribe-on-news">
		<input class="checkbox" type="checkbox" id="<?php echo $field_id; ?>" data-register="<?php echo $only_register;?>" name="<?php echo $name; ?>" <?php if ( $value ) echo 'checked="checked"'; ?> /> <?php echo $error_name; ?>
		       <label for="<?php echo $field_id; ?>" class="control-label"><?php echo $text_subscribe_on_news; ?></label>
	</div>
</div>
<?php } else if( $type == "radio") { ?>

<?php $vals = explode(';',$default); if(sizeof($vals)>1) { ?>
<div class="row field form-group<?php echo $error_style; ?><?php echo $required; ?>">
	<div class="col-sm-4">
		<h3><?php echo $label; ?></h3>
	</div>
	<div class="col-sm-8">
	<?php $ix = 0; foreach($vals as $val) { ?>
	<div class="radio radio-primary">
		<input type="radio" id="<?php echo $field_id.'_'.$i.$ix; ?>" name="<?php echo $name; ?>" value="<?php echo $label; ?>: <?php echo $val; ?>" /> <?php echo $error_name; ?>
		<label for="<?php echo $field_id.'_'.$i.$ix; ?>" class="control-label"><?php echo $val; ?></label>
	</div>
	<?php $ix++; } ?>
	</div>
</div>
<?php } else { ?>
<div class="row field form-group<?php echo $error_style; ?><?php echo $required; ?>">
	<div class="col-sm-offset-4 col-sm-8 radio radio-primary radio-inline">
		<input type="radio" id="<?php echo $field_id; ?>" data-register="<?php echo $only_register;?>" name="<?php echo $name; ?>" value="<?php echo $value; ?>" /> <?php echo $error_name; ?>
		<label for="<?php echo $field_id; ?>" class="control-label"><?php echo $label; ?>:</label>
	</div>
</div>
<?php } ?>

<?php } else if( $type == "textarea") { ?>
<div class="row field form-group<?php echo $error_style; ?><?php echo $required; ?>">
	<div class="col-sm-4">
		<label for="<?php echo $field_id; ?>" class="control-label"><?php echo $label; ?>:</label>
	</div>
	<div class="col-sm-8">
		<textarea id="<?php echo $field_id; ?>" data-register="<?php echo $only_register;?>" name="<?php echo $name; ?>" class="form-control"><?php echo $value; ?></textarea> <?php echo $error_name; ?>
	</div>
</div>
<?php } else if( $type == "select") { ?>
<div class="row field form-group<?php echo $error_style; ?><?php echo $required; ?>">
	<div class="col-sm-4">
		<label for="<?php echo $field_id; ?>" class="control-label"><?php echo $label; ?>:</label>
	</div>
	<div class="col-sm-8">
		<select id="<?php echo $field_id; ?>" data-register="<?php echo $only_register;?>" name="<?php echo $name; ?>" class="form-control">
			<?php foreach( $field['values'] as $code => $name ) { ?>
			<option value="<?php echo $code; ?>" <?php if ( $code == $value ) { ?> selected="selected" <?php } ?>><?php echo $name; ?></option>
			<?php } ?>
		</select>
		<?php echo $error_name; ?>
	</div>
</div>
<?php }elseif($type == "html") { ?>
<div class="field text-block">
	<?php echo html_entity_decode($value); ?>
</div> 
<?php }elseif($type == "file") {  ?>
<div class="row field form-group<?php echo $error_style; ?><?php echo $required; ?>">
	<div class="col-sm-4">
		<label for="<?php echo $field_id; ?>" class="control-label"><?php echo $label; ?>:</label>
	</div>
	<div class="col-sm-8">
		<div class="button-uploading" style="width:144px; height:40px; position:relative;">
			<input type="file" id="input_images" style="display:block; cursor:pointer; opacity:0; filter: alpha(opacity=0); position:absolute; width:144px; height:40px; left:0; top:0;" name="filename" multiple="multiple"/>
			<a href=""  class="btn btn-primary select-files"><?php echo $text_files_upload; ?></a>
		</div>
		<ul id="ul-photo-preview" style="display:block; margin-left:0px; padding-left:0px;">
			<?php if($value){ ?>
			<?php foreach($value as $key => $file_val) { ?>
			       <li style="background-image:url(/image/neoseo_checkout/file.png); border:none;"><?php echo isset($file_val['mask_name']) ? $file_val['mask_name'] : $file_val['name'];?><a href="" onclick="del_photo(this, <?php echo $key+1;?>);return false;"></a></li>
			<?php } ?>
			<?php } ?>
			<div>
		</ul>
	</div>
</div>
</div>
<script>
	$(document).ready(function ()
	{	
		files_array = [];
		$('#input_images').unbind('change');
		$('#input_images').change(function (event){read_file($(this)[0].files);});
	});

	function read_file(file)
	{ 
		//$('.error_files').remove();
		for (var i = 0; i < file.length; i++)
		{ console.log(file[i].type.indexOf('/spreadsheetml.sheet/'));
			if (file[i].type.indexOf('image') !== -1)
			{ 
				files_array[files_array.length]=file[i];
				var reader = new FileReader();
				reader.onload = function (event)
				{
					var contents = event.target.result;
					$('#ul-photo-preview').append('<li style="background-image:url(' + contents + ');"><a href="" onclick="del_photo(this,' + files_array.length + '); return false;"></a></li>');
				};
				reader.readAsDataURL(file[i]);
			} else if (file[i].type.indexOf('text/plain') !== -1)
			{
				files_array[files_array.length] = file[i];
				$('#ul-photo-preview').append('<li style="background-image:url(/image/neoseo_checkout/txt.png); border:none;"><a href="" onclick="del_photo(this,' + files_array.length + '); return false;"></a></li>');
			} else if (file[i].type.indexOf('rtf') !== -1 || file[i].type.indexOf('msword') !== -1)
			{ 
				files_array[files_array.length] = file[i];
				if (file[i].type.indexOf('openxmlformats-officedocument') !== -1)
					$('#ul-photo-preview').append('<li style="background-image:url(image/neoseo_checkout/xls.ico); border:none;"><a href="" onclick="del_photo(this,' + files_array.length + '); return false;"></a></li>');
				else
					$('#ul-photo-preview').append('<li style="background-image:url(/image/neoseo_checkout/doc.ico); border:none;"><a href="" onclick="del_photo(this,' + files_array.length + '); return false;"></a></li>');
			} else if (file[i].type.indexOf('openxmlformats-officedocument') !== -1)
			{  
				files_array[files_array.length] = file[i];
				$('#ul-photo-preview').append('<li style="background-image:url(/image/neoseo_checkout/xls.ico); border:none;"><a href="" onclick="del_photo(this,' + files_array.length + '); return false;"></a></li>');
			} else{
				files_array[files_array.length] = file[i];
				$('#ul-photo-preview').append('<li style="background-image:url(/image/neoseo_checkout/file.png); border:none;"><a href="" onclick="del_photo(this,' + files_array.length + '); return false;"></a></li>');
		
		//$('.button-uploading').after('<span class="error_files" style="color:#f00"><?php echo $error_upload_file;?><span>');
			}
		}
	}

	function del_photo(obj, index)
	{
		var obj;
		$(obj).parent('li').remove();
		delete(files_array[index - 1]);
	}
</script>				
<?php } ?>
<?php } ?>
