<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelPaymentNeoSeoPaymentLiqPay extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_payment_liqpay';
		$this->_modulePostfix = "";
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;

		$cron=array();
		foreach (range(1, 7) as $day_id) {
			$cron[$day_id] = array(
				'from' => '00:00',
				'to' => '23:59',
			);
		}

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'merchant'=>'',
			'signature'=>'',
			'type'=>'liqpay',
			'total'=>'',
            'hold' => 0,
			'order_status_id'=>0,
			'hold_order_status_id'=>0,
			'missing_order_status_id'=>10,
			'geo_zone_id'=>'',
			'sort_order'=>1,
			'cron_status'=>0,
			'non_working_days'=>'',
			'cron'=>$cron,
		);
	}

	public function install()
	{
		$this->initParams($this->params);
		return TRUE;
	}

	public function upgrade()
	{
		$this->initParams($this->params);
	}

	public function uninstall()
	{
		return TRUE;
	}

}

