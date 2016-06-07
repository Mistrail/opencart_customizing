<?php

class ControllerModuleBonusclub extends Controller {

    private $error = array();

    public function index() {
        $this->document->setTitle("Настройки Bonusclub API");
        $this->load->language('module/bonusclub');
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
            'href' => $this->url->link('module/account', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->children = array(
            "common/header",
            "common/footer",
        );

        $this->template = "bonusclub/index.tpl";
        $this->response->setOutput($this->render());
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

}
