<a href="<?php echo $home; ?>" class="navbar-brand">
	<?php if($image) { ?>
	<img src="view/image/ishop_logo.png" alt="ishop" title="ishop"/>
	<?php }else{ ?>
	<img src="view/image/logo.png" alt="" title=""/>
	<?php } ?>
</a>
<a href="#" class="dropdown-toggle dropdown-arrow navbar-brand " data-toggle="dropdown"><span><?php echo $firstname; ?> <?php echo $lastname; ?></span> <img src="view/image/icon-arrow-menu.png" alt=""></a>

<div class="dropdown-menu">
        <a href="<?php echo $edit_user;?>" class=""><i class="fa fa-user"></i><?php echo $firstname; ?> <?php echo $lastname; ?> (<small><?php echo $user_group; ?></small>)</a>

        <a href="https://neoseo.com.ua" target="_blank"><i class="fa fa-question-circle"></i><?php echo $text_help; ?></a>
</div>