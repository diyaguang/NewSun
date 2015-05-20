using System;
using System.Collections.Generic;
using System.Xml;

namespace Com.NewSun.JobService
{
    public class ScheduleConfig : CustomConfigBase
    {
        #region 私有成员

        //配置文件的Xml引用信息
        private XmlDocument _document = null;
        private XmlNamespaceManager _nsmsg = null;
        private XmlNode _root = null;

        //解析出的全部配置信息
        private List<ScheduleItem> _items;

        #endregion

        #region 构造函数

        /// <summary>
        /// 根据配置文件的绝对路径名初始化实例，并解析装载全部配置项
        /// </summary>
        /// <param name="filePath">完整文件路径</param>
        public ScheduleConfig(string filePath)
            : base(filePath, ConfigType.XmlDocument)
        {
            InitConfigFile();

            LoadConfigItems();
        }

        #endregion

        #region 公共方法

        /// <summary>
        /// 获取配置信息集合
        /// </summary>
        public List<ScheduleItem> Items
        {
            get
            {
                return this._items;
            }
        }

        /// <summary>
        /// 根据配置项的Name查找配置项
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public ScheduleItem GetItemByName(string name)
        {
            ScheduleItem result = null;
            foreach (ScheduleItem item in this._items)
            {
                if (item.Name.Equals(name))
                {
                    result = item;
                    break;
                }
            }
            return result;
        }

        /// <summary>
        /// 根据配置项的Title查找配置项
        /// </summary>
        /// <param name="title"></param>
        /// <returns></returns>
        public ScheduleItem GetItemByTitle(string title)
        {
            ScheduleItem result = null;
            foreach (ScheduleItem item in this._items)
            {
                if (item.Title.Equals(title))
                {
                    result = item;
                    break;
                }
            }
            return result;
        }

        /// <summary>
        /// 保存更改到原文件
        /// </summary>
        public void Save()
        {
            this.SaveConfigFile();
        }

        #endregion

        #region 私有方法

        /// <summary>
        /// 装载配置文件
        /// </summary>
        private void InitConfigFile()
        {
            this._items = new List<ScheduleItem>();

            //装载配置文件
            _document = base.XmlConfig;

            //构建一个Xml命名空间，由于所有节点没有明确指定节点名前缀，因此需要构建一个临时前缀的命名空间
            _nsmsg = new XmlNamespaceManager(_document.NameTable);
            _nsmsg.AddNamespace("xx", _document.DocumentElement.NamespaceURI);

            //根节点 (quartz节点)
            _root = _document.DocumentElement;
        }

        /// <summary>
        /// 当配置文件改变后自动激活
        /// </summary>
        protected override void FileChanged()
        {
            InitConfigFile();

            LoadConfigItems();
        }

        /// <summary>
        /// 从配置文件中解析全部配置项
        /// </summary>
        private void LoadConfigItems()
        {
            //读取Job定义
            XmlNodeList jobNodes = _root.SelectNodes("//xx:job/xx:job-detail", _nsmsg);
            foreach (XmlNode jobNode in jobNodes)
            {
                string name = this.GetXmlNodeText(jobNode, "xx:name");
                if (string.IsNullOrEmpty(name) == false)
                {
                    string title = GetXmlNodeText(jobNode, "xx:title");
                    string description = GetXmlNodeText(jobNode, "xx:description");
                    ScheduleItem item = new ScheduleItem(name, title, description);

                    XmlNode triggerNode = _root.SelectSingleNode(string.Format("//xx:trigger/xx:simple[xx:job-name=\"{0}\"]", name), _nsmsg);
                    if (triggerNode != null)
                    {
                        item.IsSimple = true;
                        item.StartTime = GetXmlNodeText(triggerNode, "xx:start-time");
                        item.EndTime = GetXmlNodeText(triggerNode, "xx:end-time");
                        item.RepeatCount = GetXmlNodeText(triggerNode, "xx:repeat-count");
                        item.RepeatInterval = GetXmlNodeText(triggerNode, "xx:repeat-interval");
                        this._items.Add(item);
                    }
                    triggerNode = _root.SelectSingleNode(string.Format("//xx:trigger/xx:cron[xx:job-name=\"{0}\"]", name), _nsmsg);
                    if (triggerNode != null)
                    {
                        item.IsSimple = false;
                        item.CronExpression = GetXmlNodeText(triggerNode, "xx:cron-expression");
                        this._items.Add(item);
                    }
                }
            }
        }

        /// <summary>
        /// 根据xpath获取一个节点的文字内容
        /// </summary>
        /// <param name="rootNoot"></param>
        /// <param name="xpath"></param>
        /// <returns></returns>
        private string GetXmlNodeText(XmlNode rootNoot, string xpath)
        {
            XmlNode node = rootNoot.SelectSingleNode(xpath, _nsmsg);

            return node != null ? node.InnerText : string.Empty;
        }

        /// <summary>
        /// 保存更改到原文件
        /// </summary>
        private void SaveConfigFile()
        {
            lock (SyncObj)
            {
                foreach (ScheduleItem item in this.Items)
                {
                    if (!item.Changed) continue;

                    XmlNode triggerNode = _root.SelectSingleNode(string.Format("//xx:trigger/xx:simple[xx:job-name=\"{0}\"]", item.Name), _nsmsg);
                    if (triggerNode != null)
                    {
                        SetXmlNodeText(triggerNode, "start-time", item.StartTime);
                        SetXmlNodeText(triggerNode, "end-time", item.EndTime);
                        SetXmlNodeText(triggerNode, "repeat-count", item.RepeatCount);
                        SetXmlNodeText(triggerNode, "repeat-interval", item.RepeatInterval);
                    }
                    else
                    {
                        triggerNode = _root.SelectSingleNode(string.Format("//xx:trigger/xx:cron[xx:job-name=\"{0}\"]", item.Name), _nsmsg);
                        if (triggerNode != null)
                        {
                            SetXmlNodeText(triggerNode, "cron-expression", item.CronExpression);
                        }
                    }
                    if (triggerNode == null)
                    {
                        throw new Exception(string.Format("保存调度配置文件失败，配置文件中找不到配置项'{0}'的触发器片段", item.Name));
                    }

                }

                try
                {
                    //保存文件
                    _document.Save(base.FilePathName);

                    //调整Changed属性
                    foreach (ScheduleItem item in this.Items)
                    {
                        if (item.Changed)
                        {
                            item.Changed = false;
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw;
                }
            }
        }

        /// <summary>
        /// 设置一个子节点的文本内容，如果该节点不存在，则新建一个
        /// </summary>
        /// <param name="parentNode"></param>
        /// <param name="childNodeName"></param>
        /// <param name="text"></param>
        private void SetXmlNodeText(XmlNode parentNode, string childNodeName, string text)
        {
            string xpath = "xx:" + childNodeName;
            XmlNode childNode = parentNode.SelectSingleNode(xpath, _nsmsg);

            if (childNode == null)
            {
                childNode = _document.CreateElement(childNodeName, _root.NamespaceURI);
                parentNode.AppendChild(childNode);
            }
            childNode.InnerText = text;
        }

        #endregion
    }
}
