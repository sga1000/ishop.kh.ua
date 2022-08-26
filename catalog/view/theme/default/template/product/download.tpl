<?php if ($product_downloads_status) { ?>
    <table class="table table-bordered table-hover">
    <thead>
    <tr>
        <td class="text-center"><?php echo $text_number_download;?></td>
        <td class="text-center"><?php echo $text_name_download;?></td>
        <td class="text-center"><?php echo $text_size_download;?></td>
        <td class="text-center"><?php echo $text_date_added_download;?></td>
    </tr>
    </thead>
            <tbody>
            <?php $i=0; foreach ($product_downloads as $product_download) { ?>
            <tr>
                <td class="text-right"><?php $i++; echo $i; ?></td>
                <td class="text-left"><?php echo $product_download['name']; ?></td>
                <td class="text-left"><?php echo $product_download['size']; ?></td>
                <td class="text-left"><?php echo $product_download['date_added']; ?></td>
                <td>
                    <a href="<?php echo $product_download['href']; ?>" data-toggle="tooltip" title="<?php echo $button_download; ?>" class="btn btn-primary"><i class="fa fa-cloud-download"></i></a>
                </td>
            </tr>
            <?php } ?>
            </tbody>
        </table>
<?php } ?>


