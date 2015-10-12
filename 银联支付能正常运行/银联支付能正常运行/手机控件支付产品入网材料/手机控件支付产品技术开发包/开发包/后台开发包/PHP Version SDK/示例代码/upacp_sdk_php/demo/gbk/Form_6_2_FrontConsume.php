<?php
header ( 'Content-type:text/html;charset=gbk' );
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/common.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/SDKConfig.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/secureUtil.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/log.class.php';
/**
 * ���ѽ���-ǰ̨ 
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
		'frontUrl' =>  SDK_FRONT_NOTIFY_URL,  		//ǰ̨֪ͨ��ַ
		'backUrl' => SDK_BACK_NOTIFY_URL,		//��̨֪ͨ��ַ	
		'signMethod' => '01',		//ǩ������
		'channelType' => '08',		//�������ͣ�07-PC��08-�ֻ�
		'accessType' => '0',		//��������
		'merId' => '888888888888888',		        //�̻����룬����Լ��Ĳ����̻���
		'orderId' => date('YmdHis'),	//�̻�������
		'txnTime' => date('YmdHis'),	//��������ʱ��
		'txnAmt' => '100',		//���׽���λ��
		'currencyCode' => '156',	//���ױ���
		'defaultPayType' => '0001',	//Ĭ��֧����ʽ	
		//'orderDesc' => '��������',  //��������������֧����wap֧����ʱ��������
		'reqReserved' =>' ͸����Ϣ', //���󷽱�����͸���ֶΣ���ѯ��֪ͨ�������ļ��о���ԭ������
		);


// ǩ��
sign ( $params );


// ǰ̨�����ַ
$front_uri = SDK_FRONT_TRANS_URL;
$log->LogInfo ( "ǰ̨�����ַΪ>" . $front_uri );
// ���� �Զ��ύ�ı�
$html_form = create_html ( $params, $front_uri );

$log->LogInfo ( "-------ǰ̨�����Զ��ύ��>--begin----" );
$log->LogInfo ( $html_form );
$log->LogInfo ( "-------ǰ̨�����Զ��ύ��>--end-------" );
$log->LogInfo ( "============����ǰ̨���� ����===========" );
echo $html_form;
