<?php if (count($languages) > 1) { ?>
<div class="language dropdown">
	<div class='language__wrap dropdown-toggle' role="button" data-toggle="dropdown">
		<?php foreach ($languages as $language) { ?>
		<?php if ($language['code'] == $code) { ?>
		<span class="text-uppercase" data-code="<?php echo $language['code']; ?>"><?php echo $language['code']; ?></span>
		<i class="fa fa-angle-down carets"></i>
		<?php } ?>
		<?php } ?>
	</div>
	<ul class="language__compact-wrap list-inline">
		<?php foreach ($languages as $language) { ?>
		<?php if ($language['code'] == $code) { ?>
		<li class="active" data-code="<?php echo $language['code']; ?>">
			<a onclick="">
				<?php echo $language['code']; ?>
			</a>
		</li>
		<?php } else { ?>
		<li data-code="<?php echo $language['code']; ?>">
			<a href="<?php echo $language['url']; ?>">
				<?php echo $language['code']; ?>
			</a>
		</li>
		<?php } ?>
		<?php } ?>
	</ul>
</div>
<?php } ?>
