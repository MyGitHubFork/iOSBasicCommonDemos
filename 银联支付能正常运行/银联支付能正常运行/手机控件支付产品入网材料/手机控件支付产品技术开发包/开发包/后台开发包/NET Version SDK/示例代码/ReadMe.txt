0. ע�⣺
1����ICSharpCode.SharpZipLib�������á�
2��.net�汾4.0�����ϡ�

1. �ο������޸�Web.config��
1) ǰ̨֪ͨ����̨֪ͨ��ַ���£���̨֪ͨ����������������ղ�����
2) ֤������Լ�����·����֤��������Ի�������000000�������Լ��޸ġ����м���֤��·�����������ã��ò����ġ�
3����־��ӡ·�������Լ����أ����Ƚ������ļ��в�ȷ�����ļ�д��Ȩ�ޡ�
�����������ղ���ָ����

�������£�
<?xml version="1.0" encoding="utf-8"?>

<!--
  �й�������� ASP.NET Ӧ�ó������ϸ��Ϣ�������
  http://go.microsoft.com/fwlink/?LinkId=169433
  -->

<configuration>
    <system.web>
        <compilation debug="true" targetFramework="4.0" />
    </system.web>
    <appSettings>
      <!-- ##########################���׷��͵�ַ����#############################-->
      <!--######(��������ΪPM�������������Ի����ã������������ü��ĵ�˵��)#######-->
      <!-- ǩ��֤��·�� PM_700000000000001_acp.pfx-->
      <add key="sdk.signCert.path" value="D:\\certs\\PM_700000000000001_acp.pfx" />
      <!-- ǩ��֤������ -->
      <add key="sdk.signCert.pwd" value="000000" />
      <!-- ǩ��֤������ -->
      <add key="sdk.signCert.type" value="PKCS12" />
      <!-- ����֤��·�� -->
      <add key="sdk.encryptCert.path" value="D:\\certs\\encrypt.cer" />
      <!-- ��ǩ֤��Ŀ¼ -->
      <add key="sdk.validateCert.dir" value="D:\\certs\\" />
      <!-- ǰ̨���׵�ַ -->
      <add key="sdk.frontTransUrl" value="https://101.231.204.80:5000/gateway/api/frontTransReq.do" />
      <!-- ��̨���׵�ַ -->
      <add key="sdk.backTransUrl" value="https://101.231.204.80:5000/gateway/api/backTransReq.do" />
      <!-- ����״̬��ѯ��ַ -->
      <add key="sdk.singleQueryUrl" value="https://101.231.204.80:5000/gateway/api/queryTrans.do" />
      <!-- �ļ������ཻ�׵�ַ -->
      <add key="sdk.fileTransUrl" value="https://101.231.204.80:9080/" />
      <!-- �������׵�ַ -->
      <add key="sdk.batTransUrl" value="https://101.231.204.80:5000/gateway/api/batchTrans.do" />
      <!-- �п����׵�ַ -->
      <add key="sdk.cardRequestUrl" value="https://101.231.204.80:5000/gateway/api/cardTransReq.do" />
      <!-- app���׵�ַ �ֻ��ؼ�֧��ʹ�øõ�ַ-->
      <add key="sdk.appRequestUrl" value="https://101.231.204.80:5000/gateway/api/appTransReq.do" />
    </appSettings>
</configuration>


2.1 wap/���ص����ѣ�����demo\utf8\Form_6_2_FrontConsume.aspx���̻������Ϊ�Լ����̻��ţ�����ת����֧��ҳ�档

2.2 �ؼ������ѣ�����demo\utf8\Form_6_2_AppConsume.aspx���̻������Ϊ�Լ����̻��ţ�����ʺ�̨��ȡtn����tn���������ֻ�app��

֧������
ƽ�����н�ǿ���6216261000000000018
֤���ţ�341126197709218366
�ֻ��ţ�13552535506
���룺123456
������ȫ����
������֤�룺123456��wap/�ؼ���111111��PC��
��������֤��ǵõ��»�ȡ��֤��֮�������룩

3. demo\utf8\Form_6_5_Query.aspxΪ��ѯ�ӿڣ��̻������Ϊ�Լ����̻��ţ�ע���޸�txnTime��orderIdΪ����ѯ���׵�txnTime��orderId��

4. demo\utf8\Form_6_3_ConsumeUndo.aspx��Form_6_4_Refund.aspx�ֱ�Ϊ���ѳ����ӿڡ��˻��ӿڣ��̻������Ϊ�Լ����̻��ţ�ע���޸�origQryIdΪ�Լ���Ҫ�˿���Ǳ����ѵ�queryId��

5. demo\utf8\FrontReceive.aspx��BackReceive.aspxΪǰ��̨֪ͨ�ӿڣ�������ɻ����е��á�

6. demo\utf8\Form_6_6_FileTransfer.aspxΪ�ļ����ؽӿڡ�
�ļ����ؽӿ�ע��㣺
1) ��ʹ���Լ��ġ���ʵ�̻��š����ԡ����������̻��š�����������ƽ̨������̻��Ŷ��ǲ��ܲ����ļ����صģ��ᷴhttp״̬500������Ϊ�ա������ʵ�̻���������ʾ���ļ���ȷ���н��ף�һ�����̻���û���ļ������ཻ�׵�Ȩ�ޣ�����Ҫ��ͨ����ϵҵ����Ӫ����operation@unionpay.com��
2) ���Ƚ������ļ��в�ȷ�����ļ�д��Ȩ�ޡ�

7. ����ʹ��gbk���룬�������޸Ĵ�����д�ı���ʹ����ļ�����ı���Ϊgbk��

8. �л�����ʱ��һ������https://open.unionpay.com/ajweb/help/faq/listByType?faqType=prod�е����⣬�ر��ǡ��л���������Щ��Ҫ�Ķ��ĵط��������FAQ��




