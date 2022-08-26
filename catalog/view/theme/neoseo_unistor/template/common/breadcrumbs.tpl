<ul class="breadcrumb box-corner">
    <?php $cnt = count($breadcrumbs); $i = 0; foreach ($breadcrumbs as $key => $breadcrumb) { ?>
    <li>
        <?php $i++; if( $i != $cnt ) { ?>
        <a href="<?php echo $breadcrumb['href']; ?>">
            <span><?php echo $breadcrumb['text']; ?></span>
        </a>
        <?php } else { ?>
            <span><?php echo $breadcrumb['text']; ?></span>
        <?php } ?>
    </li>
    <?php } ?>
</ul>