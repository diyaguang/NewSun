using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Enyim.Caching;

namespace Com.NewSun.Common.Cache
{
    public class CacheMemcached : ICache
    {
        public void Set(string key, object value)
        {
            using (var mc = new MemcachedClient())
            {
                mc.Store(Enyim.Caching.Memcached.StoreMode.Set, key, value);
            }
        }
        public void Set(string key, object value,DateTime expiresDateTime)
        {
            using (var mc = new MemcachedClient())
            {
                mc.Store(Enyim.Caching.Memcached.StoreMode.Set, key, value, expiresDateTime);
            }
        }
        public object Get(string key)
        {
            using (var mc = new MemcachedClient())
            {
                return mc.Get(key);
            }
        }
        public void Remove(string key)
        {
            using (var mc = new MemcachedClient())
            {
                mc.Remove(key);
            }
        }
    }
}
