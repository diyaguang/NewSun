using System;
using System.Collections.Generic;
using System.Runtime.Remoting.Messaging;
using System.Linq;
using System.Text;
using System.Web;

namespace Com.NewSun.Common.Session
{
    public class SessionHelper
    {
        public static void Set(string key, object value)
        {
            if (null == HttpContext.Current)
            {
                CallContext.SetData(key, value);
            }
            else
            {
                HttpContext.Current.Session[key] = value;
            }
        }
        public static object Get(string key)
        {
            return null == HttpContext.Current ? CallContext.GetData(key) : HttpContext.Current.Session[key];
        }
    }
}
