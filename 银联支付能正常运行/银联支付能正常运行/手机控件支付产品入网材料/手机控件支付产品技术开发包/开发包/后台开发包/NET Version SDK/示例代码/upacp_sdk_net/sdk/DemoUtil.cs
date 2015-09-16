using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Security.Cryptography;

/**
 * 仅供UPOP联机对账文件下载使用
 * */
namespace upacp_sdk_net.com.unionpay.sdk
{
    public class DemoUtil
    {

        /**
         * md5计算
         * 
         * @param sourcestring 参与运算的字符串
         * @param encoder 字符集
         * @return
         */
        public static string md5string(string sourcestring, Encoding encoder)
        {
            string result = "";
            MD5 md5 = MD5.Create();
            byte[] encodedSource = md5.ComputeHash(encoder.GetBytes(sourcestring));
            StringBuilder sBuilder = new StringBuilder();
            for (int i = 0; i < encodedSource.Length; i++)
            {
                result = result + encodedSource[i].ToString("x").PadLeft(2, '0');
            }
            return result;
        }


        /**
         * 字段排序
         * 
         * @param data
         * @return
         */
        public static string pasMap(Dictionary<string, string> data)
        {
            SortedDictionary<string, string> treeMap = new SortedDictionary<string, string>(StringComparer.Ordinal);
            foreach (KeyValuePair<string, string> kvp in data)
            {
                treeMap.Add(kvp.Key, kvp.Value);
            }
            StringBuilder builder = new StringBuilder();
            foreach (KeyValuePair<string, string> element in treeMap)
            {
                builder.Append(element.Key + "=" + element.Value + "&");
            }
            return builder.ToString();
        }


        /**
         * 
         * @param res
         * @return
         */
        public static Dictionary<string, string> pasRes(string res)
        {
            Dictionary<string, string> param = new Dictionary<string, string>();
            if (!string.IsNullOrEmpty(res))
            {
                string[] ss = res.Split('&');
                foreach (string s in ss)
                {
                    if (s.StartsWith("fileContent"))
                    {
                        param.Add("fileContent", s.Substring(12));
                        continue;
                    }
                    string[] subs = s.Split('=');
                    if (2 == subs.Length)
                    {
                        param.Add(subs[0], subs[1]);
                    }

                }
            }
            return param;
        }


    }
}