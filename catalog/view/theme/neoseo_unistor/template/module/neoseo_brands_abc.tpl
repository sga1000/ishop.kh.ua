<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_brands_abc_', $params); ?>
<div class="brands <?php if ($is_home && $menu_type) {?>side-brands<?php } ?>">
	<div class="brands__title">
		<?php echo $heading_title; ?>
	</div>
	<?php foreach ($letters as $key => $letter) { ?>
	<div class="brands__ul">
		<a href="<?php echo $letter['href']; ?>"><?php echo $key ?></a>
		<div class="brands__ul-box">
			<?php foreach ($letter['manufacturers'] as $manufacturer) { ?>
			<a onclick="location.href='<?php echo $manufacturer['href']; ?>'"><?php echo $manufacturer['name'] ?></a>
			<?php } ?>
		</div>
	</div>
	<?php } ?>
</div>