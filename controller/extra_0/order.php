<?php

class ControllerExtraOrder extends Controller {

    protected $errors = array();

    public function __construct($registry) {
        parent::__construct($registry);

        $this->config->set('is_iframe', isset($this->request->get['iframe']));

        $this->document->addScript('view/javascript/jquery/extra-order.js');

        // $this->config->set('delivery_time', 3600);
    }

    public function index() {
        $this->load->libraryModel('extra/order');
        $this->load->libraryModel('extra/customer');
        $this->load->model('localisation/order_status');
        $this->load->model('catalog/product');

        $this->document->setTitle('Оператор');

        $orders = array();
        $customers = array();

        $data = array(
            'filter_status_id' => array(
                NEW_ORDER_STATUS_ID,
                CONFIRM_ORDER_STATUS_ID,
                PREPARE_ORDER_STATUS_ID,
            )
        );

        $results = $this->model_extra_order->getOrders($data);

        foreach ($results as $result) {
            if ($result['status_id'] == NEW_ORDER_STATUS_ID && $result['preorder']) {
                // проверяем сколько осталось времени до заказа. если меньше PREORDER_COFIRM_TIME, от выводим заказ как новый, чтобы оператор мог связаться с клиентом и подтвердить
                $preorder_timestamp = strtotime($result['delivery_date'] . ' ' . $result['delivery_time']);
                $should_confirm_timestamp = $preorder_timestamp - PREORDER_COFIRM_TIME;

                if (time() < $should_confirm_timestamp) {
                    // еще рано, не отображаем заказ
                    // continue; // а теперь отображаем — говорят, так удообней, пусть будет видно сразу
                }
            }

            if (!isset($customers[$result['customer_id']])) {
                $customers[$result['customer_id']] = $this->model_extra_customer->getCustomer($result['customer_id']);
            }

            $customer = $customers[$result['customer_id']];

            if ($customer['phone'] == $customer['phone2']) {
                $phone = $customer['phone'];
            } else {
                $phone = $customer['phone'] . '<br>' . $customer['phone2'];
            }

            $order_total = $this->model_extra_order->getOrderTotal($result['order_id']);

            $orders[$result['status_id']][] = array(
                'order_id' => $result['order_id'],
                'number' => $result['number'],
                'customer_name' => $customer['name'],
                'preorder' => $result['preorder'],
                'delivery_price' => $this->model_extra_order->getDeliveryPrice($result['distance']),
                'delivery_date' => $result['delivery_date'],
                'delivery_time' => $result['delivery_time'],
                'confirm_date' => date('d.m.Y', strtotime($result['date_confirm'])),
                'confirm_time' => date('H:i', strtotime($result['date_confirm'])),
                'total' => $order_total['price'],
                'total_special' => $order_total['special'],
                'total_diff' => $result['total_diff'],
                'customer_phone' => $phone,
                'href_edit' => $this->url->link('extra/order/edit', 'order_id=' . $result['order_id'] . '&token=' . $this->session->data['token'])
            );
        }

        $this->data['orders'] = $orders;

        $this->data['extra_comment'] = $this->config->get('extra_comment');

        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $this->data['success'] = false;
        }

        $this->data['token'] = $this->session->data['token'];

        $this->template = 'extra/index.tpl';

        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    public function test() {
        // echo __file__;
        header('Content-Type: text/html; charset=utf-8');
    }

    public function all() {
        $this->load->libraryModel('extra/order');
        $this->load->libraryModel('extra/customer');
        $this->load->model('localisation/order_status');
        $this->load->model('catalog/product');

        $this->document->setTitle('Заказы');

        $customers = array();
        $orders = array();

        $total = 0;
        $total_special = 0;
        $total_diff = 0;
        $total_delivery = 0;

        $delivery_methods = $this->model_extra_order->getDeliveryMethods();
        $payment_methods = $this->model_extra_order->getPaymentMethods();

        if (date('H') < ORDER_NUM_RESET_HOUR) {
            $timestamp = (time() - 60 * 60 * 24);
        } else {
            $timestamp = time();
        }
        $this->data['timestampV'] = $timestamp;
        // $this->data['timestampV']=date('Y-m-d', $timestamp).' 09:00:00';
        $data = array(
            'filter_date_confirm_start' => date('Y-m-d', $timestamp) . ' ' . ORDER_NUM_RESET_HOUR . ':00:00',
            'filter_status_id' => array(
                CONFIRM_ORDER_STATUS_ID,
                PREPARE_ORDER_STATUS_ID,
                COMPLETE_ORDER_STATUS_ID,
                Z_INVISIBLE_ORDER_STATUS_ID
            )
        );

        $results = $this->model_extra_order->getOrders($data);

        foreach ($results as $result) {
            if (!isset($customers[$result['customer_id']])) {
                $customers[$result['customer_id']] = $this->model_extra_customer->getCustomer($result['customer_id']);
            }

            $customer = $customers[$result['customer_id']];

            $products = array();

            $order_products = $this->model_extra_order->getOrderProducts($result['order_id']);

            foreach ($order_products as $order_product) {
                $product_info = $this->model_catalog_product->getProduct($order_product['product_id']);

                if ($product_info) {
                    $products[] = array(
                        'product_id' => $order_product['product_id'],
                        'name' => $product_info['name'],
                        'quantity' => $order_product['quantity']
                    );
                } else {
                    $products[] = array(
                        'product_id' => $order_product['product_id'],
                        'name' => 'Товар не найден в каталоге',
                        'quantity' => $order_product['quantity']
                    );
                }
            }

            $order_total = $this->model_extra_order->getOrderTotal($result['order_id']);
 
            if ($result['status_id'] == COMPLETE_ORDER_STATUS_ID) {
                $total += $order_total['price'];
                $total_special += $order_total['special'];
                $total_diff += $order_total['diff'];

                if (!in_array($result['delivery_id'], $this->model_extra_order->getFreeDeliveryIds()) && ($result['distance'] > FREE_DELIVERY_DISTANCE || $result['biglion'] || ($order_total['special'] + $order_total['diff'] > 0 && $order_total['special'] + $order_total['diff'] < FREE_DELIVERY_TOTAL))) {
                    $total_delivery += $this->model_extra_order->getDeliveryPrice($result['distance']);
                }
            }

            if ($result['status_id'] == CONFIRM_ORDER_STATUS_ID) {
                $href_change_status = $this->url->link('extra/helper/changeStatus', 'order_id=' . $result['order_id'] . '&status_id=' . PREPARE_ORDER_STATUS_ID . '&token=' . $this->session->data['token']);
            } elseif ($result['status_id'] == PREPARE_ORDER_STATUS_ID) {
                $href_change_status = $this->url->link('extra/helper/changeStatus', 'order_id=' . $result['order_id'] . '&status_id=' . COMPLETE_ORDER_STATUS_ID . '&token=' . $this->session->data['token']);
            } elseif ($result['status_id'] == COMPLETE_ORDER_STATUS_ID) {
                $href_change_status = $this->url->link('extra/helper/changeStatus', 'order_id=' . $result['order_id'] . '&status_id=' . Z_INVISIBLE_ORDER_STATUS_ID . '&token=' . $this->session->data['token']);
            } elseif ($result['status_id'] == Z_INVISIBLE_ORDER_STATUS_ID) {
                $href_change_status = $this->url->link('extra/helper/changeStatus', 'order_id=' . $result['order_id'] . '&status_id=' . COMPLETE_ORDER_STATUS_ID . '&token=' . $this->session->data['token']);
            } else {
                $href_change_status = false;
            }

            $orders[$result['status_id']][] = array(
                'order_id' => $result['order_id'],
                'number' => $result['number'],
                'customer_name' => $customer['name'],
                'preorder' => $result['preorder'],
                'confirm_time' => date('Y-m-d H:i:s', strtotime($result['date_confirm'])),
                'delivery_time' => $result['delivery_time'],
                'delivery_date' => date('d.m.Y', strtotime($result['delivery_date'])),
                'delivery_price' => $this->model_extra_order->getDeliveryPrice($result['distance']),
                'total' => $order_total['price'],
                'total_special' => $order_total['special'],
                'total_diff' => $order_total['diff'],
                'special_percent' => round(($order_total['price'] - $order_total['special']) / ($order_total['price'] / 100), 0),
                'phone' => $customer['phone'],
                'phone2' => $customer['phone2'],
                'address' => $customer['city'] . ', ' . $customer['street'] . ', ' . $customer['house'] . ', ' . $customer['flat'],
                'delivery_method' => $delivery_methods[$result['delivery_id']],
                'payment_id' => $result['payment_id'],
                'payment_method' => $payment_methods[$result['payment_id']],
                'products' => $products,
                'comment' => $result['comment'],
                'href_change_status' => $href_change_status,
                'href_edit' => $this->url->link('extra/order/edit', 'order_id=' . $result['order_id'] . '&save=1&' . '&token=' . $this->session->data['token'])
            );
        }
        $this->data['orders'] = $orders;

        $this->data['payment_methods'] = $this->model_extra_order->getPaymentMethods();

        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $this->data['success'] = false;
        }
        
        $bonus = $this->model_extra_order->getOrderBonuspoints($result['order_id']); 
        
        
        $this->data['delivery_time'] = $this->config->get('delivery_time');
        $this->data['extra_comment'] = $this->config->get('extra_comment');

        $this->data['total'] = $total;
        $this->data['total_special'] = $total_special;
        $this->data['total_diff'] = $total_diff;
        $this->data['total_delivery'] = $total_delivery;

        $this->data['href_x_report'] = $this->url->link('extra/report/xReport', 'token=' . $this->session->data['token']);
        $this->data['href_z_report'] = $this->url->link('extra/report/zReport', 'token=' . $this->session->data['token']);

        if (isset($this->session->data['print_check'])) {
            $this->data['print_check'] = $this->session->data['print_check']; // print_check == order_id
            unset($this->session->data['print_check']);
        } else {
            $this->data['print_check'] = false;
        }
        $this->data['bonus'] = $bonus;
        $this->data['token'] = $this->session->data['token'];

        $this->template = 'extra/all.tpl';

        $this->children = array(
            'extra/order/catalog',
            'extra/order/order_info',
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    public function add() {
        $this->document->setTitle('Новый заказ');

        $this->getForm();
    }

    public function edit() {
        $this->document->setTitle('Редактирование заказа');

        $this->getForm();
    }

    protected function getForm() {
        $this->load->model('catalog/product');
        $this->load->libraryModel('extra/order');
        $this->load->libraryModel('extra/customer');
        $this->load->model('localisation/order_status');

        $statuses = array();

        $results = $this->model_localisation_order_status->getOrderStatuses();

        foreach ($results as $result) {
            $statuses[$result['order_status_id']] = $result['name'];
        }

        $this->data['customer'] = false;

        $this->data['latest_orders'] = array();

        if (isset($this->request->get['phone'])) {
            $customer = $this->model_extra_customer->getCustomerByPhone($this->request->get['phone']);

            if ($customer) {
                $this->data['customer'] = $customer;

                $data = array(
                    'filter_customer_id' => $customer['customer_id'],
                    'filter_status_id' => array(
                        CONFIRM_ORDER_STATUS_ID,
                        PREPARE_ORDER_STATUS_ID
                    )
                );

                $results = $this->model_extra_order->getOrders($data);

                foreach ($results as $result) {
                    $confirm_timestamp = strtotime($result['date_confirm']);
                    $delivery_timestamp = strtotime($result['delivery_date'] . ' ' . $result['delivery_time']);

                    $delivery_left_timestamp = $delivery_timestamp - time();

                    $time_left = round($delivery_left_timestamp / 60);
                    if ($time_left >= 60) {
                        $text_time_left = (int) ($time_left / 60) . ' ч., ' . $time_left % 60 . ' мин.';
                    } elseif ($time_left >= 0) {
                        $text_time_left = $time_left . ' мин.';
                    } elseif ($time_left >= -60) {
                        $text_time_left = 'Просрочено на ' . abs($time_left) . ' мин.';
                    } else {
                        $text_time_left = 'Просрочено на ' . (int) (abs($time_left) / 60) . ' ч., ' . abs($time_left) % 60 . ' мин.';
                    }

                    $total = $this->model_extra_order->getOrderTotal($result['order_id']);

                    $this->data['latest_orders'][] = array(
                        'order_id' => $result['order_id'],
                        'time_confirm' => date('H:i', $confirm_timestamp),
                        'date_delivery' => date('d.m', $delivery_timestamp),
                        'time_delivery' => date('H:i', $delivery_timestamp),
                        'delivery_price' => $this->model_extra_order->getDeliveryPrice($result['distance']),
                        'time_left' => $time_left,
                        'text_time_left' => $text_time_left,
                        'total_special' => $total['special'],
                        'total_diff' => $result['total_diff'],
                        'status_id' => $result['status_id'],
                        'status_name' => $statuses[$result['status_id']]
                    );
                }
            }
        }

        // echo '<pre style="text-align: left; background: #FFFFFF;">'; print_r($this->data['latest_orders']); echo '</pre>';

        if ($this->config->get('delivery_time') >= 60) {
            $config_delivery_time = (int) ($this->config->get('delivery_time') / 60) . 'ч.';

            if ($this->config->get('delivery_time') % 60 > 0) {
                $config_delivery_time .= ($this->config->get('delivery_time') % 60) . ', мин.';
            }
        } else {
            $config_delivery_time = $this->config->get('delivery_time') . ' мин.';
        }

        $this->data['extra_comment'] = $this->config->get('extra_comment');

        $this->data['free_delivery_ids'] = $this->model_extra_order->getFreeDeliveryIds();

        $this->data['config_delivery_time'] = $config_delivery_time;

        $this->data['specials'] = $this->model_extra_order->getSpecials();

        $this->data['token'] = $this->session->data['token'];

        $this->template = 'extra/order_form.tpl';

        $this->children = array(
            'extra/order/catalog',
            'extra/order/order_info',
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    public function order_info() {
        $this->load->model('catalog/product');
        $this->load->libraryModel('extra/order');
        $this->load->libraryModel('extra/customer');

        if (isset($this->request->get['order_id'])) {
            $order_id = $this->request->get['order_id'];
        } elseif (isset($this->request->get['phone'])) {
            $order_id = $this->model_extra_customer->getLastOrderIdByPhone($this->request->get['phone'], NEW_ORDER_STATUS_ID);
        } else {
            $order_id = 0;
        }

        $order_info = $this->model_extra_order->getOrder($order_id);

        if ($order_info) {
            $order_info['delivery_date'] = date('d.m.Y', strtotime($order_info['delivery_date']));

            // products
            $this->data['products'] = array();

            $order_products = $this->model_extra_order->getOrderProducts($order_id);

            foreach ($order_products as $order_product) {
                $product = $this->model_catalog_product->getProduct($order_product['product_id']);

                if (!$product) {
                    continue;
                }

                $this->data['products'][] = array(
                    'product_id' => $order_product['product_id'],
                    'name' => $product['name'],
                    'quantity' => $order_product['quantity'],
                    'price' => $order_product['price'],
                    'special' => $order_product['special'],
                    'special_percent' => $order_product['special_percent'],
                    'total' => $order_product['quantity'] * $order_product['special']
                );
            }

            // order info
            $this->data['order'] = $order_info;
        } else {
            $this->data['products'] = array();

            $this->data['order'] = array(
                'status_id' => NEW_ORDER_STATUS_ID,
                'payment_id' => 0,
                'delivery_id' => 0,
                'persons' => 1,
                'preorder' => 0,
                'biglion' => 0,
                'delivery_date' => date('d.m.Y'),
                'delivery_time' => 0,
                'date_confirm' => 0,
                'comment' => '',
                'floor' => 1
            );
        }

        if (isset($order_info['customer_id'])) {
            $customer = $this->model_extra_customer->getCustomer($order_info['customer_id']);
        } elseif (isset($this->request->get['phone'])) {
            $customer = $this->model_extra_customer->getCustomerByPhone($this->request->get['phone']);
        } else {
            $customer = false;
        }

        if ($customer) {
            $this->data['customer'] = $customer;
        } else {
            $this->data['customer'] = array(
                'name' => '',
                'phone' => '[:CALL_FROM:]',
                'phone2' => '',
                'city' => 'Калининград',
                'street' => '',
                'house' => '',
                'flat' => '',
                'total_special' => 0
            );
        }

        $this->data['specials'] = $this->model_extra_order->getSpecials();
        $this->data['delivery_methods'] = $this->model_extra_order->getDeliveryMethods();
        $this->data['free_delivery_ids'] = $this->model_extra_order->getFreeDeliveryIds();
        $this->data['delivery_time'] = $this->model_extra_order->getDeliveryTime();
        $this->data['payment_methods'] = $this->model_extra_order->getPaymentMethods();

        if (isset($this->request->get['order_id'])) {
            $this->data['href_cancel'] = $this->url->link('extra/helper/changeStatus', 'order_id=' . $this->request->get['order_id'] . '&status_id=' . CANCELED_ORDER_STATUS_ID . '&back=extra/order' . '&token=' . $this->session->data['token']);
        } else {
            $this->data['href_cancel'] = $this->url->link('extra/order', 'token=' . $this->session->data['token']);
        }

        $this->template = 'extra/order_info.tpl';

        $this->response->setOutput($this->render());
    }

    public function catalog() {
        $this->load->model('catalog/category');
        $this->load->model('catalog/product');
        $this->load->model('tool/image');

        $this->data['categories'] = array();

//		$categories = $this->model_catalog_category->getCategoriesByParentId(0);
        $categories = $this->model_catalog_category->getCategoriesCrunch(0);
//    var_dump($categories);
        foreach ($categories as $category) {
            $data = array(
                'filter_category_id' => $category['category_id'],
                'filter_sub_category' => true
            );

            $products = array();

            $results = $this->model_catalog_product->getProducts($data);

            foreach ($results as $result) {
                $products[] = array(
                    'product_id' => $result['product_id'],
                    'name' => $result['name'],
                    'price' => round($result['price'], 0),
                    'description' => strip_tags(html_entity_decode($result['description']), '<br>'),
                    'weight' => round($result['weight'], 1)
                        // 'image'      => $this->model_tool_image->resize($result['image'], 40, 40)
                );
            }

            $category['products'] = $products;

            $this->data['categories'][] = $category;
        }

        $this->template = 'extra/catalog.tpl';

        $this->response->setOutput($this->render());
    }

    public function jxSaveOrder() {
        $json = array();

        $this->load->libraryModel('extra/customer');
        $this->load->libraryModel('extra/order');

        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate_order()) {
            $customer_data = $this->request->post['customer'];
            $order_data = $this->request->post['order'];



            $customer_data['phone'] = $this->model_extra_customer->formatPhone($customer_data['phone']);
            $customer_data['phone2'] = $this->model_extra_customer->formatPhone($customer_data['phone2']);

            // if ($customer_data['total_special']) {
            // unset($customer_data['total_special']);
            // }

            $customer_id = $this->model_extra_customer->saveCustomer($customer_data);

            if (!$order_data['preorder']) {
                // todo убрать - 360 когда на сервере обновится калининградское время! (на данный момент на час вперед)
                $delivery_timestamp = (time() + ($this->config->get('delivery_time') * 60) - 3600); // delivery_time в минутах

                $order_data['delivery_date'] = date('Y-m-d', $delivery_timestamp);
                $order_data['delivery_time'] = date('H:i:s', $delivery_timestamp);
            } else {
                $order_data['delivery_date'] = date('Y-m-d', strtotime($order_data['delivery_date']));
            }

            $order_data['address'] = $customer_data['city'] . ', ' . $customer_data['street'] . ', ' . $customer_data['house'];
            $bonusdata = $this->request->post["bonusdata"];
            if ($customer_data['flat']) {
                $order_data['address'] .= ', ' . $customer_data['flat'];
            }
            $order_data["floor"] = $customer_data['floor'];
            /* $this->response->setOutput(json_encode($order_data));
              return;/* */

            if (isset($order_data['order_id'])) {

                // подтверждение заказа с сайта, либо редактирование уже подтвержденного заказа $order_data['date_confirm'] date_confirm
                $order = array(
                    'bc_fill' => $bonusdata['fill'],
                    'bc_withdraw' => $bonusdata['withdraw'],
                    'bc_account' => $bonusdata['account'],
                    'bc_phone' => $bonusdata['phone'],
                    
                    'order_id' => $order_data['order_id'],
                    'status_id' => $order_data['status_id'],
                    'payment_id' => $order_data['payment_id'],
                    'payment_id' => $order_data['payment_id'],
                    'delivery_id' => $order_data['delivery_id'],
                    'delivery_date' => $order_data['delivery_date'],
                    'delivery_time' => $order_data['delivery_time'],
                    'date_confirm' => date('Y-m-d H:i:s'),
                    'preorder' => $order_data['preorder'],
                    'biglion' => $order_data['biglion'],
                    'persons' => trim($order_data['persons']),
                    'comment' => $order_data['comment'],
                    'address' => $order_data['address'],
                    'distance' => $customer_data['distance'],
                    'bc_fill' => $bonusdata['fill'],
                    'floor' => trim($order_data['floor'])
                );

                $result = $this->model_extra_order->updateOrder($order);

                $order_id = $order['order_id'];
                $json["action"] = "updateOrder";
                $json["response"] = $result;
                $json["result"] = $result;
            } else {
                // новая заявка по телефону

                $order = array(
                    'bc_fill' => $bonusdata['fill'],
                    'bc_withdraw' => $bonusdata['withdraw'],
                    'bc_account' => $bonusdata['account'],
                    'bc_phone' => $bonusdata['phone'],
                    
                    'oc_order_id' => 0,
                    'status_id' => $order_data['status_id'],
                    'number' => $this->model_extra_order->getCurrentOrderNum() + 1,
                    'customer_id' => $customer_id,
                    'payment_id' => $order_data['payment_id'],
                    'delivery_id' => $order_data['delivery_id'],
                    'delivery_date' => $order_data['delivery_date'],
                    'delivery_time' => $order_data['delivery_time'],
                    'preorder' => $order_data['preorder'],
                    'biglion' => $order_data['biglion'],
                    'persons' => trim($order_data['persons']),
                    'comment' => $order_data['comment'],
                    'date_confirm' => date('Y-m-d H:i:s'),
                    'date_add' => date('Y-m-d H:i:s'),
                    'total_diff' => 0,
                    'address' => $order_data['address'],
                    'distance' => $customer_data['distance'],
                    'floor' => trim($order_data['floor'])
                );
                // ниже бэкап, js не всегда отрабатывал получение даты
// $order = array(
// 					'oc_order_id'   => 0,
// 					'status_id'     => $order_data['status_id'],
// 					'number'        => $this->model_extra_order->getCurrentOrderNum() + 1,
// 					'customer_id'   => $customer_id,
// 					'payment_id'    => $order_data['payment_id'],
// 					'delivery_id'   => $order_data['delivery_id'],
// 					'delivery_date' => $order_data['delivery_date'],
// 					'delivery_time' => $order_data['delivery_time'],
// 					'preorder'      => $order_data['preorder'],
// 					'biglion'       => $order_data['biglion'],
// 					'persons'       => trim($order_data['persons']),
// 					'comment'       => $order_data['comment'],
// 					'date_confirm'  => $order_data['date_confirm'],
// 					'date_add'      => date('Y-m-d H:i:s'),
// 					'total_diff'    => 0,
// 					'address'       => $order_data['address'],
// 					'distance'      => $customer_data['distance']
// 				);

                $order_id = $this->model_extra_order->addOrder($order);
                $json["action"] = "addOrder";
                $json["response"] = $order_id;
            }
            
            $this->model_extra_order->addProductsToOrder($order_id, $this->request->post['products'], true);

            $this->session->data['success'] = 'Изменения сохранены';

            $url = '&token=' . $this->session->data['token'];
            if ($this->config->get('is_iframe')) {
                $url .= '&iframe=true';
            }

            if (isset($this->request->post['redirect_route'])) {
                $route = $this->request->post['redirect_route'];
            } else {
                $route = 'extra/order';
            }
            
            if(!empty($order["bc_withdraw"])){
                $CLI = $GLOBALS["BCCLI"];
                $json["bc_withdraw"] = $CLI->Withdraw($order["bc_account"], $order["bc_withdraw"]);
            }
            
            if(!empty($order["bc_fill"])){
                $CLI = $GLOBALS["BCCLI"];
                $json["bc_fill"] = $CLI->Fill($order["bc_account"], $order["bc_fill"]);
            }

            $json['redirect'] = html_entity_decode($this->url->link($route, $url));
        }

        if ($this->errors) {
            $json['errors'] = $this->errors;
        }

        $this->response->setOutput(json_encode($json));
    }

    protected function validate_order() {
        if (!isset($this->request->post['order']['payment_id'])) {
            $this->errors[] = 'Не выбран способ оплаты';
        }

        if (!isset($this->request->post['order']['delivery_id'])) {
            $this->errors[] = 'Не выбран способ доставки';
        }

        if (!isset($this->request->post['products']) || empty($this->request->post['products'])) {
            $this->errors[] = 'Корзина пуста';
        }

        if (empty($this->request->post['customer']['name'])) {
            $this->errors[] = 'Не указано имя клиента';
        }

        if (empty($this->request->post['customer']['phone'])) {
            $this->errors[] = 'Укажите телефон клиента';
        }

        if (empty($this->errors)) {
            return true;
        } else {
            return false;
        }
    }

}

?>