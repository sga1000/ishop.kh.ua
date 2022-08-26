<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelLocalisationNeoSeoAddress extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);

		$this->_moduleName = "";
		$this->_moduleSysName = "neoseo_checkout";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_status") == 1;
	}

	public function clearAddresses($shipping_method)
	{
		if (is_array($shipping_method)) {
			foreach ($shipping_method as $k => $v) {
				$shipping_method[$k] = $this->db->escape($v);
			}
			$this->db->query("DELETE FROM `" . DB_PREFIX . "city_address` WHERE shipping_method IN ('" . implode("','", $shipping_method) . "')");
			$this->db->query("DELETE FROM `" . DB_PREFIX . "city_address_description` WHERE shipping_method IN ('" . implode("','", $shipping_method) . "')");
		} else {
			$this->db->query("DELETE FROM `" . DB_PREFIX . "city_address` WHERE shipping_method = '" . $this->db->escape($shipping_method) . "'");
			$this->db->query("DELETE FROM `" . DB_PREFIX . "city_address_description` WHERE shipping_method = '" . $this->db->escape($shipping_method) . "'");
		}
	}

	public function addAddress($data)
	{
		reset($data['cities']);
		$city = $data['cities'][key($data['cities'])];
		$this->db->query("INSERT INTO " . DB_PREFIX . "city_address SET name = '" . $this->db->escape($data['name']) . "', zone_id = '" . $this->db->escape($data['zone_id']) . "', city = '" . $this->db->escape($city) . "', shipping_method = '" . $this->db->escape($data['shipping_method']) . "'");

		$address_id = $this->db->getLastId();

		foreach ($data['names'] as $language_id => $name) {
			$city = $data['cities'][$language_id];
			$this->db->query("INSERT INTO " . DB_PREFIX . "city_address_description SET address_id = '" . (int) $this->db->escape($address_id) . "',name = '" . $this->db->escape($name) . "', zone_id = '" . $this->db->escape($data['zone_id']) . "', city = '" . $this->db->escape($city) . "', shipping_method = '" . $this->db->escape($data['shipping_method']) . "', language_id = '" . (int) $language_id . "'");
		}

		$this->cache->delete('address');
	}

	public function editAddress($address_id, $data)
	{
		reset($data['cities']);
		$city = $data['cities'][key($data['cities'])];
		$this->db->query("UPDATE " . DB_PREFIX . "city_address SET name = '" . $this->db->escape($data['name']) . "', zone_id = '" . $this->db->escape($data['zone_id']) . "', city = '" . $this->db->escape($city) . "', shipping_method = '" . $this->db->escape($data['shipping_method']) . "' WHERE address_id = '" . (int) (int) $this->db->escape($address_id) . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "city_address_description WHERE address_id = '" . (int) $this->db->escape($address_id) . "'");

		foreach ($data['names'] as $language_id => $name) {
			$city = $data['cities'][$language_id];
			$this->db->query("INSERT INTO " . DB_PREFIX . "city_address_description SET address_id = '" . (int) $this->db->escape($address_id) . "',name = '" . $this->db->escape($name) . "', zone_id = '" . $this->db->escape($data['zone_id']) . "', city = '" . $this->db->escape($city) . "', shipping_method = '" . $this->db->escape($data['shipping_method']) . "', language_id = '" . (int) $language_id . "'");
		}

		$this->cache->delete('address');
	}

	public function deleteAddress($address_id)
	{

		$this->db->query("DELETE FROM " . DB_PREFIX . "city_address WHERE address_id = '" . (int) $this->db->escape($address_id) . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "city_address_description WHERE address_id = '" . (int) $this->db->escape($address_id) . "'");

		$this->cache->delete('address');
	}

	public function deleteAllAddresses()
	{
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "city_address");
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "city_address_description");
		$this->cache->delete('address');
	}

	public function getAddressDescriptions($address_id)
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "city_address_description WHERE address_id = '" . (int) $this->db->escape($address_id) . "'");

		return $query->rows;
	}

	public function getAddress($address_id)
	{
		$query = $this->db->query("SELECT DISTINCT * , (SELECT z.name FROM " . DB_PREFIX . "zone z WHERE  z.zone_id = a.zone_id) as zone FROM " . DB_PREFIX . "city_address a WHERE address_id = '" . (int) $this->db->escape($address_id) . "'");

		return $query->row;
	}

	public function getAddresses($data = array())
	{
		if ($data) {
			$filtered_columns = array('name' => 'a.name', 'city' => 'a.city', 'shipping_method' => 'a.shipping_method');
			$sql = "SELECT a.*, z.name as zone FROM " . DB_PREFIX . "city_address a LEFT JOIN (" . DB_PREFIX . "zone z) ON (a.zone_id=z.zone_id)";
			$sort_data = array(
				'name',
				'zone',
				'city',
				'shipping_method'
			);

			$and = array();
			if (isset($data['filter'])) {
				if (isset($data['filter']['zone']))
					$and[] = 'z.name LIKE "%' . $this->db->escape($data['filter']['zone']) . '%"';
				foreach ($data['filter'] as $k => $v) {
					if (isset($filtered_columns[$k]))
						$and[] = $filtered_columns[$k] . ' LIKE "%' . $this->db->escape($v) . '%"';
				}
			}
			if (!empty($and))
				$sql .= ' WHERE ' . implode(' AND ', $and);

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];
			} else {
				$sql .= " ORDER BY name";
			}

			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}

			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}

				$sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
			}

			$query = $this->db->query($sql);

			return $query->rows;
		} else {
			$address_data = $this->cache->get('address');

			if (!$address_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "city_address ORDER BY name ASC");

				$address_data = $query->rows;

				$this->cache->set('country', $address_data);
			}

			return $address_data;
		}
	}

	public function getTotalAddresses($data = array())
	{
		$filtered_columns = array('name' => 'a.name', 'city' => 'a.city', 'shipping_method' => 'a.shipping_method');
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "city_address a LEFT JOIN (" . DB_PREFIX . "zone z) ON (a.zone_id=z.zone_id)";
		$and = array();
		if (isset($data['filter'])) {
			if (isset($data['filter']['zone']))
				$and[] = 'z.name LIKE "%' . $this->db->escape($data['filter']['zone']) . '%"';
			foreach ($data['filter'] as $k => $v) {
				if (isset($filtered_columns[$k]))
					$and[] = $filtered_columns[$k] . ' LIKE "%' . $this->db->escape($v) . '%"';
			}
		}
		if (!empty($and))
			$sql .= ' WHERE ' . implode(' AND ', $and);
		$query = $this->db->query($sql);
		return $query->row['total'];
	}

}
