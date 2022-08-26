<?php
require_once( DIR_SYSTEM . "/engine/soforp_model.php");
class ModelModuleNeoseoCategoryWallBlock extends SoforpModel {

	// Install/Uninstall
	public function install()
	{
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'module/neoseo_category_wall_block');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'module/neoseo_category_wall_block');
        $this->load->model('user/user_group');
	//@todo: Продумать как объеденить 2 файла модуля в один

	}


	public function uninstall() {

	}

	public function upgrade(){

	}

}
