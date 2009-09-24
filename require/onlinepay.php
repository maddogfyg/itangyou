<?php
!function_exists('readover') && exit('Forbidden');

/**
 *
 * PHPWind 网上支付统一入口
 * author:chenjm@phpwind.net / sky_hold@163.com
 *
 */
Class OnlinePay {
	
	var $charset;
	var $seller_email;
	var $baseurl;
	var $alipay_key;
	var $alipay_partnerID;

	var $pwpay_url	= 'http://pay.phpwind.net/pay/create_payurl.php?';
	var $alipay_url	= 'https://www.alipay.com/cooperate/gateway.do?';

	function OnlinePay($email) {
		$this->seller_email = $email;
		$this->charset = $GLOBALS['db_charset'];
		$this->baseurl = $GLOBALS['db_bbsurl'];

		$this->alipay_key = $GLOBALS['ol_alipaykey'];
		$this->alipay_partnerID = $GLOBALS['ol_alipaypartnerID'];
	}

	function alipayurl($order_no, $fee, $paytype) {
		$param = array(
			'_input_charset'	=> $this->charset,
			'service'			=> 'create_direct_pay_by_user',
			'notify_url'		=> $this->baseurl.'/alipay.php',
			'return_url'		=> $this->baseurl.'/alipay.php',
			'payment_type'		=> '1',
			'subject'			=> getLangInfo('olpay', "olpay_{$paytype}_title", array('order_no' => $order_no)),
			'body'				=> getLangInfo('olpay', "olpay_{$paytype}_content"),
			'out_trade_no'		=> $order_no,
			'total_fee'			=> $fee,
			'seller_email'		=> $this->seller_email
		);
		if ($this->alipay_key && $this->alipay_partnerID) {
			$url = $this->alipay_url;
			$param['partner'] = $this->alipay_partnerID;
			ksort($param);
			reset($param);
			$arg = '';
			foreach ($param as $key => $value) {
				if ($value) {
					$url .= "$key=".urlencode($value)."&";
					$arg .= "$key=$value&";
				}
			}
			$url  .= 'sign='.md5(substr($arg,0,-1).$this->alipay_key).'&sign_type=MD5';
		} else {
			$url = $this->pwpay_url;
			foreach ($param as $key => $value) {
				if ($value) {
					$url  .= "$key=".urlencode($value)."&";
				}
			}
		}
		return $url;
	}

	function alipay2url($param) {
		$param['service']			= 'trade_create_by_buyer';
		$param['_input_charset']	= $this->charset;
		$param['seller_email']		= $this->seller_email;

		if (0 && $this->alipay_key && $this->alipay_partnerID) {
			$url = $this->alipay_url;
			$param['partner'] = $this->alipay_partnerID;
			ksort($param);
			reset($param);
			$arg = '';
			foreach ($param as $key => $value) {
				if ($value) {
					$url .= "$key=".urlencode($value)."&";
					$arg .= "$key=$value&";
				}
			}
			$url  .= 'sign='.md5(substr($arg,0,-1).$this->alipay_key).'&sign_type=MD5';
		} else {
			$url = $this->pwpay_url;
			foreach ($param as $key => $value) {
				if ($value) {
					$url  .= "$key=".urlencode($value)."&";
				}
			}
		}
		return $url;
	}
}
?>