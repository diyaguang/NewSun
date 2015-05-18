using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace Com.NewSun.Common.Extension
{
    public static class StringExtension
    {
        public static bool IsInt(this string str)
        {
            if (str == null)
            {
                return false;
            }
            return Regex.IsMatch(str, @"(-?[1-9]\d*|0)");

        }
        public static bool IsDate(this string str)
        {
            if (str == null)
            {
                return false;
            }
            return Regex.IsMatch(str, @"^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-9]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$");
        }

        public static int ToInt(this string str, int defval)
        {
            if (!IsInt(str))
                return defval;
            return Convert.ToInt32(str);
        }

        public static string ToNullableString(this object obj)
        {
            if (obj == null)
                return string.Empty;
            else
                return obj.ToString();
        }

        public static decimal? ToNullableDecimal(this object obj)
        {
            if (obj == null)
                return null;
            else
                return obj.ToString().ToNullableDecimal();
        }

        public static int? ToNullableInt(this string str)
        {
            if (!IsInt(str))
                return null;
            return Convert.ToInt32(str);
        }

        public static DateTime ToDateTime(this string str)
        {
            if (!IsDate(str))
                return new DateTime(1900, 1, 1);
            return Convert.ToDateTime(str);
        }

        public static DateTime? ToNullableDateTime(this string str)
        {
            if (!IsDate(str))
                return null;
            return Convert.ToDateTime(str);
        }

        public static bool ToBoolean(this string str, bool def)
        {
            bool result = def;
            if (!bool.TryParse(str, out result))
            {
                return def;
            }
            return result;
        }
    }
}
