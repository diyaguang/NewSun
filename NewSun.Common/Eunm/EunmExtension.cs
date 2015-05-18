using System;
using System.Collections.Generic;
using System.Linq;
using System.ComponentModel;
using System.Text;
using System.Reflection;

namespace Com.NewSun.Common
{
    /// <summary>
    /// 枚举方法扩展类
    /// 主要用来操作枚举中的描述信息，通过对枚举项的 CustomAttribute 中设置 Description 来标示描述。
    /// 可以通过描述字符串信息转换为枚举成员对象。
    /// </summary>
    public static class EunmExtension
    {
        /// <summary>
        /// 获取枚举元素的单个 Description 描述信息。
        /// </summary>
        /// <typeparam name="TEnum">枚举类型</typeparam>
        /// <param name="enumerationValue">枚举项</param>
        /// <returns></returns>
        public static string GetDescription<TEnum>(this TEnum enumerationValue) where TEnum : struct,IComparable, IFormattable, IConvertible
        {
            Type type = enumerationValue.GetType();
            if (!type.IsEnum)
                throw new ArgumentException("EnumerationValue must be of Enum type", "enumerationValue");
            MemberInfo[] memberInfo = type.GetMember(enumerationValue.ToString());
            if (memberInfo != null && memberInfo.Length > 0)
            { 
                object[] attrs = memberInfo[0].GetCustomAttributes(typeof(DescriptionAttribute),false);
                if (attrs != null && attrs.Length > 0)
                    return ((DescriptionAttribute)attrs[0]).Description;
            }
            return enumerationValue.ToString();
        }

        /// <summary>
        /// 获取枚举元素的所有 Description 描述信息。
        /// </summary>
        /// <typeparam name="TEnum">枚举类型</typeparam>
        /// <param name="enumerationValue">枚举项</param>
        /// <returns></returns>
        public static string[] GetDescriptions<TEnum>(this TEnum enumerationValue) where TEnum : struct, IComparable, IFormattable, IConvertible
        {
            Type type = enumerationValue.GetType();
            if (!type.IsEnum)
                throw new ArgumentException("EnumerationValue must be of Enum type", "enumerationValue");
            MemberInfo[] memberInfo = type.GetMember(enumerationValue.ToString());
            if (memberInfo != null && memberInfo.Length > 0)
            {
                object[] attrs = memberInfo[0].GetCustomAttributes(typeof(DescriptionAttribute), false);
                if (attrs != null && attrs.Length > 0)
                    return attrs.OfType<DescriptionAttribute>().Select(t => t.Description).ToArray();
            }
            return new[] { enumerationValue.ToString() };
        }

        /// <summary>
        /// 根据字符描述返回对应的枚举项
        /// </summary>
        /// <typeparam name="TEnum">枚举类型</typeparam>
        /// <param name="self"></param>
        /// <returns></returns>
        public static TEnum ToEnumByDescription<TEnum>(this string self) where TEnum : struct, IComparable, IFormattable, IConvertible
        {
            if (string.IsNullOrEmpty(self))
                throw new ArgumentException("self must have a value", "self");

            var query = Enum.GetValues(typeof(TEnum));

            foreach (TEnum q in query)
            {
                if (q.GetDescriptions().Any(t => t.Equals(self, StringComparison.OrdinalIgnoreCase)))
                    return q;
            }
            return (TEnum)query.GetValue(0);
        }

        /// <summary>
        ///  根据字符返回对应的枚举项
        /// </summary>
        /// <typeparam name="TEnum">枚举类型</typeparam>
        /// <param name="self"></param>
        /// <returns></returns>
        public static TEnum ToEnum<TEnum>(this string self) where TEnum : struct, IComparable, IFormattable, IConvertible
        {
            return (TEnum)Enum.Parse(typeof(TEnum), self, true);
        }
    }
}
