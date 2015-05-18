using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Web;
using System.Runtime.Remoting.Messaging;

namespace Com.NewSun.Common.Application
{
    public class ApplicationHelper
    {
        public static void Set(string key, object value)
        {
            if (null == HttpContext.Current)
            {
                CallContext.SetData(key, value);
            }
            else
            {
                HttpContext.Current.Application[key] = value;
            }
        }
        public static object Get(string key)
        {
            return null == HttpContext.Current ? CallContext.GetData(key) : HttpContext.Current.Application[key];
        }
        public static void Remove(string key)
        {
            if (HttpContext.Current == null)
                Set(key, "");
            else
                HttpContext.Current.Application.Remove(key);
        }
        public static void RemoveAll()
        {
            if (HttpContext.Current != null)
                HttpContext.Current.Application.RemoveAll();
        }
    }
}
