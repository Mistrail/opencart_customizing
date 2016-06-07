<?php

class ControllerBonusclubApi extends Controller {

    public function __construct($registry) {
        parent::__construct($registry);

        $this->load->model("setting/setting");
        $this->data["settings"] = $this->model_setting_setting->getSetting("bonusclub");
        if (!array_key_exists("private_key", $this->data["settings"])) {
            $this->data["settings"]["private_key"] = false;
        }
        if (!array_key_exists("public_key", $this->data["settings"])) {
            $this->data["settings"]["public_key"] = false;
        }
        if (!array_key_exists("url", $this->data["settings"])) {
            $this->data["settings"]["url"] = false;
        }
    }

    public function check() {
        $resp = $this->send("check", "emulate", "");
        $this->response->setOutput($resp);
    }

    public function GetToken() {
        
    }

    public function getaccount($filter) {
        
    }

    public function fill($id, $summ) {
        
    }

    public function withdraw($id, $summ) {
        
    }

    public function history($from_U = false, $to_U = false) {
        
    }

    public function disconnect() {
        
    }

    public function test() {
        $action = $_POST["action"];
        $public = $this->data["settings"]["public_key"];
        $token = "emulate";
        $data = json_encode($_POST["data"]);

        $resp = $this->send($action, $token, $data);
        $this->response->setOutput("<pre>" . print_r($resp, true) . "</pre>");
    }

    public function checkmethod() {
        if (filter_input(INPUT_POST, "method")) {
            list($class, $method) = explode("::", filter_input(INPUT_POST, "method"));
            $this->response->setOutput(method_exists($class, $method));
        } else {
            $this->response->setOutput(false);
        }
    }

    /* PRIVATE FUNCTION */

    private function privateKey() {
        $str = $this->data["settings"]["private_key"];
        $heading = "-----BEGIN PRIVATE KEY-----\n";
        $body = chunk_split($str, 64);
        $footing = "-----END PRIVATE KEY-----";

        return $heading . $body . $footing;
    }

    private function publicKey() {
        $str = $this->data["settings"]["private_key"];
        $heading = "-----BEGIN PRIVATE KEY-----\n";
        $body = chunk_split($str, 64);
        $footing = "-----END PRIVATE KEY-----";

        return $heading . $body . $footing;
    }

    private function send($action, $token, $data) {
        $resp = false;
        $post = array();
        if (!empty($data)) {
            if (is_string($data)) {
                $data = json_decode($data);
            }
            foreach ($data as $field => $value) {
                if ($field == "0") {
                    continue;
                }
                $post[] = "$field=$value";
            }
        }
        $post[] = "action=" . $action;
        $post[] = "token=" . $token;
        $post[] = "public_key=" . $this->data["settings"]["public_key"];

        $ch = curl_init($this->data["settings"]["url"]);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_POSTFIELDS, implode("&", $post));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $resp = curl_exec($ch);

        $output = json_decode($resp, true);
        curl_close($ch);
        
        return $output["response"];
    }

}
