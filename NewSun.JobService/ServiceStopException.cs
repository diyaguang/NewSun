using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace NewSun.JobService
{
    public class ServiceStopException : Exception
    {
        public ServiceStopException(string msg)
            : base(msg)
        {
        }

        public static void WaitAndThrow(WaitHandle handle)
        {
            if (handle.WaitOne(0, false))
                throw new ServiceStopException("Stop EventHandle Triggered");
        }
    }
}
