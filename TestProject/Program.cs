using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

using Com.NewSun.Common;
using Com.NewSun.DataAccess;

namespace TestProject
{
    class Program
    {
        static void Main(string[] args)
        {
            var obj = new Program();
            obj.TestSqlMapper();
        }

        public void testLogDatabase()
        {
            //LogHelper.Debug("Test");
            var tmpLogMsg = new LogMessage()
            {
                ID = Utilitys.NewID().ToString(),
                ShortMessage = "testShortMessage",
                FullMessage = "fullMessage",
                IPAddress = CommonHelper.GetIPAddress(),
                PageUrl = "NaN",
                ReferrerUrl = "NaN",
                LogLevelID = Convert.ToInt32(LogLevel.Debug).ToString(),
                UserID = Utilitys.NewID().ToString(),
                UserName = "admin",
                LoggerName = "testLog",
                CreateTime = DateTime.Now
            };

            LogHelper.Database(tmpLogMsg);
        }




        public string connectionName = "ConncetionKey";
        public DbBase CreateDbBase()
        {
            return new DbBase(connectionName);
        }
        public void Connection()
        {
            var providerName = "System.Data.SqlClient";
            var connStr = ConfigurationManager.ConnectionStrings[connectionName].ConnectionString;
            if (!string.IsNullOrEmpty(ConfigurationManager.ConnectionStrings[connectionName].ProviderName))
                providerName = ConfigurationManager.ConnectionStrings[connectionName].ProviderName;

            var dbProvider = DbProviderFactories.GetFactory(providerName);
            var conn = dbProvider.CreateConnection();
            conn.ConnectionString = connStr;
            conn.Open();
            Console.WriteLine("状态：" + conn.State.ToString());
        }
        public void TestSqlMapper()
        {
            var model = new TestTable()
            {
                Description = "TestValue"
            };
            using (DbBase db = CreateDbBase())
            {
                var result = db.Insert<TestTable>(model);
                if (result)
                    Console.WriteLine("添加成功");
                else
                    Console.WriteLine("添加失败");
            }
        }
    }
}
