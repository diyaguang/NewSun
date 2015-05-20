using System;
using System.Collections;
using System.ComponentModel;
using System.IO;
using System.Threading;
using Com.NewSun.JobService;
using Quartz;
using Quartz.Impl;
using Quartz.Xml;

namespace Com.NewSun.WinService
{
    public partial class MainService : System.ServiceProcess.ServiceBase
    {
        public event CreateJobDelegete CreateJobEvent;
        private ILogger logger = new ServiceLogger(typeof(MainService).Name);

        internal static MainService Instance = new MainService();
        internal string[] args; //WinForm应用程序参数

        private FileSystemWatcher scheduleWatcher = null; //调度配置文件监视
        private IScheduler sched = null; // 调度框架

        /// <summary>
        /// 启动类型：应用程序或后台服务
        /// </summary>
        private ServiceEntryType entryType = ServiceEntryType.Service;

        /// <summary>
        /// Service状态：默认停止
        /// </summary>
        private ServiceStatusType serviceStatus = ServiceStatusType.Stopped;

        internal ServiceEntryType EntryType
        {
            get
            {
                return this.entryType;
            }
            set
            {
                this.entryType = value;
            }
        }

        internal ServiceStatusType ServiceStatus
        {
            get
            {
                return this.serviceStatus;
            }
            set
            {
                this.serviceStatus = value;
            }
        }


        public MainService()
        {
            InitializeComponent();

            this.ServiceName = ServiceMainSettings.GetConfig().ServiceName;
            this.AutoLog = false;
        }


        #region Public Method, None inherit

        public void StarService()
        {
            //this.exitEvent.Reset();

            OnStart(args);

            this.ServiceStatus = ServiceStatusType.Running;
        }

        public void StopService()
        {
            OnStop();

            this.ServiceStatus = ServiceStatusType.Stopped;
        }

        #endregion

        #region Protected Method

        protected override void OnStart(string[] args)
        {
            Thread startThread = new Thread(delegate()
            {
                try
                {
                    logger.Info("Service开始启动");

                    //通过配置文件启动调度引擎
                    StartScheduler();

                    //添加文件监视
                    InitQuartzWatcher();

                    logger.Info("Service启动成功");
                }
                catch (Exception ei)
                {
                    logger.Error("Service启动失败：" + ei.Message);
                }
            });

            startThread.Start();
        }

        protected override void OnStop()
        {
            try
            {
                StopScheduler();
                logger.Info("Service停止");
            }
            catch (Exception e)
            {
                logger.Error(string.Format("当试图停止Service时发生错误: {0}，错误堆栈:{1}", e.Message, e.StackTrace));
            }
        }

        #endregion

        #region Private Method

        /// <summary>
        /// 启动调度引擎
        /// </summary>
        private void StartScheduler()
        {
            logger.Info("调度引擎开始启动");

            ISchedulerFactory schedFactory = new StdSchedulerFactory();
            sched = schedFactory.GetScheduler();

            //读取配置文件中配置的Job和Trigger信息到Scheduler中
            JobSchedulingDataProcessor processor = new JobSchedulingDataProcessor(true, true);
            processor.ProcessFile(ServiceMainSettings.GetConfig().ScheduleConfig);
            processor.ScheduleJobs(new Hashtable(), sched, false);

            //装在调度Job信息
            string[] jobGroupNames = sched.JobGroupNames;
            if (jobGroupNames == null || jobGroupNames.Length <= 0)
            {
                logger.Debug("没有调度Job信息被装载");
            }

            //开始执行调度任务
            sched.Start();

            logger.Info("调度引擎启动成功");
        }

        /// <summary>
        /// 停止调度引擎
        /// </summary>
        private void StopScheduler()
        {
            logger.Info("准备停止调度引擎");

            if (sched != null)
            {
                //停止全部正在运行的调度任务
                IList jobs = sched.GetCurrentlyExecutingJobs();
                foreach (JobExecutionContext job in jobs)
                {
                    if (job == null) continue;
                    IInterruptableJob interruptableJob = job.JobInstance as IInterruptableJob;
                    if (interruptableJob != null)
                        interruptableJob.Interrupt();
                }

                //此处参数要选择false，否则本行代码会等待所有作业执行完成后才返回，导致服务停止操作报告失败
                sched.Shutdown(false);
            }

            logger.Info("调度引擎停止成功");
        }

        /// <summary>
        /// 添加quartz_jobs.xml文件监视，当配置文件发生任意变动时，调度引擎将自动重启
        /// </summary>
        private void InitQuartzWatcher()
        {
            if (scheduleWatcher == null)
            {
                scheduleWatcher = new FileSystemWatcher(ServiceMainSettings.GetConfig().ScheduleConfigPath, ServiceMainSettings.GetConfig().ScheduleConfigFile);
                scheduleWatcher.NotifyFilter = NotifyFilters.LastWrite | NotifyFilters.FileName;
                scheduleWatcher.Changed += new FileSystemEventHandler(quartzWatcher_Changed);
                scheduleWatcher.EnableRaisingEvents = true;
            }
        }

        /// <summary>
        /// 文件变动处理事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void quartzWatcher_Changed(object sender, FileSystemEventArgs e)
        {
            try
            {
                logger.Info(string.Format("调度配置文件'{0}'被更改，调度引擎将重新启动", ServiceMainSettings.GetConfig().ScheduleConfig));

                //停止调度引擎
                StopScheduler();

                //启动调度引擎
                StartScheduler();

                logger.Info("调度引擎重启成功");
            }
            catch (Exception ex)
            {
                logger.Error("Error:" + ex);
            }
        }

        #endregion
    }
}
