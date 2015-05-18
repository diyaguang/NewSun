using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NewSun.JobService
{
    public class ScheduleItem
    {
        #region 私有成员

        private bool _changed = false;

        private string _name = string.Empty;

        private string _title = string.Empty;

        private string _description = string.Empty;

        private string _startTime = string.Empty;

        private string _endTime = string.Empty;

        private string _repeatCount = string.Empty;

        private string _repeatInterval = string.Empty;

        private string _cronExpression = string.Empty;

        private bool _isSimple = true;

        #endregion

        #region 构造函数
        public ScheduleItem(string name, string title, string description)
        {
            this._name = name;
            this._title = title;
            this._description = description;
        }
        #endregion

        #region 公共属性

        #region 配置项只读信息

        public bool IsSimple
        {
            set
            {
                this._isSimple = value;
            }
            get
            {
                return this._isSimple;
            }
        }

        /// <summary>
        /// 获取配置项的名称
        /// </summary>
        public string Name
        {
            get
            {
                return this._name;
            }
        }

        /// <summary>
        /// 获取配置项的标题
        /// </summary>
        public string Title
        {
            get
            {
                return string.IsNullOrEmpty(this._title) ? this._name : this._title;
            }
        }

        /// <summary>
        /// 获取配置项的描述信息
        /// </summary>
        public string Description
        {
            get
            {
                return this._description;
            }
        }

        #endregion

        #region 配置项可写信息

        /// <summary>
        /// 获取或设置开始时间
        /// </summary>
        public string StartTime
        {
            get
            {
                return this._startTime;
            }
            set
            {
                if (this._startTime.Equals(value ?? string.Empty) == false)
                {
                    this._startTime = value ?? string.Empty;
                    this._changed = true;
                }
            }
        }

        /// <summary>
        /// 获取或设置结束时间
        /// </summary>
        public string EndTime
        {
            get
            {
                return this._endTime;
            }
            set
            {
                if (this._endTime.Equals(value ?? string.Empty) == false)
                {
                    this._endTime = value ?? string.Empty;
                    this._changed = true;
                }
            }
        }

        /// <summary>
        /// 获取或设置重复次数，-1为不限定
        /// </summary>
        public string RepeatCount
        {
            get
            {
                return this._repeatCount;
            }
            set
            {
                if (this._repeatCount.Equals(value ?? string.Empty) == false)
                {
                    this._repeatCount = value ?? string.Empty;
                    this._changed = true;
                }
            }
        }

        /// <summary>
        /// 获取或设置重复间隔时间，单位毫秒
        /// </summary>
        public string RepeatInterval
        {
            get
            {
                return this._repeatInterval;
            }
            set
            {
                if (this._repeatInterval.Equals(value ?? string.Empty) == false)
                {
                    this._repeatInterval = value ?? string.Empty;
                    this._changed = true;
                }
            }
        }
        /// <summary>
        /// Cron表达式
        /// </summary>
        public string CronExpression
        {
            get { return this._cronExpression; }
            set
            {
                this._cronExpression = value ?? string.Empty;
                this._changed = true;
            }
        }

        #endregion

        #region 配置项类型化信息

        /// <summary>
        /// 获取重复间隔时间设置，单位秒
        /// </summary>
        /// <returns></returns>
        public int GetRepeatInterval()
        {
            int result;
            int.TryParse(this.RepeatInterval, out result);

            if (result < 1000) result = 1000;
            return result / 1000;
        }

        /// <summary>
        /// 获取开始时间设置
        /// </summary>
        /// <returns></returns>
        public DateTime GetStartTime()
        {
            DateTime result = DateTime.MinValue;
            DateTime.TryParse(this.StartTime, out result);

            //Quartz只认0时区的时间，所以这里要加上当前时区值
            result = result.Add(TimeZoneInfo.Local.GetUtcOffset(result));

            return result;
        }

        /// <summary>
        /// 获取结束时间设置
        /// </summary>
        /// <returns></returns>
        public DateTime GetEndTime()
        {
            DateTime result = DateTime.MinValue;
            DateTime.TryParse(this.EndTime, out result);

            //Quartz只认0时区的时间，所以这里要加上当前时区值
            result = result.Add(TimeZoneInfo.Local.GetUtcOffset(result));

            return result;
        }

        #endregion

        /// <summary>
        /// 获取或设置一个状态值，标识此配置数据是否有任何更改
        /// </summary>
        public bool Changed
        {
            get
            {
                return this._changed;
            }
            set
            {
                this._changed = value;
            }
        }

        /// <summary>
        /// 获取一个状态值，标识此配置是否有效。<br/>
        /// 判断配置有效的规则为：<br/>
        ///   结束时间为空，或开始时间>结束时间，且结束时间>当前时间
        /// </summary>
        public bool Active
        {
            get
            {
                DateTime startTime = this.GetStartTime();
                DateTime endTime = this.GetEndTime();

                return string.IsNullOrEmpty(this.EndTime.Trim()) ||
                    (startTime < endTime &&
                     endTime > DateTime.Now);
            }
        }
        #endregion
    }
}
