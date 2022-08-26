<?php
// Heading
$_['heading_title']  = 'NeoSeo Backups';

// Column
$_['column_id']  = '№';
$_['column_name']  = 'Copy';
$_['column_action']  = 'Action';

// Button
$_['button_close']  = 'Close';
$_['button_backup']  = 'Create a copy';
$_['button_download'] = 'Download copy';
$_['button_restore']  = 'Restore database only';
$_['button_delete']  = 'Delete copy';

// Text
$_['text_neoseo_backup']  = 'Backups';
$_['text_backup_format']  = 'Copy from %s';
$_['text_confirm_restore'] = "Attention!!!\\r\\n\\r\\nIn the case of severe restrictions of your hosting, restoring from backup may not be able to work. In this case, you need to perform manual recovery through PhpMyAdmin, or other tool to work with the database \r\n\r\n If you firmly believe that hosting will not fail, than click OK";
$_['text_confirm_delete'] = "Attention!!!\\r\\n\\r\\nBackup does not happen a lot! Very often, after the removal of the backup needs just the data that it holds. We do not recommend that you remove the copy manually \r\n\r\n If you firmly believe that you need to remove copy - click OK";
$_['text_success_restore'] = "Database recovery successfully completed";
$_['text_error_restore'] = "Restoring the database is unsuccessful";
$_['text_success_delete'] = "Removing the backup completed successfully";
$_['text_error_delete'] = "Removing the backup is unsuccessful";
$_['text_success_backup'] = "Backup completed successfully!";
$_['text_error_backup'] = "Backup completed with errors";
$_['text_error_auth'] = 'Authorization error, please check the settings.';

$_['text_subject']  = 'Backup for {domain} - {status}!';
$_['text_report']  = '<p>Backup completed with status "{status}"!</p><ul><li>Database - "{status_sql}", {size_sql}MB for {time_sql} sec</li><li>Catalog - "{status_zip}", {size_zip}MB for {time_zip} sec</li><li>Upload - "{status_upload}", {time_upload} sec, speed {speed_upload}mBs</li></ul><p>Overall time - {time} seconds!</p>';

$_['text_success']  = 'successfull';
$_['text_skipped']  = 'skipped';
$_['text_failed']   = 'error';
$_['text_denied']   = 'access denied';