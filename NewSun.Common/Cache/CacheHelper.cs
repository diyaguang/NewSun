using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Com.NewSun.Common.Cache
{
    public class CacheHelper
    {
        private static ICache cacheInstance = null;
        private static CacheType cacheType = CacheType.Application;

        static CacheHelper()
        {
            string cacheTypeValue = System.Configuration.ConfigurationManager.AppSettings[ConstantDefine.CacheConfigKey];
            if (cacheTypeValue == ConstantDefine.CacheType_Memcached)
                cacheType = CacheType.Memcached;
            if (cacheType == CacheType.Application)
                cacheInstance = new CacheApplication();
            else if (cacheType == CacheType.Memcached)
                cacheInstance = new CacheMemcached();
        }
        public static void Set(string key, object value)
        { 
            cacheInstance.Set(key,value);
        }
        public static void Set(string key, object value, DateTime expiresDateTime)
        { 
            cacheInstance.Set(key,value,expiresDateTime);
        }
        public static object Get(string key)
        {
            return cacheInstance.Get(key);
        }
    }
}
