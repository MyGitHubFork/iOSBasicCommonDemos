��Web.config���������޸�����������Ϣ��
 
 <appSettings>
  	<!-- ##########################���׷��͵�ַ����#############################-->
    <!--######(��������ΪPM�������������Ի����ã������������ü��ĵ�˵��)#######-->
    <!-- ǩ��֤��·�� PM_700000000000001_acp.pfx-->
    <add key="sdk.signCert.path" value="d:\\certs\\PM_700000000000001_acp.pfx" />
    <!-- ǩ��֤������ -->
    <add key="sdk.signCert.pwd" value="000000" />
    <!-- ǩ��֤������ -->
    <add key="sdk.signCert.type" value="PKCS12" />
    <!-- ����֤��·�� -->
    <add key="sdk.encryptCert.path" value="d:\\certs\\encrypt.cer" />
    <!-- ��ǩ֤��Ŀ¼ -->
    <add key="sdk.validateCert.dir" value="d:\\certs\\" />
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