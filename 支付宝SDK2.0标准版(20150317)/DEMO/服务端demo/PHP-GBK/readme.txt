
            �q�����������������������������������������������r
    ����������           ֧��������ʾ���ṹ˵��             ����������
            �t�����������������������������������������������s 

�� ��    ����汾��3.3
         �������ԣ�PHP
         ��    Ȩ��֧�������й������缼�����޹�˾
��       �� �� �ߣ�֧�����̻���ҵ������֧����
         ��ϵ��ʽ���̻�����绰0571-88158090

    ������������������������������������������������������������������

��������������
 �����ļ��ṹ
��������������

php-GBK
  ��
  ��lib�����������������������������������������ļ���
  ��  ��
  ��  ��alipay_core.function.php ������������֧�����ӿڹ��ú����ļ�
  ��  ��
  ��  ��alipay_notify.class.php��������������֧����֪ͨ�������ļ�
  ��  ��
  ��  ��alipay_rsa.function.php��������������֧�����ӿ�RSA�����ļ�
  ��
  ��log.txt������������������������������������־�ļ�
  ��
  ��alipay.config.php�����������������������������������ļ�
  ��
  ��notify_url.php ���������������������������������첽֪ͨҳ���ļ�
  ��
  ��key��������������������������������������˽Կ��Կ�ļ��У��÷����·���ע�����
  ��  ��
  ��  ��rsa_private_key.pem�������������������̻���˽Կ�ļ�
  ��  ��
  ��  ��alipay_public_key.pem����������������֧�����Ĺ�Կ�ļ�
  ��
  ��openssl����������������������������������ȱʡdll�ļ����÷����·���ע�����
  ��  ��
  ��  ��libeay32.dll
  ��  ��
  ��  ��ssleay32.dll
  ��  ��
  ��  ��php_openssl.dll
  ��
  ��cacert.pem ����������������������������������CURL��У��SSL��CA֤���ļ�
  ��
  ��readme.txt ������������������������������ʹ��˵���ı�

��ע���

1�����뿪��curl����
��1��ʹ��Crul��Ҫ�޸ķ�������php.ini�ļ������ã��ҵ�php_curl.dllȥ��ǰ���";"����
��2���ļ�����cacert.pem�ļ�����ط��õ��̻���վƽ̨�У��磺�������ϣ������ұ�֤��·����Ч���ṩ�Ĵ���demo�е�Ĭ��·���ǵ�ǰ�ļ����¡���getcwd().'\\cacert.pem'

2����Ҫ���õ��ļ��ǣ�
alipay.config.php
alipayapi.php
key�ļ���


3����Կ���
���̻���˽Կ���̻��Ĺ�Կ��֧������Կ

key�ļ�����������.pem��׺�����̻�˽Կ��֧�����Ĺ�Կ�����ļ���

���̻���˽Կ
1�����뱣ֻ֤��һ�����֣�����û�лس������С��ո��
2������Ҫ�Ը����ɵģ�ԭʼ�ģ�˽Կ��pkcs8����
3������Ҫȥ��ȥ����-----BEGIN PUBLIC KEY-----������-----END PUBLIC KEY-----��
����֮��ֻҪά�ָ����ɳ�����˽Կ�����ݼ��ɡ�

���̻��Ĺ�Կ
1�����뱣ֻ֤��һ�����֣�����û�лس������С��ո��
2��ȥ����-----BEGIN PUBLIC KEY-----������-----END PUBLIC KEY-----����ֻ��������������֮�еĲ���
3������ú������롰���������ID.dat����������ʽ���磺2088101568342279.dat
4���������󣬽���֧����

��֧������Կ
1�����뱣ֻ֤��һ�����֣�����û�лس������С��ո��
2���뱣����-----BEGIN PUBLIC KEY-----������-----END PUBLIC KEY-----�����������֡�
����֮��֧������Կֻ��Ҫά��ԭ�����ɡ�


��openssl�ļ����е�3��DLL�ļ��÷�

1��������ϵͳ��windowsϵͳ����system32�ļ�Ŀ¼��û��libeay32.dll��ssleay32.dll�������ļ�
   ��ô��Ҫ�����������ļ���system32�ļ�Ŀ¼��

2���������php��װĿ¼�£�php\ext����û��php_openssl.dll
   ��ô���php_openssl.dll��������ļ�����


�񱾴���ʾ����DEMO������fsockopen()�ķ���Զ��HTTP��ȡ���ݡ�����DOMDocument()�ķ�������XML���ݡ�

������̻���վ��������������Ƿ�ʹ�ô���ʾ���еķ�ʽ����
�����ʹ��fsockopen����ô������curl�����棻
�����������PHP5�汾�������ϣ���ô����������������DOMDocument()��

curl��XML���������������б�д���롣


������������������
 ���ļ������ṹ
������������������

alipay_core.function.php

function createLinkstring($para)
���ܣ�����������Ԫ�أ����ա�����=����ֵ����ģʽ�á�&���ַ�ƴ�ӳ��ַ���
���룺Array  $para ��Ҫƴ�ӵ�����
�����String ƴ������Ժ���ַ���

function createLinkstringUrlencode($para)
���ܣ�����������Ԫ�أ����ա�����=����ֵ����ģʽ�á�&���ַ�ƴ�ӳ��ַ��������Բ���ֵurlencode
���룺Array  $para ��Ҫƴ�ӵ�����
�����String ƴ������Ժ���ַ���

function paraFilter($para)
���ܣ���ȥ�����еĿ�ֵ��ǩ������
���룺Array  $para ǩ��������
�����Array  ȥ����ֵ��ǩ�����������ǩ��������

function argSort($para)
���ܣ�����������
���룺Array  $para ����ǰ������
�����Array  ����������

function logResult($word='')
���ܣ�д��־��������ԣ�����վ����Ҳ���Ըĳɴ������ݿ⣩
���룺String $word Ҫд����־����ı����� Ĭ��ֵ����ֵ

function getHttpResponsePOST($url, $cacert_url, $para, $input_charset = '')
���ܣ�Զ�̻�ȡ���ݣ�POSTģʽ
���룺String $url ָ��URL����·����ַ
      String $cacert_url ָ����ǰ����Ŀ¼����·��
      Array  $para ���������
      String $input_charset �����ʽ��Ĭ��ֵ����ֵ
�����String Զ�����������

function getHttpResponseGET($url, $cacert_url)
���ܣ�Զ�̻�ȡ���ݣ�GETģʽ
���룺String $url ָ��URL����·����ַ
      String $cacert_url ָ����ǰ����Ŀ¼����·��
�����String Զ�����������

function charsetEncode($input,$_output_charset ,$_input_charset)
���ܣ�ʵ�ֶ����ַ����뷽ʽ
���룺String $input ��Ҫ������ַ���
      String $_output_charset ����ı����ʽ
      String $_input_charset ����ı����ʽ
�����String �������ַ���

function charsetDecode($input,$_input_charset ,$_output_charset) 
���ܣ�ʵ�ֶ����ַ����뷽ʽ
���룺String $input ��Ҫ������ַ���
      String $_output_charset ����Ľ����ʽ
      String $_input_charset ����Ľ����ʽ
�����String �������ַ���

��������������������������������������������������������������

alipay_rsa.function.php

function sign($data, $private_key_path)
���ܣ�RSAǩ��
���룺String $data ��ǩ������
      String $private_key_path �̻�˽Կ�ļ�·��
�����String ǩ�����

function verify($data, $ali_public_key_path, $sign)
���ܣ�RSA��ǩ
���룺String $data ��ǩ������
      String $ali_public_key_path ֧�����Ĺ�Կ�ļ�·��
      String $sign ҪУ�Եĵ�ǩ�����
�����bool ��֤���

function decrypt($content, $private_key_path)
���ܣ�RSA����
���룺String $content ��Ҫ���ܵ����ݣ�����
      String $private_key_path �̻�˽Կ�ļ�·��
�����String ���ܺ����ݣ�����

��������������������������������������������������������������


alipay_notify.class.php

function verifyNotify()
���ܣ���notify_url����֤
�����Bool  ��֤�����true/false

function verifyReturn()
���ܣ���return_url����֤
�����Bool  ��֤�����true/false

function getSignVeryfy($para_temp, $sign)
���ܣ���ȡ����ʱ��ǩ����֤���
���룺Array $para_temp ֪ͨ�������Ĳ�������
      String $sign ֧�������ص�ǩ�����
�����Bool ���ǩ����֤���

function getResponse($notify_id)
���ܣ���ȡԶ�̷�����ATN���,��֤����URL
���룺String $notify_id ֪ͨУ��ID
�����String ������ATN���

��������������������������������������������������������������

