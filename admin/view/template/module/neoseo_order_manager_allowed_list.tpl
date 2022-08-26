<?php foreach($statusData as $data) { ?>
    <input type='checkbox' id='osa-<?php echo $data["status_id"]; ?>' name='allowed[<?php echo $data["status_id"] ?>]' value='<?php echo $data["status_id"] ?>' <?php if ($data["allowed"]) echo "checked='checked'"; ?>  />  
    <label for='osa-<?php echo $data["status_id"]; ?>'><?php echo $data["name"] ?></label> <br />	
<?php } ?>