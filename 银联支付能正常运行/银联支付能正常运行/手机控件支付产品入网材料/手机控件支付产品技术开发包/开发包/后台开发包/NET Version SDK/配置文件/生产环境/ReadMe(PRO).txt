��Web.config���������޸�����������Ϣ��
 
 <appSettings>
  	<!-- ##########################���׷��͵�ַ����#############################-->
    <!--######(��������Ϊ�������Ի�����)#######-->
    <!--  ǩ��֤��·�� ����ϵ��Ӫ��ȡ���룬��CFCA��վ���غ����ã���������֤�����벢���ã� -->
    <add key="sdk.signCert.path" value="d:\\certs\\PRO_700000000000001_acp.pfx" />
    <!-- ǩ��֤������ -->
    <add key="sdk.signCert.pwd" value="000000" />
    <!-- ǩ��֤������ -->
    <add key="sdk.signCert.type" value="PKCS12" />
    <!-- ����֤��·�� -->
    <add key="sdk.encryptCert.path" value="d:\\certs\\RSA2048_PROD_index_22.cer" />
    <!-- ��ǩ֤��Ŀ¼ -->
    <add key="sdk.validateCert.dir" value="d:\\certs\\" />
    <!-- ǰ̨���׵�ַ -->
    <add key="sdk.frontTransUrl" value="https://gateway.95516.com/gateway/api/frontTransReq.do" />
    <!-- ��̨���׵�ַ -->
    <add key="sdk.backTransUrl" value="https://gateway.95516.com/gateway/api/backTransReq.do" />
    <!-- ����״̬��ѯ��ַ -->
    <add key="sdk.singleQueryUrl" value="https://gateway.95516.com/gateway/api/queryTrans.do" />
    <!-- �ļ������ཻ�׵�ַ -->
    <add key="sdk.fileTransUrl" value="https://filedownload.95516.com/" />
    <!-- �������׵�ַ -->
    <add key="sdk.batTransUrl" value="https://gateway.95516.com/gateway/api/batchTrans.do" />
    <!-- �п����׵�ַ -->
    <add key="sdk.cardRequestUrl" value="https://gateway.95516.com/gateway/api/cardTransReq.do" />
    <!-- app���׵�ַ �ֻ��ؼ�֧��ʹ�øõ�ַ-->
    <add key="sdk.appRequestUrl" value="https://gateway.95516.com/gateway/api/appTransReq.do" />
  </appSettings>