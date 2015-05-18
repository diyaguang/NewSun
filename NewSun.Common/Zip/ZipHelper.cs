using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Ionic.Zip;
using System.IO;

namespace Com.Newsun.Common.Zip
{
    /// <summary>
    /// 文件压缩操作类
    /// 使用第三方类库，Ionic.Zip  用来压缩目录和向压缩文件中添加文件
    /// </summary>
    public class ZipHelper
    {
        /// <summary>
        /// 压缩指定目录
        /// </summary>
        /// <param name="directory">目录路径</param>
        /// <param name="output">指定Zip文件路径+文件名</param>
        public static void CompressDirectory(string directory, string output)
        {
            try
            {
                if (File.Exists(output))
                    File.Delete(output);
                using (ZipFile zip = new ZipFile(output))
                {
                    string[] rootFiles = Directory.GetFiles(directory);
                    zip.TempFileFolder = directory;
                    zip.Save(output);
                }
            }
            catch (Exception ex1)
            {
                throw ex1;
            }
        }

        /// <summary>
        /// 压缩制定目录中的Zip文件
        /// </summary>
        /// <param name="directory">目录路径</param>
        /// <param name="outputFileName">指定Zip文件路径+文件名</param>
        public static void CompressDirectoryZip(string directory, string outputFileName)
        {
            try
            {
                if (File.Exists(directory + outputFileName))
                    File.Delete(directory + outputFileName);

                string[] rootFiles = Directory.GetFiles(directory).Distinct().ToArray();

                using (ZipFile zip = new ZipFile(directory + outputFileName))
                {
                    foreach (string s in rootFiles)
                    {
                        if (s.ToLower().EndsWith(".zip"))
                        {
                            zip.AddFile(s, "");
                        }
                    }
                    zip.TempFileFolder = directory;
                    zip.Save(directory + outputFileName);
                }

                foreach (string s in rootFiles)
                {
                    if (s.ToLower().EndsWith(".zip"))
                    {
                        File.Delete(s);
                    }
                }
            }
            catch (Exception ex1)
            {
                throw ex1;
            }
        }

        /// <summary>
        /// 向 Zip 包中添加文件
        /// </summary>
        /// <param name="zipfile">指定Zip文件路径+文件名</param>
        /// <param name="files">添加文件列表（路径+文件名）</param>
        public static void ZipFiles(FileInfo zipfile, params  string[] files)
        {
            if (files.Length <= 0)
            {
                throw new InvalidDataException("the files to be zipped can't be null.");
            }
            if (zipfile.Exists)
            {
                throw new Exception("File:" + zipfile.FullName + " is already exsited.");
            }
            using (var zip = new ZipFile(zipfile.FullName))
            {
                files = files.Distinct().ToArray();
                foreach (string s in files)
                {
                    if (File.Exists(s))
                    {
                        zip.AddFile(s, "");
                    }
                }
                zip.TempFileFolder = zipfile.DirectoryName;
                zip.Save(zipfile.FullName);
            }
        }
    }
}
