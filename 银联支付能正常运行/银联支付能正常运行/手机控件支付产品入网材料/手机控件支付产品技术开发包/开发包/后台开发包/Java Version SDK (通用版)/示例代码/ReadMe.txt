0. ע�⣺
1����������upacp_sdk-1.0.0.jar����ӵ�buildpath��
2��acp_sdk.properties�ŵ�src��Ŀ¼�¡���������õĲ���eclipse/MyEclipse��������ļ�Ĭ�ϲ��ᱻ������classesĿ¼�£����¼��ز�������ļ�����ע���޸����û��ֹ���������ļ���

1. �޸�acp_sdk.properties��
1) ֤������Լ�����·����֤��������Ի�������000000�������Լ��޸ġ�

2.1 wap/���ص����ѣ�����Form_6_2_FrontConsume���̻������Ϊ�Լ����̻��ţ�������һ��html��������ӡ�������������ת֧��ҳ�档�������дһ��servletֱ�Ӵ�ӡҳ�棬���߰�html���Ƶ�һ�����±����׺��html��������򿪡�

2.2 �ؼ������ѣ�����Form_6_2_AppConsume���̻������Ϊ�Լ����̻��ţ�����ʺ�̨��ȡtn����tn���������ֻ�app��

֧������
ƽ�����н�ǿ���6216261000000000018
֤���ţ�341126197709218366
�ֻ��ţ�13552535506
���룺123456
������ȫ����
������֤�룺123456��wap/�ؼ���111111��PC��
��������֤��ǵõ��»�ȡ��֤��֮�������룩

3. Form_6_5_QueryΪ��ѯ�ӿڣ��̻������Ϊ�Լ����̻��ţ�ע���޸�txnTime��orderIdΪ����ѯ���׵�txnTime��orderId��

4. Form_6_3_ConsumeUndo��Form_6_4_Refund�ֱ�Ϊ���ѳ����ӿڡ��˻��ӿڣ��̻������Ϊ�Լ����̻��ţ�ע���޸�origQryIdΪ�Լ���Ҫ�˿���Ǳ����ѵ�queryId��

5. FrontRcvResponse��BackRcvResponseΪǰ��̨֪ͨ�ӿڣ�Ϊ2��Servlet����ע������web.xml������FrontRcvResponse��ʹ�á������ļ�/utf8_result.jsp����������ɻ����֪ͨ�ӿڡ�

6. Form_6_6_FileTransferΪ�ļ����ؽӿڡ�
�ļ����ؽӿ�ע��㣺
1) ��ʹ���Լ��ġ���ʵ�̻��š����ԡ����������̻��š�����������ƽ̨������̻��Ŷ��ǲ��ܲ����ļ����صģ��ᷴhttp״̬500������Ϊ�ա������ʵ�̻���������ʾ���ļ���ȷ���н��ף�һ�����̻���û���ļ������ཻ�׵�Ȩ�ޣ�����Ҫ��ͨ����ϵҵ����Ӫ����operation@unionpay.com��
2) ���Ƚ������ļ��в�ȷ�����ļ�д��Ȩ�ޡ�

7. ����ʹ��gbk���룬�������޸Ĵ�����д�ı���ʹ����ļ�����ı���Ϊgbk��

8. ���������ļ��������⣺
SDKConfig.getConfig().loadPropertiesFromSrc()��仰�������������õ�ʱ��ִ��һ�μ��ɣ�����ط�����ɾ����
������Խ�����servlet����ʼ��ʱ���ã�web.xml�����ó�����ʱ�ͼ������servlet��

InitServlet.java��
public class InitServlet extends HttpServlet{
	@Override
	public void init() throws ServletException {
		SDKConfig.getConfig().loadPropertiesFromSrc();// ��classpath����acp_sdk.properties�ļ�
		super.init();
	}
}

web.xml��
  <servlet>
  	<servlet-name>InitServlet</servlet-name>
  	<servlet-class>com.unionpay.acp.demo.InitServlet</servlet-class>
  	<load-on-startup>0</load-on-startup>
  </servlet>


9. ��־�ļ�·�����⣺
��rar��upacp_sdk-1.0.0.jar���޸�����log4j.properties���õ�·����

10. �л�����ʱ��һ������https://open.unionpay.com/ajweb/help/faq/listByType?faqType=prod�е����⣬�ر��ǡ��л���������Щ��Ҫ�Ķ��ĵط��������FAQ��


