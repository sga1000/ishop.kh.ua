<?php

class ModelModuleNeoSeoCashMemo extends Model
{

	// Install/Uninstall
	public function install()
	{

		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'sale/neoseo_cash_memo');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'sale/neoseo_cash_memo');
	}

	public function uninstall()
	{
		
	}

}
