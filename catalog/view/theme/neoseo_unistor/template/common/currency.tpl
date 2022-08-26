<?php if (count($currencies) > 1) { ?>
<div class="currency-box dropdown">
    <div class='currency-box__wrap dropdown-toggle' role="button" data-toggle="dropdown">
        <ul class="list-inline">
        <?php foreach ($currencies as $currency) { ?>
        <?php if ($currency['code'] == $code) { ?>
        <?php $symbol = $currency['symbol_right'] ? $currency['symbol_right']  : $currency['symbol_left']?>
        <li class='current' title="<?php echo  $currency['title'] ?>">
            <b><?php echo $symbol ?></b> <i class="fa fa-angle-down carets"></i>
        </li>
        <?php } ?>
        <?php } ?>
        </ul>
    </div>
    <div class="currency-box__compact-wrap dropdown-menu" role="menu">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="currency">
            <ul class="currency-box__wrap__list list-inline">
                <?php foreach ($currencies as $currency) { ?>
                <?php if ( $currency['code'] == $code) { ?>
                <?php if ($currency['symbol_left']) { ?>
                <li class="active" title="<?php echo  $currency['title'] ?>">
                    <button class="currency-select btn" type="button" name="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_left']; ?></button>
                </li>
                <?php } else { ?>
                <li class="active" title="<?php echo  $currency['title'] ?>">
                    <button class="currency-select btn" type="button" name="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_right']; ?></button>
                </li>
                <?php } ?>
                <?php } else { ?>
                <?php if ($currency['symbol_left']) { ?>
                <li title="<?php echo  $currency['title'] ?>">
                    <button class="currency-select btn" type="button" name="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_left']; ?></button>
                </li>
                <?php } else { ?>
                <li title="<?php echo  $currency['title'] ?>">
                    <button class="currency-select btn" type="button" name="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_right']; ?></button>
                </li>
                <?php } ?>
                <?php } ?>
                <?php } ?>
            </ul>
            <input type="hidden" name="code" value=""/>
            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>"/>
        </form>
    </div>
</div>
<?php } ?>
