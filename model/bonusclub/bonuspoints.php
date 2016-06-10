<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of bonuspoints
 *
 * @author frigu
 */
class ModelBonusclubBonuspoints extends Model {

    function create() {
        $sql = "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "mod_bonuspoints__itemlist (
  id int(11) NOT NULL AUTO_INCREMENT,
  product_id int(11) NOT NULL,
  bonuspoints int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY product_id (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;";

        $this->db->query($sql);
    }

    function update($data) {
        $this->create();
        foreach ($data as $id => $points) {
            if($points < 0){
                $points = 0;
            }
            $exists = $this->db->query("SELECT id FROM " . DB_PREFIX . "mod_bonuspoints__itemlist WHERE product_id = $id");
            if ($exists->num_rows > 0) {
                $sql = "UPDATE " . DB_PREFIX . "mod_bonuspoints__itemlist SET bonuspoints = " . (int) $points . " WHERE product_id = $id";
            } else {
                $sql = "INSERT INTO " . DB_PREFIX . "mod_bonuspoints__itemlist (product_id, bonuspoints) VALUES ($id, " . (int) $points . ")";
            }
            $this->db->query($sql);
        }
    }

    function get($product_id) {
        $this->create();
        $sql = "SELECT bonuspoints FROM " . DB_PREFIX . "mod_bonuspoints__itemlist WHERE product_id = $product_id";
        $result = $this->db->query($sql);
        return empty($result->rows) ? 0 : $result->rows[0]["bonuspoints"];
    }

}
