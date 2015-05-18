using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Com.NewSun.Common
{
    public enum CacheType
    { 
        Application,
        Memcached,
    }

    /// <summary>
    /// 设置日志级别
    /// </summary>
    public enum LogLevel
    {
        Info=10,
        Error=50,
        Debug=0,
        Warning=30
    }
}
