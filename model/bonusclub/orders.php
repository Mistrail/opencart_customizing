<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of orders
 *
 * @author Мистраль
 */
class ModelBonusclubOrders extends Model{
    
    public function index($phone) {
        
    }
    
    public function account($phone) {
        return $phone;
    }
    
}