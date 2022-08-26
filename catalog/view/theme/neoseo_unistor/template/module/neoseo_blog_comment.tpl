<div class="catalogSidebarBlock">
	<a class="sidebarBlockTitle slideupBtn"><i class="icon-big-megaphone"></i><span><?php echo $heading_title; ?></span></a>
	<div class="sidebarBlockContent slideupCont">
		<ul class="sidebarNewsList">
			<?php foreach ($comments as $comment) { ?>
			<li><a href="<?php echo $comment['href']; ?>" class="item">
					<div class="item-pic"><img alt="" src="<?php echo $comment['thumb']; ?>"></div>
					<div class="item-desc">
						<div class="item-date"><?php echo $comment['date_modified']; ?></div>
						<div class="item-text"><?php echo $comment['name']; ?></div>
					</div>
				</a>
			</li>
			<?php } ?>
		</ul>
	</div>
</div>