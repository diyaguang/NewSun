using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using Com.NewSun.JobService.Configuration;

namespace Com.NewSun.JobService
{
    public sealed class ServiceMainSettings : ConfigurationSection
    {
        private const string ServiceMainConfigName = "serviceMainConfig";

        public static ServiceMainSettings GetConfig()
        {
            ServiceMainSettings result = (ServiceMainSettings)ConfigurationManager.GetSection(ServiceMainConfigName);

            if (result == null)
                result = new ServiceMainSettings();

            return result;
        }

        private ServiceMainSettings()
        {
        }

        /// <summary>
        /// 真正的ServiceName在ServiceInstaller中定义
        /// 这里的名称只是为记录日志来定义的，要求和ServiceInstaller中的ServiceName一致
        /// </summary>
        [ConfigurationProperty("serviceName", DefaultValue = "CFLDTOPKService")]
        public string ServiceName
        {
            get { return this["serviceName"].ToString(); }
        }


        [ConfigurationProperty("scheduleConfigPath", DefaultValue = "")]
        public string ScheduleConfigPath
        {
            get
            {
                if (this["scheduleConfigPath"] == null || string.IsNullOrEmpty(this["scheduleConfigPath"].ToString()))
                    return System.AppDomain.CurrentDomain.BaseDirectory;
                return this["scheduleConfigPath"].ToString();
            }
        }

        [ConfigurationProperty("scheduleConfigFile", DefaultValue = "ScheduleJobs.xml")]
        public string ScheduleConfigFile
        {
            get
            {
                return this["scheduleConfigFile"].ToString();
            }
        }

        public string ScheduleConfig
        {
            get
            {
                if (ScheduleConfigPath.EndsWith(@"\"))
                    return string.Format(@"{0}{1}", ScheduleConfigPath, ScheduleConfigFile);
                return string.Format(@"{0}\{1}", ScheduleConfigPath, ScheduleConfigFile);
            }
        }

        /// <summary>
        /// 更改配置文件的控件Type
        /// </summary>
        [ConfigurationProperty("extendConfigs")]
        public TypeConfigurationCollection ExtendConfigs
        {
            get { return (TypeConfigurationCollection)this["extendConfigs"]; }
        }

        /// <summary>
        /// 插件信息Type
        /// </summary>
        [ConfigurationProperty("addinConfigs")]
        public TypeConfigurationCollection AddinConfigs
        {
            get { return (TypeConfigurationCollection)this["addinConfigs"]; }
        }
    }
}
