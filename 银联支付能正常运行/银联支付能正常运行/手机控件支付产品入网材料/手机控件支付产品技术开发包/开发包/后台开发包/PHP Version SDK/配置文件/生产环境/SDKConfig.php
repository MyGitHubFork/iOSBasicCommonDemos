<?php

// ######(��������Ϊ�����������ã�������̻�ϵͳ��������޸�)#######

// cvn2���� 1������ 0:������
const SDK_CVN2_ENC = 0;
// ��Ч�ڼ��� 1:���� 0:������
const SDK_DATE_ENC = 0;
// ���ż��� 1������ 0:������
const SDK_PAN_ENC = 0;
 

// ǩ��֤��·�� ����ϵ��Ӫ��ȡ���룬��CFCA��վ���غ����ã���������֤�����벢���ã�
const SDK_SIGN_CERT_PATH = 'D:/certs/PRO_700000000000001_acp.pfx';

// ǩ��֤������
 const SDK_SIGN_CERT_PWD = '000000';
 
// ��ǩ֤��
const SDK_VERIFY_CERT_PATH = 'D:/certs/UPOP_VERIFY.cer';

// �������֤��
const SDK_ENCRYPT_CERT_PATH = 'D:/certs/RSA2048_PROD_index_22.cer';

// ��ǩ֤��·��
const SDK_VERIFY_CERT_DIR = 'D:/certs/';

// ǰ̨�����ַ
const SDK_FRONT_TRANS_URL = 'https://gateway.95516.com/gateway/api/frontTransReq.do';

// ��̨�����ַ
const SDK_BACK_TRANS_URL = 'https://gateway.95516.com/gateway/api/backTransReq.do';

// ��������
const SDK_BATCH_TRANS_URL = 'https://gateway.95516.com/gateway/api/batchTrans.do';

//���ʲ�ѯ�����ַ
const SDK_SINGLE_QUERY_URL = 'https://gateway.95516.com/gateway/api/queryTrans.do';

//�ļ����������ַ
const SDK_FILE_QUERY_URL = 'https://filedownload.95516.com/';

//�п����׵�ַ
const SDK_Card_Request_Url = 'https://gateway.95516.com/gateway/api/cardTransReq.do';

//App���׵�ַ
const SDK_App_Request_Url = 'https://gateway.95516.com/gateway/api/appTransReq.do';


// ǰ̨֪ͨ��ַ (�̻���������֪ͨ��ַ)
const SDK_FRONT_NOTIFY_URL = 'http://127.0.0.1/upacp_sdk_php/demo/response.php';
// ��̨֪ͨ��ַ (�̻���������֪ͨ��ַ)
const SDK_BACK_NOTIFY_URL = 'http://127.0.0.1/upacp_sdk_php/demo/response.php';

//�ļ�����Ŀ¼ 
const SDK_FILE_DOWN_PATH = 'd:/file/';

//��־ Ŀ¼ 
const SDK_LOG_FILE_PATH = 'D:/logs/';

//��־����
const SDK_LOG_LEVEL = 'INFO';


	
?>