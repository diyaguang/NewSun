using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Com.NewSun.Common.Cache
{
    public interface ICache
    {
        void Set(string key, object value);
        void Set(string key, object value, DateTime expiresDateTime);
        object Get(string key);
        void Remove(string key);
    }
}
