using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Com.NewSun.Common
{
    public static class CommonHelper
    {
        #region 配置文件相关操作
        public static string GetConfigString(string key)
        {
            if (ConfigurationManager.AppSettings[key] == null)
                return string.Empty;

            var value = ConfigurationManager.AppSettings[key].ToString().Trim();
            return value;
        }

        public static int GetConfigInt(string key)
        {
            int result = 0;
            string value = GetConfigString(key);
            if (!int.TryParse(value, out result))
                result = 0;
            return result;
        }

        public static bool GetConfigBoolean(string key)
        {
            bool result = false;
            string value = GetConfigString(key);
            if (!bool.TryParse(value, out result))
                return false;
            return result;
        }

        public static IList<string> GetConfigList(string key, char split)
        {
            string content = GetConfigString(key);
            return content.Split(split).ToList();
        }
        #endregion

        /// <summary>
        /// 判断是否是Web应用程序
        /// </summary>
        /// <returns></returns>
        public static bool IsWebApplicaiton()
        {
            if (HttpContext.Current == null)
                return false;
            return true;
        }

        #region 获取IP、URL等信息

        /// <summary>
        ///  获取IP地址
        /// </summary>
        /// <returns></returns>
        public static string GetIPAddress()
        {
            string ipAddress = string.Empty;
            try
            {
                if (!string.IsNullOrEmpty(System.Web.HttpContext.Current.Request.ServerVariables["HTTP_VIA"]))
                    ipAddress = Convert.ToString(System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]);
                if (string.IsNullOrEmpty(ipAddress))
                    ipAddress = Convert.ToString(HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"]);
                return ipAddress;
            }
            catch { }

            try
            {
                System.Net.IPHostEntry HostEntry = System.Net.Dns.GetHostEntry(System.Net.Dns.GetHostName());
                if (HostEntry.AddressList.Length > 0)
                    ipAddress = HostEntry.AddressList[0].ToString();
                return ipAddress;
            }
            catch { }

            return ipAddress;
        }

        /// <summary>
        ///  获取当前URL
        /// </summary>
        /// <returns></returns>
        public static string GetPageUrl()
        {
            if (IsWebApplicaiton())
                return HttpContext.Current.Request.RawUrl;

            return string.Empty;
        }

        /// <summary>
        /// 获取上一次请求的URL
        /// </summary>
        /// <returns></returns>
        public static string GetReferrerUrl()
        {
            if (IsWebApplicaiton())
                return HttpContext.Current.Request.UrlReferrer == null ? string.Empty : HttpContext.Current.Request.UrlReferrer.ToString();
            return string.Empty;
        }
        #endregion

        #region 加密解密

        /// <summary>
        /// 使用MD5加密
        /// </summary>
        /// <param name="strInput"></param>
        /// <returns></returns>
        public static string EncryptByMD5(string strInput)
        {
            StringBuilder strPwd = new StringBuilder();

            MD5 md5 = MD5.Create();//实例化一个md5对像
            //加密后是一个字节类型的数组，这里要注意编码UTF8/Unicode等的选择　
            byte[] s = md5.ComputeHash(Encoding.UTF8.GetBytes(strInput));
            // 通过使用循环，将字节类型的数组转换为字符串，此字符串是常规字符格式化所得
            for (int i = 0; i < s.Length; i++)
            {
                //将得到的字符串使用十六进制类型格式,格式后的字符是小写的字母，如果使用大写（X）则格式后的字符是大写字符 
                strPwd.Append(s[i].ToString("X"));
            }

            return strPwd.ToString();
        }

        /// <summary>
        /// 校验MD5
        /// </summary>
        /// <param name="argInput">原始字符串</param>
        /// <param name="argHash">比较MD5字符串</param>
        /// <returns></returns>
        public static bool VerifyMD5(string strInput, string strHash)
        {
            string strInputHash = EncryptByMD5(strInput);
            if (strInputHash.Equals(strHash))
                return true;
            return false;
        }

        /// <summary>
        /// Base64加密
        /// </summary>
        /// <param name="str">要加密的字符串</param>
        /// <returns></returns>
        public static string BaseEncode(string str)
        {
            string code = "";
            if (!string.IsNullOrWhiteSpace(str))
            {
                try
                {
                    byte[] bytes = System.Text.Encoding.Default.GetBytes(str);
                    code = Convert.ToBase64String(bytes);
                }
                catch { }
            }
            return code;

        }
        /// <summary>
        /// Base64解密
        /// </summary>
        /// <param name="str">要解密的字符串</param>
        /// <returns></returns>
        public static string BaseDncode(string str)
        {
            string code = "";
            if (!string.IsNullOrWhiteSpace(str))
            {
                try
                {
                    byte[] bytes = Convert.FromBase64String(str);
                    code = System.Text.Encoding.Default.GetString(bytes);
                }
                catch { }
            }
            return code;
        }

        /// <summary>
        /// 获取AES KEY
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static string GetAesKey(string key)
        {
            byte[] keyArray = Encoding.Default.GetBytes(key);
            using (System.Security.Cryptography.MD5CryptoServiceProvider m = new System.Security.Cryptography.MD5CryptoServiceProvider())
            {
                keyArray = m.ComputeHash(keyArray);
            }
            return Encoding.Default.GetString(keyArray);

        }
        /// <summary>
        /// AES 加密(高级加密标准，是下一代的加密算法标准，速度快，安全级别高，目前 AES 标准的一个实现是 Rijndael 算法)
        /// </summary>
        /// <param name="EncryptString">待加密密文</param>
        /// <param name="EncryptKey">加密密钥</param>
        /// <returns></returns>
        public static string AESEncrypt(string EncryptString, string EncryptKey)
        {
            if (string.IsNullOrEmpty(EncryptString)) { throw (new Exception("密文不得为空")); }

            if (string.IsNullOrEmpty(EncryptKey)) { throw (new Exception("密钥不得为空")); }

            string m_strEncrypt = "";

            byte[] m_btIV = Convert.FromBase64String("Rkb4jvUy/ye7Cd7k89QQgQ==");

            Rijndael m_AESProvider = Rijndael.Create();

            try
            {
                byte[] m_btEncryptString = Encoding.Default.GetBytes(EncryptString);

                MemoryStream m_stream = new MemoryStream();

                CryptoStream m_csstream = new CryptoStream(m_stream, m_AESProvider.CreateEncryptor(Encoding.Default.GetBytes(EncryptKey), m_btIV), CryptoStreamMode.Write);

                m_csstream.Write(m_btEncryptString, 0, m_btEncryptString.Length);

                m_csstream.FlushFinalBlock();

                m_strEncrypt = Convert.ToBase64String(m_stream.ToArray());

                m_stream.Close(); m_stream.Dispose();

                m_csstream.Close(); m_csstream.Dispose();
            }
            catch (IOException ex) { throw; }
            catch (CryptographicException ex) { throw; }
            catch (ArgumentException ex) { throw; }
            catch (Exception ex) { throw; }
            finally { m_AESProvider.Clear(); }

            return m_strEncrypt;
        }

        /// <summary>
        /// AES 解密(高级加密标准，是下一代的加密算法标准，速度快，安全级别高，目前 AES 标准的一个实现是 Rijndael 算法)
        /// </summary>
        /// <param name="DecryptString">待解密密文</param>
        /// <param name="DecryptKey">解密密钥</param>
        /// <returns></returns>
        public static string AESDecrypt(string DecryptString, string DecryptKey)
        {
            if (string.IsNullOrEmpty(DecryptString)) { throw (new Exception("密文不得为空")); }

            if (string.IsNullOrEmpty(DecryptKey)) { throw (new Exception("密钥不得为空")); }

            string m_strDecrypt = "";

            byte[] m_btIV = Convert.FromBase64String("Rkb4jvUy/ye7Cd7k89QQgQ==");

            Rijndael m_AESProvider = Rijndael.Create();

            try
            {
                byte[] m_btDecryptString = Convert.FromBase64String(DecryptString);

                MemoryStream m_stream = new MemoryStream();

                CryptoStream m_csstream = new CryptoStream(m_stream, m_AESProvider.CreateDecryptor(Encoding.Default.GetBytes(DecryptKey), m_btIV), CryptoStreamMode.Write);

                m_csstream.Write(m_btDecryptString, 0, m_btDecryptString.Length);

                m_csstream.FlushFinalBlock();

                m_strDecrypt = Encoding.Default.GetString(m_stream.ToArray());

                m_stream.Close(); m_stream.Dispose();

                m_csstream.Close(); m_csstream.Dispose();
            }
            catch (IOException ex) { throw; }
            catch (CryptographicException ex) { throw; }
            catch (ArgumentException ex) { throw; }
            catch (Exception ex) { throw; }
            finally { m_AESProvider.Clear(); }

            return m_strDecrypt;
        }

        /// <summary>
        /// DES 加密
        /// </summary>
        /// <param name="EncryptString">加密密文</param>
        /// <param name="Key">加密密钥</param>
        /// <returns></returns>
        public static string DESEncrypt(string EncryptString, string Key)
        {
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();
            byte[] inputByteArray;
            inputByteArray = Encoding.Default.GetBytes(EncryptString);
            des.Key = ASCIIEncoding.ASCII.GetBytes(System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(Key, "md5").Substring(0, 8));
            des.IV = ASCIIEncoding.ASCII.GetBytes(System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(Key, "md5").Substring(0, 8));
            System.IO.MemoryStream ms = new System.IO.MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write);
            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();
            StringBuilder ret = new StringBuilder();
            foreach (byte b in ms.ToArray())
            {
                ret.AppendFormat("{0:X2}", b);
            }
            ms.Dispose();
            cs.Dispose();
            return ret.ToString();
        }

        /// <summary>
        /// DES 解密 
        /// </summary>
        /// <param name="DecryptString">加密密文</param>
        /// <param name="Key">解密密匙</param>
        /// <returns></returns>
        public static string DESDecrypt(string DecryptString, string Key)
        {
            DESCryptoServiceProvider des = new DESCryptoServiceProvider();

            byte[] inputByteArray = new byte[DecryptString.Length / 2];
            for (int x = 0; x < DecryptString.Length / 2; x++)
            {
                int i = (Convert.ToInt32(DecryptString.Substring(x * 2, 2), 16));
                inputByteArray[x] = (byte)i;
            }

            des.Key = ASCIIEncoding.UTF8.GetBytes(Key);
            des.IV = ASCIIEncoding.UTF8.GetBytes(Key);
            MemoryStream ms = new MemoryStream();
            CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write);
            cs.Write(inputByteArray, 0, inputByteArray.Length);
            cs.FlushFinalBlock();

            StringBuilder ret = new StringBuilder();

            return System.Text.Encoding.Default.GetString(ms.ToArray());
        }

        #endregion 加密解密
    }
}
