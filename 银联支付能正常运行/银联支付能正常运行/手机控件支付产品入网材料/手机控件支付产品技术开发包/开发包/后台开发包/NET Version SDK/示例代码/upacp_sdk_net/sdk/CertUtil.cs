using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Numerics;
using System.IO;
using System;



namespace upacp_sdk_net.com.unionpay.sdk
{

    public class CertUtil
    {

        /// <summary>
        /// 获取签名证书私钥
        /// </summary>
        /// <returns></returns>
        public static RSACryptoServiceProvider GetSignProviderFromPfx()
        {
            X509Certificate2 pc = new X509Certificate2(SDKConfig.SignCertPath, SDKConfig.SignCertPwd, X509KeyStorageFlags.MachineKeySet);
            return (RSACryptoServiceProvider)pc.PrivateKey;
        }
      
        /// <summary>
        /// 获取签名证书的证书序列号
        /// </summary>
        /// <returns></returns>
        public static string GetSignCertId()
        {
            X509Certificate2 pc = new X509Certificate2(SDKConfig.SignCertPath, SDKConfig.SignCertPwd, X509KeyStorageFlags.MachineKeySet);
            //return BigNum.ToDecimalStr(BigNum.ConvertFromHex(pc.SerialNumber)); 低于4.0版本的.NET请使用此方法
            return BigInteger.Parse(pc.SerialNumber, System.Globalization.NumberStyles.HexNumber).ToString();
        }

        /// <summary>
        /// 通过证书id，获取验证签名的证书
        /// </summary>
        /// <param name="certId"></param>
        /// <returns></returns>
        public static RSACryptoServiceProvider GetValidateProviderFromPath(string certId)// 
        {
            
            DirectoryInfo directory = new DirectoryInfo(SDKConfig.ValidateCertDir);
            FileInfo[] files = directory.GetFiles("*.cer");
            if (null == files || 0 == files.Length)
            {
                return null;
            }
            foreach (FileInfo file in files)
            {
                X509Certificate2 pc = new X509Certificate2(file.DirectoryName + "\\" + file.Name);
                //string id = BigNum.ToDecimalStr(BigNum.ConvertFromHex(pc.SerialNumber)); 低于4.0版本的.NET请使用此方法
                string id = BigInteger.Parse(pc.SerialNumber, System.Globalization.NumberStyles.HexNumber).ToString();
                if (certId.Equals(id))
                {

                    return (RSACryptoServiceProvider)pc.PublicKey.Key;
                }
            }
            return null;
        }

    }
}