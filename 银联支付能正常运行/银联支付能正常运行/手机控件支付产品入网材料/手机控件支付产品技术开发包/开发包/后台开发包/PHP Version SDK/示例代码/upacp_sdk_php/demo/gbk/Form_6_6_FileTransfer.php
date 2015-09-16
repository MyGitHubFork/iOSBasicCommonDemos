<?php
header ( 'Content-type:text/html;charset=GBK' );
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/common.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/SDKConfig.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/secureUtil.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/httpClient.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/log.class.php';

/**
 * 文件传输类交易
 */
 
 
/**
 *	以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己需要，按照技术文档编写。该代码仅供参考
 */


// 初始化日志
$log = new PhpLog ( SDK_LOG_FILE_PATH, "PRC", SDK_LOG_LEVEL );
$log->LogInfo ( "===========处理后台请求开始============" );

$params = array(
		'version' => '5.0.0',		//版本号
		'encoding' => 'GBK',		//编码方式
		'certId' => getSignCertId (),	//证书ID
		'txnType' => '76',		//交易类型	
		'signMethod' => '01',		//签名方法
		'txnSubType' => '01',		//交易子类
		'bizType' => '000000',		//业务类型
		'accessType' => '0',		//接入类型
		'merId' => '700000000000001',	                //商户代码，请替换实际商户号测试，如使用的是自助化平台注册的商户号，该商户号没有权限测文件下载接口的，请使用测试参数里写的文件下载的商户号和日期测。如需真实交易文件，请使用自助化平台下载文件。
		'settleDate' => '0119',		//清算日期
		'txnTime' => date('YmdHis'),	//订单发送时间
		'fileType' => '00',		//文件类型
	);

// 签名
sign ( $params );

echo "请求：" . getRequestParamString ( $params );
$log->LogInfo ( "后台请求地址为>" . SDK_FILE_QUERY_URL );
// 发送信息到后台
$result = sendHttpRequest ( $params, SDK_FILE_QUERY_URL );
$log->LogInfo ( "后台返回结果为>" . $result );

echo "应答：" . $result;

//返回结果展示
$result_arr = coverStringToArray ( $result );

echo verify ( $result_arr ) ? '验签成功' : '验签失败';
// 处理文件，保存路径在配置文件中修改，注意预先建立文件夹并授读写权限
deal_file ( $result_arr );

?>
