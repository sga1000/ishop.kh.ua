<?php if ($product_downloads_status) { ?>
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th scope="col"><?php echo $text_number_download;?></th>
                <th scope="col"><?php echo $text_name_download;?></th>
                <th scope="col"><?php echo $text_size_download;?></th>
                <th scope="col"><?php echo $text_date_added_download;?></th>
                <th scope="col"></th>
            </tr>
        </thead>
        <tbody>
            <?php $i=0; foreach ($product_downloads as $product_download) { ?>
                <tr>
                    <td data-label="<?php echo $text_number_download;?>"><?php $i++; echo $i; ?></td>
                    <td data-label="<?php echo $text_name_download;?>"><?php echo $product_download['name']; ?></td>
                    <td data-label="<?php echo $text_size_download;?>"><?php echo $product_download['size']; ?></td>
                    <td data-label="<?php echo $text_date_added_download;?>"><?php echo $product_download['date_added']; ?></td>
                    <td data-label=""><a href="<?php echo $product_download['href']; ?>" data-toggle="tooltip" title="<?php echo $button_download; ?>" class="btn btn-primary"><i class="fa fa-cloud-download"></i></a></td>
                </tr>
            <?php } ?>
        </tbody>
    </table>
<?php } ?>


