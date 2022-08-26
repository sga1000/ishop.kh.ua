<?php
class ModelLocalisationZone extends Model {
	public function addZone($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "zone SET status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($data['name']) . "', code = '" . $this->db->escape($data['code']) . "', country_id = '" . (int)$data['country_id'] . "'");
		/* NeoSeo Checkout - begin */
		$zone_id = $this->db->getLastId();
		foreach ($data['names'] as $language_id =>$name)
		{
			$this->db->query("INSERT INTO " . DB_PREFIX . "zone_description SET zone_id = '". $zone_id ."', status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($name) . "', code = '" . $this->db->escape($data['code']) . "', country_id = '" . (int)$this->db->escape($data['country_id']). "', language_id = '" . (int)$language_id . "'");
		}
		/* NeoSeo Checkout - end */

		$this->cache->delete('zone');
	}

	public function editZone($zone_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "zone SET status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($data['name']) . "', code = '" . $this->db->escape($data['code']) . "', country_id = '" . (int)$data['country_id'] . "' WHERE zone_id = '" . (int)$zone_id . "'");

		/* NeoSeo Checkout - begin */
		$this->db->query("DELETE FROM " . DB_PREFIX . "zone_description WHERE zone_id = '" . (int)$zone_id . "'");
		foreach ($data['names'] as $language_id => $name)
		{
			$this->db->query("INSERT INTO " . DB_PREFIX . "zone_description SET zone_id = '". $zone_id ."', status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($name) . "', code = '" . $this->db->escape($data['code']) . "', country_id = '" . (int)$this->db->escape($data['country_id']). "', language_id = '" . (int)$language_id . "'");
		}
		/* NeoSeo Checkout - end */

		$this->cache->delete('zone');
	}

	public function deleteZone($zone_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "zone WHERE zone_id = '" . (int)$zone_id . "'");
		/* NeoSeo Checkout - begin */
		$this->db->query("DELETE FROM " . DB_PREFIX . "zone_description WHERE zone_id = '" . (int)$zone_id . "'");
		/* NeoSeo Checkout - end */

		$this->cache->delete('zone');
	}

		/* NeoSeo Checkout - begin */
		public function getZoneDescription($zone_id, $language_id) {
			$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "zone_description WHERE zone_id = '" . (int)$zone_id . "' AND language_id = '" . (int)$language_id . "'");
			return $query->row;
		}
		/* NeoSeo Checkout - end */
	public function getZone($zone_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "zone WHERE zone_id = '" . (int)$zone_id . "'");

		return $query->row;
	}

	public function getZones($data = array()) {
		$sql = "SELECT *, z.name, c.name AS country FROM " . DB_PREFIX . "zone z LEFT JOIN " . DB_PREFIX . "country c ON (z.country_id = c.country_id)";

		$sort_data = array(
			'c.name',
			'z.name',
			'z.code'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY c.name";
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

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getZonesByCountryId($country_id) {
		$zone_data = $this->cache->get('zone.' . (int)$country_id);

		if (!$zone_data) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE country_id = '" . (int)$country_id . "' AND status = '1' ORDER BY name");

			$zone_data = $query->rows;

			$this->cache->set('zone.' . (int)$country_id, $zone_data);
		}

		return $zone_data;
	}

	public function getTotalZones() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "zone");

		return $query->row['total'];
	}

	public function getTotalZonesByCountryId($country_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "zone WHERE country_id = '" . (int)$country_id . "'");

		return $query->row['total'];
	}
}