<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_brands_abc_', $params);
?>
<div id="neoseo-brands-abc" class="row">
	<div class="wrapper col-xs-12">
		<div class="heading">
			<?php echo $heading_title; ?>
		</div>
		<ul>
		<?php foreach ($letters as $key => $letter) { ?>
			<li>
				<a onclick="location.href='<?php echo $letter['href']; ?>'"><?php echo $key ?></a>
				<div class="hidden-xs">
					<ul>
						<?php foreach ($letter['manufacturers'] as $manufacturer) { ?>
						<li>
							<a onclick="location.href='<?php echo $manufacturer['href']; ?>'"><?php echo $manufacturer['name'] ?></a>
						</li>
						<?php } ?>
					</ul>
				</div>
			</li>
		<?php } ?>
		</ul>
	</div>
</div>