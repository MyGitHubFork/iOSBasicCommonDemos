<?php

// ######(以下配置为生产环境配置，请根据商户系统自身情况修改)#######

// cvn2加密 1：加密 0:不加密
const SDK_CVN2_ENC = 0;
// 有效期加密 1:加密 0:不加密
const SDK_DATE_ENC = 0;
// 卡号加密 1：加密 0:不加密
const SDK_PAN_ENC = 0;
 

// 签名证书路径 （联系运营获取两码，在CFCA网站下载后配置，自行设置证书密码并配置）
const SDK_SIGN_CERT_PATH = 'D:/certs/PRO_700000000000001_acp.pfx';

// 签名证书密码
 const SDK_SIGN_CERT_PWD = '000000';
 
// 验签证书
const SDK_VERIFY_CERT_PATH = 'D:/certs/UPOP_VERIFY.cer';

// 密码加密证书
const SDK_ENCRYPT_CERT_PATH = 'D:/certs/RSA2048_PROD_index_22.cer';

// 验签证书路径
const SDK_VERIFY_CERT_DIR = 'D:/certs/';

// 前台请求地址
const SDK_FRONT_TRANS_URL = 'https://gateway.95516.com/gateway/api/frontTransReq.do';

// 后台请求地址
const SDK_BACK_TRANS_URL = 'https://gateway.95516.com/gateway/api/backTransReq.do';

// 批量交易
const SDK_BATCH_TRANS_URL = 'https://gateway.95516.com/gateway/api/batchTrans.do';

//单笔查询请求地址
const SDK_SINGLE_QUERY_URL = 'https://gateway.95516.com/gateway/api/queryTrans.do';

//文件传输请求地址
const SDK_FILE_QUERY_URL = 'https://filedownload.95516.com/';

//有卡交易地址
const SDK_Card_Request_Url = 'https://gateway.95516.com/gateway/api/cardTransReq.do';

//App交易地址
const SDK_App_Request_Url = 'https://gateway.95516.com/gateway/api/appTransReq.do';


// 前台通知地址 (商户自行配置通知地址)
const SDK_FRONT_NOTIFY_URL = 'http://127.0.0.1/upacp_sdk_php/demo/response.php';
// 后台通知地址 (商户自行配置通知地址)
const SDK_BACK_NOTIFY_URL = 'http://127.0.0.1/upacp_sdk_php/demo/response.php';

//文件下载目录 
const SDK_FILE_DOWN_PATH = 'd:/file/';

//日志 目录 
const SDK_LOG_FILE_PATH = 'D:/logs/';

//日志级别
const SDK_LOG_LEVEL = 'INFO';


	
?>