using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Com.NewSun.Common
{
    /// <summary>
    /// Log4net 日志封装类
    /// </summary>
    public class LogHelper
    {
        private static readonly log4net.ILog loginfo = log4net.LogManager.GetLogger("loginfo");
        private static readonly log4net.ILog logerror = log4net.LogManager.GetLogger("logerror");
        private static readonly log4net.ILog logdebug = log4net.LogManager.GetLogger("logdebug");
        private static readonly log4net.ILog logquick = log4net.LogManager.GetLogger("logquick");
        private static readonly log4net.ILog logdatabase = log4net.LogManager.GetLogger("logdatabase");

        public static void Info(string message)
        {
            if (loginfo.IsInfoEnabled)
            {
                loginfo.Info(message);
            }
        }
        public static void Quick(string message)
        {
            if (logquick.IsInfoEnabled)
            {
                logquick.Info(message);
            }
        }
        public static void Quick(string message, Exception ex)
        {
            if (logquick.IsErrorEnabled)
            {
                if (!string.IsNullOrEmpty(message) && ex == null)
                {
                    logquick.ErrorFormat("<br>【附加信息】 : {0}<br>", new object[] { message });
                }
                else if (!string.IsNullOrEmpty(message) && ex != null)
                {
                    string errorMsg = BeautyErrorMsg(ex);
                    logquick.ErrorFormat("<br>【附加信息】 : {0}<br>{1}", new object[] { message, errorMsg });
                }
                else if (string.IsNullOrEmpty(message) && ex != null)
                {
                    string errorMsg = BeautyErrorMsg(ex);
                    logquick.Error(errorMsg);
                }
            }
        }
        public static void Error(string message)
        {
            if (logerror.IsErrorEnabled)
            {
                logerror.Error(message);
            }
        }
        public static void Error(string message, Exception ex)
        {
            if (logerror.IsErrorEnabled)
            {
                if (!string.IsNullOrEmpty(message) && ex == null)
                {
                    logerror.ErrorFormat("<br>【附加信息】 : {0}<br>", new object[] {message});
                }
                else if (!string.IsNullOrEmpty(message) && ex != null)
                {
                    string errorMsg = BeautyErrorMsg(ex);
                    logerror.ErrorFormat("<br>【附加信息】 : {0}<br>{1}", new object[] { message, errorMsg });
                }
                else if (string.IsNullOrEmpty(message) && ex != null)
                {
                    string errorMsg = BeautyErrorMsg(ex);
                    logerror.Error(errorMsg);
                }
            }
        }
        public static void Debug(string message)
        {
            if (logdebug.IsErrorEnabled)
            {
                logdebug.Debug(message);
            }
        }
        public static void Debug(string message, Exception ex)
        {
            if (logdebug.IsDebugEnabled)
            {
                if (!string.IsNullOrEmpty(message) && ex == null)
                {
                    logdebug.DebugFormat("<br>【附加信息】 : {0}<br>", new object[] {message});
                }
                else if (!string.IsNullOrEmpty(message) && ex != null)
                {
                    string errorMsg = BeautyErrorMsg(ex);
                    logdebug.DebugFormat("<br>【附加信息】 : {0}<br>{1}", new object[] { message, errorMsg });
                }
                else if (string.IsNullOrEmpty(message) && ex != null)
                {
                    string errorMsg = BeautyErrorMsg(ex);
                    logdebug.Debug(errorMsg);
                }
            }
        }

        public static void Database(LogMessage logMsg)
        {
            logdatabase.Info(logMsg);
        }

        private static string BeautyErrorMsg(Exception ex)
        {
            string errorMsg = string.Format("【异常类型】：{0} <br>【异常信息】：{1} <br>【堆栈调用】：{2}",
                new object[] {ex.GetType().Name, ex.Message, ex.StackTrace});
            errorMsg = errorMsg.Replace("\r\n", "<br>");
            errorMsg = errorMsg.Replace("位置", "<strong style='color:red'>位置</strong><br>");
            return errorMsg;
        }
    }
}
