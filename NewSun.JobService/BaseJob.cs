using Quartz;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace NewSun.JobService
{
    public abstract class BaseJob
    {
        //同步锁
        private static object SYNC_LOCK = new object();

        protected virtual ILogger Logger
        {
            get;
            set;
        }

        public virtual void Interrupt()
        { }

        public virtual void Execute(JobExecutionContext context)
        {
            Logger = new ServiceLogger(context.JobDetail.Name);

            if (Monitor.TryEnter(SYNC_LOCK, 3000) == false)
            {
                Logger.Debug("上一次调度未完成,本次调度放弃运行");
                return;
            }

            try
            {
                Logger.Info("调度开始执行");

                InnerExecute(context);

                Logger.Info("调度正常结束");
            }
            catch (Exception e)
            {
                Logger.Error("调度执行时发生异常: " + e);
            }
            finally
            {
                Monitor.Exit(SYNC_LOCK);
            }
        }

        protected abstract void InnerExecute(JobExecutionContext context);
    }
}
