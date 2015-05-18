using System;
using System.Configuration;
using System.IO;
using System.Xml;
using System.Xml.Linq;

namespace NewSun.JobService
{
    public enum ConfigType
    {
        None,
        Exe,
        XmlDocument,
        XElement
    }

    public abstract class CustomConfigBase
    {

        #region 私有成员

        private string filePathName = string.Empty;

        private System.Configuration.Configuration m_ExecConfig;

        private XmlDocument m_XmlConfig;

        private XElement m_XmlConfigElement;

        private ConfigType m_ConfigType = ConfigType.None;

        private FileSystemWatcher m_FileWatcher;

        //ServiceLogger logger = new ServiceLogger(ServiceMainSettings.GetConfig().ServiceName);

        #endregion

        #region 保护成员

        /// <summary>
        /// 配置文件读写时使用的锁对象
        /// 注：对配置文件的读写一定要锁定本对象
        /// </summary>
        protected object SyncObj = new object();

        #endregion

        #region 构造方法

        /// <summary>
        /// 使用一个XML文件的名字生成实例
        /// </summary>
        /// <param name="filePathName"></param>
        /// <param name="type"></param>
        public CustomConfigBase(string filePathName, ConfigType type)
        {
            this.filePathName = filePathName;
            this.m_ConfigType = type;

            this.OpenConfigFile(type);
        }

        /// <summary>
        /// 使用一个可执行文件(.exe或.dll)生成实例
        /// </summary>
        /// <param name="assembly"></param>
        public CustomConfigBase(System.Reflection.Assembly assembly)
        {
            this.filePathName = assembly.Location + ".config";

            this.m_ConfigType = ConfigType.Exe;

            this.OpenConfigFile(this.m_ConfigType);
        }

        ~CustomConfigBase()
        {
            if (m_FileWatcher != null)
            {
                m_FileWatcher.Dispose();
            }
        }

        #endregion

        #region 公共属性

        /// <summary>
        /// 获取文件完整路径名
        /// </summary>
        public string FilePathName
        {
            get
            {
                return this.filePathName;
            }
        }

        /// <summary>
        /// 获取配置文件的类型(true: 可执行文件配套, false: XML文件
        /// </summary>
        public bool IsExecConfig
        {
            get
            {
                return this.m_ConfigType == ConfigType.Exe;
            }
        }

        /// <summary>
        /// 获取可执行程序的配置。仅当采用assembly实例化才有效。
        /// </summary>
        public System.Configuration.Configuration ExecConfig
        {
            get
            {
                return this.m_ExecConfig;
            }
        }

        /// <summary>
        /// 获取XML文件格式的配置。仅当采用filePathName实例化才有效
        /// </summary>
        public XmlDocument XmlConfig
        {
            get
            {
                return this.m_XmlConfig;
            }
        }

        /// <summary>
        /// 获取XML文件格式的配置。仅当采用filePathName实例化才有效
        /// </summary>
        public XElement XmlConfigElement
        {
            get
            {
                return this.m_XmlConfigElement;
            }
        }

        #endregion

        #region 公共方法

        /// <summary>
        /// 获取ExecConfig中的一个appSetting的值
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public string GetAppSetting(string key)
        {
            string result = string.Empty;
            if (this.m_ExecConfig != null)
            {
                KeyValueConfigurationElement item = this.m_ExecConfig.AppSettings.Settings[key];
                result = item != null ? item.Value : string.Empty;
            }
            return result;
        }

        /// <summary>
        /// 获取指定config文件中的一个配置的连接串
        /// </summary>
        public string GetConnectionString(string name)
        {
            string result = string.Empty;
            if (this.m_ExecConfig != null)
            {
                ConnectionStringSettings item = this.m_ExecConfig.ConnectionStrings.ConnectionStrings[name];
                result = item != null ? item.ConnectionString : string.Empty;
            }
            return result;
        }

        #endregion

        #region 私有方法

        /// <summary>
        /// 装入配置文件
        /// </summary>
        private void OpenConfigFile(ConfigType type)
        {
            lock (SyncObj)  //锁定配置文件锁对象
            {
                switch (type)
                {
                    case ConfigType.Exe:
                    case ConfigType.None:
                        ExeConfigurationFileMap configFileMap = new ExeConfigurationFileMap { ExeConfigFilename = this.filePathName };
                        this.m_ExecConfig = ConfigurationManager.OpenMappedExeConfiguration(configFileMap, ConfigurationUserLevel.None);
                        break;
                    case ConfigType.XmlDocument:

                        this.m_XmlConfig = new XmlDocument();

                        this.m_XmlConfig.Load(this.filePathName);
                        break;
                    case ConfigType.XElement:
                        XmlReader reader = XmlReader.Create(this.filePathName);
                        this.m_XmlConfigElement = XElement.Load(reader);
                        break;
                }

                this.InitFileWatcher();
            }
        }


        /// <summary>
        /// 初始化文件监测，当文件被修改时，将激活相应的处理程序
        /// </summary>
        private void InitFileWatcher()
        {
            if (this.m_FileWatcher == null)
            {
                string filePath = Path.GetDirectoryName(this.filePathName);
                string fileName = Path.GetFileName(this.filePathName);
                if (string.IsNullOrEmpty(filePath) || string.IsNullOrEmpty(fileName))
                {
                    //LogHelper.GetInstance(this.GetType().ToString()).Error("文件路径解析错误");
                    return;
                }
                this.m_FileWatcher = new FileSystemWatcher(filePath, fileName)
                {
                    NotifyFilter = NotifyFilters.LastWrite | NotifyFilters.FileName,
                    EnableRaisingEvents = true
                };

                this.m_FileWatcher.Changed += FileWatcherChanged;
            }
        }

        /// <summary>
        /// 文件监测到改变后的处理程序
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void FileWatcherChanged(object sender, FileSystemEventArgs e)
        {
            //LogHelper.GetInstance(this.GetType().FullName).Debug(string.Format("文件发生改变，重新载入"));
            try
            {
                //重新装入配置文件
                OpenConfigFile(this.m_ConfigType);

                //触发文件改变事件
                this.FileChanged();
            }
            catch (Exception ex)
            {
                //LogHelper.GetInstance(this.GetType().FullName).Debug(string.Format("重新载入配置文件时发生异常，异常信息：{0}，堆栈信息： {1}", ex.Message, ex.StackTrace));
                throw;
            }
        }

        #endregion

        #region 接口方法

        /// <summary>
        /// 文件改变后的处理程序，子类必须实现
        /// </summary>
        protected abstract void FileChanged();

        #endregion
    }
}
