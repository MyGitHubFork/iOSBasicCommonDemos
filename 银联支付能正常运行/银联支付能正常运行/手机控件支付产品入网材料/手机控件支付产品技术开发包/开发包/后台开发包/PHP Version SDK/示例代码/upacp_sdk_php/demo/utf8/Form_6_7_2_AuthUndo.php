<?php
header ( 'Content-type:text/html;charset=utf-8' );
 include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/utf8/func/common.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/utf8/func/SDKConfig.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/utf8/func/secureUtil.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/utf8/func/httpClient.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/utf8/func/log.class.php';

/**
 *	预授权撤销
 */


/**
 *	以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己需要，按照技术文档编写。该代码仅供参考
 */

// 初始化日志
$log = new PhpLog ( SDK_LOG_FILE_PATH, "PRC", SDK_LOG_LEVEL );
$log->LogInfo ( "===========处理后台请求开始============" );

$params = array(
		'version' => '5.0.0',		//版本号
		'encoding' => 'utf-8',		//编码方式
		'certId' => getSignCertId (),	//证书ID	
		'signMethod' => '01',		//签名方法
		'txnType' => '32',		//交易类型	
		'txnSubType' => '00',		//交易子类
		'bizType' => '000201',		//业务类型
		'accessType' => '0',		//接入类型
		'channelType' => '07',		//渠道类型
		'orderId' => date('YmdHis'),	//商户订单号，重新产生，不同于原消费
		'merId' => '888888888888888',			//商户代码，请改成自己的测试商户号
		'origQryId' => '201502281106305523728',    //原预授权的queryId，可以从查询接口或者通知接口中获取
		'txnTime' => date('YmdHis'),	//订单发送时间，重新产生，不同于原交易
		'txnAmt' => '100',              //交易金额，需和原预授权一致
		'backUrl' => SDK_BACK_NOTIFY_URL,	   //后台通知地址	
		'reqReserved' =>' 透传信息', //请求方保留域，透传字段，查询、通知、对账文件中均会原样出现
	);


// 签名
sign ( $params );

echo "请求：" . getRequestParamString ( $params );
$log->LogInfo ( "后台请求地址为>" . SDK_BACK_TRANS_URL );
// 发送信息到后台
$result = sendHttpRequest ( $params, SDK_BACK_TRANS_URL );
$log->LogInfo ( "后台返回结果为>" . $result );

echo "应答：" . $result;

//返回结果展示
$result_arr = coverStringToArray ( $result );

echo verify ( $result_arr ) ? '验签成功' : '验签失败';
?>

