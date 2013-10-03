<?php

class CliController extends Jien_Controller {

    public function init(){
        parent::init();
    }

    public function info($msg = ''){
        echo "$msg\r\n";
        ob_flush();
    }

    public function checkAction (){

        $monitor = new Proccrm_Monitor;

        $this->info("Checking sites ... ");

	$mids = Zend_Json::decode(Jien::curl("https://portal.processing.com/api.mids.php", "POST", array("pw" => "aoisn30923fsjakjsd3@P#()")));

        /*
        $mids = array(
             array('paysite' => 'https://www.naturalgreencleanse.com/'),
             array('paysite' => 'http://www.cellanburn.com'),
             array('paysite' => 'http://www.acaienergizeextra.com'),
        );
        */

        foreach($mids AS $key=>$mid){

            $url = $mid['paysite'];

            if(empty($url) || !strstr($url, '.')){
                continue;
            }

            $temp_url = str_replace('https','http',$url);
            $alt_url = Jien::model('Site')->Where("url = '{$temp_url}'")->andWhere('iframe_ignore = 0')->get()->row('alt_url');

            $this->info("---------------");
            $this->info("Checking {$url}");
            $monitor->monitor($url, $mid, $alt_url);
            $this->info("---------------");
            $this->info("sleep 10 seconds");
            sleep(5);
            $this->info(" ");

        }

        $sites = Jien::model("Site")->filter(array("site_status"=>'changed'))->get()->rows();
        $warnings = count($sites);
        $this->info("{$warnings} sites have changed");
        if($warnings > 0){
            $changed = array();
            foreach($sites AS $key=>$site){
                $changed[] = "{$site['url']} ({$site['account_name']}/{$site['corp_name']})";
            }
            $changed = implode("<br>", $changed);
            $msg = "The {$warnings} sites requires review: <br><br> {$changed} <br><br>Please log on to http://proccrm.processing.com for more details.";

            Jien::mail("support@processing.com", "risk@processing.com", "{$warnings} sites requires review", null, $msg);
            Jien::mail("support@processing.com", "jaequery@gmail.com", "{$warnings} sites requires review", null, $msg);

            $this->info("email notice sent out!");
        }

        exit;
    }

    public function resetAction(){
        $img_path = dirname(__FILE__) . "/../../public/screenshots/*";
        Jien::model("Site")->delete("1=1");
        exec("rm -rf {$img_path}");
        $this->info("Site reset!");
        exit;
    }

}