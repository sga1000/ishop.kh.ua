<?php
class ModelAccountWishlist extends Model {
	public function addWishlist($product_id) {
		$this->event->trigger('pre.wishlist.add');

		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_wishlist WHERE customer_id = '" . (int)$this->customer->getId() . "' AND product_id = '" . (int)$product_id . "'");

		$this->db->query("INSERT INTO " . DB_PREFIX . "customer_wishlist SET customer_id = '" . (int)$this->customer->getId() . "', product_id = '" . (int)$product_id . "', date_added = NOW()");

		$this->event->trigger('post.wishlist.add');
	}

	public function deleteWishlist($product_id) {
		$this->event->trigger('pre.wishlist.delete');

		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_wishlist WHERE customer_id = '" . (int)$this->customer->getId() . "' AND product_id = '" . (int)$product_id . "'");

		$this->event->trigger('post.wishlist.delete');
	}

	public function getWishlist() {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_wishlist WHERE customer_id = '" . (int)$this->customer->getId() . "'");

		return $query->rows;
	}

	public function getTotalWishlist() {
				/* NeoSeo UniSTOR - begin */
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer_wishlist cw JOIN " . DB_PREFIX . "product p ON cw.product_id = p.product_id WHERE customer_id = '" . (int) $this->customer->getId() . "' AND p.status=1");
		/* NeoSeo UniSTOR - end */

		return $query->row['total'];
	}
}
