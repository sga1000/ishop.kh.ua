<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-rss"></i></a>
    <ul class="dropdown-menu dropdown-menu-right">
        <li class="dropdown-header"><?php echo $text_title; ?> <i class="fa fa-plane"></i></li>
        <li class="divider"></li>
        <?php foreach($feeds as $feed) { ?>
        <li><a name="<?php echo $feed['cod']; ?>" href="javascript:void(0);" onclick="doExport('<?php echo $feed['cod']; ?>');" data-token="<?php echo $token; ?>"><?php echo $feed['name']; ?></a></li>
        <?php }?>
    </ul>
</li>
