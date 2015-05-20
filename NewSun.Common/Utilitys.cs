using System;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Web;

namespace Com.NewSun.Common
{
    public static class Utilitys
    {
        public static string ConvertToArrayString(this string value)
        {
            if (Regex.IsMatch(value, @"^{""[^""]+"":([.\s\S]+)}$"))
            {
                var match = Regex.Match(value, @"^{""[^""]+"":([.\s\S]+)}$");
                if (match.Groups.Count > 0)
                {
                    return string.Format("[{0}]", match.Groups[0].Value);
                }
            }
            return value;
        }

        /// <summary>
        /// 获取时间格式字符串  yyyyMMddHHmmsss
        /// </summary>
        /// <returns></returns>
        public static string GetExpenseNumber()
        {
            return DateTime.Now.ToString("yyyyMMddHHmmsss");
        }

        /// <summary>
        /// GUID
        /// </summary>
        /// <returns></returns>
        public static Guid NewID()
        {
            return Guid.NewGuid();
        }

        /// <summary>
        /// 将数据转换为Int类型
        /// </summary>
        public static int ToInt(this  object data, int defaultValue = default(int))
        {
            int returnValue = defaultValue;

            if (IsNullOrEmpty(data) || !int.TryParse(data.ToString(), out returnValue))
                returnValue = defaultValue;
            return returnValue;
        }

        /// <summary>
        ///  检测对象是否为空，为空返回true
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static bool IsNullOrEmpty(this object data)
        {
            bool returnValue = true;
            if (data != null)
            {
                if (data.GetType() == typeof(String))
                {
                    if (string.IsNullOrEmpty(data.ToString().Trim()))
                    {
                        return true;
                    }
                }
                if (data.GetType() == typeof(DBNull))
                {
                    return true;
                }
                returnValue = false;
            }
            return returnValue;
        }

        /// <summary>
        /// 判断是否是异步调用
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public static bool IsAjax(this HttpRequest request)
        {
            return (request["X-Requested-With"] == "XMLHttpRequest") ||
                ((request.Headers != null) && (request.Headers["X-Requested-With"] == "XMLHttpRequest"));
        }

        /// <summary>  
        /// 是否为日期型字符串  
        /// </summary>  
        /// <param name="StrSource">日期字符串</param>  
        /// <returns></returns>  
        public static bool IsDate(string StrSource)
        {
            if (StrSource == null)
            {
                return false;
            }
            return Regex.IsMatch(StrSource, @"^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-9]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$");
        }

        /// <summary>
        /// 判断是否为数字
        /// </summary>
        /// <param name="text"></param>
        /// <returns></returns>
        public static bool IsNumber(string text)
        {
            Regex reg = new Regex("^[0-9]+$");
            if (text == null)
            {
                return false;
            }
            Match ma = reg.Match(text);
            if (ma.Success)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static string AppSetting(this string key)
        {
            return ConfigurationManager.AppSettings[key];
        }

        /// <summary>
        /// 生成密码
        /// </summary>
        /// <param name="codeCount"></param>
        /// <returns></returns>
        public static string CreateRandomCode(int codeCount)
        {
            string allChar = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
            string[] allCharArray = allChar.Split(',');
            string randomCode = "";
            int temp = -1;

            Random rand = new Random();
            for (int i = 0; i < codeCount; i++)
            {
                if (temp != -1)
                {
                    rand = new Random(i * temp * ((int)DateTime.Now.Ticks));
                }
                int t = rand.Next(61);
                if (temp == t)
                {
                    return CreateRandomCode(codeCount);
                }
                temp = t;
                randomCode += allCharArray[t];
            }
            return randomCode;
        }

        //计算文件的MD5值
        public static string GetStreamMD5(Stream stream)
        {
            string strResult = "";
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            byte[] arrayHashValue = md5.ComputeHash(stream); //计算指定stream对象的哈希值
            //由以连接字符分隔的十六进制构成的String,其中每一对表示value对应的元素，例如"F-2C-4A"
            strResult = BitConverter.ToString(arrayHashValue);
            //替换
            strResult = strResult.Replace("-", "");
            return strResult;
        }

        #region 验证码
        private static Bitmap CreateImages(string checkCode, string type)
        {
            int step = 0;
            if (type == "ch")
            {
                step = 5;//中文字符，边界值做大
            }
            int iwidth = (int)(checkCode.Length * (13 + step));
            System.Drawing.Bitmap image = new System.Drawing.Bitmap(iwidth, 22);
            Graphics g = Graphics.FromImage(image);
            g.Clear(Color.White);//清除背景色
            Color[] c = { Color.Black, Color.Red, Color.DarkBlue, Color.Green, Color.Orange, Color.Brown, Color.DarkCyan, Color.Purple };//定义随机颜色
            string[] font = { "Verdana", "Microsoft Sans Serif", "Comic Sans MS", "Arial", "宋体" };
            Random rand = new Random();

            for (int i = 0; i < 50; i++)
            {
                int x1 = rand.Next(image.Width);
                int x2 = rand.Next(image.Width);
                int y1 = rand.Next(image.Height);
                int y2 = rand.Next(image.Height);
                g.DrawLine(new Pen(Color.LightGray, 1), x1, y1, x2, y2);//根据坐标画线
            }

            for (int i = 0; i < checkCode.Length; i++)
            {
                int cindex = rand.Next(7);
                int findex = rand.Next(5);

                Font f = new System.Drawing.Font(font[findex], 10, System.Drawing.FontStyle.Bold);
                Brush b = new System.Drawing.SolidBrush(c[cindex]);
                int ii = 4;
                if ((i + 1) % 2 == 0)
                {
                    ii = 2;
                }
                g.DrawString(checkCode.Substring(i, 1), f, b, 3 + (i * (12 + step)), ii);

            }
            g.DrawRectangle(new Pen(Color.Black, 0), 0, 0, image.Width - 1, image.Height - 1);
            MemoryStream ms = new MemoryStream();
            return image;
        }

        private static string GetRndStr()
        {
            string Vchar = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";
            string[] VcArray = Vchar.Split(',');
            string checkCode = string.Empty;
            Random rand = new Random();
            for (int i = 0; i < 4; i++)
            {
                int t = rand.Next(VcArray.Length);
                checkCode += VcArray[t];
            }
            return checkCode;
        }
        #endregion
    }
}
