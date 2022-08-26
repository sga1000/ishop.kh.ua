<?php
class ModelLocalisationZone extends Model {
	public function getZone($zone_id) {
		/* NeoSeo Checkout - begin */
		$language_id = $this->config->get('config_language_id');
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_description WHERE zone_id = '" . (int)$zone_id . "' AND status = '1' AND language_id = '".$language_id."'");
		$row = $query->row;
		if (!$row)
		{
		/* NeoSeo Checkout - end */
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE zone_id = '" . (int)$zone_id . "' AND status = '1'");
		/* NeoSeo Checkout - begin */
		}
		/* NeoSeo Checkout - end */

		return $query->row;
	}

	public function getZonesByCountryId($country_id) {
				/* NeoSeo Checkout - begin */
		$language_id = $this->config->get('config_language_id');
		$zone_data = $this->cache->get('zone.' . (int)$country_id . '.' . (int)$language_id);
		/* NeoSeo Checkout - end */

		if (!$zone_data) {
			/* NeoSeo Checkout - begin */
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_description WHERE country_id = '" . (int)$country_id . "' AND status = '1'  AND language_id = '".$language_id."' ORDER BY name");
			$zone_data = $query->rows;
			if (!$zone_data)
			{
			/* NeoSeo Checkout - end */
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone WHERE country_id = '" . (int)$country_id . "' AND status = '1' ORDER BY name");

			$zone_data = $query->rows;
		/* NeoSeo Checkout - begin */
		}
		/* NeoSeo Checkout - end */

					/* NeoSeo Checkout - begin */
		$this->cache->set('zone.' . (int)$country_id . '.' . (int)$language_id, $zone_data);
		/* NeoSeo Checkout - end */
		}

		return $zone_data;
	}
}