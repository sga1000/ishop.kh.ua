<?php
class ControllerCommonProfile extends Controller {
	public function index() {
		$data= $this->load->language('common/menu');

		$this->load->model('user/user');

		$this->load->model('tool/image');

		$user_info = $this->model_user_user->getUser($this->user->getId());

		if ($user_info) {
			$data['firstname'] = $user_info['firstname']; 
			$data['lastname'] = $user_info['lastname'];
			$data['username'] = $user_info['username'];

			$data['user_group'] = $user_info['user_group'] ;

			$data['edit_user'] = $this->url->link('user/user/edit', 'token=' . $this->session->data['token'] . '&user_id='.$user_info['user_id'], 'SSL');

			if (is_file(DIR_IMAGE . $user_info['image'])) {
				$data['image'] = $this->model_tool_image->resize($user_info['image'], 45, 45);
			} else {
				$data['image'] = '';
			}
		} else {
			$data['username'] = '';
			$data['image'] = '';
		}

		$data['home'] = $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL');
		
		return $this->load->view('common/profile.tpl', $data);
	}
}
