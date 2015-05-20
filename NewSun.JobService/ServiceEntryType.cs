using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Com.NewSun.JobService
{
    public delegate void CreateJobDelegete(object obj);

    /// <summary>
    /// 服务程序的入口类型
    /// </summary>
    public enum ServiceEntryType
    {
        /// <summary>
        /// 服务
        /// </summary>
        Service = 1,

        /// <summary>
        /// 应用程序
        /// </summary>
        Application = 2
    }

    /// <summary>
    /// 服务运行状态
    /// </summary>
    public enum ServiceStatusType
    {
        /// <summary>
        /// 已停止
        /// </summary>
        Stopped = 0,
        /// <summary>
        /// 运行中
        /// </summary>
        Running = 1
    }
}
