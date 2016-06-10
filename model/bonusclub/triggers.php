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
class ModelBonusclubTriggers extends Model {

    public function getTriggerHTML($action, $data) {
        $str = $this->$action($data);
        return $str;
    }

}
