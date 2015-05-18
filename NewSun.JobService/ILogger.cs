using System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NewSun.JobService
{
    public interface ILogger
    {
        void Info(string message, params object[] args);
        void Debug(string message, params object[] args);
        void Error(string message, params object[] args);
    }

    public class ServiceLogger : ILogger
    {
        private NLog.Logger _logInstance = null;

        public ServiceLogger(string loggerName)
        {
            _logInstance = NLog.LogManager.GetLogger(loggerName);
        }


        public void Info(string message, params object[] args)
        {
            if (string.IsNullOrWhiteSpace(message))
                return;

            _logInstance.Info(message, args);
        }

        public void Debug(string message, params object[] args)
        {
            if (string.IsNullOrWhiteSpace(message))
                return;

            _logInstance.Debug(message, args);
        }

        public void Error(string message, params object[] args)
        {
            if (string.IsNullOrWhiteSpace(message))
                return;

            _logInstance.Error(message, args);
        }
    }
}
