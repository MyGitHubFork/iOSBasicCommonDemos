
            �q�����������������������������������������������������������������������������r
    ����������           ����ȫ����֧�������˵��                                           ����������
            �t�����������������������������������������������������������������������������s                                                          
��       �ӿ����ƣ�����ȫ����֧��ͳһ����ӿ�
�� ��    ����汾��1.1
         �������ԣ�PHP
         ��    Ȩ������ȫ����
��       �� �� �ߣ�����ȫ����
         ��ϵ��ʽ�� 

    ������������������������������������������������������������������

��������������
 �����ļ��ṹ
��������������


  ��gbk.func���������������������������ļ���
  ��  ��
  ��  ��encryptParams.php���������������������� �Կ��ţ�cvn2�����룬cvn2��Ч�ڴ�����
  ��  ��
  ��  ��PinBlock.php �����������������������������
  ��  ��
  ��  ��httpClient.php��������������������̨����ͨ�Ŵ�����
  ��  ��
  ��  ��SDKConfig.php ������������������ ������Ϣ��
  ��  ��
  ��  ��PublicEncrypte.php �������������������� ����/ǩ����
  ��  ��
  ��  ��common.php �������������������ķ�����
  ��  ��
  ��  ��secureUtil.php����������������ǩ��/��ǩ��
  ��  ��
  ��  ��log.class.php ������������������־��ӡ������
  ��
  
 
  

��ע���

 openssl֤��������ʹ�� ���е�php_openssl.dll,ssleay32.dll,libeay32.dll3���ļ�����windows/system32/�ļ����£�������Apache����


������������������
��Ҫ���ļ�����˵��
������������������

--------------------------------------------------------------------


SDKConfig.php

 ǩ��֤��·��
const SDK_SIGN_CERT_PATH = '';

 ǩ��֤������
 const SDK_SIGN_CERT_PWD = '';
 
 ��ǩ֤��
const SDK_VERIFY_CERT_PATH = '';

�������֤��
const SDK_ENCRYPT_CERT_PATH = '';

 ��ǩ֤��·��
const SDK_VERIFY_CERT_DIR = '';

 ǰ̨�����ַ
const SDK_FRONT_TRANS_URL = '';

 ��̨���ؽ����ַ
const SDK_BACK_TRANS_URL = '';

 ��������
const SDK_BATCH_TRANS_URL = '';

��������״̬��ѯ
const SDK_BATCH_QUERY_URL = '';


���ʲ�ѯ�����ַ
const SDK_SINGLE_QUERY_URL = '';

�ļ����������ַ
const SDK_FILE_QUERY_URL = '';

 ǰ̨֪ͨ��ַ
const SDK_FRONT_NOTIFY_URL = '';

��̨֪ͨ��ַ
const SDK_BACK_NOTIFY_URL = '';

�ļ�����Ŀ¼ 
const SDK_FILE_DOWN_PATH = '';

��־ Ŀ¼ 
const SDK_LOG_FILE_PATH = '';

��־����
const SDK_LOG_LEVEL = '';

�п����׵�ַ
const SDK_Card_Request_Url = '';

App���׵�ַ
const SDK_App_Request_Url = '';

��������������������������������������������������������������

common.php

function coverParamsToString($param)
���ܣ����� �����ת��Ϊ���崮


function coverStringToArray($val )
���ܣ��ַ���ת��Ϊ ����

function deal_params(&$params)
���ܣ������ر��� ����ͻ���Ϣ , �������ΪGBK ��תΪutf-8


function deflate_file(&$params)
���ܣ�����ѹ���ļ�

function deal_file($params)
���ܣ��������ļ�

function create_html($params, $action)
���ܣ������Զ��ύ��



��������������������������������������������������������������

HttpClient.php


function sendHttpRequest($params, $url)
���ܣ�����������ģ��Զ��HTTP��POST����ʽ���첢��ȡ�����Ĵ�����


function getRequestParamString($params)
���ܣ���װ����


��������������������������������������������������������������

encryptParams.php

function encrypt_params(&$params) 
���ܣ��Կ��� | cvn2 | ���� | cvn2��Ч�ڽ��д���


��������������������������������������������������������������

PinBlock.php
function  Pin2PinBlock( &$sPin )
���ܣ�����תpin  ��֤ת��



��������������������������������������������������������������

PublicEncrypte.php

function EncryptedPin��$sPin, $sCardNo ,$sPubKeyURL��

���ܣ�֤��Id��֤���뷽��


��������������������������������������������������������������

secureUtil.php

function sign(&$params)

���ܣ�ǩ������

function verify($params)

���ܣ���ǩ����

function getPulbicKeyByCertId($certId)

���ܣ�����֤��ID����֤�鷽��

function getCertId($cert_path)

���ܣ�ȡ֤��ID����

function getCertIdByCerPath($cert_path)

���ܣ�ȡ֤�����ͷ���

function getPublicKey($cert_path)

���ܣ�ȡ֤�鹫Կ -��ǩ

function getPrivateKey($cert_path)

���ܣ�����(ǩ��)֤��˽Կ 

function encryptPan($pan)

���ܣ����ܿ��ŷ���

function encryptPin($pan, $pwd)

���ܣ�pin���ܷ���

function encryptCvn2($cvn2)

���ܣ�cvn2���ܷ���

function encryptDate($certDate) 

���ܣ���Ч�ڼ��ܷ���


