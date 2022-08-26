<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelLocalisationNeoSeoCity extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);

		$this->_moduleName = "";
		$this->_moduleSysName = "neoseo_checkout";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_status") == 1;
	}

	public function addCity($data)
	{
		// Нам нужна защита от дубликатов на уровне добавления
		foreach ($data['name'] as $language_id => $name) {
			$sql = "SELECT c.city_id 
                      FROM " . DB_PREFIX . "city c 
                           LEFT JOIN " . DB_PREFIX . "city_description cd ON (cd.city_id = c.city_id) 
                     WHERE cd.language_id = '" . (int)$language_id . "'
                       AND cd.name = '" . $this->db->escape($name) . "'
                       AND c.country_id = '" . (int)$data['country_id'] . "'
                       AND c.zone_id = '" . (int)$data['zone_id'] . "'
                       ";
			$query = $this->db->query($sql);
			if( $query->num_rows ) {
				return $query->row['city_id'];
			}
		}

		// Все ок, можно добавлять
		$this->db->query("INSERT INTO " . DB_PREFIX . "city SET status = '" . (int) $data['status'] . "', zone_id = '" . $this->db->escape($data['zone_id']) . "', country_id = '" . (int) $data['country_id'] . "'");
		$city_id = $this->db->getLastId();

		foreach ($data['name'] as $language_id => $name) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "city_description SET city_id = '" . (int) $city_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($name) . "'");
		}

		$this->cache->delete('city');
		return $city_id;
	}

	public function editCity($city_id, $data)
	{
		$this->db->query("UPDATE " . DB_PREFIX . "city SET status = '" . (int) $data['status'] . "', zone_id = '" . $this->db->escape($data['zone_id']) . "', country_id = '" . (int) $data['country_id'] . "' WHERE city_id = '" . (int) $city_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "city_description WHERE city_id = '" . (int) $city_id . "'");

		foreach ($data['name'] as $language_id => $name) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "city_description SET city_id = '" . (int) $city_id . "', language_id = '" . (int) $language_id . "', name = '" . $this->db->escape($name) . "'");
		}
		$this->cache->delete('city');
	}

	public function deleteCity($city_id)
	{
		$this->db->query("DELETE FROM " . DB_PREFIX . "city WHERE city_id = '" . (int) $city_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "city_description WHERE city_id = '" . (int) $city_id . "'");

		$this->cache->delete('city');
	}

	public function getCity($city_id)
	{
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "city ct LEFT JOIN " . DB_PREFIX . "city_description cd ON (ct.city_id = cd.city_id) WHERE ct.city_id = '" . (int) $city_id . "' AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "'");

		return $query->row;
	}

	public function getCities($data = array())
	{
		$sql = "SELECT *, cd.name AS name, c.name AS country, z.name as zone_name FROM " . DB_PREFIX . "city ct LEFT JOIN " . DB_PREFIX . "country c ON (ct.country_id = c.country_id) LEFT JOIN " . DB_PREFIX . "zone z ON (ct.zone_id = z.zone_id) LEFT JOIN " . DB_PREFIX . "city_description cd ON (ct.city_id = cd.city_id) WHERE cd.language_id = '" . (int) $this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND cd.name LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
		}
		if (!empty($data['filter_country'])) {
			$sql .= " AND ct.country_id = '" . (int) $data['filter_country'] . "'";
		}
		if (!empty($data['filter_zone'])) {
			$sql .= " AND ct.zone_id = '" . (int) $data['filter_zone'] . "'";
		}

		$sort_data = array(
			'cd.name',
			'c.name',
			'z.name',
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY cd.name";
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
	}

	public function getCityDescriptions($city_id)
	{
		$city_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "city_description WHERE city_id = '" . (int) $city_id . "'");

		foreach ($query->rows as $result) {
			$city_data[$result['language_id']] = $result['name'];
		}

		return $city_data;
	}

	public function getCitiesByCountryId($country_id)
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "city WHERE country_id = '" . (int) $country_id . "' AND status = '1' ORDER BY name");

		$city_data = $query->rows;

		return $city_data;
	}

	public function getCitiesByZoneId($zone_id)
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "city WHERE zone_id = '" . (int) $zone_id . "' AND status = '1' ORDER BY name");

		$city_data = $query->rows;

		return $city_data;
	}

	public function deleteAllCities()
	{
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "city");
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "city_description");
		$this->cache->delete('neoseo_city');
	}

	public function getTotalCities($data = array())
	{
		$sql = "SELECT COUNT(DISTINCT ct.city_id) AS total FROM " . DB_PREFIX . "city ct LEFT JOIN " . DB_PREFIX . "city_description cd ON (ct.city_id = cd.city_id) WHERE cd.language_id = '" . (int) $this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND cd.name LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
		}
		if (isset($data['filter_country']) && !is_null($data['filter_country'])) {
			$sql .= " AND ct.country_id = '" . (int) $data['filter_country'] . "'";
		}

		if (isset($data['filter_zone']) && !is_null($data['filter_zone'])) {
			$sql .= " AND ct.zone_id = '" . (int) $data['filter_zone'] . "'";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getTotalCitiesByCountryId($country_id)
	{
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "city WHERE country_id = '" . (int) $country_id . "'");
		return $query->row['total'];
	}

	public function getTotalCitiesByZoneId($zone_id)
	{
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "city WHERE zone_id = '" . (int) $zone_id . "'");
		return $query->row['total'];
	}

	public function lookup_city($name, $zone_id, $country_id)
	{

		$result = array();

		$sql = "SELECT cd.`name`, c.zone_id, c.country_id
					FROM " . DB_PREFIX . "city_description cd
					     INNER JOIN " . DB_PREFIX . "city c on ( c.city_id = cd.city_id )
				WHERE cd.name like '" . $name . "%' 
				  AND c.status = '1'
				  AND cd.language_id = '" . $this->config->get('config_language_id') . "'
			    ";
		if ($country_id != 0) {
			$sql .= " AND c.country_id = " . ($country_id) . "";
			if ($zone_id != 0) {
				$sql .= " AND c.zone_id = " . ($zone_id) . "";
			}
		}
		$sql .= " ORDER BY `name` LIMIT 0,20";

		$query = $this->db->query($sql);
		foreach ($query->rows as $row) {
			$item = array();
			$item['city'] = $row['name'];
			$item['zone_id'] = $row['zone_id'];
			$item['country_id'] = $row['country_id'];
			$result[] = $item;
		}

		return $result;
	}

}
