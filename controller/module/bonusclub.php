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
            'href' => $this->url->link('module/bonusclub/emulate', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->template = "bonusclub/api.tpl";
        $this->response->setOutput($this->render());
    }

    public function itemlist() {
        $this->document->setTitle("Баллы для товаров");

        $this->data['breadcrumbs'][] = array(
            'text' => $this->document->getTitle(),
            'href' => $this->url->link('module/bonusclub/emulate', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->template = "bonusclub/" . __FUNCTION__ . ".tpl";
        $this->response->setOutput($this->render());
    }

    public function c_trigger() {
        $this->document->setTitle("Триггеры баллов корзины");

        $this->data['breadcrumbs'][] = array(
            'text' => $this->document->getTitle(),
            'href' => $this->url->link('module/bonusclub/emulate', 'token=' . $this->session->data['token'], 'SSL'),
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
