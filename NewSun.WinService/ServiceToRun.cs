using System.Windows.Forms;
using System.ServiceProcess;
using NewSun.JobService;
using System.Threading;
using System.IO;

namespace NewSun.WinService
{
    public class ServiceToRun
    {
        /// <summary>
        /// 程序入口点文件
        /// </summary>
        /// <param name="args"></param>
        private static void Main(string[] args)
        {
            MainService.Instance.EntryType = ServiceEntryType.Service;
            var servicesToRun = new System.ServiceProcess.ServiceBase[] { MainService.Instance };
            System.ServiceProcess.ServiceBase.Run(servicesToRun);
        }
    }
}
