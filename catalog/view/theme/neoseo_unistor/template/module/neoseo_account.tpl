<?php if ($logged) { ?>
<div class="account-icons">
    <div class="account-icons-list">
        <a href="<?php echo $account; ?>" class="account-icon">
            <div class="account-item box-shadow box-corner">
            <i class="fa fa-user" aria-hidden="true"></i>
           <h6><?php echo $text_account; ?></h6>
        </div>
        </a>

        <a href="<?php echo $order; ?>" class="account-icon">
        <div class="account-item box-shadow box-corner">
            <i class="fa fa-list-alt" aria-hidden="true"></i>
            <h6><?php echo $text_order; ?></h6>
        </div>
        </a>

        <?php if ($reward) { ?>
        <a href="<?php echo $reward; ?>" class="account-icon">
        <div class="account-item box-shadow box-corner">
            <i class="fa fa-gift" aria-hidden="true"></i>
            <h6><?php echo $text_reward; ?></h6>
        </div>
        </a>
        <?php } ?>

        <a href="<?php echo $compare; ?>" class="account-icon">
            <div class="account-item box-shadow box-corner">
                <i class="ns-clone" aria-hidden="true"></i>
                <h6><?php echo $text_compare; ?></h6>
            </div>
        </a>

        <a href="<?php echo $wishlist; ?>" class="account-icon">
        <div class="account-item box-shadow box-corner">
            <i class="fa fa-heart" aria-hidden="true"></i>
            <h6><?php echo $text_wishlist; ?></h6>
        </div>
        </a>

        <?php if ($watched) { ?>
        <a href="<?php echo $watched; ?>" class="account-icon">
        <div class="account-item box-shadow box-corner">
            <i class="fa fa-eye" aria-hidden="true"></i>
            <h6><?php echo $text_watched; ?></h6>
        </div>
        </a>
        <?php } ?>

        <a href="<?php echo $logout; ?>" class="account-icon">
        <div class="account-item box-shadow box-corner">
            <i class="fa fa-sign-out" aria-hidden="true"></i>
            <h6><?php echo $text_logout; ?></h6>
        </div>
        </a>
    </div>
</div>
<?php } ?>
