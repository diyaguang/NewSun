using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;
using Newtonsoft.Json;

namespace Com.NewSun.Common
{
    /// <summary>
    /// JSON扩展方法类
    /// 提供将字符串或对象进行序列化和反序列化
    /// </summary>
    public static class JsonExtension
    {
        /// <summary>
        /// 将字符串反序列化为对象
        /// </summary>
        /// <typeparam name="T">要转化的对象</typeparam>
        /// <param name="s">json字符串</param>
        /// <returns></returns>
        public static T DeserializeObject<T>(this string s)
        {
            if (s == null) return default(T);
            return (T)JavaScriptConvert.DeserializeObject(s, typeof(T));
        }

        /// <summary>
        /// 将字符串反序列化为对象集合
        /// </summary>
        /// <typeparam name="T">要转化的对象集合</typeparam>
        /// <param name="s">json字符串</param>
        /// <returns></returns>
        public static List<T> DeserializeObjectList<T>(this string s)
        {
            if (s == null) return new List<T>();
            return (List<T>)JavaScriptConvert.DeserializeObject(s, typeof(List<T>));
        }

        /// <summary>
        /// 将对象序列化为Json字符串
        /// </summary>
        /// <param name="o"></param>
        /// <returns></returns>
        public static string SerializeObject(this object o)
        {
            if (o == null) return null;
            return JavaScriptConvert.SerializeObject(o);
        }
    }
}
