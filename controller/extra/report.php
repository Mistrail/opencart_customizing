<?php 
class ControllerExtraReport extends Controller {
	public function __construct($registry) {
		parent::__construct($registry);
		
		$this->config->set('is_iframe', true);
		
		// $this->document->addStyle('view/stylesheet/report.css');
		$this->document->addStyle('view/stylesheet/report.css', 'stylesheet', 'all');
		
		// $this->data['company_info'] = 'ООО «ИТ» ИНН 3906289683, ОГРН 1133926008347';
		// $this->data['company_address'] = 'г. Калининград, ул. Кирова 7, тел.: 337-111';
		$this->data['company_info'] = 'ООО «ОК +» ИНН – 3906961464 ОГРН – 1153926015022';
		$this->data['company_address'] = 'г. Калининград, ул. Сибирякова 23Б, тел.: 611-113, www.banzai-sushi.ru';
	}

	public function buyerCheck() {
		$this->document->setTitle('Товарный чек');
	
		if (isset($this->request->get['order_id'])) {
			$order_id = $this->request->get['order_id'];
		} else {
			$order_id = 0;
		}
		
		$this->load->libraryModel('extra/order');
		$this->load->libraryModel('extra/customer');
		
		$order = $this->model_extra_order->getOrder($order_id);
		
		if ($order) {
			$this->data['order_id'] = $order['order_id'];
			$this->data['persons'] = $order['persons'];
			$this->data['delivery_time'] = date('H:i', strtotime($order['delivery_time']));
			$this->data['address'] = $order['address'];
			$this->data['floor'] = $order['floor'];
			$this->data['order_num'] = $order['number'];
			$this->data['comment'] = $order['comment'];
			
			$customer_info = $this->model_extra_customer->getCustomer($order['customer_id']);
			
			if ($customer_info) {
				$this->data['phone'] = $customer_info['phone'];
				$this->data['phone2'] = $customer_info['phone2'];
			} else {
				$this->data['phone'] = 'Неизвестен';
				$this->data['phone2'] = 'Неизвестен';
			}
			
			$total = $this->model_extra_order->getOrderTotal($order_id);
			
			$order_total = $total['special'] + $total['diff'];
			$this->data['sum'] = $order_total;
			
			if ((!in_array($order['delivery_id'], $this->model_extra_order->getFreeDeliveryIds())) && ($order['distance'] > FREE_DELIVERY_DISTANCE || $order['biglion'] || ($order_total > 0 && $order_total < FREE_DELIVERY_TOTAL))) {
				$delivery_price = $this->model_extra_order->getDeliveryPrice($order['distance']);
				$order_total += $delivery_price;
			} else {
				$delivery_price = false;
			}
			
			$this->data['delivery_price'] = $delivery_price;
			$this->data['total'] = $order_total;
			
			$this->load->model('catalog/product');
			
			$this->data['products'] = array();
			
			$results = $this->model_extra_order->getOrderProducts($order_id);
			
			foreach ($results as $result) {
				$product = $this->model_catalog_product->getProduct($result['product_id']);
				
				if ($product) {
					$this->data['products'][] = array(
						'name'     => $product['name'],
						'quantity' => $result['quantity'],
						'price'    => $result['special'],
						'total'    => $result['special'] * $result['quantity']
					);
				} else {
					$this->data['products'][] = array(
						'name'     => 'Товар не найден',
						'quantity' => $result['quantity'],
						'price'    => $result['special'],
						'total'    => $result['special'] * $result['quantity']
					);
				}
			}
			
			$this->template = 'extra/report/buyer_check.tpl';
			
			$this->children = array(
				'common/header',
				'common/footer'
			);
			
			return $this->render();
		}
		
		return null;
	}
	
	public function cashVoucher() {
		$this->document->setTitle('Кассовый чек');
		
		if (isset($this->request->get['order_id'])) {
			$order_id = $this->request->get['order_id'];
		} else {
			$order_id = 0;
		}
		
		$this->load->libraryModel('extra/order');
		$this->load->libraryModel('extra/customer');
		
		$order = $this->model_extra_order->getOrder($order_id);
		
		if ($order) {
			$this->data['order_id'] = $order['order_id'];
			$this->data['persons'] = $order['persons'];
			$this->data['delivery_time'] = date('H:i', strtotime($order['delivery_time']));
			$this->data['address'] = $order['address'];
			$this->data['floor'] = $order['floor'];
			$this->data['order_num'] = $order['number'];
			$this->data['comment'] = $order['comment'];
			
			$delivery_methods = $this->model_extra_order->getDeliveryMethods();
			if (isset($delivery_methods[$order['delivery_id']])) {
				$this->data['delivery_method'] = mb_substr($delivery_methods[$order['delivery_id']], 0, 1, 'UTF-8');
			} else {
				$this->data['delivery_method'] = '?';
			}
				
			$payment_methods = $this->model_extra_order->getPaymentMethods();
			if (isset($payment_methods[$order['payment_id']])) {
				$this->data['payment_method'] = $payment_methods[$order['payment_id']];
			} else {
				$this->data['payment_method'] = '?';
			}
			
			$total = $this->model_extra_order->getOrderTotal($order_id);
			
			$order_total = $total['special'] + $total['diff'];
			$this->data['sum'] = $order_total;
			
			if ((!in_array($order['delivery_id'], $this->model_extra_order->getFreeDeliveryIds())) && ($order['distance'] > FREE_DELIVERY_DISTANCE || $order['biglion'] || ($order_total > 0 && $order_total < FREE_DELIVERY_TOTAL))) {
				$delivery_price = $this->model_extra_order->getDeliveryPrice($order['distance']);
				$order_total += $delivery_price;
			} else {
				$delivery_price = false;
			}
						
			$this->data['delivery_price'] = $delivery_price;
			
			$this->data['total'] = $order_total;

			$customer = $this->model_extra_customer->getCustomer($order['customer_id']);
			if ($customer) {
				$this->data['phone'] = '8' . $customer['phone'];
				
				if (!empty($customer['phone2']) && $customer['phone2'] != $customer['phone']) {
					$this->data['phone'] .= ' (8' . $customer['phone2'] . ')';
				}
			} else {
				$this->data['phone'] = false;
			}			
			
			$this->load->model('catalog/product');
			
			$this->data['products'] = array();
			
			$results = $this->model_extra_order->getOrderProducts($order_id);
			
			foreach ($results as $result) {
				$product = $this->model_catalog_product->getProduct($result['product_id']);
				
				if ($product) {
					$this->data['products'][] = array(
						'name'     => $product['name'],
						'quantity' => $result['quantity'],
						'price'    => $result['special'],
						'total'    => $result['special'] * $result['quantity']
					);
				} else {
					$this->data['products'][] = array(
						'name'     => 'Товар не найден',
						'quantity' => $result['quantity'],
						'price'    => $result['special'],
						'total'    => $result['special'] * $result['quantity']
					);
				}
			}
			
			$this->template = 'extra/report/cash_voucher.tpl';
		
			$this->children = array(
				'common/header',
				'common/footer'
			);
			
			return $this->render();
			// $this->response->setOutput($this->render());
		}
		
		return null;
	}
	
	public function xReport() {
		$this->document->setTitle('X-отчет');
		
		$this->load->libraryModel('extra/order');
		
		$payment_methods = $this->model_extra_order->getPaymentMethods();
		
		// должен генерироваться отчет за прошедший день, поэтому после 12 ночи до начала рабочего дня генерируем за предыдущий день
		if (date('H') < ORDER_NUM_RESET_HOUR) {
			$timestamp = time() - 60*60*24;
		} else {
			$timestamp = time();
		}
		
		$data = array(
			'filter_date_confirm_start' => date('Y-m-d', $timestamp) . ' 00:00:00',
			'filter_status_id' => COMPLETE_ORDER_STATUS_ID
		);
		
		$results = $this->model_extra_order->getOrders($data);
		
		$total = 0;
		$total_special = 0;
		$cash = 0;
		$cashless = 0;
		
		foreach ($results as $result) {			
			$order_total = $this->model_extra_order->getOrderTotal($result['order_id']);
			
			if (!in_array($result['delivery_id'], $this->model_extra_order->getFreeDeliveryIds()) && ($result['distance'] > FREE_DELIVERY_DISTANCE || $result['biglion'] || ($order_total['special'] + $order_total['diff'] > 0 && $order_total['special'] + $order_total['diff'] < FREE_DELIVERY_TOTAL))) {
				$delivery_price = $this->model_extra_order->getDeliveryPrice($result['distance']);
			} else {
				$delivery_price = 0;
			}

			if ($result['payment_id'] == 1) {
				$cash += $order_total['special'] + $order_total['diff'] + $delivery_price;
			} else {
				$cashless += $order_total['special'] + $order_total['diff'] + $delivery_price;
			}
			
			$total += $order_total['price'];
			$total_special += $order_total['special'] + $order_total['diff'] + $delivery_price;
		}
		
		$this->data['total'] = $total;
		$this->data['total_special'] = $total_special;
		$this->data['cash'] = $cash;
		$this->data['cashless'] = $cashless;
		
		$this->template = 'extra/report/x_report.tpl';
		
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
		$this->response->setOutput($this->render());
	}
	
	public function zReport() {
		$this->document->setTitle('Z-отчет');
	
		$this->load->libraryModel('extra/order');
		$this->load->model('catalog/product');
		$this->load->model('setting/setting');
		
		$report_num = $this->config->get('latest_z_report_num');
		
		$report_num++;
		
		$data = array(
			'latest_z_report_num' => $report_num
		);
		
		$this->model_setting_setting->editSetting('extra_latest_z_report_num', $data);
		
		$this->data['report_num'] = $report_num;
		
		$payment_methods = $this->model_extra_order->getPaymentMethods();
		
		// должен генерироваться отчет за прошедший день, поэтому после 12 ночи до начала рабочего дня генерируем за предыдущий день
		if (date('H') < ORDER_NUM_RESET_HOUR) {
			$timestamp = (time() - 60*60*24);
		} else {
			$timestamp = time();
		}

		$data = array(
			'filter_date_confirm_start' => date('Y-m-d', $timestamp) . ' ' . ORDER_NUM_RESET_HOUR . ':00:00',
			'filter_status_id' => COMPLETE_ORDER_STATUS_ID
		);
		
		$results = $this->model_extra_order->getOrders($data);
		$dataG = array(
			'filter_status_id' => COMPLETE_ORDER_STATUS_ID
		);
		$resultsG = $this->model_extra_order->getOrderGross();
//        $gtotal=0;
//        foreach ($resultsG as $resultG) {
//            $gt = $this->model_extra_order->getOrderTotal($resultG['order_id']);
//            $gtotal=$gt['special'];
//        }
//
//        file_put_contents ($_SERVER['DOCUMENT_ROOT'] . "/gross3.log", print_r($gtotal, true), FILE_APPEND);

		$total = 0;
		$total_special = 0;
		$total_cost = 0;
		$cash = 0;
		$cashless = 0;
		$products = array();
		$diff = 0;
		$delivery = array();
		$orders_count = count($results);
		
		foreach ($results as $result) {
			$order_total = $this->model_extra_order->getOrderTotal($result['order_id']);
			
			if (!in_array($result['delivery_id'], $this->model_extra_order->getFreeDeliveryIds()) && ($result['distance'] > FREE_DELIVERY_DISTANCE || $result['biglion'] || ($order_total['special'] + $order_total['diff'] > 0 && $order_total['special'] + $order_total['diff'] < FREE_DELIVERY_TOTAL))) {
				$delivery_price = $this->model_extra_order->getDeliveryPrice($result['distance']);
			} else {
				$delivery_price = 0;
			}
			
			if (!isset($delivery[$delivery_price])) {
				$delivery[$delivery_price] = 0;
			}
			
			$delivery[$delivery_price] += 1;
			
			$order_products = $this->model_extra_order->getOrderProducts($result['order_id']);
			
			foreach ($order_products as $order_product) {
				if (!isset($products[$order_product['product_id']])) {
					$product_info = $this->model_catalog_product->getProduct($order_product['product_id']);
					
					if (!$product_info) {
						$product_info = array(
							'name' => 'Неизвестный товар',
							'upc'  => 0
						);
					}
					
					$products[$order_product['product_id']] = array(
						'name' => $product_info['name'],
						'upc'  => $product_info['upc'],
						'quantity' => 0,
						'total' => 0,
						'total_special' => 0
					);
				}
				
				$product = &$products[$order_product['product_id']];
				
				$product['quantity'] += $order_product['quantity'];
				$product['total'] += $order_product['price'] * $order_product['quantity'];
				$product['total_special'] += $order_product['special'] * $order_product['quantity'];
				$total_cost += $product['upc'] * $order_product['quantity'];
			}

			if ($result['payment_id'] == 1) {
				$cash += $order_total['special'] + $order_total['diff'] + $delivery_price;
			} else {
				$cashless += $order_total['special'] + $order_total['diff'] + $delivery_price;
			}
			
			$total += $order_total['price'];
			$total_special += $order_total['special'] + $order_total['diff'] + $delivery_price;
			$diff += $order_total['diff'];
		}
		
		$this->data['total'] = $total;
		$this->data['total_special'] = $total_special;
		$this->data['total_cost'] = $total_cost;
		$this->data['cash'] = $cash;
		$this->data['cashless'] = $cashless;
		$this->data['products'] = $products;
		$this->data['diff'] = $diff;
		$this->data['delivery'] = $delivery;
		$this->data['orders_count'] = $orders_count;
        $this->data['gross'] = $resultsG;
		
		$this->template = 'extra/report/z_report.tpl';
		
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
		$this->response->setOutput($this->render());
	}
	
	public function print_check() {
		if (isset($this->request->get['check_type'])) {
			$check_type = $this->request->get['check_type'];
		} else {
			$check_type = null;
		}
		
		if (isset($this->request->get['order_id'])) {
			$order_id = $this->request->get['order_id'];
		} else {
			$order_id = 0;
		}
		
		$filename = 'order_' . $order_id . '_' . $check_type . '.pdf';
		
		if (!file_exists(DIR_PDF . $filename) || true) {
			// создаем файл
			$this->load->library('tcpdf/config/lang/rus');
			$this->load->library('tcpdf/tcpdf');

			// create new PDF document
			if ($check_type == 'buyerCheck') {
				$document_size = array(210, 148); // A3
				$page_orientation = 'A';
			} else { // cashVoucher
				$document_size = array(78, 210);
				$page_orientation = 'P';
			}
			
			$pdf = new TCPDF($page_orientation, PDF_UNIT, $document_size, true, 'UTF-8', false);

			// set document information
			$pdf->SetCreator('Banzai');
			$pdf->SetAuthor('Banzai');
			$pdf->SetTitle('Banzai');
			$pdf->SetSubject('Banzai');
			$pdf->SetKeywords('Banzai');
			$pdf->setPrintHeader(false);
			$pdf->setPrintFooter(false);

			// set default monospaced font
			$pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);

			//set margins
			if ($check_type == 'buyerCheck') {
				$pdf->SetMargins(10,0,10,true);
			} else { // cashVoucher
				$pdf->SetMargins(0,0,0,true);
			}
			//set auto page breaks
			$pdf->SetAutoPageBreak(false, PDF_MARGIN_BOTTOM);

			//set image scale factor
			$pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);

			//set some language-dependent strings
			$pdf->setLanguageArray(1);

			// ---------------------------------------------------------

			// set default font subsetting mode
			$pdf->setFontSubsetting(true);

			// Set font
			// dejavusans is a UTF-8 Unicode font, if you only need to
			// print standard ASCII chars, you can use core fonts like
			// helvetica or times to reduce file size.
			$pdf->SetFont('dejavusans', '', 9, '', true);

			// Add a page
			// This method has several options, check the source code documentation for more information.
			$pdf->AddPage();
			
			$check_content = $this->$check_type();
			// $check_content = $this->response->pub_compress($check_content);
			// $check_content = iconv('UTF-8', 'CP1251', $check_content);
			
			// file_put_contents('/var/www/dev/data/www/demo14.unibix.ru/test.txt', $check_content);
			// echo $check_content;
			$pdf->writeHTMLCell($w=0, $h=0, $x='', $y='', $check_content, $border=0, $ln=0, $fill=0, $reseth=true, $align='', $autopadding=false);

			$pdf->Output(DIR_PDF . $filename, 'F');
		}
		
		// Google Cloud Print
		//это закомментил до решения проблем с хромом 2015-06-18
		/*$this->load->library('GoogleCloudPrint');
		
		$gcp = new GoogleCloudPrint;

		$gcp->loginToGoogle('sushi.banzai14@gmail.com', 'banzai14');

		$printers = $gcp->getPrinters();
		
		foreach ($printers as $printer) {
			if ($check_type == 'buyerCheck' && $printer['name'] == 'Canon LBP2900') {
				break;
			} elseif ($check_type == 'cashVoucher' && $printer['name'] == 'CheckPrinter') {
				break;
			}
		}
		
		if (isset($this->request->get['copies'])) {
			$copies = $this->request->get['copies'];
		} else {
			$copies = 1;
		}
		
		for ($i = 1; $i <= $copies; $i++) {
			$result = $gcp->sendPrintToPrinter($printer['id'], 'Печать чека', HTTP_PDF . $filename, 'application/pdf', 'file');
		}*/
	}
	
	public function resetZReportNumber() {
		$this->load->model('setting/setting');
		
		$data = array(
			'latest_z_report_num' => 0
		);
		
		$this->model_setting_setting->editSetting('extra_latest_z_report_num', $data);
	}
}
 ?>