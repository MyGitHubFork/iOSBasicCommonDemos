<?php
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/SDKConfig.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/PublicEncrypte.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/common.php';
include_once $_SERVER ['DOCUMENT_ROOT'] . '/upacp_sdk_php/gbk/func/log.class.php';

// ��ʼ����־
$log = new PhpLog ( SDK_LOG_FILE_PATH, "PRC", SDK_LOG_LEVEL );
/**
 * ǩ��
 *
 * @param String $params_str
 */
function sign(&$params) {
	global $log;
	$log->LogInfo ( '=====ǩ�����Ŀ�ʼ======' );
	if(isset($params['transTempUrl'])){
		unset($params['transTempUrl']);
	}
	// ת����key=val&��
	$params_str = coverParamsToString ( $params );
	$log->LogInfo ( "ǩ��key=val&...�� >" . $params_str );
	
	$params_sha1x16 = sha1 ( $params_str, FALSE );
	$log->LogInfo ( "ժҪsha1x16 >" . $params_sha1x16 );
	// ǩ��֤��·��
	$cert_path = SDK_SIGN_CERT_PATH;
	$private_key = getPrivateKey ( $cert_path );
	// ǩ��
	$sign_falg = openssl_sign ( $params_sha1x16, $signature, $private_key, OPENSSL_ALGO_SHA1 );
	if ($sign_falg) {
		$signature_base64 = base64_encode ( $signature );
		$log->LogInfo ( "ǩ����Ϊ >" . $signature_base64 );
		$params ['signature'] = $signature_base64;
	} else {
		$log->LogInfo ( ">>>>>ǩ��ʧ��<<<<<<<" );
	}
	$log->LogInfo ( '=====ǩ�����Ľ���======' );
}

/**
 * ��ǩ
 *
 * @param String $params_str        	
 * @param String $signature_str        	
 */
function verify($params) {
	global $log;
	// ��Կ
	$public_key = getPulbicKeyByCertId ( $params ['certId'] );	
//	echo $public_key.'<br/>';
	// ǩ����
	$signature_str = $params ['signature'];
	unset ( $params ['signature'] );
	$params_str = coverParamsToString ( $params );
	$log->LogInfo ( '����ȥ[signature] key=val&��>' . $params_str );
	$signature = base64_decode ( $signature_str );
//	echo date('Y-m-d',time());
	$params_sha1x16 = sha1 ( $params_str, FALSE );
	$log->LogInfo ( 'ժҪshax16>' . $params_sha1x16 );	
	$isSuccess = openssl_verify ( $params_sha1x16, $signature,$public_key, OPENSSL_ALGO_SHA1 );
	$log->LogInfo ( $isSuccess ? '��ǩ�ɹ�' : '��ǩʧ��' );
	return $isSuccess;
}

/**
 * ����֤��ID ���� ֤��
 *
 * @param unknown_type $certId        	
 * @return string NULL
 */
function getPulbicKeyByCertId($certId) {
	global $log;
	$log->LogInfo ( '���ķ��ص�֤��ID>' . $certId );
	// ֤��Ŀ¼
	$cert_dir = SDK_VERIFY_CERT_DIR;
	$log->LogInfo ( '��֤ǩ��֤��Ŀ¼ :>' . $cert_dir );
	$handle = opendir ( $cert_dir );
	if ($handle) {
		while ( $file = readdir ( $handle ) ) {
			clearstatcache ();
			$filePath = $cert_dir . '/' . $file;
			if (is_file ( $filePath )) {
				if (pathinfo ( $file, PATHINFO_EXTENSION ) == 'cer') {
					if (getCertIdByCerPath ( $filePath ) == $certId) {
						closedir ( $handle );
						$log->LogInfo ( '������ǩ֤��ɹ�' );
						return getPublicKey ( $filePath );
					}
				}
			}
		}
		$log->LogInfo ( 'û���ҵ�֤��IDΪ[' . $certId . ']��֤��' );
	} else {
		$log->LogInfo ( '֤��Ŀ¼ ' . $cert_dir . '����ȷ' );
	}
	closedir ( $handle );
	return null;
}

/**
 * ȡ֤��ID(.pfx)
 *
 * @return unknown
 */
function getCertId($cert_path) {
	$pkcs12certdata = file_get_contents ( $cert_path );

	openssl_pkcs12_read ( $pkcs12certdata, $certs, SDK_SIGN_CERT_PWD );
	$x509data = $certs ['cert'];
	openssl_x509_read ( $x509data );
	$certdata = openssl_x509_parse ( $x509data );
	$cert_id = $certdata ['serialNumber'];
	return $cert_id;
}

/**
 * ȡ֤��ID(.cer)
 *
 * @param unknown_type $cert_path        	
 */
function getCertIdByCerPath($cert_path) {
	$x509data = file_get_contents ( $cert_path );
	openssl_x509_read ( $x509data );
	$certdata = openssl_x509_parse ( $x509data );
	$cert_id = $certdata ['serialNumber'];
	return $cert_id;
}

/**
 * ǩ��֤��ID
 *
 * @return unknown
 */
function getSignCertId() {
	// ǩ��֤��·��
	
	return getCertId ( SDK_SIGN_CERT_PATH );
}
function getEncryptCertId() {
	// ǩ��֤��·��
	return getCertIdByCerPath ( SDK_ENCRYPT_CERT_PATH );
}

/**
 * ȡ֤�鹫Կ -��ǩ
 *
 * @return string
 */
function getPublicKey($cert_path) {
	return file_get_contents ( $cert_path );
}
/**
 * ����(ǩ��)֤��˽Կ -
 *
 * @return unknown
 */
function getPrivateKey($cert_path) {
	$pkcs12 = file_get_contents ( $cert_path );
	openssl_pkcs12_read ( $pkcs12, $certs, SDK_SIGN_CERT_PWD );
	return $certs ['pkey'];
}

/**
 * ���� ����
 *
 * @param String $pan
 *        	����
 * @return String
 */
function encryptPan($pan) {
	$cert_path = MPI_ENCRYPT_CERT_PATH;
	$public_key = getPublicKey ( $cert_path );
	
	openssl_public_encrypt ( $pan, $cryptPan, $public_key );
	return base64_encode ( $cryptPan );
}
/**
 * pin ����
 *
 * @param unknown_type $pan        	
 * @param unknown_type $pwd        	
 * @return Ambigous <number, string>
 */
function encryptPin($pan, $pwd) {
	$cert_path = SDK_ENCRYPT_CERT_PATH;
	$public_key = getPublicKey ( $cert_path );

	return EncryptedPin ( $pwd, $pan, $public_key );
}
/**
 * cvn2 ����
 *
 * @param unknown_type $cvn2        	
 * @return unknown
 */
function encryptCvn2($cvn2) {
	$cert_path = SDK_ENCRYPT_CERT_PATH;
	$public_key = getPublicKey ( $cert_path );
	
	openssl_public_encrypt ( $cvn2, $crypted, $public_key );
	
	return base64_encode ( $crypted );
}
/**
 * ���� ��Ч��
 *
 * @param unknown_type $certDate        	
 * @return unknown
 */
function encryptDate($certDate) {
	$cert_path = SDK_ENCRYPT_CERT_PATH;
	$public_key = getPublicKey ( $cert_path );
	
	openssl_public_encrypt ( $certDate, $crypted, $public_key );
	
	return base64_encode ( $crypted );
}

/**
 * ���� ����
 *
 * @param unknown_type $certDatatype
 * @return unknown
 */
function encryptDateType($certDataType) {
	$cert_path = SDK_ENCRYPT_CERT_PATH;
	$public_key = getPublicKey ( $cert_path );

	openssl_public_encrypt ( $certDataType, $crypted, $public_key );

	return base64_encode ( $crypted );
}

?>