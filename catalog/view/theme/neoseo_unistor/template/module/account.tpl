<?php if ($logged) { ?>
<div class="account-icons">
    <div class="chekout-container">
    <a href="<?php echo $account; ?>" class="account-icon"><?php echo $text_account; ?></a>
    <a href="<?php echo $order; ?>" class="account-icon"><?php echo $text_order; ?></a>

<?php if ($reward) { ?>
    <a href="<?php echo $reward; ?>" class="account-icon"><?php echo $text_reward; ?></a>
<?php } ?>

    <a href="<?php echo $wishlist; ?>" class="account-icon"><?php echo $text_wishlist; ?></a>

    <a href="<?php echo $logout; ?>" class="account-icon"><?php echo $text_logout; ?></a>
</div>
</div>
<?php } ?>
