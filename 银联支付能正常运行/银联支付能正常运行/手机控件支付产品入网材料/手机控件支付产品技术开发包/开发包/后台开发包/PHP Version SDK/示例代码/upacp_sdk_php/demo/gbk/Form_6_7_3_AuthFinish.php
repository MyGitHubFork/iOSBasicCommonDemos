<?php
header ( 'Content-type:text/html;charset=utf-8' );
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/common.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/SDKConfig.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/secureUtil.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/httpClient.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/log.class.php';
/**
 *	Ԥ��Ȩ���
 */


/**
 *	���´���ֻ��Ϊ�˷����̻����Զ��ṩ���������룬�̻����Ը����Լ���Ҫ�����ռ����ĵ���д���ô�������ο�
 */

// ��ʼ����־
$log = new PhpLog ( SDK_LOG_FILE_PATH, "PRC", SDK_LOG_LEVEL );
$log->LogInfo ( "===========�����̨����ʼ============" );

$params = array(
		'version' => '5.0.0',		//�汾��
		'encoding' => 'gbk',		//���뷽ʽ
		'certId' => getSignCertId (),	//֤��ID	
		'signMethod' => '01',		//ǩ������
		'txnType' => '03',		//��������	
		'txnSubType' => '00',		//��������
		'bizType' => '000201',		//ҵ������
		'accessType' => '0',		//��������
		'channelType' => '07',		//��������
		'orderId' => date('YmdHis'),	//�̻������ţ����²�������ͬ��ԭ����
		'merId' => '888888888888888',			//�̻����룬��ĳ��Լ��Ĳ����̻���
		'origQryId' => '201502281122575524648',    //ԭԤ��Ȩ��queryId�����ԴӲ�ѯ�ӿڻ���֪ͨ�ӿ��л�ȡ
		'txnTime' => date('YmdHis'),	//��������ʱ�䣬���²�������ͬ��ԭ����
		'txnAmt' => '100',              //���׽�С�ڵ���ԭԤ��Ȩ����115%
		'backUrl' => SDK_BACK_NOTIFY_URL,	   //��̨֪ͨ��ַ	
		'reqReserved' =>' ͸����Ϣ', //���󷽱�����͸���ֶΣ���ѯ��֪ͨ�������ļ��о���ԭ������
	);


// ǩ��
sign ( $params );

echo "����" . getRequestParamString ( $params );
$log->LogInfo ( "��̨�����ַΪ>" . SDK_BACK_TRANS_URL );
// ������Ϣ����̨
$result = sendHttpRequest ( $params, SDK_BACK_TRANS_URL );
$log->LogInfo ( "��̨���ؽ��Ϊ>" . $result );

echo "Ӧ��" . $result;

//���ؽ��չʾ
$result_arr = coverStringToArray ( $result );

echo verify ( $result_arr ) ? '��ǩ�ɹ�' : '��ǩʧ��';
?>

