using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.SessionState;

namespace Com.NewSun.Common
{
    public class LogMessage : IRequiresSessionState
    {
        public LogMessage() { }

        public string ID { get; set; }
        public string ShortMessage { get; set; }
        public string FullMessage { get; set; }
        public string IPAddress { get; set; }
        public string PageUrl { get; set; }
        public string ReferrerUrl { get; set; }
        public string LogLevelID { get; set; }
        public string UserID { get; set; }
        public string UserName { get;set; }
        public string LoggerName { get; set; }
        public DateTime CreateTime { get; set; }

    }
}
