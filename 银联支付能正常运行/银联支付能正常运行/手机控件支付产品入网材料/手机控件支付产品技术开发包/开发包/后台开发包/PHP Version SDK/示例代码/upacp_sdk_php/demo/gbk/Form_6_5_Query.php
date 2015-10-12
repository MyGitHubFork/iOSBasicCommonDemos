<?php
header ( 'Content-type:text/html;charset=GBK' );
 include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/common.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/SDKConfig.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/secureUtil.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/httpClient.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/log.class.php';

/**
 *	��ѯ����
 */

/**
 *	���´���ֻ��Ϊ�˷����̻����Զ��ṩ���������룬�̻����Ը����Լ���Ҫ�����ռ����ĵ���д���ô�������ο�
 */


// ��ʼ����־
$log = new PhpLog ( SDK_LOG_FILE_PATH, "PRC", SDK_LOG_LEVEL );
$log->LogInfo ( "===========�����̨����ʼ============" );

$params = array(
		'version' => '5.0.0',		//�汾��
		'encoding' => 'GBK',		//���뷽ʽ
		'certId' => getSignCertId (),	//֤��ID	
		'signMethod' => '01',		//ǩ������
		'txnType' => '00',		//��������	
		'txnSubType' => '00',		//��������
		'bizType' => '000000',		//ҵ������
		'accessType' => '0',		//��������
		'channelType' => '07',		//��������
		'orderId' => '20150206215110',	//���޸ı���ѯ�Ľ��׵Ķ�����
		'merId' => '888888888888888',	//�̻����룬���޸�Ϊ�Լ����̻���
		'txnTime' => '20150206212559',	//���޸ı���ѯ�Ľ��׵Ķ�������ʱ��
	);

// ǩ��
sign ( $params );

echo "����" . getRequestParamString ( $params );
$log->LogInfo ( "��̨�����ַΪ>" . SDK_SINGLE_QUERY_URL );
// ������Ϣ����̨
$result = sendHttpRequest ( $params, SDK_SINGLE_QUERY_URL );
$log->LogInfo ( "��̨���ؽ��Ϊ>" . $result );

echo "Ӧ��" . $result;

//���ؽ��չʾ
$result_arr = coverStringToArray ( $result );

echo verify ( $result_arr ) ? '��ǩ�ɹ�' : '��ǩʧ��';
?>

