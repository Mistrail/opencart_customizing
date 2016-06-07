<?php 
class ControllerExtraHelper extends Controller {
	public function delivery_time() {
		// изменение времени доставки
		$json = array();
		
		if (isset($this->request->post['delivery_time'])) {
			$this->load->model('setting/setting');
			
			$data = array(
				'delivery_time' => $this->request->post['delivery_time']
			);
			
			$this->model_setting_setting->editSetting('extra_delivery_time', $data);
			
			$json['success'] = 1;
		}
		
		$this->response->setOutput(json_encode($json));
	}
	
        /* public function getByPhone() {
            global $client;
            
            $json = array();
            $token = $client->hello();
            $phone = $this->request->post['phone'];
            $data = $client->GetAccountByPhone($token["token"], $phone);

            
            $this->response->setOutput(json_encode($data));
            
            
        }/* */
        
	public function extraComment() {
		// изменение времени доставки
		$json = array();
		
		if (isset($this->request->post['extra_comment'])) {
			$this->load->model('setting/setting');
			
			$data = array(
				'extra_comment' => $this->request->post['extra_comment']
			);
			
			$this->model_setting_setting->editSetting('extra_comment', $data);
			
			$json['success'] = 1;
		}
		
		$this->response->setOutput(json_encode($json));
	}
	
	public function check() {
		$json = array();
		
		$this->checkPreorder();
		
		$canceled_orders = $this->checkCancel();
		
		if ($canceled_orders) {
			$json['canceled_orders'] = $canceled_orders;
		}
		
		if ($this->checkNew()) {
			$json['new_orders'] = 1;
		}
		
		$this->response->setOutput(json_encode($json));
	}
	
	protected function checkPreorder() {
		// проверка есть ли предзаказы, которые уже нужно подтвердить
		
		if (isset($this->session->data['notified_preorders'])) { // в notified_preorders будут храниться id заказов, о которых оператор уже уведомлен
			$notified_preorders = unserialize($this->session->data['notified_preorders']);
		} else {
			$notified_preorders = array();
		}
		
		$this->load->libraryModel('extra/order');
		
		$deadline_timestamp = time() + PREORDER_COFIRM_TIME;
		
		$data = array(
			'filter_status_id' => NEW_ORDER_STATUS_ID,
			'filter_preorder' => 1,
			'filter_delivery_time_end' => date('H:i:s', $deadline_timestamp),
			'filter_delivery_date_end' => date('Y-m-d', $deadline_timestamp)
		);
		
		$results = $this->model_extra_order->getOrders($data);
		
		foreach ($results as $result) {
			if (!in_array($result['order_id'], $notified_preorders)) {
				// TODO уведомляем оператора
				$this->load->library('mail');
				
				$text = 'Предзаказ' . "\n";
				$confirm_url = $this->url->link('extra/order/edit', 'order_id=' . $result['order_id'] . '&autologin=' . AUTOLOGIN_PASS);
				$text .= '<a href="' . $confirm_url . '">Обработать</a>' . "\n";
				
				$mail = new Mail(); 
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->hostname = $this->config->get('config_smtp_host');
				$mail->username = $this->config->get('config_smtp_username');
				$mail->password = $this->config->get('config_smtp_password');
				$mail->port = $this->config->get('config_smtp_port');
				$mail->timeout = $this->config->get('config_smtp_timeout');			
				$mail->setTo(CALLCENTER_EMAIL);
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($this->config->get('config_name'));
				$mail->setSubject(html_entity_decode('Предзаказ', ENT_QUOTES, 'UTF-8'));
				$mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));
				$mail->send();
				
				$notified_preorders[] = $result['order_id'];
			}
		}
		
		$this->session->data['notified_preorders'] = serialize($notified_preorders);
	}
	
	protected function checkCancel() {
		// проверяет не отменен ли один из переданных в $_POST заказов
		if (isset($this->request->post['orders']) && is_array($this->request->post['orders'])) {
			$orders = $this->request->post['orders'];
		} else {
			$orders = array();
		}
		
		$canceled_orders = array();

		if (!empty($orders)) {
			$this->load->libraryModel('extra/order');
		
			$data = array(
				'filter_status_id' => CANCELED_ORDER_STATUS_ID,
				'filter_order_id'  => $orders
			);
			
			$results = $this->model_extra_order->getOrders($data);
			
			foreach ($results as $result) {
				$canceled_orders[] = $result['order_id'];
			}
		}
		
		return $canceled_orders;
	}
	
	protected function checkNew() {
		$this->load->libraryModel('extra/order');
		
		if (!isset($this->session->data['last_checked_new_orders'])) {
			$last_check_new_orders = time();
		} else {
			$last_check_new_orders = $this->session->data['last_checked_new_orders'];
		}
		
		$data = array(
			'filter_status_id' => CONFIRM_ORDER_STATUS_ID,
			'filter_date_confirm_start' => date('Y-m-d H:i:s', $last_check_new_orders)
		);
		
		$orders = $this->model_extra_order->getOrders($data);
		
		$this->session->data['last_checked_new_orders'] = time();
		
		if ($orders) {
			return true;
		} else {
			return false;
		}
	}
	
	public function getDisabledDeliveryTime() {
		// список доступного времени для предзаказа на выбранную дату
		$json = array();
		
		if (isset($this->request->post['delivery_date'])) {
			$this->load->libraryModel('extra/order');
			
			$delivery_date = date('Y-m-d', strtotime($this->request->post['delivery_date']));
			
			$disabled_time = $this->model_extra_order->getDisabledDeliveryTime($delivery_date);
			// echo '<pre style="text-align: left; background: #FFFFFF;">'; print_r($disabled_time); echo '</pre>';
			
			if (isset($this->request->post['order_id'])) {
				// редактирование заказа. исключаем из disabled_time выбранное для этого заказа время доставки
				$order = $this->model_extra_order->getOrder($this->request->post['order_id']);
				if (!empty($order) && $order['preorder'] && $order['delivery_date'] == $delivery_date) {
					$time_key = array_search($order['delivery_time'], $disabled_time);
					var_dump($time_key);
					if ($time_key !== false) {
						unset($disabled_time[$time_key]);
					}
				}
			}
			
			$json['disabled'] = $disabled_time;
		}
		
		$this->response->setOutput(json_encode($json));
	}
	
	public function cancel() {
		// отменяет заказ
		if (isset($this->request->get['order_id'])) {
			$order_id = $this->request->get['order_id'];
		} else {
			$order_id = 0;
		}
		
		$this->load->libraryModel('extra/order');
        $this->load->libraryModel('extra/customer');

		$order = $this->model_extra_order->getOrder($order_id);
        $th_total = $this->model_extra_order->getOrderTotal($order_id);
        $th_customer_info = $this->model_extra_customer->getCustomer($order['customer_id']);
		
		if ($order) {

//            file_put_contents ($_SERVER['DOCUMENT_ROOT'] . "/cancel.log", print_r($order, true), FILE_APPEND);
//			file_put_contents ($_SERVER['DOCUMENT_ROOT'] . "/cancel.log", print_r($th_total, true), FILE_APPEND);

            $sendInfo='id заказа:'.$order['order_id']."\n"
                .'дата доставки:'.$order['delivery_date']."\n"
                .'время доставки:'.$order['delivery_time']."\n"
                .'адрес:'.$order['address'] . "\n"
                .'комментарий:'.$order['comment'] . "\n"
                .'цена (без учета доставки):'.$th_total['special']."\n"
                .'Телефон:'.$th_customer_info['phone']." ";
            $this->load->library('mail');

            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->hostname = $this->config->get('config_smtp_host');
            $mail->username = $this->config->get('config_smtp_username');
            $mail->password = $this->config->get('config_smtp_password');
            $mail->port = $this->config->get('config_smtp_port');
            $mail->timeout = $this->config->get('config_smtp_timeout');
            $mail->setTo("vs.got@bk.ru");
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender($this->config->get('config_name'));
            $mail->setSubject(html_entity_decode('Отменённый заказ', ENT_QUOTES, 'UTF-8'));
            $mail->setText(html_entity_decode($sendInfo, ENT_QUOTES, 'UTF-8'));
            $mail->send();

            $data = array(
				'order_id'  => $order_id,
				'status_id' => CANCELED_ORDER_STATUS_ID
			);
			
			$this->model_extra_order->updateOrder($data);
			
			$this->session->data['success'] = 'Заказ отменен';
		}
	}
	
	public function changeStatus() {		
		if (isset($this->request->get['order_id']) && isset($this->request->get['status_id'])) {
			$this->load->libraryModel('extra/order');
			
			$status_id = $this->request->get['status_id'];
			
			$data = array(
				'order_id'  => $this->request->get['order_id'],
				'status_id' => $status_id
			);
			
			$this->model_extra_order->updateOrder($data);
			
			if ($status_id == NEW_ORDER_STATUS_ID) {
				$success = 'Статус заказа: Новый';
			} elseif ($status_id == CONFIRM_ORDER_STATUS_ID) {
				$success = 'Заказ подтвержден';
			} elseif ($status_id == PREPARE_ORDER_STATUS_ID) {
				$success = 'Статус заказа: Приготовление и доставка';
			} elseif ($status_id == COMPLETE_ORDER_STATUS_ID) {
				$success = 'Заказ доставлен';
			} elseif ($status_id == CANCELED_ORDER_STATUS_ID) {
				$success = 'Заказ отменен';
			} elseif ($status_id == Z_INVISIBLE_ORDER_STATUS_ID) {
				$success = 'Заказ скрыт из z-отчета';
			} else {
				$success = 'Неизвестный статус заказа';
			}
			
			$this->session->data['success'] = $success;
		
			if (isset($this->request->get['print_check'])) { // печатаем чеки после редиректа
				$this->session->data['print_check'] = $this->request->get['print_check'];
			}
		}
		
		if (isset($this->request->get['back'])) {
			$this->redirect($this->url->link($this->request->get['back'], 'token=' . $this->session->data['token']));
		} else {
			$this->redirect($this->url->link('extra/order/all', 'token=' . $this->session->data['token']));
		}
	}
	
	public function password() {
		if (isset($this->request->post['password']) && $this->request->post['password'] == CHANGE_ORDER_PASSWORD) {
			echo 1;
		}
	}
	
	public function changeOrder() {
		$json = array();
		
		if (isset($this->request->post['password']) && $this->request->post['password'] == CHANGE_ORDER_PASSWORD) {
			if (isset($this->request->post['order_id'])) {
				$order_id = $this->request->post['order_id'];
			} else {
				$order_id = 0;
			}
			
			$this->load->libraryModel('extra/order');

            $this->load->libraryModel('extra/customer');


			
			$total = $this->model_extra_order->getOrderTotal($order_id);
			$order = $this->model_extra_order->getOrder($order_id);
            $th_customer_info = $this->model_extra_customer->getCustomer($order['customer_id']);
			$diff = $this->request->post['total_special'] - $total['special'];

//            file_put_contents ($_SERVER['DOCUMENT_ROOT'] . "/change.log", print_r($total, true), FILE_APPEND);
//            file_put_contents ($_SERVER['DOCUMENT_ROOT'] . "/change.log", ' '.print_r($this->request->post['total_special'], true), FILE_APPEND);
            $sendInfo='id заказа:'.$order['order_id']."\n"
                .'дата доставки:'.$order['delivery_date']."\n"
                .'время доставки:'.$order['delivery_time']."\n"
                .'адрес:'.$order['address'] . "\n"
                .'комментарий:'.$order['comment'] . "\n"
                .'цена (без учета доставки):'.$total['special']."\n"
                .'новая цена:'.$this->request->post['total_special']."\n"
                .'Телефон:'.$th_customer_info['phone']." ";
            $this->load->library('mail');

            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->hostname = $this->config->get('config_smtp_host');
            $mail->username = $this->config->get('config_smtp_username');
            $mail->password = $this->config->get('config_smtp_password');
            $mail->port = $this->config->get('config_smtp_port');
            $mail->timeout = $this->config->get('config_smtp_timeout');
            $mail->setTo("vs.got@bk.ru");
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender($this->config->get('config_name'));
            $mail->setSubject(html_entity_decode('Изменение заказа', ENT_QUOTES, 'UTF-8'));
            $mail->setText(html_entity_decode($sendInfo, ENT_QUOTES, 'UTF-8'));
            $mail->send();


            $data = array(
				'order_id' => $this->request->post['order_id'],
				'payment_id' => $this->request->post['payment_id'],
				'total_diff' => $diff
			);
			
			$this->model_extra_order->updateOrder($data);
			
			$json['redirect'] = html_entity_decode($this->url->link('extra/order/all', 'token=' . $this->session->data['token']));
		} else {
			$json['error'] = 'Неверный пароль';
		}
		
		$this->response->setOutput(json_encode($json));
	}
	
	public function getDistance() {
		$json = array();
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$to = '';
			
			$to .= $this->request->post['street'] . ', ';
			$to .= $this->request->post['house'] . ', ';

			if (isset($this->request->post['flat']) && !empty($this->request->post['flat'])) {
				$to .= $this->request->post['flat'] . ', ';
			}
			
			$to .= $this->request->post['city'] . ', ';
			$to .= ' Калининградская область, Россия';
			// echo $to;
//            вобще изначально оно было правильно, брало из админки, но Вася сказал,
//            что после переезда считает не так
			$data = array(
//				'from' => COMPANY_ORIGIN,
				'from' => 'Кирова, 7, Калининград,  Калининградская область, Россия',
				'to'   => $to
			);
			file_put_contents('distancelog.log',print_r($data,true));
			$result = $this->_googleGetDistance($data);
			
			if ($result->status == 'OK') {
				$distance = $result->rows[0]->elements[0]->distance;
				
				$json['distance'] = array(
					'text' => $distance->text,
					'value' => $distance->value
				);
				
			} else {
				$json['error'] = 'Ошибка Google';
			}
		} 

		$this->response->setOutput(json_encode($json));
	}
	
	protected function _googleGetDistance($data) {
		$api_url = 'http://maps.googleapis.com/maps/api/distancematrix/json?';
		
		$query = array(
			'origins'      => is_array($data['from']) ? implode('|', $data['from']) : $data['from'],
			'destinations' => is_array($data['to']) ? implode('|', $data['to']) : $data['to'],
			'language'     => 'RU-ru',
			'mode'         => 'driving',
			'sensor'       => false
		);
		
		$query_url = http_build_query($query);
		
		$request_url = $api_url . $query_url;
		// echo $request_url;
		$response = file_get_contents($request_url);
		
		$result = json_decode($response);
		
		return $result;
	}
}
 ?>