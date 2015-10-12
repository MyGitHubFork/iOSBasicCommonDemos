<?php
header ( 'Content-type:text/html;charset=GBK' );
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/common.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/SDKConfig.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/secureUtil.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/httpClient.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/log.class.php';

/**
 * �ļ������ཻ��
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
		'txnType' => '76',		//��������	
		'signMethod' => '01',		//ǩ������
		'txnSubType' => '01',		//��������
		'bizType' => '000000',		//ҵ������
		'accessType' => '0',		//��������
		'merId' => '700000000000001',	                //�̻����룬���滻ʵ���̻��Ų��ԣ���ʹ�õ���������ƽ̨ע����̻��ţ����̻���û��Ȩ�޲��ļ����ؽӿڵģ���ʹ�ò��Բ�����д���ļ����ص��̻��ź����ڲ⡣������ʵ�����ļ�����ʹ��������ƽ̨�����ļ���
		'settleDate' => '0119',		//��������
		'txnTime' => date('YmdHis'),	//��������ʱ��
		'fileType' => '00',		//�ļ�����
	);

// ǩ��
sign ( $params );

echo "����" . getRequestParamString ( $params );
$log->LogInfo ( "��̨�����ַΪ>" . SDK_FILE_QUERY_URL );
// ������Ϣ����̨
$result = sendHttpRequest ( $params, SDK_FILE_QUERY_URL );
$log->LogInfo ( "��̨���ؽ��Ϊ>" . $result );

echo "Ӧ��" . $result;

//���ؽ��չʾ
$result_arr = coverStringToArray ( $result );

echo verify ( $result_arr ) ? '��ǩ�ɹ�' : '��ǩʧ��';
// �����ļ�������·���������ļ����޸ģ�ע��Ԥ�Ƚ����ļ��в��ڶ�дȨ��
deal_file ( $result_arr );

?>
