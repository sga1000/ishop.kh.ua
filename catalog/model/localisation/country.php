<?php
class ModelLocalisationCountry extends Model {
	public function getCountry($country_id) {
        // NeoSeo Checkout - begin
        $language_id = $this->config->get('config_language_id');

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country_description WHERE country_id = '" . (int)$country_id . "' AND status = '1' AND language_id = '".$language_id."'");
        if($query->row)
            return $query->row;
        else
        // NeoSeo Checkout - end
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country WHERE country_id = '" . (int)$country_id . "' AND status = '1'");

		return $query->row;
	}


    private function getCountryDescription() {
        $language_id = $this->config->get('config_language_id');

        $country_data = $this->cache->get('country.status.' . $language_id);

        if (!$country_data) {
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country_description WHERE status = '1'  AND language_id = '".$language_id."' ORDER BY name ASC");
            $country_data = $query->rows;

            $this->cache->set('country.status.' . $language_id, $country_data);
        }

        return $country_data;
    }
		
	public function getCountries() {
		// NeoSeo Checkout - begin
			return $this->getCountryDescription();
		// NeoSeo Checkout - end
		$country_data = $this->cache->get('country.status');

		if (!$country_data) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "country WHERE status = '1' ORDER BY name ASC");

			$country_data = $query->rows;

			$this->cache->set('country.status', $country_data);
		}

		return $country_data;
	}
}