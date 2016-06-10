<?php

class ControllerModuleBonusclub extends Controller {

    private $error = array();

    public function __construct($registry) {
        parent::__construct($registry);
        $this->load->language('module/bonusclub');
        $this->document->addStyle("view/template/bonusclub/css/style.css");
        $this->document->addScript("view/template/bonusclub/js/script.js");

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('module/bonusclub/emulate', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );


        $this->children = array(
            "common/header",
            "common/footer",
        );
    }

    public function ctriggerform() {
        $this->load->model("bonusclub/triggers");
        $action = empty($this->request->post["action"]) ? "getCase" : $this->request->post["action"];
        $cond = $this->model_bonusclub_triggers->getTriggerHTML($action, $this->request->post);
        
        $this->response->setOutput($cond);
    }
    
    public function index() {
        $this->document->setTitle("Настройки Bonusclub API");

        $this->data['breadcrumbs'][] = array(
            'text' => $this->document->getTitle(),
            'href' => $this->url->link('module/bonusclub', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );


        $this->template = "bonusclub/index.tpl";

        $this->load->model("setting/setting");

        if (filter_input(INPUT_POST, "action") == "saveConfig") {
            $settings = array(
                "url" => $this->request->post["url"],
                "public_key" => $this->request->post["public_key"],
                "private_key" => $this->request->post["private_key"],
            );
            $this->model_setting_setting->editSetting("bonusclub", $settings);
        }

        $this->data["settings"] = $this->model_setting_setting->getSetting("bonusclub");
        if (empty($this->data["settings"]["public_key"])) {
            $this->data["settings"]["public_key"] = "";
        }
        if (empty($this->data["settings"]["private_key"])) {
            $this->data["settings"]["private_key"] = "";
        }
        if (empty($this->data["settings"]["url"])) {
            $this->data["settings"]["url"] = "";
        }

        $this->response->setOutput($this->render());
    }

    public function emulate() {
        $this->document->setTitle("Эмуляция");

        $this->data['breadcrumbs'][] = array(
            'text' => $this->document->getTitle(),
            'href' => $this->url->link('module/bonusclub/emulate', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->template = "bonusclub/emulate.tpl";
        $this->response->setOutput($this->render());
    }

    public function api() {
        $this->document->setTitle("Методы API");

        $this->data['breadcrumbs'][] = array(
            'text' => $this->document->getTitle(),
            'href' => $this->url->link('module/bonusclub/api', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->template = "bonusclub/api.tpl";
        $this->response->setOutput($this->render());
    }

    private function getItemList($cid) {
        $data = array();
        $return = array();
        $this->load->model("catalog/product");
        $this->load->model("bonusclub/bonuspoints");
        $data = $this->model_catalog_product->getProductsByCategoryId($cid);
        
        foreach($data as $item){
            $return[] = array(
                "name" => $item["name"],
                "product_id" => $item["product_id"],
                "price" => $item["price"],
                "currency" => $this->currency->getCode(),
                "bonus_points" => $this->model_bonusclub_bonuspoints->get($item["product_id"]),
            );
        }
        
        return $return;
    }

    private function getCategoryList() {
        $data = array();
        $this->load->model("catalog/category");
        $data = $this->model_catalog_category->getCategories();
        return $data;
    }

    public function itemlist() {
        $this->document->setTitle("Баллы для товаров");

        $this->data['breadcrumbs'][] = array(
            'text' => $this->document->getTitle(),
            'href' => $this->url->link('module/bonusclub/emulate', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        if(!empty($this->request->post["action"]) && $this->request->post["action"] == "batchUpdateBonuspoints"){
            $this->load->model("bonusclub/bonuspoints");
            $result = $this->model_bonusclub_bonuspoints->update($this->request->post["bonus_points"]);
        }
        
        
        $this->data["products"] = array();

        if(!empty($this->request->get["category_id"])){
            $this->data["products"] = $this->getItemList($this->request->get["category_id"]);
        }
        
        $this->data["categories"] = $this->getCategoryList();
        
        $this->template = "bonusclub/" . __FUNCTION__ . ".tpl";
        $this->response->setOutput($this->render());
    }

    public function c_trigger() {
        $this->document->setTitle("Триггеры баллов корзины");

        $this->data['breadcrumbs'][] = array(
            'text' => $this->document->getTitle(),
            'href' => $this->url->link('module/bonusclub/itemlist', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->template = "bonusclub/" . __FUNCTION__ . ".tpl";
        $this->response->setOutput($this->render());
    }

    public function o_trigger() {
        $this->document->setTitle("Триггеры баллов заказа");

        $this->data['breadcrumbs'][] = array(
            'text' => $this->document->getTitle(),
            'href' => $this->url->link('module/bonusclub/emulate', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->template = "bonusclub/" . __FUNCTION__ . ".tpl";
        $this->response->setOutput($this->render());
    }

}
