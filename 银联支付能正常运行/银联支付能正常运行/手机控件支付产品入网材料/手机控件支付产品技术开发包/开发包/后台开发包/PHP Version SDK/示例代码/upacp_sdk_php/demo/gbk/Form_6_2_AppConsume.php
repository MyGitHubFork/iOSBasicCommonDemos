<?php
header ( 'Content-type:text/html;charset=gbk' );
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/common.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/SDKConfig.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/secureUtil.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/httpClient.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/log.class.php';
/**
 * ���ѽ���-�ؼ���̨�������� 
 */


/**
 *	���´���ֻ��Ϊ�˷����̻����Զ��ṩ���������룬�̻����Ը����Լ���Ҫ�����ռ����ĵ���д���ô�������ο�
 */
// ��ʼ����־
$log = new PhpLog ( SDK_LOG_FILE_PATH, "PRC", SDK_LOG_LEVEL );
$log->LogInfo ( "============����ǰ̨����ʼ===============" );
// ��ʼ����־
$params = array(
		'version' => '5.0.0',				//�汾��
		'encoding' => 'gbk',				//���뷽ʽ
		'certId' => getSignCertId (),			//֤��ID
		'txnType' => '01',				//��������	
		'txnSubType' => '01',				//��������
		'bizType' => '000201',				//ҵ������
		'frontUrl' =>  SDK_FRONT_NOTIFY_URL,  		//ǰ̨֪ͨ��ַ���ؼ������ʱ�򲻻�������
		'backUrl' => SDK_BACK_NOTIFY_URL,		//��̨֪ͨ��ַ	
		'signMethod' => '01',		//ǩ������
		'channelType' => '08',		//�������ͣ�07-PC��08-�ֻ�
		'accessType' => '0',		//��������
		'merId' => '888888888888888',	//�̻����룬����Լ��Ĳ����̻���
		'orderId' => date('YmdHis'),	//�̻������ţ�8-40λ������ĸ
		'txnTime' => date('YmdHis'),	//��������ʱ��
		'txnAmt' => '100',		//���׽���λ��
		'currencyCode' => '156',	//���ױ���
		'orderDesc' => '��������',  //�����������ɲ����ͣ�����ʱ�ؼ��л���ʾ����Ϣ
		'reqReserved' =>' ͸����Ϣ', //���󷽱�����͸���ֶΣ���ѯ��֪ͨ�������ļ��о���ԭ������
		);


// ǩ��
sign ( $params );

echo "����" . getRequestParamString ( $params );
$log->LogInfo ( "��̨�����ַΪ>" . SDK_App_Request_Url );
// ������Ϣ����̨
$result = sendHttpRequest ( $params, SDK_App_Request_Url );
$log->LogInfo ( "��̨���ؽ��Ϊ>" . $result );

echo "Ӧ��" . $result;

//���ؽ��չʾ
$result_arr = coverStringToArray ( $result );

echo verify ( $result_arr ) ? '��ǩ�ɹ�' : '��ǩʧ��';

?>

