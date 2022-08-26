<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="width=device-width; initial-scale=1.0; maximum-scale=1.0;" name="viewport">

<img src="<?php echo $logo; ?>">

<p style="margin-bottom: 20px;font-size:16px;">
	<b><?php echo $text_top; ?></b>
</p>

<table border="0" style="font-family: 'Helvetica Neue', Helvetica, sans-serif;font-size:14px;max-width:800px;" width="100%">
	<tbody>
		<tr style="background-color:rgba(0,0,0,0.1);font-weight:normal;font-size:13px">
			<td height="20" style="padding: 5px;" width="60%"><?php echo $column_name; ?></td>
			<td style="padding: 5px; text-align: right;" width="20%"><?php echo $column_quantity; ?></td>
			<td style="padding: 5px; text-align: right;" width="20%"><?php echo $column_price; ?></td>
		</tr>
		<?php foreach ($products as $product) { ?>
		<tr>
			<td style="padding: 5px; border-bottom: 1px dotted #ddd;">
				<a href="<?php echo $product['href']; ?>">
					<img src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" style="float:left;width:40px;height:40px;margin-right:12px;">
				</a>
				<a href="<?php echo $product['href']; ?>" style='font-size:13px;color:#656769;text-decoration:underline;'><?php echo $product['name']; ?></a>
				<ul style="margin:5px 0 0 0;padding:5px 0 0 10px;font-size:11px;color:#999;">
					<?php echo $product['option']; ?>
				</ul>
				<br style="clear:both">
			</td>
			<td style="font-size:13px;padding:5px;border-bottom-width:1px;border-bottom-style:dotted;border-bottom-color:rgb(199,199,199);text-align:right;"><span style="font-family: Helvetica, sans-serif; text-align: right;"><?php echo $product['quantity']; ?></span></td>
			<td style="font-size:13px;padding:5px;border-bottom-width:1px;border-bottom-style:dotted;border-bottom-color:rgb(199,199,199);text-align:right;"><span style="font-family: Helvetica, sans-serif; text-align: right;"><?php echo $product['price']; ?></span></td>
		</tr>
		<?php } ?>
		<tr>
			<td align="right" colspan="2" style="margin-top: 10px; border-top: 1px dotted #c7c7c7;" width="80%"><b><?php echo $text_total; ?></b></td>
			<td style="margin-top: 10px; border-top-width: 1px; border-top-style: dotted; border-top-color: rgb(199, 199, 199); font-size: 16px; text-align: right;" width="20%"><span style="font-family: Arial, Helvetica, sans-serif; text-align: right;"><?php echo $total; ?></span></td>
		</tr>
	</tbody>
</table>

<p style="font-size:13px;">
	<a href="<?php echo $restore_url; ?>"><?php echo $text_bottom; ?></a>
</p>