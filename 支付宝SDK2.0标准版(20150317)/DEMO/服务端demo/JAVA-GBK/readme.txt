
            �q�����������������������������������������������r
    ����������           ֧��������ʾ���ṹ˵��             ����������
            �t�����������������������������������������������s 

�� ��    ����汾��3.3
         �������ԣ�JAVA
         ��    Ȩ��֧�������й������缼�����޹�˾
��       �� �� �ߣ�֧�����̻���ҵ������֧����
         ��ϵ��ʽ���̻�����绰0571-88158090

    ������������������������������������������������������������������

��������������
 �����ļ��ṹ
��������������

JAVA-GBK
  ��
  ��src�����������������������������������ļ���
  ��  ��
  ��  ��com.alipay.config
  ��  ��  ��
  ��  ��  ��AlipayConfig.java���������������������ļ�
  ��  ��
  ��  ��com.alipay.util
  ��  ��  ��
  ��  ��  ��AlipayCore.java������������֧�����ӿڹ��ú������ļ�
  ��  ��  ��
  ��  ��  ��AlipayNotify.java����������֧����֪ͨ�������ļ�
  ��  ��  ��
  ��  ��  ��UtilDate.java��������������֧�����Զ��嶩�����ļ�
  ��  ��
  ��  ��com.alipay.rsa
  ��  ��  ��
  ��  ��  ��RSA.java ������������������RSAǩ�����ļ�
  ��  ��  ��
  ��  ��  ��Base64.java����������������RSA��Կת��
  ��  ��
  ��  ��com.alipay.util.httpClient���ѷ�װ��
  ��      ��
  ��      ��HttpProtocolHandler.java ��֧����HttpClient�������ļ�
  ��      ��
  ��      ��HttpRequest.java ����������֧����HttpClient�������ļ�
  ��      ��
  ��      ��HttpResponse.java����������֧����HttpClient�������ļ�
  ��      ��
  ��      ��HttpResultType.java��������֧����HttpClient���صĽ���ַ���ʽ���ļ�
  ��
  ��WebRoot����������������������������ҳ���ļ���
  ��  ��
  ��  ��notify_url.jsp �����������������������첽֪ͨҳ���ļ�
  ��  ��
  ��  ��WEB-INF
  ��   	  ��
  ��      ��lib�����JAVA��Ŀ�а�����Щ�ܰ�������Ҫ���룩
  ��   	     ��
  ��   	     ��commons-codec-1.6.jar
  ��   	     ��
  ��   	     ��commons-httpclient-3.0.1.jar
  ��   	     ��
  ��   	     ��commons-logging-1.1.1.jar
  ��   	     ��
  ��   	     ��dom4j-1.6.1.jar
  ��   	     ��
  ��   	     ��jaxen-1.1-beta-6.jar
  ��
  ��readme.txt ������������������ʹ��˵���ı�

��ע���
��Ҫ���õ��ļ��ǣ�
alipay_config.java
notify_url.jsp
������ʾ����demo����ģ���ȡԶ��HTTP��Ϣʹ�õ���commons-httpclient-3.0�汾�ĵ������ܰ�����֧������httpClient��װ�ࡣ
���������ʹ�ø÷�ʽʵ��ģ���ȡԶ��HTTP���ܣ���ô������������ʽ���棬��ʱ�������б�д���롣

���̻���˽Կ���̻��Ĺ�Կ��֧������Կ


���̻���˽Կ
1�����뱣ֻ֤��һ�����֣�����û�лس������С��ո��
2����Ը����ɵģ�ԭʼ�ģ�˽Կ��pkcs8����
3��������ɺ󣬸��Ƹö�˽Կ����ȥ������Ļس������С��ո��

���̻��Ĺ�Կ
1�����뱣ֻ֤��һ�����֣�����û�лس������С��ո��
2��ȥ����-----BEGIN PUBLIC KEY-----������-----END PUBLIC KEY-----����ֻ��������������֮�еĲ���
3������ú������롰���������ID.dat����������ʽ���磺2088101568342279.dat
4���������󣬽���֧����

��֧������Կ
1�����뱣ֻ֤��һ�����֣�����û�лس������С��ո��
2��ȥ����-----BEGIN PUBLIC KEY-----������-----END PUBLIC KEY-----����ֻ��������������֮�еĲ���

������������������
 ���ļ������ṹ
������������������

AlipayCore.java

public static Map paraFilter(Map<String, String> sArray)
���ܣ���ȥ�����еĿ�ֵ��ǩ������
���룺Map<String, String> sArray Ҫǩ��������
�����Map<String, String> ȥ����ֵ��ǩ�����������ǩ��������

public static String createLinkString(Map<String, String> params)
���ܣ�����������Ԫ�أ����ա�����=����ֵ����ģʽ�á�&���ַ�ƴ�ӳ��ַ���
���룺Map<String, String> params ��Ҫƴ�ӵ�����
�����String ƴ������Ժ���ַ���

public static void logResult(String sWord)
���ܣ�д��־��������ԣ�����վ����Ҳ���Ըĳɴ������ݿ⣩
���룺String sWord Ҫд����־����ı�����

public static String getAbstract(String strFilePath, String file_digest_type) throws IOException
���ܣ������ļ�ժҪ
���룺String strFilePath �ļ�·��
      String file_digest_type ժҪ�㷨
�����String �ļ�ժҪ���

��������������������������������������������������������������

RSA.java

public static String sign(String content, String privateKey, String input_charset)
���ܣ�RSAǩ��
���룺String content ����
      String privateKey �̻�˽Կ
      String input_charset �����ʽ
�����String ǩ�����

public static boolean verify(String content, String sign, String ali_public_key, String input_charset)
���ܣ�RSA��ǩ�����
���룺String content ��ǩ������
      String sign ֧������ǩ��ֵ
      String privateKey ֧������Կ
      String input_charset �����ʽ
�����boolean ǩ�����

��������������������������������������������������������������

AlipayNotify.java

public static boolean verify(Map<String, String> params)
���ܣ����ݷ�����������Ϣ������ǩ�����
���룺Map<String, String>  Params ֪ͨ�������Ĳ�������
�����boolean ��֤���

private static boolean getSignVeryfy(Map<String, String> Params, String sign)
���ܣ����ݷ�����������Ϣ����֤ǩ��
���룺Map<String, String>  Params ֪ͨ�������Ĳ�������
      String sign ֧������ǩ��ֵ
�����boolean ǩ�����

private static String verifyResponse(String notify_id)
���ܣ���ȡԶ�̷�����ATN���,��֤����URL
���룺String notify_id ��֤֪ͨID
�����String ��֤���

private static String checkUrl(String urlvalue)
���ܣ���ȡԶ�̷�����ATN���
���룺String urlvalue ָ��URL·����ַ
�����String ������ATN����ַ���

��������������������������������������������������������������

UtilDate.java

public  static String getOrderNum()
���ܣ��Զ����������ţ���ʽyyyyMMddHHmmss
�����String ������

public  static String getDateFormatter()
���ܣ���ȡ���ڣ���ʽ��yyyy-MM-dd HH:mm:ss
�����String ����

public static String getDate()
���ܣ���ȡ���ڣ���ʽ��yyyyMMdd
�����String ����

public static String getThree()
���ܣ������������λ��
�����String �����λ��

��������������������������������������������������������������
