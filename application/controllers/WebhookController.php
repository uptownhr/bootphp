<?php

class WebhookController extends My_Controller {

    public function init() {
    	parent::init();
    }

    public function indexAction(){
    	echo 'wtf';exit;
    }

    public function boletoAction(){
    	error_log(var_export($this->params(), true));

    	$params = $this->params();
    	if($params['status'] == "SUCCESS"){
    		$transaction = Jien::model("Transaction")->where("foreign_key = '{$params['payment']}'")->get()->row();
    		if(!empty($transaction)){
    			switch($params['payment']['status']){
    				case "CO":
    					$transaction_id = Jien::model("Transaction")->save(array(
    						"transaction_id"	=>	$transaction['transaction_id'],
    						"status"	=>	"paid",
    						"paid"	=>	$params['payment']['confirm_date'],
    					));
    					$order_id = Jien::model("Order")->save(array(
    						"order_id"	=>	$transaction['order_id'],
    						"status"	=>	"paid",
    						"paid"	=>	$params['payment']['confirm_date'],
    					));

    					// refresh cart
						Jien::model("Order")->setAsPaid($order_id, $this->session);

    				break;

    				case "CA":
    					$transaction_id = Jien::model("Transaction")->save(array(
    						"transaction_id"	=>	$transaction['transaction_id'],
    						"status"	=>	"cancelled",
    					));
    					$order_id = Jien::model("Order")->save(array(
    						"order_id"	=>	$transaction['order_id'],
    						"status"	=>	"cancelled",
    					));
    				break;

    				case "OP":
    				break;
    			}
    		}

    	}

    	echo 'ok';
    	exit;
    }

    public function stripeAction() {
    	$res = $this->params();

    	$body = @file_get_contents('php://input');
		$res = Zend_Json::decode($body);

		switch($res['type']){
			case "charge.succeeded":
				if(empty($to)){
					$user = Jien::model("User")->where("token = '{$res['data']['object']['customer']}")->get()->row();
					$from = "jae@stiqr.com";
					$to = $user['email'];
					$subject = "[" . SITE_URL . "] Receipt";
					$html = "Thank you for your purchase";
					$response = Jien::mail($from, $to, $subject, $text, $html);
					error_log(var_export($response,true));
				}
			break;

		}
    	error_log(print_r($res,true));

    	echo 'ok';
    	exit;
    }



}

