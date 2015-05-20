using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Com.NewSun.JobService
{
    public class ServiceUtility
    {
        /// <summary>
        /// 获取一段时间的字符串表示
        /// </summary>
        /// <param name="seconds"></param>
        /// <returns></returns>
        public static string TimeString(int seconds)
        {
            StringBuilder sb = new StringBuilder();
            int days = seconds / (60 * 60 * 24);
            int hours = seconds / (60 * 60) % 24;
            int minutes = seconds / 60 % 60;
            seconds = seconds % 60;

            if (days > 0)
            {
                if (sb.Length > 0) sb.Append(" ");
                sb.AppendFormat("{0} 天", days);
            }
            if (hours > 0 || minutes > 0 || seconds > 0)
            {
                if (hours > 0 || sb.Length > 0)
                {
                    if (sb.Length > 0) sb.Append(" ");
                    sb.AppendFormat("{0} 小时", hours);
                }

                if (minutes > 0 || seconds > 0)
                {
                    if (minutes > 0 || sb.Length > 0)
                    {
                        if (sb.Length > 0) sb.Append(" ");
                        sb.AppendFormat("{0} 分", minutes);
                    }

                    if (seconds > 0)
                    {
                        if (sb.Length > 0) sb.Append(" ");
                        sb.AppendFormat("{0} 秒", seconds % 60);
                    }
                }
            }
            return sb.ToString();
        }

        /// <summary>
        /// 获取当前应用程序下文件的绝对路径
        /// </summary>
        /// <param name="fileName"></param>
        /// <returns></returns>
        public static string ApplicationPath(string fileName)
        {
            string path = System.AppDomain.CurrentDomain.BaseDirectory;
            return System.IO.Path.Combine(path, fileName);
        }
    }
}
