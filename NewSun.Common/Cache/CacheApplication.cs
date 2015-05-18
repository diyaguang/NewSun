using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Com.NewSun.Common.Cache
{
    public class CacheApplication : ICache
    {
        public void Set(string key, object value)
        {
            Application.ApplicationHelper.Set(key, value);
        }
        public void Set(string key, object value, DateTime expiresDateTime)
        {
            Application.ApplicationHelper.Set(key, value);
        }
        public object Get(string key)
        {
            return Application.ApplicationHelper.Get(key);
        }
        public void Remove(string key)
        {
            Application.ApplicationHelper.Remove(key);
        }
    }
}
