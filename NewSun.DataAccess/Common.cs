using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Com.NewSun.DataAccess
{
    public static class Common
    {
        private static object objLock = new object();
        /// <summary>
        /// 用于缓存对象转换实体
        /// </summary>
        private static Dictionary<string, ModelDes> _ModelDesCache = new Dictionary<string, ModelDes>();
        /// <summary>
        /// 确定是否已经存在缓存
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        private static ModelDes ExistModelDesCache(string key)
        {
            ModelDes value;
            _ModelDesCache.TryGetValue(key, out value);
            return value;
        }
        /// <summary>
        /// 添加缓存
        /// </summary>
        /// <param name="key"></param>
        /// <param name="des"></param>
        private static void Add(string key, ModelDes des)
        {
            lock (objLock)
            {
                if ((!_ModelDesCache.ContainsKey(key)) && des != null)
                {
                    _ModelDesCache.Add(key, des);
                }
            }
        }
        /// <summary>
        /// 获取缓存
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        private static ModelDes GetModelDesCache(string key)
        {
            ModelDes value;
            _ModelDesCache.TryGetValue(key, out value);
            if (value != null)
                return value;
            throw new Exception("缓存中没存在此数据");
        }
        /// <summary>
        /// 更新缓存
        /// </summary>
        /// <typeparam name="T"></typeparam>
        private static ModelDes UpdateModelDesCache<T>()
        {
            var type = typeof(T);
            var cacheValue = ExistModelDesCache(type.FullName);
            if (cacheValue == null)
            {
                var model = new ModelDes();
                #region 表描述
                model.ClassType = type;
                model.ClassName = type.Name;
                var tbAttrObj = type.GetCustomAttributes(typeof(TableAttribute), true).FirstOrDefault();
                if (tbAttrObj != null)
                {
                    var tbAttr = tbAttrObj as TableAttribute;
                    if (!string.IsNullOrEmpty(tbAttr.Name))
                        model.TableName = tbAttr.Name;
                    else
                        model.TableName = model.ClassName;
                }
                else
                    model.TableName = model.ClassName;
                #endregion
                #region 属性描述
                foreach (var propertyInfo in type.GetProperties())
                {
                    var pty = new PropertyDes();
                    pty.Field = propertyInfo.Name;
                    var arri = propertyInfo.GetCustomAttributes(typeof(BaseAttribute), true).FirstOrDefault();
                    if (arri is IgnoreAttribute)
                    {
                        continue;
                    }
                    else if (arri is IdAttribute)
                    {
                        pty.CusAttribute = arri as IdAttribute;
                    }
                    else if (arri is ColumnAttribute)
                    {
                        pty.CusAttribute = arri as ColumnAttribute;
                    }
                    model.Properties.Add(pty);
                }
                #endregion
                Add(type.FullName, model);
                cacheValue = model;
            }
            return cacheValue;
        }
        /// <summary>
        /// 获取转换实体对象描述
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        internal static ModelDes GetModelDes<T>()
        {
            return UpdateModelDesCache<T>();
        }
        /// <summary>
        /// 获取要执行SQL时的列,添加和修改数据时
        /// </summary>
        /// <param name="des"></param>
        /// <param name="add">是否是添加</param>
        /// <returns></returns>
        internal static IList<ParamColumnModel> GetExecColumns(ModelDes des, bool add = true)
        {
            var columns = new List<ParamColumnModel>();
            if (des != null && des.Properties != null)
            {
                foreach (var item in des.Properties)
                {
                    if ((!add) && item.CusAttribute is IdAttribute)
                    {
                        continue;
                    }
                    else if ((item.CusAttribute is IdAttribute) && ((item.CusAttribute as IdAttribute).CheckAutoId))
                    {
                        continue;
                    }
                    else if ((item.CusAttribute is ColumnAttribute) && ((item.CusAttribute as ColumnAttribute).AutoIncrement))
                    {
                        continue;
                    }
                    columns.Add(new ParamColumnModel() { ColumnName = item.Column, FieldName = item.Field });
                }
            }
            return columns;
        }
        /// <summary>
        /// 获取对象的主键标识列和属性
        /// </summary>
        /// <param name="des"></param>
        /// <returns></returns>
        internal static PropertyDes GetPrimary(ModelDes des)
        {
            var p = des.Properties.Where(m => m.CusAttribute is IdAttribute).FirstOrDefault();
            if (p == null)
            {
                throw new Exception("没有任何列标记为主键特性");
            }
            return p as PropertyDes;
        }
        /// <summary>
        /// 通过表达式树获取属性名
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="expr"></param>
        /// <returns></returns>
        internal static PropertyDes GetPropertyByExpress<T>(ModelDes des, Expression<Func<T, object>> expr) where T : class
        {
            var pname = "";
            if (expr.Body is UnaryExpression)
            {
                var uy = expr.Body as UnaryExpression;
                pname = (uy.Operand as MemberExpression).Member.Name;
            }
            else
            {
                pname = (expr.Body as MemberExpression).Member.Name;
            }
            var p = des.Properties.Where(m => m.Column == pname).FirstOrDefault();
            if (p == null)
            {
                throw new Exception(string.Format("{0}不是映射列，不能进行SQL处理", pname));
            }
            return p;
        }
    }

    public enum QueryType
    {
        And,   //Query.And(Query.EQ("name", "a"), Query.EQ("title", "t"));//同时满足多个条件
        Or,     //Query.Or(Query.EQ("name", "a"), Query.EQ("title", "t"));//满足其中一个条件
        Not,          //Query.Not("name");//元素条件语句
    }

    public enum QueryItemType
    {
        EQ,          //等于
        Exists,      //Query.Exists("type", true);//判断键值是否存在
        GT,           //大于
        GTE,         //大于等于
        In,            //Query.In("name", "a", "b");//包括指定的所有值,可以指定不同类型的条件和值
        LT,            //小于
        LTE,          //小于等于<=
        //Mod,        //Query.Mod("value", 3, 1);//将查询值除以第一个给定值,若余数等于第二个给定值则返回该结果
        NE,           //不等于
        Nor,          //Query.Nor(Array);//不包括数组中的值
        NotIn,       //Query.NotIn("name", "a", 2);//返回与数组中所有条件都不匹配的文档
        Size,          //Query.Size("name", 2);//给定键的长度
        //Type,         //Query.Type("_id", BsonType.ObjectId );//给定键的类型
        //Where,      //Query.Where(BsonJavaScript);//执行JavaScript
        Matches,   //Query.Matches("Title",str);//模糊查询 相当于sql中like -- str可包含正则表达式
    }

    public class QueryPropertyItem
    {
        public string PropertyName { get; set; }
        public QueryItemType OpType { get; set; }
        public object PropertyValue { get; set; }
        public QueryPropertyItem(string propertyName, object propertyValue, QueryItemType type)
        {
            PropertyName = propertyName;
            PropertyValue = propertyValue;
            OpType = type;
        }
    }
}
