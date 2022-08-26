<form action="<?php echo $action; ?>" method="post" id="liqpay-form">
  <input type="hidden" name="data" value="<?php echo $request_data; ?>">
  <input type="hidden" name="signature" value="<?php echo $signature; ?>">
  <div class="buttons">
    <div class="pull-right">
      <input type="submit" value="<?php echo $button_confirm; ?>" class="btn btn-primary" />
    </div>
  </div>
</form>
