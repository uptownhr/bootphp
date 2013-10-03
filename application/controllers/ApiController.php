<?php

class ApiController extends My_Controller {

    public function init(){
    	$this->session = $this->params('session', session_id());
        parent::init();
    }

    public function indexAction(){
    	echo 'API usage';exit;
    }

	public function cartAction(){
		$params = $this->params();

		switch($params['cmd']){
			case "add":

				$required_fields = array("product_id", "qty");
				foreach($required_fields AS $field){
					if(empty($params[$field])){
						$this->json(array(), 400, "{$field} can not be empty");
					}
				}

				$product = Jien::model("Product")->get($params['product_id'])->row();

				if(empty($product)){
					$this->json(array(), 404, "product not found");
				}

				$cart_id = Jien::model("Cart")->save(array(
					"product_id"	=>	$params['product_id'],
					"qty"	=>	$params['qty'],
					"product_price"	=>	$product['product_price'],
					"session"	=>	$this->session,
					"product_options"	=>	!empty($params['product_options']) ? Zend_Json::encode($params['product_options']) : ''
				));

				$this->json(array("cart_id"	=>	$cart_id), 200, 'item added');
			break;

			case "update":

				$required_fields = array("cart_id", "qty");
				foreach($required_fields AS $field){
					if(empty($params[$field])){
						$this->json(array(), 400, "{$field} can not be empty");
					}
				}

				$cart = Jien::model("Cart")->get($params['cart_id']);
				if($cart->count() == 0){
					$this->json(array(), 404);
				}else{
					$cart_id = Jien::model("Cart")->update(array("qty"=>$params['qty']), "cart_id = {$params['cart_id']}");
				}

				$this->json(array("cart_id"	=>	$params['cart_id']), 200, 'item updated');
			break;

			case "delete":

				$required_fields = array("cart_id");
				foreach($required_fields AS $field){
					if(empty($params[$field])){
						$this->json(array(), 400, "{$field} can not be empty");
					}
				}

				$cart_id = $params['cart_id'];
				$cart_id = Jien::model("Cart")->delete("cart_id = $cart_id AND order_id IS NULL");

				if(!$cart_id){
					$this->json(array(), 404);
				}

				$this->json(array("cart_id"	=>	$cart_id), 200, 'item deleted');
			break;

			case "empty":

				$cart_id = Jien::model("Cart")->delete("session = '{$this->session}'");
				if(!$cart_id){
					$this->json(array(), 404);
				}

				$this->json(array("cart_id"	=>	$cart_id), 200, 'cart emptied');
			break;

			case "list":
				$products = Jien::model("Cart")->getProductsBySession($this->session);
				$totals = Jien::model("Cart")->getTotalsBySession($this->session);
				$coupons = Jien::model("Cart")->getActiveCoupons("session = '{$this->session}'");
				$charges = Jien::model("Cart")->getChargeAmounts($this->session);
				$this->json(array("products"=>$products, "summary"=>$totals, "coupons"=>$coupons, "charges"=>$charges), 200);
			break;

			case "apply_coupon":
				$required_fields = array("coupon_code");
				foreach($required_fields AS $field){
					if(empty($params[$field])){
						$this->json(array(), 400, "{$field} can not be empty");
					}
				}

				$coupon = Jien::model("Coupon")->where("coupon_code = '{$params['coupon_code']}' AND status = 'published'")->get()->row();
				if(empty($coupon)){
					$this->json(array(), 404, "Coupon code not found or has been expired.");
				}else{

					$couponSession = Jien::model("CouponSession")->where("coupon_id = {$coupon['coupon_id']} AND session = '{$this->session}'")->get()->rows();
					if(!empty($couponSession)){
						$this->json(array(), 404, "Coupon code already in session.");
					}

					$coupon_session_id = Jien::model("CouponSession")->save(array(
						"session"	=>	$this->session,
						"coupon_id"	=>	$coupon['coupon_id'],
					));
					$this->json(array("coupon_session_id"=>$coupon_session_id), 200);
				}
			break;

		}
	}

	public function orderAction(){
		$params = $this->params();

		$required_fields = array("cmd");
		foreach($required_fields AS $field){
			if(empty($params[$field])){
				$this->json(array(), 400, "{$field} can not be empty");
			}
		}

		switch($params['cmd']){
			case "add":

				$cart_totals = Jien::model("Cart")->getTotalsBySession($this->session);
				if(empty($cart_totals['total_qty'])){
					$this->json(array(), 404, 'cart empty');
				}

				// check required fields
				$required_fields = array("b_fname", "b_lname", "b_addr1", "b_city", "b_state", "b_zip", "payment_method");
				foreach($required_fields AS $field){
					if(empty($params[$field])){
						$this->json(array("focus"=>$field), 400, "{$field} can not be empty");
					}
				}

				if(empty($_SESSION['user']['user_id'])){
					$this->json(array(), 401, 'requires user to be signed in');
				}

				// create an order
				$order_data = array(
					"session"	=>	$this->session,
					"user_id"	=>	$_SESSION['user']['user_id'],
					"total_qty"	=>	$cart_totals['total_qty'],
					"subtotal_price"	=>	$cart_totals['subtotal_price'],
					"shipping_price"	=>	$cart_totals['shipping_price'],
					"tax_price"	=>	$cart_totals['tax_price'],
					"discount_price"	=>	$cart_totals['discount_price'],
					"total_price"	=>	$cart_totals['total_price'],
					"b_fname"	=>	$this->params('b_fname'),
					"b_lname"	=>	$this->params('b_lname'),
					"b_addr1"	=>	$this->params('b_addr1'),
					"b_addr2"	=>	$this->params('b_addr2'),
					"b_city"	=>	$this->params('b_city'),
					"b_state"	=>	$this->params('b_state'),
					"b_zip"	=>	$this->params('b_zip'),
					"s_fname"	=>	$this->params('s_fname', $this->params('b_fname')),
					"s_lname"	=>	$this->params('s_lname', $this->params('b_lname')),
					"s_addr1"	=>	$this->params('s_addr1', $this->params('b_addr1')),
					"s_addr2"	=>	$this->params('s_addr2', $this->params('b_addr2')),
					"s_city"	=>	$this->params('s_city', $this->params('b_city')),
					"s_state"	=>	$this->params('s_state', $this->params('b_state')),
					"s_zip"	=>	$this->params('s_zip', $this->params('b_zip')),
					"payment_method"	=>	$this->params('payment_method'),
				);

				// check if prior order exists
				$order = Jien::model("Order")->where("session='{$this->session}' AND status='pending'")->get()->row();
				if(!empty($order)){
					Jien::model("Order")->update($order_data, "session='{$this->session}' AND status='pending'");
					$order_id = $order['order_id'];
				}else{
					$order_id = Jien::model("Order")->save($order_data);
				}

				// process transaction
				switch($this->params('payment_method')){

					case "stripe":

						$required_fields = array("b_fname", "b_lname", "b_addr1", "b_city", "b_state", "b_zip", "payment_method", "card_num", "card_exp_month", "card_exp_year", "card_cvv");
						foreach($required_fields AS $field){
							if(empty($params[$field])){
								$this->json(array("focus"=>$field), 400, "{$field} can not be empty");
							}
						}

						// check if stripe customer exists
						if(empty($_SESSION['user']['token'])){

							// create stripe customer
							try {

								$res = Stripe_Customer::create(array(
								  "description" => $_SESSION['user']['user_id'],
								  "card" => $this->params('stripe_token_id'),
								  "email"	=>	$_SESSION['user']['email'],
								));
								Jien::model("User")->save(array(
									"user_id"	=>	$_SESSION['user']['user_id'],
									"token"	=>	$res['id'],
								));
								$_SESSION['user']['token'] = $res['id'];

							}catch(Exception $e){
								$this->json(array(), 401, $e->getMessage());
							}

						}

						// this is used instead of card information
						$customer_token = $_SESSION['user']['token'];

						// get charge amounts which is now separated into onetime and subscriptions
						$charge_amounts = Jien::model("Cart")->getChargeAmounts($this->session);

						// process one-time charges
						$charge_amount = $charge_amounts['onetime'];
						if(!empty($charge_amount)){
							try {
								$request = array(
									'customer' => $customer_token,
									'currency' => 'usd',
									'amount' => $charge_amount * 100,
									'description' => $order_id,
								);
								$response = Stripe_Charge::create($request);

								// save transaction
								$transaction_id = Jien::model("Transaction")->save(array(
									"method"	=>	"stripe",
									"status"	=>	"paid",
									"plan"		=>	"onetime",
									"user_id"	=>	$_SESSION['user']['user_id'],
									"order_id"	=>	$order_id,
									"amount"	=>	$charge_amount,
									"paid"	=>	new Zend_Db_Expr("NOW()"),
									"foreign_key" => $response['id'],
									"foreign_request" => Zend_Json::encode((array)$request),
									"foreign_response" => Zend_Json::encode((array)$response),
								));

							}catch(Exception $e){
								$this->json(array(), 401, $e->getMessage());
							}
						}

						// process subscription charges
						$subscriptions = $charge_amounts['subscriptions'];
						if(!empty($subscriptions)){
							foreach($subscriptions AS $product_id=>$subscription){
								try {
									$stripe_customer = Stripe_Customer::retrieve($customer_token);
									$request = array("prorate" => true, "plan" => $subscription['plan']);
									$response = $stripe_customer->updateSubscription($request);

									// save transaction
									$transaction_id = Jien::model("Transaction")->save(array(
										"method"	=>	"stripe",
										"status"	=>	"paid",
										"plan"	=>	$subscription['plan'],
										"user_id"	=>	$_SESSION['user']['user_id'],
										"order_id"	=>	$order_id,
										"amount"	=>	$subscription['amount'],
										"paid"	=>	new Zend_Db_Expr("NOW()"),
										"foreign_key" => $response['id'],
										"foreign_request" => Zend_Json::encode((array)$request),
										"foreign_response" => Zend_Json::encode((array)$response),
									));

								}catch(Exception $e){
									$this->json(array(), 401, $e->getMessage());
								}
							}
						}

					break;

					case "boleto":

						// check last boleto transaction status if it exists
						$transaction = Jien::model("Transaction")->where("order_id = '{$order_id}' AND method='boleto'")->orderBy('transaction_id DESC')->limit(1)->get()->row();
						Jien::errorLog($transaction);

						$request = array(
							"account_username" => 'a',
							"account_password" => 'a',
							"mid" => 'a',
							"mid_q" => 'a',
							"type" => 'request',
							"first_name" => $_SESSION['user']['b_fname'],
							"last_name" => $_SESSION['user']['b_lname'],
							"email_address" => $_SESSION['user']['email'],
							"amount" => $cart_totals['total_price'],
							"referenceid" => 'test'.time().$order_id,
							"order_number" => $order_id,
						);

						if(!empty($transaction['status'])){
							switch($transaction['status']){
								case "open":
									$this->json($transaction, 200, "Currently open, please fill out boleto form");
								break;


								case "paid":
									$this->json($transaction, 200, "Already paid");
								break;

								case "cancelled":
									$this->json($transaction, 200, "Transaction cancelled");
								break;
							}
						}else{
							$response = Zend_Json::decode(Jien::curl("http://processing.jaequery.com/api/boleto", "POST", $request));
							Jien::errorLog($request);
						}

						if($response['status']['code'] == 200){
							// save transaction
							$transaction_data = array(
								"method"	=>	"boleto",
								"status"	=>	"pending",
								"user_id"	=>	$_SESSION['user']['user_id'],
								"order_id"	=>	$order_id,
								"amount"	=>	$cart_totals['total_price'],
								"foreign_key" => $response['result']['payment']['hash'],
								"foreign_request" => Zend_Json::encode((array)$request),
								"foreign_response" => Zend_Json::encode((array)$response),
							);
							if(!empty($transaction['transaction_id'])){
								$transaction_data['transaction_id'] = $transaction['transaction_id'];
							}
							$transaction_id = Jien::model("Transaction")->save($transaction_data);
							$this->json($response['result'], 200);
						}else {
							$this->json($response, 400, $response['status']['message']);
						}
					break;
				}

				// refresh cart
				Jien::model("Order")->setAsPaid($order_id, $this->session);

				// output
				$this->json(array("order_id"=>$order_id), 200);
			break;

			case "update":

				$required_fields = array("order_id", "status");
				foreach($required_fields AS $field){
					if(empty($params[$field])){
						$this->json(array(), 400, "{$field} can not be empty");
					}
				}

				$order_id = Jien::model("Order")->update(array("status"=>$params['status']), "order_id = {$params['order_id']}");

				if(!$order['cart_id']){
					$this->json(array(), 404);
				}

				$this->json(array("order_id"=>$order_id), 200, 'item updated');
			break;

			case "view":

				$required_fields = array("order_id");
				foreach($required_fields AS $field){
					if(empty($params[$field])){
						$this->json(array(), 400, "{$field} can not be empty");
					}
				}

				$order = Jien::model("Order")->joinUser()->get($params['order_id'])->row();

				if(empty($order['order_id'])){
					$this->json($order, 404);
				}

				$products = Jien::model("Order")->getCartProducts($params['order_id']);
				$order = array_merge($order, Jien::model("Cart")->getTotalsByOrderId($params['order_id']));
				$coupons = Jien::model("Cart")->getActiveCoupons("order_id = '{$params['order_id']}'");

				$res = array();

				$res['order'] = $order;
				$res['products'] = $products;
				$res['coupons'] = $coupons;

				$this->json($res, 200);
			break;

		}
	}

	public function userAction(){
		$data = $this->params();
		$data = Jien::sanitize($data);

		switch($data['cmd']){
			case "update":

				if(empty($_SESSION['user'])){
					$this->json(array(), 404, "User needs to be logged in to perform this command");
				}

				if(empty($data['username'])){
					$error['msg'] = "Username can't be blank";
					$error['focus'] = "username";
				}

				if(!empty($error)){
					$this->json($error, 401, 'input validation error');
				}

				if(!empty($_SESSION['user']['user_id'])){
					$data['user_id'] = $_SESSION['user']['user_id'];
				}

				$res = Jien::model("User")->save($data);

				$user = Jien::model("User")->get($_SESSION['user']['user_id'])->row();
				$_SESSION['user'] = $user;

				$this->json($res, 200, 'user updated');
			break;

		}
	}

    public function getHistoryAction(){
        $post = $this->params();

        $data = Jien::model("SiteData")->Where('site = "' . $post['site_id'] . '"')->get($post['sitedata_id'])->row();

        $this->json($data,200,'SUCCESS');
    }

    public function setOriginalAction(){
        $post = $this->params();

        $temp = Jien::model('Site')->get($post['site_id'])->row();

        $siteData = Jien::model('SiteData')->Where('site = "' . $post['site_id'] . '"')->orderBy('created DESC')->get()->rows();

        if($post['sitedata_id'] == $temp['new_source']){
            $data = array(
                'site_id' => $post['site_id'],
                'current_source' => $post['sitedata_id'],
                'new_source' => null,
            );
        }else if($post['sitedata_id'] != $temp['new_source'] && empty($temp['new_source']) && count($siteData) > 1){
            $data = array(
                'site_id' => $post['site_id'],
                'current_source' => $post['sitedata_id'],
                'new_source' => $siteData[0]['sitedata_id']
            );
        }else{
            $data = array(
                'site_id' => $post['site_id'],
                'current_source' => $post['sitedata_id']
            );
        }


        $res = Jien::model('Site')->save($data);

        if($res){
            $this->json($res,200,'SUCCESS');
        }else{
            $this->json(null,400,'ERROR');
        }

    }

    public function generateAuthSecretAction(){
        $ga = new GoogleAuthenticator();
        $secret = $ga->generateSecret();
        $username = $this->params('username');
        if(!empty($username)){
            $res = array(
                'secret' => $secret,
                'qr' => $ga->getUrl($username,'processing.com',$secret)
            );
        }

        if(!empty($res)){
            $this->json($res,200,'SUCCESS');
        }else{
            $this->json(null,400,'ERROR');
        }
    }

    public function authCheckAction(){
        $user_id = $this->params('user_id');
        $res = Jien::model('Authenticator')->Where('authenticator_user_id = ' . $user_id)->get()->row();
        if(!empty($res)){
            $this->json(null,200,'SUCCESS');
        }else{
            $this->json(null,400,'ERROR');
        }
    }

    public function sendAuthSmsAction(){
        $username = $this->params('username');
        $user_id = Jien::model('User')->Where('username = "' . $username . '"')->get()->row('user_id');
        $authenticator_data = Jien::model('Authenticator')->Where("authenticator_user_id = {$user_id}")->get()->row();

        $ga = new GoogleAuthenticator();
        $auth_code = $ga->getCode($authenticator_data['authenticator_secret']);

        $data = array(
            'token' => TROPO_KEY,
            'numberToDial' => $authenticator_data['authenticator_sms'],
            'name' => $username,
            'auth_code' => $auth_code
        );

        $json_data = json_encode($data);

        $client = new Zend_Http_Client("https://api.tropo.com/1.0/sessions");
        $client->setHeaders('accept', 'application/json');
        $client->setHeaders('content-type', 'application/json');
        $response = $client->setRawData($json_data, 'application/json')->request('POST');

        $res = $response->getBody();
        $res = (array) json_decode($res);

        if($res['success']){
            $result = array(
                "number" =>  substr($authenticator_data['authenticator_sms'], -4)
            );
            $this->json($result,200,'SUCCESS');
        }else{
            $this->json(null,400,'ERROR');
        }
    }
}
